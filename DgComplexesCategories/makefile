# make sure gap --quitonbreak fails even if it is part of a pipe
SHELL=/bin/bash -o pipefail

all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		$(wildcard doc/*.autodoc gap/*.gd gap/*.gi examples/*.g examples/*/*.g)
			gap --quitonbreak makedoc.g

clean:
	(cd doc ; ./clean)

test: doc
	gap tst/testall.g

test-basic-spacing:
	# exit code 1 means no match, which is what we want here (exit code 2 signals an error)
	grep -RPl "\t" examples/ gap/; test $$? -eq 1 || (echo "Tabs found" && exit 1)
	grep -RPl "\r" examples/ gap/; test $$? -eq 1 || (echo "Windows line-endings found" && exit 1)
	grep -RPzL "\n\z" examples/ gap/ | grep ""; test $$? -eq 1 || (echo "File with no newline at end of file found" && exit 1)

test-doc: doc
	cp -aT doc/ doc_tmp/
	cd doc_tmp && ./clean
	gap --quitonbreak makedoc_with_overfull_hbox_warnings.g | perl -pe 'END { exit $$status } $$status=1 if /#W/;'

test-with-coverage: doc
	gap --quitonbreak --cover stats tst/testall.g
	gap --quitonbreak --norepl -c 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");'

ci-test: test-basic-spacing test-with-coverage
