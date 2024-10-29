from pprint import pprint
from typing import List, Dict

export = {
    "cars":
        [
            {"plate": "AG-KF-732", "brand": "Ford", "model": "Focus", "year": 2024, "fuel type": "petrol",
             "horsepower": 160, "consumption": 4.6},
            {"plate": "AB-BB-542", "brand": "Renault", "model": "Zoe", "year": 2022, "fuel type": "electric",
             "horsepower": 135, "range": 350},
            {"plate": "AG-WE-333", "brand": "Opel", "model": "Astra", "year": 2020, "fuel type": "petrol",
             "horsepower": 105, "consumption": 6.4},
            {"plate": "AD-QQ-123", "brand": "Tesla", "model": "Model 3", "year": 2022, "fuel type": "electric",
             "horsepower": 283, "range": 580},
            {"plate": "AG-LE-554", "brand": "Volkswagen", "model": "Golf", "year": 2021, "fuel type": "petrol",
             "horsepower": 150, "consumption": 5.1}
        ],
    "history": [
        {"id": 1, "name": "2024-08",
         "companies": [{"hash": "kjd23bhasdjf", "name": "TechSphere",
                        "bookings": [{"plate": "AG-KF-732", "day": 4, "hours": "12:00", "km": 590},
                                     {"plate": "AB-BB-542", "day": 5, "hours": "08:00", "km": 110},
                                     {"plate": "AG-LE-554", "day": 12, "hours": "11:00", "km": 450},
                                     {"plate": "AD-QQ-123", "day": 16, "hours": "12:00", "km": 320},
                                     {"plate": "AD-QQ-123", "day": 18, "hours": "14:00", "km": 330},
                                     {"plate": "AD-QQ-123", "day": 24, "hours": "08:00", "km": 90}
                                     ]},
                       {"hash": "2je7wqu2j342", "name": "Quantum Innovations",
                        "bookings": [{"plate": "AG-KF-732", "day": 20, "hours": "12:00", "km": 220},
                                     {"plate": "AB-BB-542", "day": 22, "hours": "08:00", "km": 110}
                                     ]},
                       {"hash": "ee68quwjqu22", "name": "Nexus Consulting",
                        "bookings": [{"plate": "AG-LE-554", "day": 1, "hours": "10:00", "km": 340},
                                     {"plate": "AG-LE-554", "day": 5, "hours": "13:00", "km": 410},
                                     {"plate": "AD-QQ-123", "day": 11, "hours": "07:00", "km": 130}
                                     ]},
                       ]
         },
        {"id": 2, "name": "2024-09",
         "companies": [{"hash": "kjd23bhasdjf", "name": "TechSphere",
                        "bookings": [{"plate": "AG-KF-732", "day": 3, "hours": "12:00", "km": 470},
                                     {"plate": "AB-BB-542", "day": 8, "hours": "08:00", "km": 280},
                                     {"plate": "AD-QQ-123", "day": 18, "hours": "14:00", "km": 320},
                                     {"plate": "AG-LE-554", "day": 24, "hours": "08:00", "km": 50}
                                     ]},
                       {"hash": "12edawqew323", "name": "GreenLeaf Solutions",
                        "bookings": [{"plate": "AG-LE-554", "day": 41, "hours": "09:00", "km": 280},
                                     {"plate": "AD-QQ-123", "day": 10, "hours": "11:30", "km": 210},
                                     {"plate": "AD-QQ-123", "day": 11, "hours": "09:30", "km": 170}
                                     ]},
                       ]
         }
    ]
}


class Car:
    def __init__(self, plate: str, brand: str, model: str, year: int):
        self.plate: str = plate
        self.brand: str = brand
        self.model: str = model
        self.year: int = year

    def __dict__(self):
        return {
            "plate": self.plate,
            "type": self.brand + ' ' + self.model,
            "year": self.year
        }


class PetrolCar(Car):
    def __init__(self, plate: str, brand: str, model: str, year: int, consumption: float):
        super().__init__(plate, brand, model, year)
        self.consumption: float = consumption


class CarList:
    def __init__(self, items):
        self.list: List[Car] = []
        for item in items:
            if item["fuel type"] == "electric":
                self.list.append(Car(item['plate'], item['brand'], item['model'], item['year']))
            elif item["fuel type"] == "petrol":
                self.list.append(PetrolCar(item['plate'], item['brand'], item['model'], item['year'], item['consumption']))
            else:
                raise ValueError(f"fuel type {item['fuel type']} not supported")
            # print(self.list[-1].__class__)

    def by_plate(self, plate: str):
        for car in self.list:
            if car.plate == plate:
                return car


class Company:
    def __init__(self, id_hash: str, name: str, bookings: List):
        self.id_hash: str = id_hash
        self.name: str = name
        self.bookings: List = bookings

    def km_by_plate(self, plate: str):
        bookings = list(filter(lambda booking: booking["plate"] == plate, self.bookings))
        return sum([a["km"] for a in bookings])

    def __repr__(self):
        # Quantum Innovations, 330 km, (Ford Focus, Renault Zoe)
        cars_set = set([a["plate"] for a in self.bookings])

        return f"{self.name}, {sum([a["km"] for a in self.bookings])} km, ({', '.join(cars_set)})"


class MonthlyData:
    def __init__(self, history: Dict):
        self.id_: str = history["id"]
        self.month = history["name"]
        # Itt lehet félreértettem a feladatot, és valójában ez kéne:
        # self.month = history["name"].split("-")[1]
        self.companies = [
            Company(a["hash"], a["name"], a["bookings"]) for a in history["companies"]
        ]

    def total_km(self) -> int:
        total = 0
        for company in self.companies:
            # sum([a.km for a in company.bookings])
            for booking in company.bookings:
                total += booking["km"]
        return total

    def total_km_per_car(self) -> Dict:
        total = {}
        for company in self.companies:
            # sum([a.km for a in company.bookings])
            for booking in company.bookings:
                if not booking["plate"] in total:
                    total[booking["plate"]] = 0
                total[booking["plate"]] += booking["km"]
        return total


class Converter:
    def __init__(self, exports: Dict):
        self.cars = CarList(exports["cars"])
        self.history = [MonthlyData(a) for a in exports["history"]]

    def convert(self) -> List:
        data = []
        for m in self.history:
            carss = []
            for k, v in m.total_km_per_car().items():
                c: Car = self.cars.by_plate(k)
                carss.append({
                    "plate": k,
                    "type": c.brand + " " + c.model,
                    "sumkm": v,
                })

            data.append({
                "month": m.month,
                "cars": carss,
            })
        return data


if __name__ == "__main__":
    converter = Converter(export)
    pprint(converter.convert())

    # b2 feladat teszt
    c1 = export["history"][0]["companies"][0]
    c = Company(c1["hash"], c1["name"], c1["bookings"])
    print('b2 feladat teszt:', c.km_by_plate("AD-QQ-123"))

    # b3 feladat teszt
    c1 = export["history"][0]["companies"][1]
    c = Company(c1["hash"], c1["name"], c1["bookings"])
    print('b3 feladat teszt:', c)

    # c2 feladat teszt
    m = MonthlyData(export["history"][0])
    print('c2 feladat teszt:', m.total_km())
