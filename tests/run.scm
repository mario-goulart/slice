(use test slice (rename slice-utf8 (slice slice-utf8)))

;;;
;;; Strings
;;;
(test-begin "Slice")

(test-begin "Strings")

(define s "1234567")

(display "s = ")
(pp s)
(test "" (slice s 0 0))
(test "" (slice s 1 0))
(test "1" (slice s 0 1))
(test "" (slice s 10 10))
(test "1234567" (slice s 0 10))
(test "" (slice s 10 0))

(test "1234567" (slice s 0))
(test "7" (slice s -1))
(test "" (slice s 10))
(test "1234567" (slice s -10))
(test "4567" (slice s -4))

(test "" (slice s -4 -4))
(test "45" (slice s -4 -2))
(test "" (slice s -4 -10))
(test "123" (slice s -10 -4))

(test-end "Strings")

;;;
;;; Lists
;;;
(test-begin "Lists")

(define l '(1 2 3 4 5 6 7))

(newline)
(display "l = ")
(pp l)

(test '() (slice l 0 0))
(test '() (slice l 1 0))
(test '(1) (slice l 0 1))
(test '(2 3) (slice l 1 3))
(test '() (slice l 10 10))
(test '(1 2 3 4 5 6 7) (slice l 0 10))
(test '() (slice l 10 0))

(test '(1 2 3 4 5 6 7) (slice l 0))
(test '(7) (slice l -1))
(test '() (slice l 10))
(test '(1 2 3 4 5 6 7) (slice l -10))
(test '(4 5 6 7) (slice l -4))

(test '() (slice l -4 -4))
(test '(4 5) (slice l -4 -2))
(test '() (slice l -4 -10))
(test '(1 2 3) (slice l -10 -4))

(test-end "Lists")

;;;
;;; Vectors
;;;
(test-begin "Vectors")

(define v '#(1 2 3 4 5 6 7))

(newline)
(display "v = ")
(pp v)

(test '#() (slice v 0 0))
(test '#() (slice v 1 0))
(test '#(1) (slice v 0 1))
(test '#(2 3) (slice v 1 3))
(test '#() (slice v 10 10))
(test '#(1 2 3 4 5 6 7) (slice v 0 10))
(test '#() (slice v 10 0))

(test '#(1 2 3 4 5 6 7) (slice v 0))
(test '#(7) (slice v -1))
(test '#() (slice v 10))
(test '#(1 2 3 4 5 6 7) (slice v -10))
(test '#(4 5 6 7) (slice v -4))

(test '#() (slice v -4 -4))
(test '#(4 5) (slice v -4 -2))
(test '#() (slice v -4 -10))
(test '#(1 2 3) (slice v -10 -4))

(test-end "Vectors")

;;;
;;; Custom object
;;;
(test-begin "Custom object")

(define-record custom-string text)

(define s (make-custom-string "custom string"))
(slice (lambda (obj)
         (and (custom-string? obj)
              (lambda (obj from to)
                (handle-exceptions
                 exn
                 ""
                 (substring (custom-string-text obj) from to))))))

(newline)
(display "s = ")
(pp s)

(test "" (slice s 0 0))
(test "" (slice s 1 0))
(test "c" (slice s 0 1))

(test-end "Custom object")

;;;
;;; UTF-8
;;;

(test-begin "UTF-8 Strings")

(define s "ççããõõ")

(display "s = ")
(pp s)
(test "" (slice-utf8 s 0 0))
(test "" (slice-utf8 s 1 0))
(test "ç" (slice-utf8 s 0 1))
(test "" (slice-utf8 s 10 10))
(test "ççããõõ" (slice-utf8 s 0 10))
(test "" (slice-utf8 s 10 0))

(test "ççããõõ" (slice-utf8 s 0))
(test "õ" (slice-utf8 s -1))
(test "" (slice-utf8 s 10))
(test "ççããõõ" (slice-utf8 s -10))
(test "ããõõ" (slice-utf8 s -4))

(test "" (slice-utf8 s -4 -4))
(test "ãã" (slice-utf8 s -4 -2))
(test "" (slice-utf8 s -4 -10))
(test "çç" (slice-utf8 s -10 -4))

(test-end "UTF-8 Strings")

(test-end "Slice")

(test-exit)
