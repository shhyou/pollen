#lang racket/base
(require (for-syntax racket/base pollen/setup) pollen/tag)
(provide def/c (rename-out (top~ #%top)))

(define-syntax (top~ stx)
  (syntax-case stx ()
    [(_ . ID)
     (setup:allow-unbound-ids?)
     (let ([unbound-id-handler (setup:allow-unbound-ids?)])
       (cond
         [(procedure? unbound-id-handler)
          (unbound-id-handler #'ID)]
         [else
          #'(#%app make-default-tag-function 'ID)]))]
    [(_ . ID)
     #'(def/c ID)]))

(define-syntax (def/c stx)
  (syntax-case stx ()
    [(_ ID) (identifier-binding #'ID) #'ID]
    [(_ ID) #'(#%top . ID)]))