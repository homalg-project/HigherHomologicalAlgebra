#

DeclareOperation( "HomologyFunctor", [ IsChainComplexCategory, IsCapCategory, IsInt  ] );

DeclareOperation( "CohomologyFunctor", [ IsCochainComplexCategory, IsCapCategory, IsInt ] );

DeclareOperation( "ShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "UnsignedShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "ChainToCochainComplexAsFunctor", [ IsCapCategory ] );

DeclareOperation( "CochainToChainComplexAsFunctor", [ IsCapCategory ] );

DeclareOperation( "ExtendFunctorToChainComplexCategoryFunctor", [ IsCapFunctor ] );

DeclareOperation( "ExtendFunctorToCochainComplexCategoryFunctor", [ IsCapFunctor ] );


