#lang scheme
(require "lang0-passes.rkt"
         "write-out.rkt"
         "lang0.rkt")

(define (driver code)
  (write-out (ast-to-llvm code)))

(define prog1 (lang0:program
               (list 
                (lang0:assign 't1 (lang0:int 8))
                (lang0:result 't1))))

(define prog2 (lang0:program
               (list
                (lang0:assign 't1 
                              (lang0:binop 
                               '+
                               (lang0:int 3)
                               (lang0:int 5)))
                (lang0:result 't1))))