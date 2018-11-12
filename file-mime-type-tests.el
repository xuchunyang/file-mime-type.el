(require 'ert)
(require 'file-mime-type)

(ert-deftest file-mime-type-test ()
  "Test `file-mime-type'."
  (should (string= (file-mime-type "file-mime-type.el") "text/x-lisp"))
  (should-error (file-mime-type "a file that does not exist")
                :type 'file-missing))
