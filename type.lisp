(in-package #:word-ptr)

;;------------------------------------------------------------

#+(and sbcl (not alpha))
(deftype word-ptr () 'sb-ext:word)

#+(or (not sbcl) alpha)
(deftype word-ptr () 'cffi:foreign-pointer)

;;------------------------------------------------------------

#+(and sbcl (not alpha))
(deftype word-ptr-offset () 'sb-vm:signed-word)

#+(or (not sbcl) alpha)
(deftype word-ptr-offset () 'integer)

;;------------------------------------------------------------

(declaim (inline as-ptr)
         (ftype (function (word-ptr) cffi:foreign-pointer) as-ptr))

#+(and sbcl (not alpha))
(defun as-ptr (wptr)
  (declare (inline sb-sys:int-sap) (word-ptr wptr)
           (optimize (speed 3) (debug 1) (safety 1)))
  (sb-sys:int-sap wptr))

#+(or (not sbcl) alpha)
(defun as-ptr (wptr)
  ptr)

;;------------------------------------------------------------

(declaim (inline as-wptr)
         (ftype (function (cffi:foreign-pointer) word-ptr) as-wptr))

#+(and sbcl (not alpha))
(defun as-wptr (ptr)
  (declare (inline sb-sys:sap-int) (cffi:foreign-pointer ptr)
           (optimize (speed 3) (debug 1) (safety 1)))
  (the word-ptr (sb-sys:sap-int ptr)))

#+(or (not sbcl) alpha)
(defun as-wptr (ptr)
  ptr)

;;------------------------------------------------------------

(declaim (inline wptr-p)
         (ftype (function (t) boolean) wptr-p))

#+(and sbcl (not alpha))
(defun wptr-p (ptr)
  (declare (optimize (speed 3) (debug 1) (safety 1)))
  (typep ptr 'word-ptr))


#+(or (not sbcl) alpha)
(defun wptr-p (ptr)
  (cffi:pointerp ptr))

;;------------------------------------------------------------

(declaim (inline null-wptr)
         (ftype (function () word-ptr) null-wptr))

#+(and sbcl (not alpha))
(defun null-wptr ()
  (declare (optimize (speed 3) (debug 1) (safety 1)))
  (the word-ptr 0))

#+(or (not sbcl) alpha)
(defun null-wptr ()
  (cffi:null-pointer))

;;------------------------------------------------------------

(declaim (inline null-wptr-p)
         (ftype (function (word-ptr) boolean) null-wptr-p))

#+(and sbcl (not alpha))
(defun null-wptr-p (wptr)
  (declare (optimize (speed 3) (debug 1) (safety 1))
           (word-ptr wptr))
  (= wptr 0))


#+(or (not sbcl) alpha)
(defun null-wptr-p (wptr)
  (cffi:null-pointer-p wptr))

;;------------------------------------------------------------

(declaim (inline wptr=)
         (ftype (function (word-ptr word-ptr) boolean) wptr=))

#+(and sbcl (not alpha))
(defun wptr= (wptr-a wptr-b)
  (declare (optimize (speed 3) (debug 1) (safety 1))
           (word-ptr wptr-a wptr-b))
  (= wptr-a wptr-b))


#+(or (not sbcl) alpha)
(defun wptr= (wptr-a wptr-b)
  (cffi:pointer-eq wptr-a wptr-b))

;;------------------------------------------------------------

(declaim (inline wptr+)
         (ftype (function (word-ptr word-ptr-offset) word-ptr) wptr+))

#+(and sbcl (not alpha))
(defun wptr+ (wptr offset)
  (declare (optimize (speed 3) (debug 1) (safety 0))
           (word-ptr wptr) (word-ptr-offset offset))
  (the word-ptr (+ wptr offset)))

#+(or (not sbcl) alpha)
(defun wptr+ (ptr offset)
  (cffi:inc-pointer ptr offset))

(define-modify-macro incf-wptr (&optional (offset 1))
  wptr+)

;;------------------------------------------------------------

(declaim (inline wptr-)
         (ftype (function (word-ptr word-ptr-offset) word-ptr-offset) wptr-))

#+(and sbcl (not alpha))
(defun wptr- (wptr offset)
  (declare (optimize (speed 3) (debug 1) (safety 0))
           (word-ptr wptr) (word-ptr-offset offset))
  (the word-ptr-offset (- wptr offset)))

#+(or (not sbcl) alpha)
(defun wptr- (ptr offset)
  (cffi:inc-pointer ptr (- offset)))

(define-modify-macro decf-wptr (&optional (offset 1))
  wptr-)

;;------------------------------------------------------------
