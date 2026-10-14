all: doc test

ci-test: doc ci-test_all_packages

# BEGIN PACKAGE JANITOR
################################
doc: doc_Bicomplexes doc_ComplexesCategories doc_DerivedCategories doc_HomotopyCategories doc_StableCategories doc_TriangulatedCategories

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

doc_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories doc

################################
test: doc test_Bicomplexes test_ComplexesCategories test_DerivedCategories test_HomotopyCategories test_StableCategories test_TriangulatedCategories

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

test_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories test

################################
ci-test_all_packages: ci-test_Bicomplexes ci-test_ComplexesCategories ci-test_DerivedCategories ci-test_HomotopyCategories ci-test_StableCategories ci-test_TriangulatedCategories

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

ci-test_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories ci-test

################################
update-notebooks: update-notebooks_ComplexesCategories update-notebooks_DerivedCategories update-notebooks_HomotopyCategories

update-notebooks_ComplexesCategories:
	$(MAKE) -C ComplexesCategories update-notebooks

update-notebooks_DerivedCategories:
	$(MAKE) -C DerivedCategories update-notebooks

update-notebooks_HomotopyCategories:
	$(MAKE) -C HomotopyCategories update-notebooks

################################
match_tests_to_examples: match_tests_to_examples_Bicomplexes match_tests_to_examples_ComplexesCategories match_tests_to_examples_DerivedCategories match_tests_to_examples_HomotopyCategories match_tests_to_examples_StableCategories match_tests_to_examples_TriangulatedCategories

match_tests_to_examples_Bicomplexes:
	$(MAKE) -C Bicomplexes match_tests_to_examples

match_tests_to_examples_ComplexesCategories:
	$(MAKE) -C ComplexesCategories match_tests_to_examples

match_tests_to_examples_DerivedCategories:
	$(MAKE) -C DerivedCategories match_tests_to_examples

match_tests_to_examples_HomotopyCategories:
	$(MAKE) -C HomotopyCategories match_tests_to_examples

match_tests_to_examples_StableCategories:
	$(MAKE) -C StableCategories match_tests_to_examples

match_tests_to_examples_TriangulatedCategories:
	$(MAKE) -C TriangulatedCategories match_tests_to_examples
# END PACKAGE JANITOR
