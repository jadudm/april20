#lang racket/base

(require rackunit rackunit/text-ui)
(require "lang0.rkt")
(require "lang0-passes.rkt")

(define i1 (lang0:int 3))
(define i2 (lang0:int 5))

(define int-struct-tests
  (test-suite
   "Integer structure tests"
   
   (test-case
    "Tests for int structure" 
    (check-equal? 3 (lang0:int-value i1)))
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
      (lang0:program
       (list 
        (lang0:assign 't1 (lang0:int 8))
        (lang0:result 't1)))))
    
   (test-case
    "Convert a binop + to an LLVM string"
    (check-equal? 
     (list "%t1 = add i32 3, 5"
           "%result = %t1")
     (ast-to-llvm
      (lang0:program
       (list
        (lang0:assign 't1 
                     (lang0:binop 
                      '+
                      (lang0:int 3)
                      (lang0:int 5)))
        (lang0:result 't1))))))
   )))

(define all-tests
  (test-suite
   "All tests"
   int-struct-tests
   ast-to-llvm-tests
   ))

(run-tests all-tests)