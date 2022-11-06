


DeclareCategory( "IsChainOrCochainComplex", IsCapCategoryObject );
DeclareCategory( "IsChainComplex", IsChainOrCochainComplex );
DeclareCategory( "IsCochainComplex", IsChainOrCochainComplex );


DeclareOperation( "CreateComplex", [ IsChainOrCochainComplexCategory, IsList ] );

DeclareAttribute( "Differentials", IsChainOrCochainComplex );
DeclareAttribute( "Objects", IsChainOrCochainComplex );
DeclareAttribute( "UpperBound", IsChainOrCochainComplex );
DeclareAttribute( "LowerBound", IsChainOrCochainComplex );

KeyDependentOperation( "ObjectAt", IsChainOrCochainComplex, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsChainOrCochainComplex, IsInt ] );

KeyDependentOperation( "DifferentialAt", IsChainOrCochainComplex, IsInt, ReturnTrue );
DeclareOperation( "\^", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "ObjectsSupport", [ IsChainOrCochainComplex, IsInt, IsInt ] );
DeclareAttribute( "ObjectsSupport", IsChainOrCochainComplex );

DeclareOperation( "DifferentialsSupport", [ IsChainOrCochainComplex, IsInt, IsInt ] );
DeclareAttribute( "DifferentialsSupport", IsChainOrCochainComplex );

KeyDependentOperation( "CocyclesAt", IsCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "CocyclesEmbeddingAt", IsCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "CoboundariesAt", IsCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "CoboundariesEmbeddingAt", IsCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "CohomologyAt", IsCochainComplex, IsInt, ReturnTrue );
DeclareOperation( "CohomologySupport", [ IsCochainComplex, IsInt, IsInt ] );
DeclareAttribute( "CohomologySupport", IsCochainComplex );

KeyDependentOperation( "CyclesAt", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "CyclesEmbeddingAt", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BoundariesAt", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BoundariesEmbeddingAt", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "HomologyAt", IsChainComplex, IsInt, ReturnTrue );
DeclareOperation( "HomologySupport", [ IsChainComplex, IsInt, IsInt ] );
DeclareAttribute( "HomologySupport", IsChainComplex );

DeclareProperty( "IsExact", IsChainOrCochainComplex );
DeclareOperation( "IsExact", [ IsChainOrCochainComplex, IsInt, IsInt ] );

DeclareAttribute( "AsComplexOverOppositeCategory", IsCochainComplex );

DeclareAttribute( "AsChainComplex", IsCochainComplex );
DeclareAttribute( "AsCochainComplex", IsChainComplex );

BindGlobal( "ChainComplex", ReturnNothing );
BindGlobal( "CochainComplex", ReturnNothing );

