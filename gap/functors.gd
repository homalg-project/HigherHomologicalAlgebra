#

#! @Chapter Functors
#! @Section Basic functors for homotopy categories.

#! @Group f1
#! @Description
#! The first argument in the input must be the chain (resp. cochain) homotopy category of an additive category $A$, 
#! the second argument is <A>A</A> and 
#! the third argument is an integer <A>n</A>. The output is the $n$'th homology (resp. cohomology) functor $:\mathrm{H}(A) \rightarrow A$.
#! @Arguments H(A), A, n
#! @Returns a functor
DeclareOperation( "HomologyFunctorAt", [ IsHomotopyCategory, IsCapCategory, IsInt  ] );

DeclareOperation( "ShiftFunctorAt", [ IsHomotopyCategory, IsInt ] );

DeclareOperation( "UnsignedShiftFunctorAt", [ IsHomotopyCategory, IsInt ] );

DeclareAttribute( "ExtendFunctorToHomotopyCategoryFunctor", IsCapFunctor );

DeclareAttribute( "EmbeddingInHomotopyCategoryOfTheFullSubcategoryGeneratedByProjectiveObjects", IsCapCategory );

DeclareAttribute( "EmbeddingInHomotopyCategoryOfTheFullSubcategoryGeneratedByInjectiveObjects", IsCapCategory );

# DeclareOperation( "LeftDerivedFunctor", [ IsCapFunctor ] );

# DeclareOperation( "RightDerivedFunctor", [ IsCapFunctor ] );


