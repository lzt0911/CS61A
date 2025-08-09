# Lecture 8 Functuon Examples
## 函数装饰器
```python
>>> def trace(fn):
        def wrapper(x):
            print('-> ', fn, '(', x, ')')
            return fn(x)
        return wrapper

>>> @trace
    def triple(x):
        return 3 * x

>>> triple(12)
-> <function triple at 0x102a39848> (12)
36

# 等价于
>>> def tripple(x):
        return 3 * x

>>> triple = trace(triple)
```



