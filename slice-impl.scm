(declare (fixnum))

(define slice
  (let ()

    (define (from/to from to len)
      (let* ((from (cond ((not from) 0)
                         ((> from len) len)
                         ((< from 0) (- len (if (> (abs from) len)
                                                len
                                                (- from))))
                         ((> from 0) from)
                         (else 0)))
             (to (cond ((not to) len)
                       ((> to len) len)
                       ((< to 0) (- len (if (> (abs to) len)
                                            len
                                            (- to))))
                       (else to))))
        (cond ((<= to from) #f)
              (else (cons from to)))))


    (define (generic-slicer obj from to ruler empty obj-slicer)
      (let* ((len (ruler obj))
             (from&to (from/to from to len))
             (from (and from&to (car from&to)))
             (to (and from&to (cdr from&to))))
        (if (and from to)
            (obj-slicer obj from to)
            empty)))

    (define (string-slice s from to)
      (generic-slicer s from to string-length "" substring))

    (define (list-slice l from to)
      (generic-slicer l from to length '()
                      (lambda (l from to)
                        (take (drop l from) (- to from)))))

    (define (vector-slice v from to)
      (define (subvector vector start end)
        (let ((sub (make-vector (- end start))))
          (let loop ((i 0))
            (if (< i (- end start))
                (begin (vector-set! sub i (vector-ref vector (+ i start)))
                       (loop (+ i 1)))))
          sub))
      (generic-slicer v from to vector-length '#() subvector))


    (let ((slicers
           (list (lambda (obj)
                   (and (string? obj)
                        string-slice))
                 (lambda (obj)
                   (and (vector? obj)
                        vector-slice))
                 (lambda (obj)
                   (and (list? obj)
                        list-slice)))))
      (lambda (obj #!optional from to)
        (if (procedure? obj)
            (set! slicers (cons obj slicers))
            (let loop ((slicers slicers))
              (if (null? slicers)
                  (error "No slicer for the given object.")
                  (let* ((slicer (car slicers))
                         (slice (slicer obj)))
                    (if slice
                        (slice obj from to)
                        (loop (cdr slicers)))))))))))
