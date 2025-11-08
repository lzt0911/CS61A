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
```python
class Employee:
    # 类变量
    company = "ABC Corp"
    employee_count = 0
    
    def __init__(self, name, salary):
        # 成员变量
        self.name = name
        self.salary = salary
        # 修改类变量应该使用类名
        Employee.employee_count += 1
    
    def show_info(self):
        # 访问成员变量 - 必须使用self.
        print(f"员工姓名: {self.name}")
        print(f"工资: {self.salary}")
        
        # 访问类变量 - 推荐使用类名
        print(f"公司: {Employee.company}")
        print(f"员工总数: {Employee.employee_count}")
    
    def change_salary(self, new_salary):
        # 修改成员变量 - 必须使用self.
        self.salary = new_salary
    
    @classmethod
    def change_company(cls, new_company):
        # 修改类变量 - 在类方法中使用cls
        cls.company = new_company
    
    def problematic_company_change(self, new_company):
        # 错误：这会创建一个同名的成员变量，而不是修改类变量
        self.company = new_company
        print(f"self.company: {self.company}")
        print(f"Employee.company: {Employee.company}")

# 使用示例
emp1 = Employee("张三", 5000)
emp2 = Employee("李四", 6000)

print("=== 初始信息 ===")
emp1.show_info()
print()

print("=== 尝试错误地修改类变量 ===")
emp1.problematic_company_change("XYZ Inc")
print(f"emp1的公司: {emp1.company}")      # 输出: XYZ Inc (成员变量)
print(f"emp2的公司: {emp2.company}")      # 输出: ABC Corp (类变量)
print(f"Employee.company: {Employee.company}")  # 输出: ABC Corp (类变量未变)
print()

print("=== 正确修改类变量 ===")
Employee.change_company("New Corp")
print(f"emp1的公司: {emp1.company}")      # 输出: XYZ Inc (仍然是成员变量)
print(f"emp2的公司: {emp2.company}")      # 输出: New Corp (类变量已更新)
print(f"Employee.company: {Employee.company}")  # 输出: New Corp
```