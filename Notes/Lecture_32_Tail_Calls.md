# Lecture 32 Tail Calls
* A procedure call that has not yet returned is active. Some procedure calls are tail calls.
* A Scheme interpreter should support an unbounded number of active tail calls using only a constant amount of space.
* 当一个函数的最后一步操作是调用另一个函数时,这个调用不会再有后续的计算，Scheme要求解释器对尾调用进行优化。
* Scheme规范要求：无限数量的尾调用只能使用常量空间。这意味着不需要为每个尾调用分配新的栈帧。实现方式：复用当前栈帧，直接跳转到新函数。
* A tail call is a call expression in a tail context:
  * The last body sub-expression in a lambda expression(lambda表达式的最后一条语句)
  * Sub-expressions 2 & 3 in a tail context `if` expression(if表达式的then和else分支, 当if本身在尾上下文中)
  * All non-predicate sub-expressions in a tail context `cond`(cond表达式的所有非谓词子表达式, 最后那个分支)
  * The last sub-expression in a tail context `and` or `or`(and/or表达式的最后子表达式)
  * The last sub-expression in a tail context `begin`(begin表达式的最后子表达式)
* A call expression is not a tail call if more computation is still required in the calling procedure.
* Linear recursive procedures can ofter be re-written to use tail calls.
```scheme
(define (length s)
    (if (null? s) 0
        (+ 1 (length (cdr s))))) ; 问题：调用后有后续计算 (+ 1 ...)

(define (length-tail s)
    (define (length-iter s n)
        (if (null? s) n
            (length-iter (cdr s) (+ 1 n)))) ; 尾调用：没有后续计算
    (length-iter s 0))
```
```scheme
; 不是尾调用
; 递归调用后还需要执行 cons 操作
(define (map procedure s)
    (if (null? s) nil
        (cons (procedure (car s))
              (map procedure (cdr s)))))

; 尾调用
; map-reverse 函数中的递归调用 (map-reverse (cdr s) ...) 是最后一步操作
; 没有后续计算，结果直接返回
(define (map procedure s)
    (define (map-reverse s m)
        (if (null? s) m
            (map-reverse (cdr s)
                         (cons (procedure (car s)) m))))
    (reverse (map-reverse s nil)))

; 尾调用
(define (reverse s)
    (define (reverse-iter s r)
        (if (null? s) r
            (reverse-iter (cdr s) (cons (car s) r))))
    (reverse-iter s nil))
```