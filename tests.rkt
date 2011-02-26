#lang racket/base

(require rackunit rackunit/text-ui)
(require "structures.rkt")
(require "passes.rkt")

(define i1 (make-int 3))
(define i2 (make-int 5))

(define int-struct-tests
  (test-suite
   "Integer structure tests"
   
   (test-case
    "Tests for int structure" 
    (check-equal? 3 (int-value i1)))
   ))

(define ast-to-llvm-tests
  (test-suite
   "<ast-to-llvm> tests"
   (test-case
    "Convert an int to an LLVM string"
    (check-equal? 
     (list "%t1 = 8"
           "%result = %t1")
     (ast-to-llvm 
      (make-program
       (list 
        (make-assign 't1 (make-int 8))
        (make-result 't1)))))
    
   (test-case
    "Convert a binop + to an LLVM string"
    (check-equal? 
     (list "%t1 = add i32 3, 5"
           "%result = %t1")
     (ast-to-llvm
      (make-program
       (list
        (make-assign 't1 
                     (make-binop 
                      '+
                      (make-int 3)
                      (make-int 5)))
        (make-result 't1))))))
   )))

(define all-tests
  (test-suite
   "All tests"
   int-struct-tests
   ast-to-llvm-tests
   ))

(run-tests all-tests)