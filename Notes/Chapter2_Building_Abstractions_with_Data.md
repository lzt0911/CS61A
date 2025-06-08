# Chapter 2: Building Abstractions with Data
## 2.1   Introduction
### 2.1.1   Native Data Types
* Every value in Python has a `class` that determines what type of value it is.
* Python includes three native numeric types: integers (`int`), real numbers (`float`), and complex numbers (`complex`).
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
>>> 1/3 == 0.333333333333333312345  # Beware of float approximation
True
```
## 2.2   Data Abstraction
### 2.2.1   Example: Rational Numbers
```python
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
```
### 2.2.2 Pairs
* Python provides a compound structure called a `list`, which can be constructed by placing expressions within square brackets separated by commas. 
```python
>>> pair = [10, 20]
>>> pair
[10, 20]
>>> x, y = pair
>>> x
10
>>> y
20
>>> pair[0]
10
>>> pair[1]
20
>>> getitem(pair, 0)
10
>>> getitem(pair, 1)
20
# 负索引从列表末尾开始计数，最右边元素的索引是-1
>>> pair[-1]
20
```
```python
>>> from fractions import gcd # 最大公约数
>>> def rational(n, d):
        g = gcd(n, d)
        return (n//g, d//g)
>>> def numer(x):
        return x[0]
>>> def denom(x):
        return x[1]
```
### 2.2.3   Abstraction Barriers
### 2.2.4   The Properties of Data
## 2.3 Sequences
* Sequences are not instances of a particular built-in type or abstract data representation, but instead a collection of behaviors that are shared among several different types of data. That is, there are many kinds of sequences, but they all share common behavior.
	* Length. A sequence has a finite length. An empty sequence has length 0.
	* Element selection. A sequence has an element corresponding to any non-negative integer index less than its length, starting at 0 for the first element.
### 2.3.1 Lists
```python
>>> digits = [1, 8, 2, 8]
>>> len(digits)
4
```
* For sequences, addition and multiplication do not add or multiply elements, but instead combine and replicate the sequences themselves.
```python
>>> [2, 7] + digits * 2
[2, 7, 1, 8, 2, 8, 1, 8, 2, 8]
```
* Any values can be included in a list, including another list.
```python
>>> pairs = [[10, 20], [30, 40]]
>>> pairs[1]
[30, 40]
>>> pairs[1][0]
30
```
### 2.3.2 Sequence Iteration
```python
>>> def count(s, value):
        """Count the number of occurrences of value in sequence s."""
        total = 0
        for elem in s:
            if elem == value:
                total = total + 1
        return total

>>> pairs = [[1, 2], [2, 2], [2, 3], [4, 4]]
>>> same_count = 0
>>>> for x, y in pairs:
        if x == y:
            same_count = same_count + 1
```
```python
for <name> in <expression>:
    <suite>
```
* A `for` statement is executed by the following procedure:
	* Evaluate the header `<expression>`, which must yield an iterable value.
	* For each element value in that iterable value, in order:
		* Bind `<name>` to that value in the current frame.
		* Execute the `<suite>`.
* A range is a sequence of consecutive integers(连续整数的序列).
* range is sequence but not list.
```python
>>> range(1, 10)  # Includes 1, but not 10
range(1, 10)
>>> list(range(5, 8))
[5, 6, 7]
>>> list(range(4))
[0, 1, 2, 3]

# This underscore is just another name in the environment as far as the interpreter is concerned, but has a conventional meaning among programmers that indicates the name will not appear in any future expressions.
>>> for _ in range(3):
        print('Go Bears!')

Go Bears!
Go Bears!
Go Bears!

# 构造嵌套lists
lists = [[] for _ in range(3)]
```
### 2.3.3 Sequence Processing
* List Comprehensions(列表推导式)
	*  `[<map expression> for <name> in <sequence expression> if <filter expression>]`
	* To evaluate a list comprehension, Python evaluates the `<sequence expression>`, which must return an iterable value. Then, for each element in order, the element value is bound to `<name>`, the filter expression is evaluated, and if it yields a true value, the map expression is evaluated. The values of the map expression are collected into a list.
```python
>>> odds = [1, 3, 5, 7, 9]
>>> [x+1 for x in odds]
[2, 4, 6, 8, 10]

>>> [x for x in odds if 25 % x == 0]
[1, 5]

>>> [[1] + s for s in [[4], [5, 6]]]
[[1, 4], [1, 5, 6]]
```
### 2.3.4   Sequence Abstraction
```python
>>> digits
[1, 8, 2, 8]
>>> 2 in digits
True
>>> 1828 not in digits
True
```
```python
>>> digits[0:2]
[1, 8]
>>> digits[1:]
[8, 2, 8]
>> digits[:2]
[1, 8]
>> digits[:]
[1, 8, 2, 8]
```
* `sum(iterable[, start]) -> value`
	* Return the sum of an iterable of numbers plus the calue of parameter 'start' (which defaults to 0). When the iterable is empty, return start. 	
```python
>>> sum([2, 3, 4])
9
>>> sum([2, 3, 4], 5)
14
>>> sum([[2, 3], [4]], [])
[2, 3, 4]
```
* `max(iterable[, key=func]) -> value` `max(a, b, c, ...[, key=func]) -> value`
	* With a single iterable argument, return its largest item.
	* With two or more arguments, return the largest argument.
```python
>>> max(range(5))
4
>>> max(0, 1, 2, 3, 4)
4
>>> max(range(10), key=lambda x: 7-(x-4)*(x-2))
3
```
* `all(iterable) -> bool`
	* Return True if bool(x) is True for all values in the iterable. If the iterable is empty, return True
```python
>>> all([x < 5 for x in range(5)])
True
>>> all(range(5))
False  
```
```python
nums = [5, 2, 1, 4, 1]  # 两个1
min_index = nums.index(min(nums))  # 返回第一个1的位置：2
```
### 2.3.5 Strings
* Python does not have a separate character type; any text is a string, and strings that represent single characters have a length of 1.
* Strings aren't limited to a single line. Triple quotes delimit string literals that span multiple lines.
```python
>>> city = 'Berkeley'
>>> len(city)
8
# an element of a string is itself a string, but with only one element
>>> city[3]
'k'

>>> 'Berkeley' + ', CA'
'Berkeley, CA'
>>> 'Shabu ' * 2
'Shabu Shabu '

# 寻找子字符串
>>> 'here' in "Where's Waldo?"
True

>>> """The Zen of Python
claims, Readability counts.
Read more: import this."""
'The Zen of Python\nclaims, "Readability counts."\nRead more: import this.'

>>> str(2) + ' is an element of ' + str(digits)
'2 is an element of [1, 8, 2, 8]'
```
```python
>>> 'curry = lambda f: lambda x: lambda y: f(x, y)'
'curry = lambda f: lambda x: lambda y: f(x, y)'
>>> exec('curry = lambda f: lambda x: lambda y: f(x, y)')
>>> curry
<function <lambda> at 0x1003c1bf8>
>>> curry(add)(3)(4)
7
```
### 2.3.6 Trees
```python
# 树的构造函数
def tree(root_label, branches=[]):
     for branch in branches:
         assert is_tree(branch), 'branches must be trees'  # 验证每个分支是否为合法树
     return [root_label] + list(branches)  # 组合根标签与分支列表

# 返回根节点
def label(tree):
    return tree[0]  # 列表首元素即根标签

# 返回所有子树
def branches(tree):
    return tree[1:]  # 列表除首元素外的剩余部分

def is_tree(tree):
	if type(tree) != list or len(tree) < 1:
	    return False
	for branch in branches(tree):
	    if not is_tree(branch):
	        return False
	return True

def is_leaf(tree):
	return not branches(tree)

def fib_tree(n):
	 if n == 0 or n == 1:
	     return tree(n)
	 else:
	     left, right = fib_tree(n-2), fib_tree(n-1)
	     fib_n = label(left) + label(right)
	     return tree(fib_n, [left, right])

def count_leaves(tree):
	if is_leaf(tree):
	     return 1
	 else:
	     branch_counts = [count_leaves(b) for b in branches(tree)]
	     return sum(branch_counts)
```
### 2.3.7   Linked Lists
![alt text](images/image-9.png)
```python
>>> empty = 'empty'
>>> def is_link(s):
        """s is a linked list if it is empty or a (first, rest) pair."""
        return s == empty or (len(s) == 2 and is_link(s[1]))
>>> def link(first, rest):
        """Construct a linked list from its first element and the rest."""
        assert is_link(rest), "rest must be a linked list."
        return [first, rest]
>>> def first(s):
        """Return the first element of a linked list s."""
        assert is_link(s), "first only applies to linked lists."
        assert s != empty, "empty linked list has no first element."
        return s[0]
>>> def rest(s):
        """Return the rest of the elements of a linked list s."""
        assert is_link(s), "rest only applies to linked lists."
        assert s != empty, "empty linked list has no rest."
        return s[1]
>>> def len_link(s):
        """Return the length of linked list s."""
        length = 0
        while s != empty:
            s, length = rest(s), length + 1
        return length
>>> def getitem_link(s, i):
        """Return the element at index i of linked list s."""
        while i > 0:
            s, i = rest(s), i - 1
        return first(s)
>>> def len_link_recursive(s):
        """Return the length of a linked list s."""
        if s == empty:
            return 0
        return 1 + len_link_recursive(rest(s))
>>> def getitem_link_recursive(s, i):
        """Return the element at index i of linked list s."""
        if i == 0:
            return first(s)
        return getitem_link_recursive(rest(s), i - 1)
```