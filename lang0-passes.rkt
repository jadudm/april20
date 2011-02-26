#lang racket
;; PROVIDES
(provide ast-to-llvm)
;; REQUIRES
(require "lang0.rkt")

;; PASS
;; verify-lang0 :: lang0 -> lang0
;; PURPOSE
;; Verifies that we have a language tree only in lang0.
(define (verify-lang0 ast)
  '...)

;; PASS
;; ast-to-llvm :: lang0 -> (list-of string)
;; PURPOSE
;; Takes lang0 (which is practically LLVM assembly) and transforms
;; it into a list of strings for inclusion in our wrapper.
(define (ast-to-llvm ast)
  (match ast 
    [(lang0:program statements)
     (map ast-to-llvm statements)]
    [(lang0:assign name val) 
     (format "%~a = ~a" name (ast-to-llvm val))]
    [(lang0:result name) 
     (format "%result = %~a" name)]
    [(lang0:binop op lhs rhs) 
     (format "~a i32 ~a, ~a" 
             (handleop op) (ast-to-llvm lhs) (ast-to-llvm rhs))]
    [(lang0:int v) 
     (format "~a" v)]
    ))

;; CONTRACT
;; handleop :: symbol -> string
(define (handleop op)
  (match op
    ['+ "add"]
    ['- "sub"]
    ['* "mul"]
    ['/ "div"]))
