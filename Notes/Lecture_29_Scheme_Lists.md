# Lecture 29 Scheme Lists
## list
* `pair` 是通过内置函数 `cons` 创建的，而元素则可以通过 `car` 和 `cdr` 进行访问。
* `car` procedure that returns the first element of a list.
* `cdr` procedure that returns the rest of a list.
* `nil` the empty list.
```scheme
> (define x (cons 1 2))
> x
(1 2)
> (car x)
1
> (cdr x)
2
```
```scheme
> (cons 1
        (cons 2
              (cons 3
                    (cons 4 nil))))
; 等价于
> (list 1 2 3 4)
; 结果是(1 2 3 4)

> (define one-through-four (list 1 2 3 4))
> (car one-through-four)
1
> (cdr one-through-four)
(2 3 4)
> (car (cdr one-through-four))
2
; 在前面加一个元素10
> (cons 10 one-through-four)
(10 1 2 3 4)

> (cons 5 one-through-four)
（5 1 2 3 4）
```
```scheme
> (define s (cons 1 (cons 2 nil)))
> s
(1 2)
> (cons (cons 4 (cons 3 nil)) s)
((4 3) 1 2) 
> (cons s (cons s nil))
((1 2) (1 2))

> (list? s)
#t
> (null? nil)
#t
```
```scheme
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define (getitem items n)
  (if (= n 0)
      (car items)
      (getitem (cdr items) (- n 1))))

> (define squares (list 1 4 9 16 25))
> (length squares)
5
> (getitem squares 3)
16
```
```scheme
> (define s (cons 1 (cons 2 nil)))
s
> s
(1 2)
> (append s s)
(1 2 1 2)
> (append s s s s)
(1 2 1 2 1 2 1 2)
> (list s s s s)
((1 2) (1 2) (1 2) (1 2))

> (map even? s)
(#f #t)
> (map (lambda (x) (* 2 x)) s)
(2 4)

> (filter even? s)
(2)
> (filter even? '(5 6 7 8 9))
(6 8)
> (filter list? '(5 (6 7) 8 (9)))
((6 7) (9))

> (apply quotient '(10 5))
2
> (apply + '(1 2 3 4))
10
```
```scheme
;;; non-empty subsets of integer list s that have an even sum
(define (even-subsets s)
  (if (null? s)
      nil
      (let ((first (car s))
            (rest (cdr s)))
        (let ((even-rest (even-subsets rest))
              (odd-rest (odd-subsets rest)))
          (let ((included (if (even? first)
                              (map (lambda (t) (cons first t)) even-rest)
                              (map (lambda (t) (cons first t)) odd-rest)))
                (first-alone (if (even? first) (list (list first)) nil)))
            (append even-rest included first-alone))))))

;;; non-empty subsets of integer list s that have an odd sum  
(define (odd-subsets s)
  (if (null? s)
      nil
      (let ((first (car s))
            (rest (cdr s)))
        (let ((even-rest (even-subsets rest))
              (odd-rest (odd-subsets rest)))
          (let ((included (if (odd? first)
                              (map (lambda (t) (cons first t)) even-rest)
                              (map (lambda (t) (cons first t)) odd-rest)))
                (first-alone (if (odd? first) (list (list first)) nil)))
            (append odd-rest included first-alone))))))

;;; non-empty subsets of s
(define (nonempty-subsets s)
    (if (null ? s) nil
        (let ((rest (nonempty-subsets (cdr s))))
             (append rest
                     (map (lambda (t) (cons (car s) t)) rest)
                     (list (list (car s)))))))

;;; non-empty subsets of integer list s that have an even sum
(define (even-subsets s)
    (filter (lambda (s) (even? (apply + s))) (nonempty-subsets s)))
```
## 符号数据
* 在 Scheme 中，我们通过在它们前面加上一个单引号来引用符号 a 和 b 而不是它们的值。
```scheme
> (define a 1)
> (define b 2)

; 等价于(list 1 2)
> (list a b)
(1 2)

> (list 'a 'b)
(a b)

> (list 'a b)
(a 2)
```
```scheme
> 'a
a
> (quote a)
a
> (cons 'a nil)
(a)
> '(1 2)
(1 2)
```