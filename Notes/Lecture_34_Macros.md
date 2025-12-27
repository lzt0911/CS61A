# Lecture 34 Macros
```scheme
(define (square-expr term) `(* ,term ,term))

`(+ ,(square-expr `a) ,(square-expr `b))
```
* A macro is an operation performed on the source code of a program before evaluation.
* Scheme has a `define-macro` special form that defines a source code transformation.
```scheme
(define (twice expr) 
    (list 'begin expr expr))
> (twice (print 2))
2
(begin None None)
> (twice '(print 2))
(begin (print 2) (print 2))
> (eval (twice '(print 2)))
2
2

(define-macro (twice expr)
    (list 'begin expr expr))

> (twice (print 2)) -> (begin (print 2) (print 2))
2
2
```
* Evaluation procedure of a macro call expression:
  * Evaluate the operator sub-expression, which evaluates to a macro.
  * Call the macro procedure on the operand expressions without evaluating them first.
  * Evaluate the expression returned from the macro procedure.
```scheme
(define-macro (check expr)
    (list 'if              ; 符号 'if
            expr           ; 表达式本身 (保持原样)
            ''passed       ; 外层引号：防止内层被过早求值, 内层引号：创建字面符号 'passed
        (list 'quote (list 'failed: expr)))) ; 创建符号 quote, 创建列表 (failed: 原始表达式)

;; 调用宏
(check (> 5 3))

;; 宏展开步骤：
;; 1. expr = (> 5 3)
;; 2. 构建列表：
(list 'if (> 5 3) ''passed 
      (list 'quote (list 'failed: (> 5 3))))

;; 3. 计算结果：
(if (> 5 3) 'passed '(failed: (> 5 3)))

;; 4. 执行：
;;    (> 5 3) 求值为 #t
;;    返回 'passed
```
```scheme
(define (map fn vals)
    (if (null? vals)
        ()
        (cons (fn (car vals) (map fn (cdr vals))))))
> (map (lambda (x) (* x x)) '(2 3 4 5))
(4 9 16 25)

(define-macro (for sym vals expr)
    (list 'map (list 'lambda (list sym) expr) vals))
```
```scheme
(define fact (lambda (n)
    (if (zero? n) 1
        (* n (fact (- n 1))))))

(define original fact)
(define fact (lambda (n)
    (print (list 'fact n))
    (original n)))

> (fact 5)
(fact 5)
(fact 4)
(fact 3)
(fact 2)
(fact 1)
120

(define-macro (trace expr)
    (define operator (car expr))
    `(begin
        (define original ,operator)
        (define ,operator (lambda (n)
                                  (print (list (quote ,operator) n))
                                  (original n)))
        (define result ,expr)
        (define ,operator original)
        result))
> (trace (fact 5))
(fact 5)
(fact 4)
(fact 3)
(fact 2)
(fact 1)
120
> (fact 5)
120
```