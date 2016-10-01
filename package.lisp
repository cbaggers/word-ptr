;;;; package.lisp

(defpackage #:word-ptr
  (:use #:cl)
  (:export :as-ptr
           :as-wptr
           :decf-wptr
           :incf-wptr
           :null-wptr
           :null-wptr-p
           :word-ptr
           :word-ptr-offset
           :wptr+
           :wptr-
           :wptr-p
           :wptr=))
