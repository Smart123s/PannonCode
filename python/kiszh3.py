export = [
        { "id" : 34342, "brand" : "Lenovo", "type": "Thinkpad T14 gen 4", "category" : "notebook", "weight" : 1.36, "battery": 52.5,
            "prices" : [{"webshop" : "Euronics", "price": 802000}, {"webshop" : "MediaMarkt", "price": 789000}, {"webshop" : "Emag", "price": 792000}]
        },
        { "id" : 81834, "brand" : "Dell",   "type": "Latitude", "category" : "notebook", "weight" : 2.03, "battery": 42.0,
            "prices" : [{"webshop" : "Euronics", "price": 495000}, {"webshop" : "MediaMarkt", "price": 499000}, {"webshop" : "Emag", "price": 489000}]
        },
        { "id" : 37219, "brand" : "Lenovo", "type": "ThinkCentre M720", "category" : "desktop", "monitor" : True,
            "prices" : [{"webshop" : "Euronics", "price": 467000},{"webshop" : "MediaMarkt", "price": 498000}, {"webshop" : "Emag", "price": 501000}]
        },
        { "id" : 13832, "brand" : "Hp",     "type": "Elitebook 840", "category" : "notebook", "weight" : 1.90, "battery": 53.5,
            "prices" : [{"webshop" : "Euronics", "price": 460000}, {"webshop" : "MediaMarkt", "price": 467000}, {"webshop" : "Emag", "price": 466000}]
        },
        { "id" : 77291, "brand" : "Dell",   "type": "OptiPlex 3080", "category" : "desktop", "monitor" : False,
            "prices" : [{"webshop" : "Euronics", "price": 381000},{"webshop" : "MediaMarkt", "price": 388000}, {"webshop" : "Emag", "price": 411000}]
        },
        { "id" : 39244, "brand" : "Asus",   "type": "VivoBook X414EA", "category" : "notebook", "weight" : 2.36, "battery": 44.8,
            "prices" : [{"webshop" : "Euronics", "price": 120000}, {"webshop" : "MediaMarkt", "price": 129000}, {"webshop" : "Emag", "price": 125000}]
        },
        { "id" : 54232, "brand" : "Lenovo", "type": "IdeaPad Flex 5", "category" : "notebook", "weight" : 2.16, "battery": 50.2,
            "prices" : [{"webshop" : "Euronics", "price": 118000}, {"webshop" : "MediaMarkt", "price": 121000}, {"webshop" : "Emag", "price": 129000}]
        },
        { "id" : 65434, "brand" : "Lenovo", "type": "Yoga Creator 7i", "category" : "notebook","weight" : 1.80, "battery": 49.9,
            "prices" : [{"webshop" : "Euronics", "price": 520000}, {"webshop" : "MediaMarkt", "price": 532000}, {"webshop" : "Emag", "price": 528000}]
        },
     ]

class Computer:
    def __init__(self, id, brand, type, prices):
        self.id = id
        self.brand = brand
        self.type = type
        self.prices = prices


class Notebook(Computer):
    def __init__(self, id, brand, type, prices, weight, battery):
        super().__init__(id, brand, type, prices)
        self.weight = weight
        self.batter = battery

    def price_avg(self):
        return int(sum(a['price'] for a in self.prices) / len(self.prices))

    def __repr__(self):
        return f"{self.brand} {self.type} ({self.price_avg()} Ft)"


class Desktop(Computer):
    def __init__(self, id, brand, type, prices, monitor):
        super().__init__(id, brand, type, prices)
        self.monitor = monitor

    def __getitem__(self, index):
        return self.prices[index]

    def __repr__(self):
        shops = list(map(lambda a: a['webshop'], self.prices))
        return f"{self.brand} {self.type} ({', '.join(shops)})"

l = []
for c in export:
    if c['category'] == 'notebook':
        l.append(Notebook(c['id'], c['brand'], c['type'], c['prices'], c['weight'], c['battery']))
    elif c['category'] == 'desktop':
        l.append(Desktop(c['id'], c['brand'], c['type'], c['prices'], c['monitor']))
    else:
        raise Exception('Hibás kategória')

for c in l:
    print(c)
