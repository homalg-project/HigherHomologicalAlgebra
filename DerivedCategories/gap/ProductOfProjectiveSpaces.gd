#
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
DeclareOperation( "CoxRingForProductOfProjectiveSpaces", [ IsRationalsForHomalg, IsList ] );
DeclareAttribute( "CoherentSheavesOverProductOfProjectiveSpaces", IsHomalgGradedRing );
DeclareAttribute( "BoxProductOnProductOfProjectiveSpaces", IsHomalgGradedRing );
KeyDependentOperation( "PullbackFunctorAlongProjection", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "KoszulChainComplex", IsHomalgGradedRing, IsInt, ReturnTrue );

