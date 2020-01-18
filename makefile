all: doc test

doc:  
	gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap tst/testall.g

