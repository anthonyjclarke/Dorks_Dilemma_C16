PYTHON ?= python3
NODE ?= node

.PHONY: all run run-original test clean docs docs-html docs-watch docs-check test-docs

all:
	$(PYTHON) scripts/restore_c16.py

run: all
	scripts/run_vice.sh build/dorks.prg

run-original:
	scripts/run_vice.sh Original_Files/DORKSDIL.BIN

test:
	$(PYTHON) -m unittest discover -s test -p 'test_*.py' -v

docs: all
	$(PYTHON) scripts/analyze_codebase.py
	$(NODE) scripts/build_docs.mjs

docs-html:
	$(NODE) scripts/build_docs.mjs

docs-watch:
	$(NODE) scripts/build_docs.mjs --watch

docs-check:
	$(NODE) scripts/build_docs.mjs --check

test-docs:
	$(NODE) --test test/test_docs.mjs

clean:
	rm -rf build
