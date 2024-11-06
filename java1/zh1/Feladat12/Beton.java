public class Beton {
	
	private float sizeX;
	private float sizeY;
	private float sizeZ;
	private float mass;
	
	// Leadás előtti ellenőrzéskor vettem észre, hogy az 1a feladatban szerepel a "pl." kifejezés, így
	// lehet mégse enum-mal kellett volna megoldani, ezért kikommenteltem
	// De nem töröltem ki az BetonType Enum file-t ezzel is fitogtatni akaorm a sokrétű tudásomat az enum-oról
	// Jó, ezt én se gondoltam teljesen komolyan... Inkább csak sajnáltam kitörölni, na..
	//private BetonType typeEnum;
	private String type;
	
	public Beton(float sizeX, float sizeY, float sizeZ, float mass) {
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		this.sizeZ = sizeZ;
		this.mass = mass;
		
		// 1d feladat hibakezelés
		// nem volt az 1d feladatban utasítás, szóval kitaláltam valamit :D
		if (!(mass > 1.8 && mass < 2.4)) {
			// throw new Exception("Nem megfelelő sűrűség");
			// Itt kéne a constructor felé throws Exception
			// Meg a main-ben is try catch
			System.out.println("Biztos jó ez a sűrűség?");
		}
	}
	
	public float getSizeX() {
		return sizeX;
	}
	
	public float getSizeY() {
		return sizeY;
	}
	
	public float getSizeZ() {
		return sizeZ;
	}
	
	public float getMass() {
		return mass;
	}
	
	// public BetonType getType() {
	public String getType() {
		return type;
	}
	
	public float terfogat(){
		return sizeX * sizeX * sizeZ;
	}
	
	public float weight() {
		return terfogat() * mass;
	}
}