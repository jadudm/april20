#lang racket/base

(require rackunit rackunit/text-ui)
(require "lang0.rkt")
(require "passes.rkt")

(define i1 (lang0:make-int 3))
(define i2 (lang0:make-int 5))

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
      (lang0:make-program
       (list 
        (lang0:make-assign 't1 (lang0:make-int 8))
        (lang0:make-result 't1)))))
    
   (test-case
    "Convert a binop + to an LLVM string"
    (check-equal? 
     (list "%t1 = add i32 3, 5"
           "%result = %t1")
     (ast-to-llvm
      (lang0:make-program
       (list
        (lang0:make-assign 't1 
                     (lang0:make-binop 
                      '+
                      (lang0:make-int 3)
                      (lang0:make-int 5)))
        (lang0:make-result 't1))))))
   )))

(define all-tests
  (test-suite
   "All tests"
   int-struct-tests
   ast-to-llvm-tests
   ))

(run-tests all-tests)