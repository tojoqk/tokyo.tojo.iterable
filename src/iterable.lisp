(defpackage #:tokyo.tojo.iterable
  (:use #:coalton
        #:coalton-prelude)
  (:shadow #:continue #:return)
  (:local-nicknames
   (#:cell #:coalton-library/cell))
  (:export #:Iterable
           #:iterate
           #:Step
           #:Continue
           #:Return))

(in-package #:tokyo.tojo.iterable)

(coalton-toplevel
  (define-type (Step :a)
    "A type that represents whether to continue or return a value and terminate"
    (Continue :a)
    (Return :a))

  (define-class (Monad :m => Iterable :m)
    "A type class representing a monad that can iterate without recursion"
    (iterate ((:a -> :m (Step :a)) -> :a -> :m :a)))

  (define-instance (Iterable Optional)
    (define (iterate f init)
      (let opt* = (cell:new (Some init)))
      (loop
        (match (>>= (cell:read opt*) f)
          ((Some (Continue x))
           (cell:write! opt* (Some x))
           (coalton:continue))
          ((Some (Return x))
           (cell:write! opt* (Some x))
           (break))
          ((None)
           (cell:write! opt* None)
           (break))))
      (cell:read opt*)))

  (define-instance (Iterable (Result :e))
    (define (iterate f init)
      (let result* = (cell:new (Ok init)))
      (loop
        (match (>>= (cell:read result*) f)
          ((Ok (Continue x))
           (cell:write! result* (Ok x))
           (coalton:continue))
          ((Ok (Return x))
           (cell:write! result* (Ok x))
           (break))
          ((Err e)
           (cell:write! result* (Err e))
           (break))))
      (cell:read result*)))

  (define-instance (Iterable List)
    (define (iterate f init)
      (let results* = (cell:new Nil))
      (let states* = (cell:new (make-list init)))
      (loop
        (match (cell:read states*)
          ((Nil) (break))
          (next-states
           (cell:write! states* Nil)
           (for x in (>>= next-states f)
                (match x
                  ((Continue next-state)
                   (cell:write! states* (Cons next-state (cell:read states*))))
                  ((Return final-state)
                   (cell:write! results* (Cons final-state (cell:read results*))))))
           (cell:update! reverse! states*)
           Unit)))
      (reverse! (cell:read results*))))

  (declare reverse! (List :a -> List :a))
  (define (reverse! xs)
    (lisp (List :a) (xs)
      (cl:nreverse xs))))
