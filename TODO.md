done!
-----
* Install basic operations of C(A) depending on the existence of the corresponding operations in A
  (adjust the documentation of ChainComplexCategory/CochainComplexCategory, A does not have to be abelian, but simply IsAbCategory)
* Fix code formatting of AddIsProjective, AddProjectiveLift
* Brual/Good truncation as functors

To do
-----
* Implement the monoidal structure also for cochain complex categories. Try to do this by turning hard coded indices into variables
  to avoid code duplication
* Associator in monoidal categories
* Is it possible to optimize the computation of projective & injective resolutions?
* Is it possible to return a minimal projective/injective resolution for a complex,
  if the underlying category allows this??
