# Lecture 17 Generators
## 生成器和Yield语句
* 生成器是由一种特殊类型的函数“生成器函数”返回的迭代器。 生成器函数与常规函数不同之处在于，它们在其主体内不包含 `return` 语句，而是使用 `yield` 语句来返回一系列元素。
```python
>>> def plus_minus(x):
        yield x
        yield -x

>>> t = plus_minus(3)
>>> next(t)
3
>>> next(t)
-3
>>> t
<generator object plus_minus ...>
```
```python
# 法一
def a_then_b(a, b):
    for x in a:
        yield x
    for x in b:
        yield x

# 法二
def a_then_b(a, b):
    yield from a
    yield from b

>>> list(a_then_b([3, 4], [5, 6]))
[3, 4, 5, 6]
```
```python
def countdown(k):
    if k > 0:
        yield k
        yield from countdown(k - 1)
```
```python
def prefixes(s):
    if s:
        yield from prefixes(s[:-1])
        yield s

>>> list(prefix('both'))
['b', 'bo', 'bot', 'both']

def substring(s):
    if s:
        yield from prefixes(s)
        yield from substring(s[1:])

>>> list(substrings('tops'))
['t', 'to', 'top', 'tops', 'o', 'op', 'ops', 'p', 'ps', 's']
```
```python
>>> def letters_generator():
        current = 'a'
        while current <= 'd':
            yield current
            current = chr(ord(current) + 1)

>>> for letter in letters_generator():
        print(letter)
a
b
c
d

>>> letters = letters_generator()
>>> type(letters)
<class 'generator'>
>>> letters.__next__()
'a'
>>> letters.__next__()
'b'
>>> letters.__next__()
'c'
>>> letters.__next__()
'd'
>>> letters.__next__()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
```
* 即使我们从未明确定义过 `__iter__ `或 `__next__` 方法， `yield` 语句表明我们正在定义一个生成器函数。 当调用时，生成器函数不返回特定的返回值，而是返回一个生成器（一种迭代器类型），该生成器本身可以返回所产出（yields）的值。
* 生成器对象具有 `__iter__` 和 `__next__` 方法，每次调用 `__next__` 方法都会从之前离开的地方继续执行生成器函数，直到另一个 `yield` 语句被执行为止。
* 当第一次调用 `__next__` 时，程序会执行 `letters_generator` 函数的语句，直到遇到 `yield` 语句。然后，它暂停并返回 `current` 的值。 `yield` 语句不会销毁新建的环境，而是保留它供以后使用。
* 当再次调用 `__next__` 时，执行会从上次离开的地方继续。 `current` 的值以及 `letters_generator` 作用域内的任何其他绑定名称的值在多次调用 `__next__` 之下都会保留。
```python
>>> def all_pairs(s):
        for item1 in s:
            for item2 in s:
                yield (item1, item2)
>>> list(all_pairs([1, 2, 3]))
[(1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), ( 3, 3)]
```
```python
>>> class LettersWithYield:
        def __init__(self, start='a', end='e'):
            self.start = start
            self.end = end
        def __iter__(self):
            next_letter = self.start
            while next_letter < self.end:
                yield next_letter
                next_letter = chr(ord(next_letter) + 1)

>>> letters = LettersWithYield()
>>> list(all_pairs(letters))[:5]
[('a', 'a'), ('a', 'b'), ('a', 'c'), ('a', 'd'), ('b', 'a') ]
```
```python
>>> class LetterIter:
        """依照 ASCII 码值顺序迭代字符的迭代器。"""
        def __init__(self, start='a', end='e'):
            self.next_letter = start
            self.end = end
        def __next__(self):
            if self.next_letter == self.end:
                raise StopIteration
            letter = self.next_letter
            self.next_letter = chr(ord(letter)+1)
            return letter

>>> letter_iter = LetterIter()
>>> letter_iter.__next__()
'a'
>>> letter_iter.__next__()
'b'
>>> next(letter_iter)
'c'
>>> letter_iter.__next__()
'd'
>>> letter_iter.__next__()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 12, in next
StopIteration
```
```python
def partitions(n, m):
    if n < 0 or m == 0:
        return []
    else:
        exact_match = []
        if n == m:
            exact_match = [str(m)]
        with_m = [p + ' + ' str(m) for p in partitions(n - m, m)]
        without_m = partitions(n, m - 1)
        return exact_match + with_m + without_m

def partitions(n, m):
    if n > 0 and m > 0:
        if n == m:
            yield str(m)
        for p in partitions(n - m, m):
            yield p + ' + ' + str(m)
        yield from partitions(n, m - 1)
```
```python
def differences(t):
    """Yield the differences between adjacent values from iterator t.

    >>> list(differences(iter([5, 2, -100, 103])))
    [-3, -102, 203]
    >>> next(differences(iter([39, 100])))
    61
    """
    "*** YOUR CODE HERE ***"
    # 法一
    pre = next(t)
    while True:
        try:
            cur = next(t)
            yield cur - pre
            pre = cur
        except StopIteration:
            break

    # 法二
    last_x = next(t)
    for x in t:
        yield x - last_x
        last_x = x
```