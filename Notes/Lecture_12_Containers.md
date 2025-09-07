# Lecture 12 Containers
## Slicing切片
```python
>>> digits = [1, 8, 2, 8]
>>> digits[0:2]
[1, 8]
>>> digits[1:]
[8, 2, 8]
>>> digits[::-1]
[1, 8, 2, 8]
>>> digits[:]
[1, 8, 2, 8]
```
## Sequence Aggregation
* `sum(iterable[, start]) -> value`
  * Return the sum of an iterable of numbers plus the value of parameter `start`(which defaults to 0) When the iterable is empty, return start.
```python
>>>sum([2, 3, 4])
9
>>> sum([2, 3, 4], 5)
14
>>> sum([[2, 3], [4]], [])
[2, 3, 4]
```
* `max(iterable[, key=func]) -> value` or `max(a, b, c, ...[, key=func]) -> value`
  * With a single iterable argument, return its largest item.
  * With two or more auguments, return the largest argument.
* `all(iterable) -> bool`
  * Return True if `bool(x)` is True for all values `x` in the iterable. If the iterable is empty, return True.
```python
>>> all([x < 5 for x in range(5)])
True
>>> all(range(5))
False
```
## Strings
* 字符串字面量（string literals）可以表示任意文本，使用时将内容用单引号或双引号括起来
* 字符串中的元素是只有一个字符的字符串。Python 没有单独的字符类型，任何文本都是字符串。表示单个字符的字符串的长度为 1
```python
>>> 'I am string!'
'I am string!'
>>> "I've got an apostrophe"
"I've got an apostrophe"
>>> '您好'
'您好'

>>> city = 'Berkeley'
>>> len(city)
8
>>> city[3]
'k'

>>> 'Berkeley' + ', CA'
'Berkeley, CA'
>>> 'Shabu ' * 2
'Shabu Shabu '

>>> 'here' in "Where's Waldo?"
True
```
```python
>>> 'curry = lambda f: lambda x: lambda y: f(x, y)'
'curry = lambda f: lambda x: lambda y: f(x, y)'
>>> exec('curry = lambda f: lambda x: lambda y: f(x, y)')
>>> curry
<function <lambda> at 0x1003c1bf8>
```
* 多行字面量（Multiline Literals）：字符串可以不限于一行。跨越多行的字符串字面量可以用三重引号括起
```python
>>> """The Zen of Python
claims, Readability counts.
Read more: import this."""
'The Zen of Python\nclaims, "Readability counts."\nRead more: import this.'
```
* 通过以对象值作为参数调用 `str` 的构造函数，可以从 Python 中的任何对象创建字符串
```python
>>> str(2) + ' is an element of ' + str(digits)
'2 is an element of [1, 8, 2, 8]'
```
```python
>>> s = 'Hello'
>>> s.upper()
'HELLO'
>>> s.lower()
'hello'
>>> s.swapcase()
'hELLO'
>>> s
'Hello'
```
```python
>>> from unicodedata import name, lookup
>>> name('A')
'LATIN CAPITAL LETTER A'
>>> name('a')
'LATIN SMALL LETTER A'
>>> lookup('BABY').encode()
b'\xf0\x9f\x91\xb6'
>>> 'A'.encode()
b'A'
```
## Dictionaries
* 字典是python的内置类型，用来存储和操作带有映射关系的数据。
```python
>>> numerals = {'I', 1, 'V': 5, 'X': 10}
>>> numerals
{'I', 1, 'V': 5, 'X': 10}
>>> numerals['X']
10
>>> list(numerals)
['I', 'V', 'X']
>>> numerals.values()
dict_value([1, 5, 10])
>>> sum(numerals.values())
16
>>> list(numerals.values())
[1, 5, 10]
>>> numerals['L'] = 50
>>> numerals
{'I', 1, 'V': 5, 'X': 10, 'L': 50}
# Python 3.7 及以上版本的字典顺序会确保为插入顺序，此行为是自 3.6 版开始的 CPython 实现细节，字典会保留插入时的顺序，对键的更新也不会影响顺序，删除后再次添加的键将被插入到末尾
```
```python
>>> d = {2: 4, 'two': ['four'], (1, 1): 4}
>>> d[2]
4
>>> d['two']
['four']
>>> d[(1, 1)]
4

>>> for k in d.keys():
...     print(k)
...
2
two
(1, 1)
>>> for v in d.values():
...     print(v)
...
4
['four']
4
>>> for k, v in d.items():
...     print(k, v)
...
2 4
two ['four']
(1, 1) 4

# 检查字典中是否包含某个键
>>> 'two' in d
True
>>> 4 in d
False
```
```python
# dictionary中key不能重复
>>> {1: 'first', 1: 'second'}
{1, 'second'}

# dictionary的key不能是列表或字典
```
```python
>>> dict([(3, 9), (4, 16), (5, 25)])
{3: 9, 4: 16, 5: 25}
```
```
{<key exp>: <value exp> for <name> in <iter exp> if <filter exp>}
```
```python
def index(keys, values, match):
    """
    Return a dictionary from keys k to a list of values v for which match(k, v) is a true value

    >>> index([7, 9, 11], range(30, 50), lambda k, v: v % k == 0)
    {7: [35, 42, 49], 9: [36, 45], 11: [33, 44]}
    """
    return {k: [v for v in values if match(k, v)] for k in keys}
```
* 字典类型也有一些限制：
  * 字典的 key 不可以是可变数据，也不能包含可变数据
  * 一个 key 只能对应一个 value
```python
# get方法，它返回指定 key 在字典中对应的 value；如果该 key 在字典中不存在，则返回默认值。get 方法接收两个参数，一个 key，一个默认值。
>>> numerals.get('A', 0)
0
>>> numerals.get('V', 0)
5
```