all: doc test

ci-test: doc ci-test_all_packages

# BEGIN PACKAGE JANITOR
################################
doc: doc_BBGG doc_Bicomplexes doc_ComplexesCategories doc_DerivedCategories doc_HomotopyCategories doc_StableCategories doc_ToolsForHigherHomologicalAlgebra doc_TriangulatedCategories

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

doc_StableCategories:
	$(MAKE) -C StableCategories doc

doc_ToolsForHigherHomologicalAlgebra:
	$(MAKE) -C ToolsForHigherHomologicalAlgebra doc

doc_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories doc

################################
test: doc test_BBGG test_Bicomplexes test_ComplexesCategories test_DerivedCategories test_HomotopyCategories test_StableCategories test_ToolsForHigherHomologicalAlgebra test_TriangulatedCategories

test_BBGG:
	$(MAKE) -C BBGG test

test_Bicomplexes:
	$(MAKE) -C Bicomplexes test

test_ComplexesCategories:
	$(MAKE) -C ComplexesCategories test

test_DerivedCategories:
	$(MAKE) -C DerivedCategories test

test_HomotopyCategories:
	$(MAKE) -C HomotopyCategories test

test_StableCategories:
	$(MAKE) -C StableCategories test

test_ToolsForHigherHomologicalAlgebra:
	$(MAKE) -C ToolsForHigherHomologicalAlgebra test

test_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories test

################################
ci-test_all_packages: ci-test_BBGG ci-test_Bicomplexes ci-test_ComplexesCategories ci-test_DerivedCategories ci-test_HomotopyCategories ci-test_StableCategories ci-test_ToolsForHigherHomologicalAlgebra ci-test_TriangulatedCategories

ci-test_BBGG:
	$(MAKE) -C BBGG ci-test

ci-test_Bicomplexes:
	$(MAKE) -C Bicomplexes ci-test

ci-test_ComplexesCategories:
	$(MAKE) -C ComplexesCategories ci-test

ci-test_DerivedCategories:
	$(MAKE) -C DerivedCategories ci-test

ci-test_HomotopyCategories:
	$(MAKE) -C HomotopyCategories ci-test

ci-test_StableCategories:
	$(MAKE) -C StableCategories ci-test

ci-test_ToolsForHigherHomologicalAlgebra:
	$(MAKE) -C ToolsForHigherHomologicalAlgebra ci-test

ci-test_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories ci-test

# END PACKAGE JANITOR
