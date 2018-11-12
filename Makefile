EMACS ?= emacs

.PHONY: compile test

all: check

check: compile test

compile:
	${EMACS} -Q --batch -L . -f batch-byte-compile file-mime-type.el

test:
	${EMACS} -Q --batch -L . -l file-mime-type-tests -f ert-run-tests-batch-and-exit
