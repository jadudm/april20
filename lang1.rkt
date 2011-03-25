#lang racket/base
;; lang0
(provide (prefix-out lang1: (all-defined-out)))

;; Grammar
;; <program>   := (program (<constant> ...) (<substitution> ...))
;; <constant>  := (constant <name> <integer>)
;; <substitution> := (subst <name> <binop>)
;; <binop>     := (binop <op> <name> <name>)
;; <name>      := symbol?
;; <integer>   := integer?

(struct program (constants substitutions))
(struct constant (name value))
(struct subst  (name bop))
(struct binop (op name name))
