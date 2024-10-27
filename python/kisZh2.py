from pprint import pprint

export = [{"license": "BAC-423", "brand": "Opel", "type": "Astra", "category": "car", "services": [
    {"km": 25600, "price": 89000},
    {"km": 56100, "price": 71500},
    {"km": 82950, "price": 123400},
    {"km": 101010, "price": 75100}]},
          {"license": "GHU-732", "brand": "Ford", "type": "Transit", "category": "truck", "services": [
              {"km": 55600, "price": 103400},
              {"km": 86700, "price": 134000},
              {"km": 11295, "price": 89000}]},

          {"license": "FGA-111", "brand": "Suzuki", "type": "Vitara", "category": "car", "services": [
              {"km": 14200, "price": 56700},
              {"km": 23900, "price": 71500},
              {"km": 29050, "price": 89100},
              {"km": 34000, "price": 75700}]}
          ]

def services_avg(c):
    asd = 0
    for a in c["services"]:
        asd += a["km"]
    avg = asd / len(c["services"])
    return avg


cars = list(filter(lambda a: a["category"] == "car", export))
for a in cars:
    a["avgkm"] = services_avg(a)

cars = list(sorted(cars, key=lambda a: a["avgkm"]))

c = cars[-1]

print(c["license"])
print(c["brand"])
print(c["type"])

# pprint(cars)
