# Lecture 33 Program As Data
```scheme
scm> (list 'quotient 10 2)
(quotient 10 2)
scm> (eval (list 'quotient 10 2))
5
```
```scheme
(define (fact n)
    (if (= n 0) 1
        (* n (fact (- n 1)))))

(define (fact-exp n)
    (if (= n 0) 1
        (list '* n (fact-exp (- n 1)))))

> (fact 5)
120
> (fact-exp 5)
(* 5 (* 4 (* 3 (* 2 (* 1 1)))))
> (eval(fact-exp 5))
120
```
```scheme
(define b 4)
; Quote
; ' 会将其后的整个表达式当作字面数据，不做任何求值
'(a ,(+ b 1)) -> (a (unquote (+ b 1)))

; Quasiquote
; ` 允许在数据模板中插入求值，通过 unquote（逗号 ,）标记需要求值的位置
`(a ,(+ b 1)) -> (a 5)

(define (make-add-procedure n) `(lambda (d) (+ d ,n)))
(make-add-procedure 2) -> (lambda (d) (+ d 2))
```
```scheme
(define (sum-while initial-x condition add-to-total update-x)
  `(begin
     (define (f x total)
       (if ,condition
           (f ,update-x (+ total ,add-to-total))
           total))
     (f ,initial-x 0)))

> (define result (sum-while 1 '(< (* x x) 50) 'x '(+ x 1)))
> result
(begin (define (f x total) (if (< (* x x) 50) (f (+ x 1) (+ total x)) total)) (f 1 0))
> (eval result)
28

```