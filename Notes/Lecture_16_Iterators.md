# Lecture 16 Iterators
* 一个序列（sequence）不一定要把每个元素显式存储在计算机的内存中。换句话说，我们可以建立一个对象（object），它提供对某个序列的访问，而无需事先计算每个元素的值。 取而代之，我们只在有需要的时候才计算元素。
## 迭代器
* Python 和许多其他编程语言都提供了一种统一的方法来按照顺序地处理容器内的元素，称为迭代器（iterators）迭代器是一种对象，提供对值逐一顺序访问的功能。 迭代器抽象有两个组件：
  * 检索下一个元素的机制
  * 到达序列末尾并且没有剩余元素，发出信号的机制
```python
>>> primes = [2, 3, 5, 7]
>>> type(primes)
<class 'list'>
>>> iterator = iter(primes)
>>> type(iterator)
<class 'list-iterator'>
>>> next(iterator)
2
>>> next(iterator)
3
>>> list(iterator)
[5, 7]
>>> next(iterator)
Traceback (most recent call las):
  File "<stdin>", line 1, in <module>
StopIteration

>>> try:
        next(iterator)
    except StopIteration:
        print('No more values')
No more values
```
```python
>>> r = range(3, 13)
>>> s = iter(r)  # r 的第一个迭代器
>>> next(s)
3
>>> next(s)
4
>>> t = iter(r)  # r 的第二个迭代器
>>> next(t)
3
>>> next(t)
4
>>> u = t        # u 绑定到 r 的第二个迭代器
>>> next(u)
5
>>> next(u)
6
# 在迭代器上调用 iter 将返回该迭代器，而不是其副本
>>> v = iter(t)  # v 绑定到 r 的第二个迭代器
>>> next(v)      # u, v, t 都为 r 的第二个迭代器
8
>>> next(u)
9
>>> next(t)
10
```
## 可迭代性
* 任何可以产生迭代器的值都称为可迭代值（iterable value）。在 Python 中，可迭代值是任何可以传递给内置 `iter` 函数的值。
```python
>>> d = {'one': 1, 'two': 2, 'three': 3}
>>> d
{'one': 1, 'three': 3, 'two': 2}
>>> k = iter(d)
>>> next(k)
'one'
>>> next(k)
'three'
>>> v = iter(d.values())
>>> next(v)
1
>>> next(v)
3
>>> i = iter(d.items())
>>> next(i)
('one', 1)
>>> next(i)
('three', 3)
>>> next(i)
('two', 2)
# 若改变字典的结构（删除key或增加key），则迭代器失效
# 修改value不会导致迭代器失效
```
## for语句
```python
# 执行 for 语句，Python 会评估标头（header）<expression>，它必须为可迭代的值。然后，对该值调用 __iter__ 方法
# 在触发 StopIteration 异常之前，Python 会重复调用该迭代器上的 __next__ 方法，并将结果绑定到 for 语句中的 <name>。然后，执行 <suite>
for <name> in <expression>:
    <suite>
```
## 内置迭代器
* `map`、`filter`、`zip`、`reversed`函数返回迭代器
  * `map(func, iterable)`: Iterate over `func(x)` for `x` in `iterable`
  * `filter(func, iterable)`: Iterate over `x` in iterable if `func(x)`
  * `zip(first_iter, second_iter)`: Iterate over co-indexed `(x, y)` pairs
  * `reversed(sequence)`: Iterate over `x` in a sequence in reverse order
```python
>>> def double_and_print(x):
        print('***', x, '=>', 2*x, '***')
        return 2*x
>>> s = range(3, 7)
>>> doubled = map(double_and_print, s)  # double_and_print 未被调用
>>> next(doubled)                       # double_and_print 调用一次
*** 3 => 6 ***
6
>>> next(doubled)                       # double_and_print 再次调用
*** 4 => 8 ***
8
>>> list(doubled)                       # double_and_print 再次调用兩次
*** 5 => 10 ***                         # list() 会把剩余的值都计算出来并生成一个列表
*** 6 => 12 ***
[10, 12]

>>> m = map(double_and_print, range(3, 7))
>>> f = lambda y : y >= 10
>>> t = filter(f, m)
>>> next(t)
*** 3 => 6 ***
*** 4 => 8 ***
*** 5 => 10 ***   
10
>>> next(t)
*** 6 => 12 ***
12
>>> list(t)
[]
```
```python
>>> list(zip([1, 2], [3, 4]))
[(1, 3), (2, 4)]
>>> list(zip([1, 2], [3, 4, 5]))
[(1, 3), (2, 4)]
>>> list(zip([1, 2], [3, 4, 5], [6, 7]))
[(1, 3, 6), (2, 4, 7)]
```
```python
def palindrome(s):
    """ Return whether s is the same forword and backword

    >>> palindrome([3, 1, 4, 1, 5])
    False
    >>> palindrome([3, 1, 4, 1, 3])
    True
    >>> palindrome('seveneves')
    True
    >>> palindrome('seven eves')
    False
    """
    # return list(s) == reversed(s)
    return all([a == b for a, b in zip(s, reversed(s))]) 
```
## python流
```python
>>> class Stream:
        """惰性计算的链表"""
        class empty:
            def __repr__(self):
                return 'Stream.empty'
        empty = empty()
        def __init__(self, first, compute_rest=lambda: empty):
            assert callable(compute_rest), 'compute_rest 必须为可调用'
            self.first = first
            self._compute_rest = compute_rest
        @property
        def rest(self):
            """返回 Stream 的其他部分（缓存部分），如果需要计算，则计算"""
            if self._compute_rest is not None:
                self._rest = self._compute_rest()
                self._compute_rest = None
            return self._rest
        def __repr__(self):
            return 'Stream({0}, <...>)'.format(repr(self.first))

>>> r = Link(1, Link(2 + 3, Link(9)))
>>> s = Stream(1, lambda: Stream(2 + 3, lambda: Stream(9)))
>>> r.first
1
>>> s.first
1
>>> r.rest.first
5
>>> s.rest.first
5
>>> r.rest
Link(5, Link(9))
>>> s.rest
Stream(5, <...>)
```
```python
# integer_stream 是惰性的，因为只有在请求 integer_stream 的 rest 部分时才会对 integer_stream 进行递归调用
>>> def integer_stream(first):
        def compute_rest():
            return integer_stream(first+1)
        return Stream(first, compute_rest)
>>> positives = integer_stream(1)
>>> positives
Stream(1, <...>)
>>> positives.first
1
>>> positives.first
1
>>> positives.rest.first
2
>>> positives.rest.rest
Stream(3, <...>)
```
```python
>>> def map_stream(fn, s):
        if s is Stream.empty:
            return s
        def compute_rest():
            return map_stream(fn, s.rest)
        return Stream(fn(s.first), compute_rest)
```
```python
>>> def filter_stream(fn, s):
        if s is Stream.empty:
            return s
        def compute_rest():
            return filter_stream(fn, s.rest)
        if fn(s.first):
            return Stream(s.first, compute_rest)
        else:
            return compute_rest()
```
```python
>>> def primes(pos_stream):
        def not_divible(x):
            return x % pos_stream.first != 0
        def compute_rest():
            return primes(filter_stream(not_divible, pos_stream.rest))
        return Stream(pos_stream.first, compute_rest)

>>> def first_k_as_list(s, k):
        first_k = []
        while s is not Stream.empty and k > 0:
            first_k.append(s.first)
            s, k = s.rest, k - 1
        return first_k

>>> prime_numbers = primes(integer_stream(2))
>>> first_k_as_list(prime_numbers, 7)
[2, 3, 5, 7, 11, 13, 17]
```