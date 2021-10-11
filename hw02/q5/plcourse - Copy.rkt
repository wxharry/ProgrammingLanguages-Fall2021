( car '( this is a list of symbols ))

( cdr '( this is a list of symbols ))

( cdr '( this that ))

( cdr '( singleton ))

; Example 1
(define reciprocol (lambda (n) (if (= n 0) "oops!" (/ 1 n))))
;(reciprocol 5)

; Example 2
; Partial application
(define foo (lambda (x) (lambda (y) (* x y))))
;((foo 4) 6)


; Example 3
(define x '(1 2 3 4))
(define minusone (lambda (ls)
          (if (null? ls) 
              '()
              (cons (- (car ls) 1) (minusone(cdr ls))))))
;(minusone x)

; Example 4
;  Expect:  (  (name, data)  (name, data), ... )
(define search (lambda (item lst)
          (cond  ((null? lst) "sorry, nothing found")
                 ((string=? (caar lst) item) (cadar lst))
                 (else (search item (cdr lst)))
           )))
;(search "joe" '( ("joe" 5) ("mary" 2) ("bob" 17) ("ed" 6)))


(define call/cc call-with-current-continuation)

; Example 5
; Call with current continuation
; Quoted from Dybvig

;(call/cc
;   (lambda (k)
;      (* 5 4)))

;(call/cc
;    (lambda (k)
;      (* 5 (k 4))))

;(+ 2
;  (call/cc
;    (lambda (k)
;      (* 5 (k 4)))))


; Example 6
; The Y Combinator
; Simulating recursion

(define F
    (lambda (fact-arg)
      (lambda (n)
        (if (zero? n)
            1
            (* n (fact-arg (- n 1)))))))

 (define Y
    (lambda (f)
      ((lambda (x)
         (f (lambda (arg) ((x x) arg))))
       (lambda (x)
         (f (lambda (arg) ((x x) arg)))))))
 
 (define fact (Y F))
 (fact 5)