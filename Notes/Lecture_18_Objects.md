# Lecture 18 Objects
## 对象和类
```python
>>> class Account:
        # 构造函数
        def __init__(self, account_holder):
            # self绑定到新创建的Account对象
            self.balance = 0
            self.holder = account_holder
        def deposit(self, amount):
            self.balance = self.balance + amount
            return self.balance
        def withdraw(self, amount):
            if amount > self.balance:
                return 'Insufficient funds'
            self.balance = self.balance - amount
            return self.balance

>>> a = Account('Kirk')
>>> a.balance
0
>>> a.holder
'Kirk'
>>> b = Account('Spock')
>>> b.balance = 200
>>> [acc.balance for acc in (a, b)]
[0, 200]

>>> a is a
True
>>> a is not b
True
>>> c = a
>>> c is a
True
```
## 消息传递和点表达式
```python
>>> spock_account = Account('Spock')
>>> spock_account.deposit(100)
100
>>> spock_account.withdraw(90)
10
>>> spock_account.withdraw(90)
'Insufficient funds'
>>> spock_account.holder
'Spock'
>>> getattr(spock_account, 'balance')
10
>>> hasattr(spock_account, 'deposit')
True

>>> type(Account.deposit)
<class 'Function'>
>>> type(spock_account.deposit)
<class 'method'>

>>> Account.deposit(spock_account, 1001)    # 函数 deposit 接受两个参数
1011
>>> spock_account.deposit(1000)             # 方法 deposit 接受一个参数
2011
```