(module slice-utf8 (slice)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use srfi-1)
   (use utf8))
  (chicken-5
   (import (chicken base))
   (import srfi-1 utf8))
  (else
   (error "Unsupported CHICKEN version.")))

(include "slice-impl.scm")

) ; end module
