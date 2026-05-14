import os
import glob
import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
from bs4 import BeautifulSoup
import time
from datetime import datetime

# ==========================================
# 0. KONFIGURÁCIÓ ÉS HATÁRÉRTÉKEK
# ==========================================
DATA_DIR = './data'
DB_URL = 'postgresql://admin:password123@localhost:5432/warehouse_metadata'
engine = create_engine(DB_URL)

# Szűrési határok
START_DATE = '2017-01-01'
TODAY = '2026-05-11' # A rendszer szerinti mai nap

def get_files(pattern):
    return glob.glob(f"{DATA_DIR}/**/{pattern}", recursive=True)

def clean_html(text_data):
    if pd.isna(text_data): return text_data
    try:
        soup = BeautifulSoup(str(text_data), "html.parser")
        return soup.get_text(separator=" ").strip()
    except: return str(text_data)

def parse_alairas(val):
    if pd.isna(val): return None
    val_str = str(val).lower()
    if 'aláírva' in val_str or 'igaz' in val_str: return True
    if 'megtagadva' in val_str or 'hamis' in val_str: return False
    return None

def parse_jegy(val):
    if pd.isna(val): return None
    val_str = str(val).lower()
    if 'jeles' in val_str or '5' in val_str: return 5
    if 'jó' in val_str or '4' in val_str: return 4
    if 'közepes' in val_str or '3' in val_str: return 3
    if 'elégséges' in val_str or '2' in val_str: return 2
    if 'elégtelen' in val_str or '1' in val_str: return 1
    return None

def fix_columns(df):
    df.columns = [str(c).strip().lower() for c in df.columns]
    cols = pd.Series(df.columns)
    for dup in cols[cols.duplicated()].unique():
        cols[cols == dup] = [dup if i == 0 else f"{dup}_{i}" for i in range(sum(cols == dup))]
    df.columns = cols
    return df.copy()

def filter_dates(df, column_name):
    """Kényszeríti a dátumformátumot és törli a tartományon kívüli sorokat."""
    if column_name in df.columns:
        df[column_name] = pd.to_datetime(df[column_name], errors='coerce')
        
        initial_count = len(df)
        df = df[
            (df[column_name] >= START_DATE) & 
            (df[column_name] <= TODAY)
        ].copy()
        
        dropped = initial_count - len(df)
        if dropped > 0:
            print(f"     ⚠️ Törölve {dropped} sor hibás dátum miatt a(z) '{column_name}' oszlopban.")
    return df

print(f"🚀 Tiszta ETL folyamat indítása (Tartomány: {START_DATE} - {TODAY})...")
start_time = time.time()

# --- ADATBÁZIS RESET (Magyar táblanevekkel) ---
with engine.connect() as conn:
    conn.execute(text("""
        DROP TABLE IF EXISTS fact_teljesitesek, fact_feleves_stat, dim_hallgato, 
                           dim_erettsegi, dim_targy, dim_kollegium, dim_elokepzettseg CASCADE;
    """))
    conn.commit()

# ==========================================
# 1. DIM_HALLGATO & DIM_ELOKEPZETTSEG
# ==========================================
print("\n--- Hallgatók és Előképzettség ---")
jogviszony_files = get_files('jogviszony_alap_*.xlsx')
if jogviszony_files:
    df_h = pd.concat([fix_columns(pd.read_excel(f)) for f in jogviszony_files], ignore_index=True)
    mapping_h = {
        'neptun kód': 'neptun_kod', 'nem': 'nem', 'születési ország': 'orszag', 
        'lakhely vármegye': 'varmegye', 'képzés név': 'szak', 'képzési szint': 'szint',
        'tagozat': 'tagozat', 'képzés kara': 'kar'
    }
    dim_hallgato = df_h.rename(columns=mapping_h)
    dim_hallgato = fix_columns(dim_hallgato)
    dim_hallgato = dim_hallgato[[c for c in mapping_h.values() if c in dim_hallgato.columns]].drop_duplicates('neptun_kod', keep='last')
    dim_hallgato.to_sql('dim_hallgato', engine, if_exists='replace', index=False)

elokep_files = get_files('elokepzettseg_*.xlsx')
if elokep_files:
    df_e = pd.concat([fix_columns(pd.read_excel(f)) for f in elokep_files], ignore_index=True)
    mapping_e = {'neptunkód': 'neptun_kod', 'előképzettség típusa': 'tipus', 'előképzettség intézmény neve': 'intezmeny'}
    dim_elokepzettseg = df_e.rename(columns=mapping_e)
    dim_elokepzettseg = dim_elokepzettseg[[c for c in mapping_e.values() if c in dim_elokepzettseg.columns]].dropna().drop_duplicates()
    dim_elokepzettseg.to_sql('dim_elokepzettseg', engine, if_exists='replace', index=False)

# ==========================================
# 2. DIM_ERETTSEGI & DIM_KOLLEGIUM
# ==========================================
print("--- Érettségi és Kollégium ---")
erett_files = get_files('erettsegi_*.xlsx')
if erett_files:
    df_er = pd.concat([fix_columns(pd.read_excel(f)) for f in erett_files], ignore_index=True)
    df_er = df_er.rename(columns={'neptunkód': 'neptun_kod', 'érettségi tárgy': 'targy'})
    df_er = fix_columns(df_er)
    df_er[['neptun_kod', 'targy', 'szint']].dropna().to_sql('dim_erettsegi', engine, if_exists='replace', index=False)

koll_files = get_files('*kollegium*.xlsx')
if koll_files:
    df_k = pd.concat([fix_columns(pd.read_excel(f)) for f in koll_files], ignore_index=True)
    df_k = df_k.rename(columns={'neptun kód': 'neptun_kod', 'kollégiumi szervezeti egység neve': 'koli_nev'})
    df_k = df_k[['neptun_kod', 'koli_nev', 'felvétel féléve']].drop_duplicates().to_sql('dim_kollegium', engine, if_exists='replace', index=False)

# ==========================================
# 3. DIM_TARGY
# ==========================================
print("--- Tantárgyak ---")
tanterv_files = get_files('*mintatanterv*.xlsx') + get_files('*mintatanterv*.csv')
if tanterv_files:
    t_dfs = []
    for f in tanterv_files:
        df = pd.read_csv(f, sep=';', on_bad_lines='skip', encoding_errors='ignore') if f.endswith('.csv') else pd.read_excel(f)
        t_dfs.append(fix_columns(df))
    dim_targy = pd.concat(t_dfs, ignore_index=True)
    dim_targy = dim_targy.rename(columns={'tárgykód': 'targykod', 'tárgynév': 'targynev', 'tárgy kredit': 'kredit', 'tárgyfelvétel típusa': 'tipus'})
    dim_targy = fix_columns(dim_targy).dropna(subset=['targykod']).drop_duplicates('targykod')
    dim_targy.to_sql('dim_targy', engine, if_exists='replace', index=False)

# ==========================================
# 4. TÉNYTÁBLÁK
# ==========================================
print("--- Ténytáblák feltöltése ---")

# Féléves statok
felev_files = get_files('hallgatoi_felevek_*.xlsx') + get_files('hallgatoi_felevek_*.csv')
for i, f in enumerate(felev_files):
    df = pd.read_csv(f, sep=';', on_bad_lines='skip') if f.endswith('.csv') else pd.read_excel(f)
    df = fix_columns(df)
    m = {'neptun kód': 'neptun_kod', 'hallgató képzésének féléves adata': 'felev', 'súlyozott átlag': 'atlag'}
    df = df.rename(columns=m)
    df.to_sql('fact_feleves_stat', engine, if_exists='replace' if i==0 else 'append', index=False)

# Jegyek (fact_teljesitesek)
# SZŰRÉS: Csak a TanulmanyiBejegyzesek mappa, és kizárjuk a 13Szak mappát
all_files = get_files('*.xlsx') + get_files('*.csv')
teljesites_files = []
for f in all_files:
    norm_path = f.replace('\\', '/')
    if 'TanulmanyiBejegyzesek' in norm_path and '13Szak' not in norm_path:
        teljesites_files.append(f)

fact_cols = ['neptun_kod', 'targykod', 'felev', 'beiras_datuma', 'alairas_statusz', 'erdemjegy', 'ervenyes']

for i, f in enumerate(teljesites_files):
    df = pd.read_csv(f, sep=';') if f.endswith('.csv') else pd.read_excel(f)
    df = fix_columns(df)
    mapping = {
        'neptun kód': 'neptun_kod', 'kód': 'targykod', 'tárgykód': 'targykod',
        'félév': 'felev', 'beírás dátuma': 'beiras_datuma', 'bejegyzés dátuma': 'beiras_datuma',
        'érvényes': 'ervenyes' # Visszakerült az érvényesség!
    }
    df = df.rename(columns=mapping)
    df = fix_columns(df)
    
    if 'beiras_datuma' in df.columns:
        df = filter_dates(df, 'beiras_datuma')
        
        if not df.empty:
            df['alairas_statusz'] = df['bejegyzés értéke'].apply(parse_alairas) if 'bejegyzés értéke' in df.columns else None
            df['erdemjegy'] = df['bejegyzés értéke'].apply(parse_jegy) if 'bejegyzés értéke' in df.columns else None
            
            # Érvényesség kinyerése (vagy alapértelmezett True, ha valamiért hiányzik az oszlop)
            if 'ervenyes' in df.columns:
                df['ervenyes'] = df['ervenyes'].apply(lambda x: str(x).strip().lower() in ['igaz', 'true', '1', 'igen', 'yes'])
            else:
                df['ervenyes'] = True 
            
            valid_cols = [c for c in fact_cols if c in df.columns]
            df[valid_cols].to_sql('fact_teljesitesek', engine, if_exists='replace' if i==0 else 'append', index=False)
            print(f"  -> {os.path.basename(f)}: Mentve.")
        else:
            print(f"  -> {os.path.basename(f)}: Átugorva (nem maradt valid dátumú sor).")

print(f"\n✨ Tiszta ETL kész! Futási idő: {round(time.time() - start_time, 2)} mp.")
