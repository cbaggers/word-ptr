;;;; word-ptr.asd

(asdf:defsystem #:word-ptr
  :description "Unboxed foreign pointer hack"
  :author "Chris Bagley (Baggers) <techsnuffle@gmail.com>"
  :license "Unlicence"
  :depends-on (:cffi)
  :serial t
  :components ((:file "package")
               (:file "type")))
