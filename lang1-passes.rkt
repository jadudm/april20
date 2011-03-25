#lang scheme

(define (ast-to-l0)
  (match ast
   [(lang1:cond 
    
    
    
  ))


(define (handlecond cond)
  (match cond
    ['> "ugt"]
    ['< "ult"]
    ['== "eq"]
    ['!= "ne"]))