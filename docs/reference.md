# Package `tokyo.tojo.iterable`<a name="tokyo.tojo.iterable-package"></a>

## [iterable.lisp](https://github.com/tojoqk/tokyo.tojo.iterable/tree/main/src/iterable.lisp) <a name="tokyo.tojo.iterable-iterable-lisp-file"></a>

### Types

#### <code>STEP :A</code> <sup><sub>[TYPE]</sub></sup><a name="step-type"></a>

A type that represents whether to continue or return a value and terminate

<details>
<summary>Instances</summary>

- <code><a href="#runtimerepr-class">RUNTIMEREPR</a> (<a href="#step-type">STEP</a> :A)</code>

</details>


***

### Classes

#### <code>ITERABLE</code> <sup><sub>[CLASS]</sub></sup><a name="iterable-class"></a>
<code><a href="#monad-class">MONAD</a> :A &rArr; <a href="#iterable-class">ITERABLE</a> :A</code>

A type class representing a monad that can iterate without recursion

Methods:
- <code>ITERATE :: ((:B &rarr; (:A (<a href="#step-type">STEP</a> :B))) &rarr; :B &rarr; (:A :B))</code>

<details>
<summary>Instances</summary>

- <code><a href="#iterable-class">ITERABLE</a> <a href="#list-type">LIST</a></code>
- <code><a href="#iterable-class">ITERABLE</a> (<a href="#result-type">RESULT</a> :A)</code>
- <code><a href="#iterable-class">ITERABLE</a> <a href="#optional-type">OPTIONAL</a></code>

</details>


***

