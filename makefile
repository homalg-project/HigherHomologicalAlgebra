all: doc test

.PHONY: test

test: BBGG_test Bicomplexes_test ComplexesCategories_test DerivedCategories_test HomotopyCategories_test QuotientCategories_test StableCategories_test ToolsForHigherHomologicalAlgebra_test TriangulatedCategories_test

BBGG_test:
	cd BBGG && make test

Bicomplexes_test:
	cd Bicomplexes && make test

ComplexesCategories_test:
	cd ComplexesCategories && make test

DerivedCategories_test:
	cd DerivedCategories && make test

HomotopyCategories_test:
	cd HomotopyCategories && make test

QuotientCategories_test:
	cd QuotientCategories && make test

StableCategories_test:
	cd StableCategories && make test

ToolsForHigherHomologicalAlgebra_test:
	cd ToolsForHigherHomologicalAlgebra && make test

TriangulatedCategories_test:
	cd TriangulatedCategories && make test

doc: BBGG_doc Bicomplexes_doc ComplexesCategories_doc DerivedCategories_doc HomotopyCategories_doc QuotientCategories_doc StableCategories_doc ToolsForHigherHomologicalAlgebra_doc TriangulatedCategories_doc

BBGG_doc:
	cd BBGG && make doc

Bicomplexes_doc:
	cd Bicomplexes && make doc

ComplexesCategories_doc:
	cd ComplexesCategories && make doc

DerivedCategories_doc:
	cd DerivedCategories && make doc

HomotopyCategories_doc:
	cd HomotopyCategories && make doc

QuotientCategories_doc:
	cd QuotientCategories && make doc

StableCategories_doc:
	cd StableCategories && make doc

ToolsForHigherHomologicalAlgebra_doc:
	cd ToolsForHigherHomologicalAlgebra && make doc

TriangulatedCategories_doc:
	cd TriangulatedCategories && make doc

ci-test: doc
	cd BBGG && make ci-test
	cd Bicomplexes && make ci-test
	cd ComplexesCategories && make ci-test
	cd DerivedCategories && make ci-test
	cd HomotopyCategories && make ci-test
	cd QuotientCategories && make ci-test
	cd StableCategories && make ci-test
	cd ToolsForHigherHomologicalAlgebra && make ci-test
	cd TriangulatedCategories && make ci-test
# BEGIN PACKAGE JANITOR
doc: doc_BBGG doc_Bicomplexes doc_ComplexesCategories doc_DerivedCategories doc_HomotopyCategories doc_QuotientCategories doc_StableCategories doc_ToolsForHigherHomologicalAlgebra doc_TriangulatedCategories

doc_BBGG:
	$(MAKE) -C BBGG doc

doc_Bicomplexes:
	$(MAKE) -C Bicomplexes doc

doc_ComplexesCategories:
	$(MAKE) -C ComplexesCategories doc

doc_DerivedCategories:
	$(MAKE) -C DerivedCategories doc

doc_HomotopyCategories:
	$(MAKE) -C HomotopyCategories doc

doc_QuotientCategories:
	$(MAKE) -C QuotientCategories doc

doc_StableCategories:
	$(MAKE) -C StableCategories doc

doc_ToolsForHigherHomologicalAlgebra:
	$(MAKE) -C ToolsForHigherHomologicalAlgebra doc

doc_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories doc

# END PACKAGE JANITOR
