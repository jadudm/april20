#lang racket/base
;; lang0
(provide (prefix-out lang0: (all-defined-out)))

;; Grammar
;; <program>   := (program (<constant> ...) (<assign> ...) <result>)
;; <constant>  := (constant <name> <integer>)
;; <assign>    := (assign <name> <binop>)
;; <binop>     := (binop <op> <name> <name>)
;; <result>    := (result <name>)
;; <name>      := symbol?
;; <integer>   := integer?

(struct program (constants statements result))
(struct constant (name value))
(struct assign (name bop)) ;; ? Are these always going to be a binop on the RHS?
(struct binop (op lname rname))
(struct result (name))
