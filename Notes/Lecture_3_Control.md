# Lecture 3 Control
## 函数文档
* 函数定义通常包括描述函数的文档，称为“文档字符串 docstring”，它必须在函数体中缩进。文档字符串通常使用三个引号，第一行描述函数的任务，随后的几行可以描述参数并解释函数的意图。
```python
>>> def pressure(v, t, n):
        """计算理想气体的压力，单位为帕斯卡

        v -- 气体体积，单位为立方米
        t -- 绝对温度，单位为开尔文
        n -- 气体粒子
        """
        k = 1.38e-23 # 玻尔兹曼常数
        return n * k * t / v

# 查看某个函数的文档字符串，输入q退出
>>> help(pressure)
```
## 参数默认值
```python
>>> def pressure(v, t, n=6.022e23):
        """计算理想气体的压力，单位为帕斯卡

        v -- 气体体积，单位为立方米
        t -- 绝对温度，单位为开尔文
        n -- 气体粒子
        """
        k = 1.38e-23 # 玻尔兹曼常数
        return n * k * t / v

>>> pressure(1, 273.15)
2269.974834
>>> pressure(1, 273.15, 3 * 6.022e23)
6809.924502
```
## 复合语句
```
<header>:
    <statement>
    <statement>
    ...
<separating header>:
    <statement>
    <statement>
    ...
...    
```
## 条件语句
```
if <expression>:
    <suite>
elif <expression>:
    <suite>
else:
    <suite>
```
* Python包含多个假值，包括0、None和布尔值False，所有其他数字都是真值。
* 布尔运算符
```python
>>> True and False
False
>>> True or False
True
>>> not False
True
```
* `and` 和 `or` 总是返回它们所计算的最后一个值，无论是否发生了短路。当使用 `True` 和 `False` 以外的值时，`and` 和 `or` 并不总是返回布尔值。
## 迭代
```python
while <expression>:
    <suite>
```
## 测试
* 断言（Assertions）：程序员使用`assert`语句来验证是否符合预期。`assert`语句在布尔上下文中有一个表达式，后面是一个带引号的文本行（单引号或双引号都可以，但要保持一致），如果表达式的计算结果为假值，则显示该行。当被断言的表达式的计算结果为真值时，执行断言语句无效。而当它是假值时，`assert`会导致错误，使程序停止执行。
```python
>>> assert 3 > 2, 'Math is broken'
>>> assert 2 > 3, 'That is false'
AssertionError: That is false
```
```python
>>> def fib_test():
        assert fib(2) == 1, '第二个斐波那契数应该是1'
        assert fib(3) == 1, '第三个斐波那契数应该是1'
        assert fib(50) == 7778742049, '在第五十个斐波那契数发生error'
```
* 文档测试（Doctests）
```python
>>> def sum_naturals(n):
        """返回前n个自然数的和

        >>> sum_naturals(10)
        55
        >>> sum_naturals(100)
        5050
        """
        total, k = 0, 1
        while k <= n:
            total, k = total + k, k + 1
        return total

>>> from doctest import testmod
>>> testmod()
TestResults(failed=0, attempted=2)

>>> from doctest import run_docstring_examples
# 第一个参数是要测试的函数
# 第二个参数应该始终是表达式globals()的结果，这是一个用于返回全局环境的内置函数
# 第三个参数True表示我们想要详细输出
>>> run_docstring_examples(sum_naturals, globals(), True)
Finding tests in NoName
Trying:
    sum_naturals(10)
Expecting:
    55
ok
Trying:
    sum_naturals(100)
Expecting:
    5050
ok    

>>> python3 -m doctest -v <python_source_file>
```
