(defsystem #:tokyo.tojo.iterable
  :description "This library provides a function to iterate monad chaining without recursion"
  :author "Masaya Tojo"
  :license  "MIT"
  :version "0.0.0"
  :depends-on (#:coalton)
  :serial t
  :pathname "src/"
  :components ((:file "iterable")))
