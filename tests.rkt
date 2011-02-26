#lang racket/base

(require rackunit rackunit/text-ui)
(require "structures.rkt")

(define i1 (make-int 3))
(define i2 (make-int 5))

(define int-struct-tests
  (test-suite
   "Integer structure tests"
   
   (test-case
    "Tests for int structure" 
    (check-equal? 3 (int-value i1)))
   ))

(define all-tests
  (test-suite
   "All tests"
   int-struct-tests))

(run-tests all-tests)