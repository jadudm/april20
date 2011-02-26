#lang racket/base

(provide (all-defined-out))

(define-struct binop (op lhs rhs))

(define-struct int (value))

(define-struct program (statements))

(define-struct assign (name value))

(define-struct result (name))
