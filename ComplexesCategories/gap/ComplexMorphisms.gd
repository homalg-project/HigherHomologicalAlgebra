



DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );
DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );
DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );

DeclareAttribute( "LowerBound", IsChainOrCochainMorphism );
DeclareAttribute( "UpperBound", IsChainOrCochainMorphism );
DeclareAttribute( "LowerBoundOfSourceAndRange", IsChainOrCochainMorphism );
DeclareAttribute( "UpperBoundOfSourceAndRange", IsChainOrCochainMorphism );

DeclareAttribute( "Morphisms", IsChainOrCochainMorphism );

KeyDependentOperation( "MorphismAt", IsChainOrCochainMorphism, IsInt, ReturnTrue );

KeyDependentOperation( "CocyclesFunctorialAt", IsCochainMorphism, IsInt, ReturnTrue );
KeyDependentOperation( "CohomologyFunctorialAt", IsCochainMorphism, IsInt, ReturnTrue );

KeyDependentOperation( "CyclesFunctorialAt", IsChainMorphism, IsInt, ReturnTrue );
KeyDependentOperation( "HomologyFunctorialAt", IsChainMorphism, IsInt, ReturnTrue );

DeclareOperation( "\[\]", [ IsChainOrCochainMorphism, IsInt ] );

DeclareAttribute( "MorphismsSupport", IsChainOrCochainMorphism );
DeclareOperation( "MorphismsSupport", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

DeclareProperty( "IsQuasiIsomorphism", IsChainOrCochainMorphism );
DeclareProperty( "IsHomotopicToZeroMorphism", IsChainOrCochainMorphism );
DeclareAttribute( "WitnessForBeingHomotopicToZeroMorphism", IsChainOrCochainMorphism );

DeclareOperation( "CreateComplexMorphism", [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsList ] );
DeclareAttribute( "AsComplexMorphismOverOppositeCategory", IsChainOrCochainMorphism );

DeclareAttribute( "AsChainComplexMorphism", IsCochainMorphism );
DeclareAttribute( "AsCochainComplexMorphism", IsChainMorphism );

