# Lecture 4 Higner-Order Functions
## 函数作为入参
```python
def summation(n, term):
    total, k = 0, 1
    while k <= n:
        total, k = total + term(k), k + 1
    return total

def cube(x):
    return x * x * x

def sum_cubes(n):
    return summation(n, cube)

result = sum_cubes(3)
```
```python
>>> def improve(update, close, guess=1):
        while not close(guess):
            guess = update(guess)
        return guess

>>> def golden_update(guess):
        return 1 / guess + 1

>>> def square_close_to_successor(guess):
        return approx_eq(guess * guess, guess + 1)

>>> def approx_eq(x, y, tolerance=1e-15):
        return abs(x - y) < tolerance

>>> improve(golden_update, square_close_to_successor)
1.6180339887498951
```
## 嵌套函数
```python
def average(x, y):
    return (x + y) / 2

def improve(update, close, guess=1):
    while not close(guess):
        guess = update(guess)
    return guess

def approx_eq(x, y, tolerance=1e-3):
    return abs(x - y) < tolerance

def sqrt(a):
    def sqrt_update(x):
        return average(x, a / x)
    def sqrt_close(x):
        return approx_eq(x * x, a)
    return improve(sqrt_update, sqrt_close)

result = sqrt(256)
```
## 嵌套作为返回值
```python
>>> def compose1(f, g):
        def h(x):
            return f(g(x))
        return h
```
```python
>>> def curried_pow(x):
        def h(y):
            return pow(x, y)
        return h

>>> curried_pow(2)(3)
8
```
## 不定参数
```python
>>> def printed(f):
...     def print_and_return(*args):
...         result = f(*args)
...         print('Result:', result)
...         return result
...     return print_and_return
>>> printed_pow = printed(pow)
>>> printed_pow(2, 8)
Result: 256
256
>>> printed_abs = printed(abs)
>>> printed_abs(-10)
Result: 10
10
```