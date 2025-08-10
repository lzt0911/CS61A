# Lecture 10 Tree Recursion
## 树递归
* 具有多个递归调用的函数称为树递归
```python
def fib(n):
    if n == 1:
        return 0
    if n == 2:
        return 1
    else:
        return fib(n-2) + fib(n-1)

result = fib(6)
```
```python
# 求正整数n的分割数，最大部分为m，即n可以分割为不大于m的正整数的和，并且按递增顺序排列
# 使用最大数为m的整数分割n的方式的数量等于
# 使用最大数为m的整数分割n-m的方式的数量，加上使用最大数为m-1的整数分割n的方式的数量
>>> def count_partitions(n, m):
        """计算使用最大数 m 的整数分割 n 的方式的数量"""
        if n == 0:
            return 1
        elif n < 0:
            return 0
        elif m == 0:
            return 0
        else:
            return count_partitions(n-m, m) + count_partitions(n, m-1)

>>> count_partitions(6, 4)
9
>>> count_partitions(5, 5)
7
>>> count_partitions(10, 10)
42
>>> count_partitions(15, 15)
176
>>> count_partitions(20, 20)
627
```