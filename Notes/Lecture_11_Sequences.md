# Lecture 11 Sequences
## 序列
* 序列（sequence）是一组有顺序的值的集合。序列并不是特定内置类型或抽象数据表示的实例，而是一个包含不同类型数据间共享行为的集合。也就是说，序列有很多种类，但它们都具有共同的行为。特别是：
  * 长度（length）：序列的长度是有限的，空序列的长度为0.
  * 元素选择（element selection）：序列中的每个元素都对应一个小于序列长度的非负整数作为其索引，第一个元素的索引从0开始。
## list
* list是一个可以有任意长度的序列
* 一个list可以存储不同数据类型的元素
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
>>> pair[-1]
20

>>> from operator import getitem
>>> getitem(pair, 0)
10
>>> getitem(pair, 1)
20
```
```python
>>> digits = [1, 8, 2, 8]
>>> len(digits)
4
>>> digits[3]
8

>>> [2, 7] + digits * 2
[2, 7, 1, 8, 2, 8, 1, 8, 2, 8]
```
```python
>>> pairs = [[10, 20], [30, 40]]
>>> pairs[1]
[30, 40]
>>> pairs[1][0]
30
```
## Containers
```python
>>> digits = [1, 8, 2, 8]
>>> 1 in digits
True
>>> 8 in digits
True
>>> 5 in digits
False
>>> 5 not in digits
True
>>> [1, 8] in digits
False
>>> '1' in digits
False
>>> [1, 2] in [3, [1, 2], 4]
True
```
## 序列遍历
```
for <name> in <expression>:
    <suite>
```
* `for`循环语句按以下过程执行：
  * 执行头部（header）中的 `<expression>`，它必须产生一个可迭代（iterable）的值
  * 对该可迭代值中的每个元素，按顺序：
    * 将当前帧的 `<name>` 绑定到该元素值
    * 执行 `<suite>`
```python
>>> def count(s, value):
        """统计在序列 s 中出现了多少次值为 value 的元素"""
        total = 0
        for elem in s:
            if elem == value:
                total = total + 1
        return total
>>> count(digits, 8)
2
```
```python
>>> pairs = [[1, 2], [2, 2], [2, 3], [4, 4]]
>>> same_count = 0
>>> for x, y in pairs:
        if x == y:
            same_count = same_count + 1
>>> same_count
2
```
## Ranges
* A range is a sequence of consecutive integers.
```python
# range有三个参数：起始值、结束值加1、步长（可选）
>>> range(1, 10)  # 包括 1，但不包括 10
range(1, 10)
>>> list(range(5, 8))
[5, 6, 7]
>>> list(range(4))
[0, 1, 2, 3]

>>> for _ in range(3):
        print('Go Bears!')

Go Bears!
Go Bears!
Go Bears!
```
## List Comprehensions列表推导式
```python
[<map expression> for <name> in <sequence expression> if <filter expression>]
```
* Python 首先执行 `<sequence expression>`，它必须返回一个可迭代值。然后将每个元素值按顺序绑定到 `<name>`，再执行 `<filter expression>`，如果结果为真值，则计算 `<map expression>`，`<map expression>` 的结果将被收集到结果列表中。
```python
>>> odds = [1, 3, 5, 7, 9]
>>> [x + 1 for x in odds]
[2, 4, 6, 8, 10]
>>> [x for x in odds if 25 % x == 0]
[1, 5]
```