#lang racket

;part (ii)
(define total 0)                           ;set total to 0
(define (sum Lst)
  (if (not (null? Lst))                    ;if Lst isn't empty
      (begin
        (set! total (+ total (car Lst)))   ;add first element of list to total
        (sum (cdr Lst)))                   ;recursivly call the remaining section of the list so the next element can be added to the total
      total))                              ;else if Lst is empty return total as all elements have been added

;(sum '(2 4 6))  =>  12
;(sum '(1 3 4 7)) =>  15

;-----------------------------------------------------------------------------------
      
;part (iv)
(define (desc Lst)
  (if (not(null?(cdr Lst)))                ;if the tail of the list is empty so it only contains one element
      (if (>= (car Lst) (car(cdr Lst)))     ;if the first element is greater than the first element of the tail(first element greater than second element)
          (desc (cdr Lst))                 ;recursivly call the tail of the list to check the remaining elements are in descending order
          false)                           ;else return false if first element is not greater than second element
      true))                               ;else return true if only one element remaing in list

;(desc '(5 3 1)) => #t
;(desc '(6 4 0 1)) => #f

	