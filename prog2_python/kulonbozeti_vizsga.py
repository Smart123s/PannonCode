from abc import ABC, abstractmethod
from datetime import date
from typing import List

class Contract(ABC):
    def __init__(self, contract_number: str, start: date, organizational_unit: str, end: date = None):
        self._contract_number = contract_number
        self._start: date = start
        self._organizational_unit = organizational_unit
        self._end = end
        
    @property
    def contract_number(self):
        return self._contract_number
    
    @property
    def start(self) -> date:
        return self._start
    
    @property
    def organizational_unit(self):
        return self._organizational_unit
    
    # Write your solution here

    @property
    def end(self):
        return self._end

    @end.setter
    def end(self, value):
        if value < self.start:
            raise ValueError(f'End date ({value}) before start date ({self.start})!')
        self._end = value
        
    def __str__(self):
        return f"{self._contract_number} from {self._start.strftime('%Y-%m-%d')}{' to ' + self._end.strftime('%Y-%m-%d') if self._end != None else ''} ({self._organizational_unit})"

# Write your solution here


class CooperationAgreement(Contract):
    def __init__(self, contract_number: str, start: date, organizational_unit: str, partner: str = None):
        Contract.__init__(self, contract_number, start, organizational_unit, None)
        self._partner = partner


    @property
    def partner(self):
        return self._partner

    def __str__(self):
        return Contract.__str__(self) + ' - partner: ' + self._partner + f' [{self.__class__.__name__}]'


class PurchaseContract(Contract):
    def __init__(self, contract_number: str, start: date, organizational_unit: str,
                 amount: int = None):
        Contract.__init__(self, contract_number, start, organizational_unit, None)
        self._amount = amount

    @property
    def amount(self):
        return self._amount

    def __str__(self):
        return Contract.__str__(self) + ' - amount: ' + str(self.amount) + f' [{self.__class__.__name__}]'


# Write your solution here

class ContractObserver(ABC):
    @abstractmethod
    def contract_created(self, contract: Contract):
        pass
    
# Write your solution here
    
# Write your solution here

class ContractManager:
    def __init__(self):
        self.storage: List[Contract] = []
        self.observers: List[ContractObserver] = []

    def add_observer(self, observer: ContractObserver):
        self.observers.append(observer)

    def read_contracts(self):
        with open('contracts.csv', 'r') as csvfile:
            for line in csvfile:
                fields = line.strip().split(',')
                contract_number = fields[0]
                start_date = fields[1]
                end_date = fields[2]
                organizational_unit = fields[3]
                type = fields[4]
                data = fields[5]
                contract = None
                if type == 'CooperationAgreement':
                    contract = CooperationAgreement(contract_number, date(int(start_date[0:4]), int(start_date[5:7]), int(start_date[8:10])), organizational_unit, data)
                elif type == 'PurchaseContract':
                    contract = PurchaseContract(contract_number, date(int(start_date[0:4]), int(start_date[5:7]), int(start_date[8:10])), organizational_unit, int(data))
                if end_date != 'None':
                    contract.end = date(int(end_date[0:4]), int(end_date[5:7]), int(end_date[8:10]))
                # Write your solution here
                self.storage.append(contract)

    # Write your solution here
    def print_all(self):
        for contract in self.storage:
            print(contract.__str__())

    def find_by_contract_number(self, contract_number):
        x = next((x for x in self.storage if x.contract_number == contract_number), None)
        return x

    def print_sorted_by_start(self):
        l = sorted(self.storage, key=lambda contract: contract.start)
        for contract in l:
            print(contract.__str__())

    def contracts_in_year(self, year: int):
        return list(filter(lambda contract: contract.start.year == year, self.storage))

    def partners(self):
        # csak CooperationAgreement-nek van partnere
        l = list(filter(lambda a: a.__class__.__name__ == 'CooperationAgreement', self.storage))
        return set([a.partner for a in l])

    def new_contract(self, t: str, start: date, end: date, organizational_unit: str,
                 extra: any = None):
        l = self.contracts_in_year(start.year)
        len(l)
        s = l[-1].contract_number.split('/')
        num = len(l)+1
        contract_number = f'{s[0]}/' + "{:04d}".format(num) + f'/{s[2]}'

        yey = None
        if t == 'PurchaseContract':
            yey = PurchaseContract(contract_number, start, organizational_unit, extra)
        elif t == 'CooperationAgreement':
            yey = CooperationAgreement(contract_number, start, organizational_unit, extra)

        self.storage.append(yey)

        for o in self.observers:
            o.contract_created(yey)

        return yey

class FilingObserver(ContractObserver):
    def __init__(self):
        super().__init__()


    def contract_created(self, contract: Contract):
        print('New contract created -> filing contract number: ' + contract.contract_number)

class NotificatioObserver(ContractObserver):
    def __init__(self, organizational_unit: str):
        super().__init__()
        self._organizational_unit = organizational_unit

    def contract_created(self, contract: Contract):
        if (self._organizational_unit == contract.organizational_unit):
            print('New contract created on: ' + self._organizational_unit + ' -> notifying organizational unit')



def main():
    def test_1_a():
        print('Executing test_1_a')
        try:
            try:
                c = Contract('PE/0012/2024', date(2024, 10, 1), 'MIK')
                c.end = date(2024, 12, 31)
                print(c)
            except ValueError as err:
                print(f"ValueError: {err}")
                
            try:
                c = Contract('PE/0003/2025', date(2025, 1, 10), 'GTK')
                c.end = date(2024, 12, 31)
                print(c)
            except ValueError as err:
                print(f"ValueError: {err}")
        except Exception as ex:
            print(f"Unhandled exception in test_1_a: {ex}")
        print()      
    def test_1_b():
        print('Executing test_1_b')
        try:
            c = CooperationAgreement('PE/0123/2023', date(2023, 3, 15), 'GTK', 'Google Inc.')
            print(c)
            print(f"Partner: {c.partner}")
            c.end = date(2024, 11, 30)
            print(c)
        except Exception as ex:
            print(f"Unhandled exception in test_1_b: {ex}")
        print()
    def test_1_c():
        print('Executing test_1_c')
        try:
            c = PurchaseContract('PE/0007/2024', date(2024, 6, 10), 'MK', 35000000)
            print(c)
            print(f"Amount: {c.amount}")
            c.end = date(2025, 6, 30)
            print(c)
        except Exception as ex:
            print(f"Unhandled exception in test_1_c: {ex}")
        print()
            
    def test_2_a():
        print('Executing test_2_a')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            contract_manager.print_all()
        except Exception as ex:
            print(f"Unhandled exception in test_2_a: {ex}")
        print()
    def test_2_b():
        print('Executing test_2_b')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            
            contract_number = 'PE/0001/2023'
            c = contract_manager.find_by_contract_number(contract_number)
            if c is not None:
                print(f"Contract found: {c}")
            else:
                print(f"Contract not found with contract number {contract_number}")
                
            print()
    
            contract_number = 'PE/1234/2024'
            c = contract_manager.find_by_contract_number(contract_number)
            if c is not None:
                print(f"Contract found: {c}")
            else:
                print(f"Contract not found with contract number {contract_number}")
        except Exception as ex:
            print(f"Unhandled exception in test_2_b: {ex}")
        print()
      
    def test_3_a():
        print('Executing test_3_a')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            contract_manager.print_sorted_by_start()
        except Exception as ex:
            print(f"Unhandled exception in test_3_a: {ex}")
        print()  
    def test_3_b():
        print('Executing test_3_b')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            
            contracts_in_year_2023 = contract_manager.contracts_in_year(2023)
            print("Contracts in year 2023:")
            if len(contracts_in_year_2023) > 0:
                for c in contracts_in_year_2023:
                    print(f"  {c}")
            else:
                print("There are no contracts in 2023")
                
            print()
            
            contracts_in_year_2030 = contract_manager.contracts_in_year(2030)
            print("Contracts in year 2030:")
            if len(contracts_in_year_2030) > 0:
                for c in contracts_in_year_2030:
                    print(f"  {c}")
            else:
                print("There are no contracts in 2030")
        except Exception as ex:
            print(f"Unhandled exception in test_3_b: {ex}")
        print()
    def test_3_c():
        print('Executing test_3_c')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            print(contract_manager.partners())
        except Exception as ex:
            print(f"Unhandled exception in test_3_c: {ex}")
        print()
        
    def test_4():
        print('Executing test_4')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            
            c = contract_manager.new_contract('PurchaseContract', date(2023, 3, 12), None, 'MIK', 120000000)
            print(f"Added new contract: {c}")
            print(f"New contract in contract manager: {contract_manager.find_by_contract_number('PE/0011/2023')}")
            
            print()
    
            c = contract_manager.new_contract('CooperationAgreement', date(2024, 5, 19), date(2025, 8, 31), 'HTK', 'META Inc.')
            print(f"Added new contract: {c}")
            print(f"New contract in contract manager: {contract_manager.find_by_contract_number('PE/0011/2024')}")
        except Exception as ex:
            print(f"Unhandled exception in test_4: {ex}")
        print()
        
    def test_5_a():
        print('Executing test_5_a')
        try:
            observer: ContractObserver = FilingObserver()
            observer.contract_created(Contract('PE/0012/2024', date(2024, 10, 1), 'MIK'))
            observer.contract_created(Contract('PE/0003/2025', date(2025, 1, 10), 'GTK'))
        except Exception as ex:
            print(f"Unhandled exception in test_5_a: {ex}")
        print()
        
    def test_5_b():
        print('Executing test_5_b')
        try:
            mik_observer: ContractObserver = NotificatioObserver('MIK')
            mik_observer.contract_created(Contract('PE/0012/2024', date(2024, 10, 1), 'MIK'))
            mik_observer.contract_created(Contract('PE/0003/2025', date(2025, 1, 10), 'GTK'))
            
            print()
            
            gtk_observer: ContractObserver = NotificatioObserver('GTK')
            gtk_observer.contract_created(Contract('PE/0012/2024', date(2024, 10, 1), 'MIK'))
            gtk_observer.contract_created(Contract('PE/0003/2025', date(2025, 1, 10), 'GTK'))
            
            print()
            
            htk_observer: ContractObserver = NotificatioObserver('HTK')
            htk_observer.contract_created(Contract('PE/0012/2024', date(2024, 10, 1), 'MIK'))
            htk_observer.contract_created(Contract('PE/0003/2025', date(2025, 1, 10), 'GTK'))
        except Exception as ex:
            print(f"Unhandled exception in test_5_b: {ex}")
        print()
        
    def test_5_c():
        print('Executing test_5_c')
        try:
            contract_manager = ContractManager()
            contract_manager.read_contracts()
            
            filing_observer: ContractObserver = FilingObserver()
            mik_observer: ContractObserver = NotificatioObserver('MIK')
            gtk_observer: ContractObserver = NotificatioObserver('GTK')
            htk_observer: ContractObserver = NotificatioObserver('HTK')
            contract_manager.add_observer(filing_observer)
            contract_manager.new_contract('PurchaseContract', date(2023, 3, 12), None, 'MIK', 120000000)
            contract_manager.new_contract('CooperationAgreement', date(2024, 5, 19), date(2025, 8, 31), 'HTK', 'META Inc.')
            
            print()
            
            contract_manager.add_observer(mik_observer)
            contract_manager.new_contract('PurchaseContract', date(2023, 3, 12), None, 'MIK', 120000000)
            contract_manager.new_contract('CooperationAgreement', date(2024, 5, 19), date(2025, 8, 31), 'HTK', 'META Inc.')
            
            print()
            
            contract_manager.add_observer(gtk_observer)
            contract_manager.add_observer(htk_observer)
            contract_manager.new_contract('PurchaseContract', date(2023, 3, 12), None, 'MIK', 120000000)
            contract_manager.new_contract('CooperationAgreement', date(2024, 5, 19), date(2025, 8, 31), 'HTK', 'META Inc.')
        except Exception as ex:
            print(f"Unhandled exception in test_5_c: {ex}")
        print()
            
    test_1_a()
    test_1_b()
    test_1_c()
    
    test_2_a()
    test_2_b()
    
    test_3_a()
    test_3_b()
    test_3_c()
    
    test_4()
    
    test_5_a()
    test_5_b()
    test_5_c()

if __name__ == "__main__":
    main()
