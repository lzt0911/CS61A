# Lecture 21 Representation
* `repr(object) -> string`: 获取对象的“官方字符串表示”。`repr`函数总是在其参数值上调用一个名为`__repr__`的方法
* The result of calling `str` on the value of an expression is what python prints using the `print` function.
```python
>>> x = [1, 2, 3]
>>> print(repr(x))
[1, 2, 3]

>>> 12e12
12000000000000.0
>>> print(repr(12e12))
12000000000000.0

>>> repr(min)
'<built-in function min>'

>>> from datetime import date
>>> tues = date(2011, 9, 12)
>>> repr(tues)
'datetime.date(2011, 9, 12)'
>>> str(tues)
'2011-09-12'
```
```python
def repr(x):
    return type(x).__repr__(x)
```
* `eval()`: 执行字符串表达式
```python
expr = "3 * (4 + 5)"
result = eval(xepr)
print(result) # 27
```
* `f-string`
```python
print(f'pi start with {pi}...')
```
* `__bool__`方法
```python
>>> Account.__bool__ = lambda self: self.balance != 0

>>> bool(Account('Jack'))
False
>>> if not Account('Jack'):
        print('Jack has nothing')
Jack has nothing

# 如果序列没有提供 __bool__ 方法，那么 Python 会使用序列的长度来确定其真假值。空的序列是假值，而非空序列是真值。
>>> bool('')
False
>>> bool([])
False
>>> bool('Go Bears!')
True
```
* `__getitem__`方法由元素选择操作符调用，但也可以直接调用它
```python
>>> 'Go Bears!'[3]
'B'
>>> 'Go Bears!'.__getitem__(3)
'B'
```
* `__call__`方法
```python
>>> class Adder(object):
        def __init__(self, n):
            self.n = n
        def __call__(self, k):
            return self.n + k
>>> add_three_obj = Adder(3)
>>> add_three_obj(4)
7
```
* `@property`装饰器可以将一个类的方法变成一个“像属性一样访问”的接口
```python
>>> class Number:
        def __add__(self, other):
            return self.add(other)
        def __mul__(self, other):
            return self.mul(other)

>>> class Complex(Number):
        def add(self, other):
            return ComplexRI(self.real + other.real, self.imag + other.imag)
        def mul(self, other):
            magnitude = self.magnitude * other.magnitude
            return ComplexMA(magnitude, self.angle + other.angle)


>>> from math import atan2
>>> class ComplexRI(Complex):
        def __init__(self, real, imag):
            self.real = real
            self.imag = imag
        @property
        def magnitude(self):
            return (self.real ** 2 + self.imag ** 2) ** 0.5
        @property
        def angle(self):
            return atan2(self.imag, self.real)
        def __repr__(self):
            return 'ComplexRI({0:g}, {1:g})'.format(self.real, self.imag)

>>> ri = ComplexRI(5, 12)
>>> ri.real
5
>>> ri.magnitude
13.0
>>> ri.real = 9
>>> ri.real
9
>>> ri.magnitude
15.0


>>> from math import sin, cos, pi
>>> class ComplexMA(Complex):
        def __init__(self, magnitude, angle):
            self.magnitude = magnitude
            self.angle = angle
            @property
        def real(self):
            return self.magnitude * cos(self.angle)
        @property
        def imag(self):
            return self.magnitude * sin(self.angle)
        def __repr__(self):
            return 'ComplexMA({0:g}, {1:g} * pi)'.format(self.magnitude, self.angle/pi)

>>> ma = ComplexMA(2, pi/2)
>>> ma.imag
2.0
>>> ma.angle = pi
>>> ma.real
-2.0

>>> from math import pi
>>> ComplexRI(1, 2) + ComplexMA(2, pi/2)
ComplexRI(1, 4)
>>> ComplexRI(0, 1) * ComplexRI(0, 1)
ComplexMA(1, 1 * pi)
```
```python
class Ratio:
    def __init__(self, n, d):
        self.numer = n
        self.denom = d

    def __repr__(self):
        return 'Ratio({0}, {1})'.format(self.numer, self.denom)

    def __str__(self):
        return '{0}/{1}'.format(self.numer, self.denom)

    def __add__(self, other):
        if isinstance(other, int):
            n = self.numer + self.denom * other
            d = self.denom
        elif isinstance(other, Ratio):
            n = self.numer * other.denom + self.denom * other.numer
            d = self.denom * other.denom
        elif isinstance(other, float):
            return float(self) + other
        g = gcd(n, d)
        return Ratio(n // g, d // g)
    
    __radd__ = __add__

    def __float__(self):
        return self.numer / self.denom

def gcd(n, d):
    while n != d:
        n, d = min(n, d), abs(n - d)
    return n
```