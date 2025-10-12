# Lecture 18 Attributes
## 类属性
```python
>>> class Account:
        interest = 0.02            # 类属性
        def __init__(self, account_holder):
            self.balance = 0
            self.holder = account_holder
        # 在这里定义更多的方法

>>> spock_account = Account('Spock')
>>> kirk_account = Account('Kirk')
>>> spock_account.interest
0.02
>>> kirk_account.interest
0.02
>>> Account.interest = 0.04
>>> spock_account.interest
0.04
>>> kirk_account.interest
0.04

# 如果我们分配给账户示例的命名属性interest，我们将创建一个与现有类属性同名的新实例属性
>>> kirk_account.interest = 0.08
>>> kirk_account.interest
0.08
>>> spock_account.interest
0.04
```
```python
<expression> . <name>
```
* 计算点表达式：
  * 点表达式左侧的 `<expression>` ，生成点表达式的对象。
  * `<name>` 与该对象的实例属性匹配；如果存在具有该名称的属性，则返回属性值。
  * 如果实例属性中没有 `<name>` ，则在类中查找 `<name>`，生成类属性。
  * 除非它是函数，否则返回属性值。如果是函数，则返回该名称绑定的方法。