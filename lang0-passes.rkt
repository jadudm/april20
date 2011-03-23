#lang racket
;; PROVIDES
(provide ast-to-llvm verify-lang0)
;; REQUIRES
(require "lang0.rkt")

;; PASS
;; verify-lang0 :: lang0 -> lang0
;; PURPOSE
;; Verifies that we have a language tree only in lang0.
(define (verify-lang0 ast)
  (match ast
    [(lang0:program statements)
     (lang0:program 
      (map verify-lang0 statements))]
    [(lang0:assign name val) 
     (if (symbol? name) 
         (lang0:assign name (verify-lang0 val))
         (error "Not lang0:assign"))]
    [(lang0:result name) 
     (if (symbol? name) 
         (lang0:result name) 
         (error "Not lang0:result"))]
    [(lang0:binop op lhs rhs) 
     (if (member op '(+ - * /)) 
         (lang0:binop op (verify-lang0 lhs) (verify-lang0 rhs)) 
         (error "Not lang0:binop"))]
    [(lang0:int v) (if (number? v) 
                       (lang0:int v) 
                       (error "Not lang0:int"))]))

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
     (format "%result = call i32 @ident(i32 %~a)" name)]
    [(lang0:binop op lhs rhs)
     ;; <return type> instruction op1 op2
     (format "i32 ~a ~a, ~a" 
             (handleop op) (ast-to-llvm lhs) (ast-to-llvm rhs))]
    [(lang0:int v) 
     (format "call i32 @ident (i32 ~a)" v)]
    ))

;; CONTRACT
;; handleop :: symbol -> string
(define (handleop op)
  (match op
    ['+ "add"]
    ['- "sub"]
    ['* "mul"]
    ['/ "div"]))
