(module slice (slice)

(import scheme)
(cond-expand
  (chicken-4
   (import chicken)
   (use srfi-1))
  (chicken-5
   (import (chicken base))
   (import srfi-1))
  (else
   (error "Unsupported CHICKEN version.")))

(include "slice-impl.scm")

) ; end module
