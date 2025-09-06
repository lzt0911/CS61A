# Lecture 13 Data Abstraction
## 原始数据类型
* Python 中的每个值都有一个类（class）来确定它的类型。
* Python 包含三种原始数字类型：整数（int）、浮点数（float）和复数（complex）。
```python
>>> type(2)
<class 'int'>
>>> type(1.5)
<class 'float'>
>>> type(1+1j)
<class 'complex'>

>>> type(1/3)
<class 'float'>
>>> 1/3
0.3333333333333333
```
## 数据抽象
```python
# rational(n, d) 返回分子为 n、分母为 d 的有理数
# numer(x) 返回有理数 x 的分子
# denom(x) 返回有理数 x 的分母
>>> from fractions import gcd
>>> def rational(n, d):
        g = gcd(n, d)
        return (n//g, d//g)

>>> def numer(x):
        return x[0]

>>> def denom(x):
        return x[1]

>>> def add_rationals(x, y):
        nx, dx = numer(x), denom(x)
        ny, dy = numer(y), denom(y)
        return rational(nx * dy + ny * dx, dx * dy)

>>> def mul_rationals(x, y):
        return rational(numer(x) * numer(y), denom(x) * denom(y))

>>> def print_rational(x):
        print(numer(x), '/', denom(x))

>>> def rationals_are_equal(x, y):
        return numer(x) * denom(y) == numer(y) * denom(x)

>>> half = rational(1, 2)
>>> print_rational(half)
1 / 2
>>> third = rational(1, 3)
>>> print_rational(mul_rationals(half, third))
1 / 6
>>> print_rational(add_rationals(third, third))
2 / 3
```