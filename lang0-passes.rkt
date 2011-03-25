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


#| 
THIS IS LANG ZERO
(struct program (constants statements result))
(struct constant (name value))
(struct assign (name bop)) ;; ? Are these always going to be a binop on the RHS?
(struct binop (op name name))
(struct result (name))
|#

;; PASS
;; L0-to-llvm :: lang0 -> (list-of string)
;; PURPOSE
;; Takes lang0 (which is practically LLVM assembly) and transforms
;; it into a list of strings for inclusion in our wrapper.
(define (L0-to-llvm ast)
  (match ast 
    [(lang0:program constants statements res) 
     ;; Return the LLVM program as one big ugly string. Ew.
     (format "
;; Format string
@.str = private constant [4 x i8] c\"%d\\0A\\00\", align 1

;; Globals
~a

define i32 @main () {
;; Allocate space for local value of constants
~a

;; Load constants
~a

;; Code
~a

;; The Result
%result = ~a

;; Print the result
  %printResult = call i32 (i8*, ...)*
       @printf (i8* noalias getelementptr inbounds
                  ([4 x i8]* @.str, i64 0, i64 0),
                  i32 %result) nounwind

  ; It turns out Unix return codes are modulo 256.
  ret i32 0
}

declare i32 @printf (i8* nocapture, ...) nounwind
" 
             (constants-to-globals constants)
             (constants-to-allocas constants)
             (constants-to-loads   constants)
             (statements-to-llvm   statements)
             (result-name res))]))

;; CONTRACT
;; handleop :: symbol -> string
(define (handleop op)
  (match op
    ['+ "add"]
    ['- "sub"]
    ['* "mul"]
    ['/ "div"]))
