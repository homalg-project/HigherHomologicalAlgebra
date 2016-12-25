#

DeclareOperation( "HomologyFunctor", [ IsChainComplexCategory, IsCapCategory, IsInt  ] );

DeclareOperation( "CohomologyFunctor", [ IsCochainComplexCategory, IsCapCategory, IsInt ] );

DeclareOperation( "ShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "UnsignedShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "ChainToCochainComplexFunctor", [ IsCapCategory ] );

DeclareOperation( "CochainToChainComplexFunctor", [ IsCapCategory ] );

DeclareOperation( "ExtendFunctorToChainComplexCategoryFunctor", [ IsCapFunctor ] );

DeclareOperation( "ExtendFunctorToCochainComplexCategoryFunctor", [ IsCapFunctor ] );


