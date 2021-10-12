; helper functions
; square
( define (square a) (* a a))

; invert
( define (invert a) (/ 1000 a))

; findmax finds the maximum in ls
(define findmax (lambda (ls)
          (if (null? (cdr ls) ) 
              (car ls)
              (if (> (car ls) (findmax (cdr ls)))
                  (car ls)
                  (findmax (cdr ls))))))

; findmin finds the minimum in ls
(define findmin (lambda (ls)
          (if (null? (cdr ls) ) 
              (car ls)
              (if (< (car ls) (findmin (cdr ls)))
                  (car ls)
                  (findmin (cdr ls))))))

; memeber returns whether elem is a member of lis 
(define (in elem lis)
  (cond
    (( null? lis) #f)
    ((eqv? elem (car lis )) #t)
    (else ( member elem (cdr lis )))))

; search searches for value of item in lst
(define (search item lst)
          (cond  ((null? lst) #f)
                 ((eqv? (caar lst) item) (cadar lst))
                 (else (search item (cdr lst)))))

; putInOrder 
(define (putInOrder x lst)
  (cond ((null? lst) (list x) )
        ((null? x) lst)
        ((< x (car lst)) (cons x lst))
        ((= x (car lst)) lst)
        ((> x (car lst)) (cons (car lst) (putInOrder x (cdr lst))))))

; rlist2set is function for list2set
(define (rlist2set lst out)
  (if (null? lst) out 
  (let ((outlist (putInOrder (car lst) out)))
  (cond ((null? lst) '())
        (else (rlist2set (cdr lst) outlist ))))))

; list2set
(define (list2set lst)
  (rlist2set lst '()))
;(list2set '(4 5 7 12 4))


; 1
; arg-max finds the maximum of a after mapping f
; a should be nonempty, otherwise it will throw an error
(define arg-max (lambda (f a)
          (if (null? (cdr a) ) 
              (car a)
              (if (> (f (car a)) (f (arg-max f (cdr a))))
                  (car a)
                  (arg-max f (cdr a))))))         
                  
;(arg-max square '(5 4 3 2 1))
;(arg-max invert '(5 4 3 2 1))
;(arg-max (lambda (x) (- 0 (square (- x 3)))) '(5 4 3 2 1))

; 2
; zip zips arbitrary lists
; I guess the point here is to use . here
(define (zip . l)l)
     
;(zip '(1 2 3) '(2 3 5))
;(zip '(1 2 3) '(2 3 5) '(5 6 7))

; 3
; unzip unzip the nth element in list
(define (unzip list n)
  (cond ((< n 0) '())
        ((= n 0) (car list))
        ((null? list) '())
        (else ( unzip (cdr list) (- n 1)))))
;(unzip '( (1 2 3) (5 6 7) (5 9 2 )) 1)
;(unzip '( (1 2 3) (5 6 7) (5 9 2 )) 0)
;(unzip '( (1 2 3) (5 6 7) (5 9 2 )) 5)

; 4
; list2set converts list to set
(define (intersectlist a b)
  (cond ((null? a) '())
        ((null? b) '())
        ((in (car a) b) (list2set (cons (car a) (intersectlist (cdr a) b))))
        (else (list2set (intersectlist (cdr a) b)))))

;(intersectlist '() '())
;(intersectlist '(1 3) '(2 4))
;(intersectlist '(1 2) '(2 4))
;(intersectlist '(1 2 3) '(1 2 2 3 4))

; The cases below are for requirements that cannot be tested from the above cases
;(intersectlist '(1 2 2 3) '(1 2 2 3 4))
;(intersectlist '(3 2 1) '(1 2 2 3 4))
;(intersectlist '(1 2 3) '(1 2 2 3 4))

; 5
; two input lists should be sorted
(define (sortedmerge x y)
  (cond ((null? x) y)
        ((null? y) x)
        ((< (car x) (car y)) (cons (car x) (sortedmerge (cdr x) y)))
        (else (cons (car y) (sortedmerge x (cdr y))))))

;(sortedmerge '(1 2 3) '(4 5 6))
;(sortedmerge '(1 3 5) '(2 4 6))
;(sortedmerge '(1 3 5) '())


; 6
; rinterleave is a recursion function for interleave
(define (rinterleave x y flag)
  (cond ((null? x) y)
        ((null? y) x)
        ((zero? flag) (cons (car x) (rinterleave (cdr x) y 1)))
        (else (cons (car y) (rinterleave x (cdr y) 0)))))

; interleave interleaves two lists
(define (interleave x y)
  (rinterleave x y 0))

;(interleave '(1 2 3) '(a b c))
;(interleave '(1 2 3) '(a b c d e f))
;(interleave '(1 2 3 4 5 6) '(a b c))


; 7
; inc increases x by 1
(define (inc x) (+ 1 x))

; issamesize returns whether two list are of the same size
(define (issamesize j l)
  (cond ((null? j) (if (null? l) #t #f))
        ((null? l) (if (null? j) #t #f))
        (else (issamesize (cdr j) (cdr l)))))

; map2f is the recusion function in map2
(define (map2f j l p f)
  (cond ((null? j) '())
        ((null? l) '())
        (else 
         (if (p (car j))
             (cons (f (car l)) (map2f (cdr j) (cdr l) p f))
             (cons (car l) (map2f (cdr j) (cdr l) p f))))))

; map2 does what required
(define (map2 j l p f)
  (if (issamesize j l) (map2f j l p f) "ERROR: The two lists are not of the same size!"))

;(map2 '(1 2 3 4) '(2 3 4 5) (lambda (x) (> x 2)) inc)


; 8
; Sorry, I know my answers for 8 are overcomplicated, but I couldn't figure out a better one the time I submitted it.
;I commented above each function to show what they can do and described in detailed under `edge-list-to-adjacency-list` `adjacency-list-to-edge-list` about my thinking process. 


; 8.a
; combine combines x and y, similar to append
(define (combine x y)
  (cond ((null? x) y)
        ((null? y) x)
        (else (cons (car y) (combine x (cdr y))))))

; delist uses combine to convert a list of lists to one list
(define (delist lst)
  (cond ((null? lst) '())
        (else
         (let ((r (delist (cdr lst))))
           (combine (car lst) r)))))

; lst2set converts a list to a set
(define (lst2set lst)
  (cond ((null? lst) '())
        (else (let ((r (lst2set (cdr lst))))
                (if (in (car lst) r)
                    r
                    (cons (car lst) r))))))

; search searches for end vertex for item
(define (getEdgeEnd item edge)
          (cond  ((null? edge) '())
                 ((eqv? (car edge) item) (cdr edge))
                 (else '())
           ))

; search4ends searches edges in lst which starts with item and returns a list of end vertex
(define (search4ends item lst)
  ( cond ((null? lst) '())
         (else (let (( r (getEdgeEnd item (car lst))))
                 (combine r (search4ends item (cdr lst)))))))
; mapping searchs every vertex in vlist and combine the vertex with the responding result
(define (mapping vlist edge-list)
  (cond ((null? vlist) '())
        (else (cons (list (list (car vlist)) (search4ends (car vlist) edge-list))
                    (mapping (cdr vlist) edge-list)))))

; edge-list-to-adjacency-list converts edge list to adjacency list
; 1. delist edge-list to get a list of vertexs
; 2. lst2set result from 1 to remove duplicate vertexs
; 3. let vlist be result from 2
; 4. mapping vlist and edge-list to search for end vertexs for each vertex in vlist and combine the start vertex with the end vertex list
(define (edge-list-to-adjacency-list edge-list)
  (let ((vlist (lst2set (delist edge-list))))
       (mapping vlist edge-list)))

;(define edge-list '((A B) (B C) (A C)))
;(edge-list-to-adjacency-list edge-list)


; 8.b
; v2ee converts a adjacency to an edge
(define (v2ee f e)
  (cond ((null? e) '())
        (else (cons (cons f (car e)) (v2ee f (cdr e))))))

; v2e converts a adjacency to an edge
(define (v2e v)
  (let ((f (caar v)) (e (cadr v)))
     (v2ee f e)
    )
  )

; adjacency-list-to-edge-list converts adjacency list to edge list
; 1. map list to convert each adjacency to list
; 2. delist lists of edges to one list
(define (adjacency-list-to-edge-list lst)
  (delist (map v2e adjacency_list)))

;(define adjacency_list '(((A) (B C)) ((B) (C)) ((C) ()) ((D) (A B C))))
;(adjacency-list-to-edge-list adjacency_list)