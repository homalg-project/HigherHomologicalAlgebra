all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Intro.autodoc \
		gap/*.gd gap/*.gi examples/*.g 
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	( gap makedoc.g; gap tst/testall.g )

