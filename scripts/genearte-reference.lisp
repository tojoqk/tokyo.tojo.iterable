(ql:quickload :coalton/doc)
(ql:quickload :tokyo.tojo.iterable)
(coalton-doc:write-documentation-to-file
 "docs/reference.md"
 :packages '(tokyo.tojo.iterable)
 :asdf-system :tokyo.tojo.iterable
 :file-link-prefix "https://github.com/tojoqk/tokyo.tojo.iterable/tree/main/src/")
