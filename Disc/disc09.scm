(define (fit total n)
    (define (f total n k)
        (if (and (= n 0) (= total 0))
            #t
        (if (< total (* k k))
            #f
        (or (f total n (+ k 1)) (f (- total (* k k)) (- n 1) (+ k 1)))
        )))
    (f total n 1))

(expect (fit 10 2) #t)  
(expect (fit 9 1)  #t)  
(expect (fit 9 2)  #f)  
(expect (fit 9 3)  #f)  
(expect (fit 25 1)  #t) 
(expect (fit 25 2)  #t) 

(define with-list
    (list (list 'a 'b) 'c 'd (list 'e)))

(define with-quote
    '((a b) c d (e)))

(define first
    (cons 'a (cons 'b nil)))
(define with-cons
    (cons first (cons 'c (cons 'd (cons (cons 'e nil) nil)))))
          
(define (pair-up s)
    (if (<= (length s) 3)
        (list s)
        (cons (list (car s) (car (cdr s))) (pair-up (cdr (cdr s))))
    ))

(expect (pair-up '(3 4 5 6 7 8)) ((3 4) (5 6) (7 8)) )
(expect (pair-up '(3 4 5 6 7 8 9)) ((3 4) (5 6) (7 8 9)) )