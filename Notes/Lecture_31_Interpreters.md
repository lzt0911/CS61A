# Lecture 31 Interepreters
```python
>>> Frame
<class '__main__.Frame'>
>>> g = Frame(None)
>>> g
<Global Frame>
>>> f1 = Frame(g)
>>> f1
<{} -> <Global Frame>>
>>> g.define('y', 3)
>>> g.define('z', 5)
>>> g.lookup('y')
3
>>> g.lookup('z')
5
>>> f1.define('x', 2)
>>> f1.define('z', 4)
>>> f1
<{x: 2, z: 4} -> <Global Frame>>
>>> f1.lookup('x')
2
>>> f1.lookup('z')
4
>>> f1.lookup('y')
3
```