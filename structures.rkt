#lang racket/base

(provide (all-defined-out))

(define-struct binop (op lhs rhs))

(define-struct int (value))

