# Lecture 20 Inheritance
# 继承
```python
>>> class Account:
        """一个余额非零的账户。"""
        interest = 0.02
        def __init__(self, account_holder):
            self.balance = 0
            self.holder = account_holder
        def deposit(self, amount):
            """存入账户 amount，并返回变化后的余额"""
            self.balance = self.balance + amount
            return self.balance
        def withdraw(self, amount):
            """从账号中取出 amount，并返回变化后的余额"""
            if amount > self.balance:
                return 'Insufficient funds'
            self.balance = self.balance - amount
            return self.balance

>>> class CheckingAccount(Account):
        """从账号取钱会扣出手续费的账号"""
        withdraw_charge = 1
        interest = 0.01
        def withdraw(self, amount):
            return Account.withdraw(self, amount + self.withdraw_charge)

>>> checking = CheckingAccount('Sam')
>>> checking.deposit(10)
10
>>> checking.withdraw(5)
4
>>> checking.interest
0.01
```
```python
class Bank:
    """A bank has accounts.

    >>> bank = Bank()
    >>> john = bank.open_account('John', 10)
    >>> jack = bank.open_account('Jack', 5, CheckingAccount)
    >>> john.interest
    0.02
    >>> jack.interest
    0.01
    >>> bank.pay_interest()
    >>> john.balance
    10.2
    """
    def __init__(self):
        self.accounts = []
    
    def open_account(self, holder, amount, kind=Account):
        account = kind(holder)
        account.deposit(amount)
        self.accounts.append(account)
        return account
    
    def pay_interest(self):
        for a in self.accounts:
            a.deposit(a.balance * a.interest)
```
* 在类中查找名称:
  * 如果它命名在指定类中的属性，则返回属性值。
  * 否则，在该类的父类中查找该名称的属性。
![alt text](images/image-12.png)
* 子类调用父类的构造函数
```python
class Parent:
    def __init__(self, name):
        self.name = name
        print(f"Parent initialized with name: {self.name}")

class Child(Parent):
    def __init__(self, name, age):
        super().__init__(name)  # 调用父类的__init__方法
        self.age = age
        print(f"Child initialized with age: {self.age}")

# 使用示例
child = Child("Alice", 10)
# 输出:
# Parent initialized with name: Alice
# Child initialized with age: 10
```
### 多继承
```python
>>> class SavingsAccount(Account):
        deposit_charge = 2
        def deposit(self, amount):
            return Account.deposit(self, amount - self.deposit_charge)

>>> class AsSeenOnTVAccount(CheckingAccount, SavingsAccount):
        def __init__(self, account_holder):
            self.holder = account_holder
            self.balance = 1           # 赠送的 1 $!

>>> such_a_deal = AsSeenOnTVAccount("John")
>>> such_a_deal.balance
1
>>> such_a_deal.deposit(20)            # 调用 SavingsAccount 的 deposit 方法，会产生 2 $的存储费用
19
>>> such_a_deal.withdraw(5)            # 调用 CheckingAccount 的 withdraw 方法，产生 1 $的取款费用。
13
>>> such_a_deal.deposit_charge
2
>>> such_a_deal.withdraw_charge
1
```
![alt text](images/image-13.png)
* 对于像这样的简单“菱形”形状，Python 会从左到右解析名称，然后向上解析名称。在此示例中，Python 按顺序检查以下类中的属性名称，直到找到具有该名称的属性：`AsSeenOnTVAccount`, `CheckingAccount`, `SavingsAccount`, `Account`, `object`
```python
>>> [c.__name__ for c in AsSeenOnTVAccount.mro()]
['AsSeenOnTVAccount', 'CheckingAccount', 'SavingsAccount', 'Account', 'object']
```