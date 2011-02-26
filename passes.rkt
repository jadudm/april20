#lang racket
(require "structures.rkt")
(provide (all-defined-out))

(define (ast-to-llvm ast)
  (match ast 
    [(int v) (format "~a" v)]
    [(binop op lhs rhs) (format "~a i32 ~a, ~a" 
             (handleop op) (ast-to-llvm lhs) (ast-to-llvm rhs))]
    [(assign name val) (format "%~a = ~a" name (ast-to-llvm val))]
    [(result name) (format "%result = ~a" name)] 
    [(program statements) (map ast-to-llvm statements)]
    ))
    
(define (handleop op)
  (match op
  ['+ "add"]
  ['- "sub"]
  ['* "mul"]
  ['/ "div"]))
