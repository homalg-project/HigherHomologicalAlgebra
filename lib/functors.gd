#

DeclareOperation( "HomologyFunctor", [ IsChainComplexCategory, IsCapCategory, IsInt  ] );

DeclareOperation( "CohomologyFunctor", [ IsCochainComplexCategory, IsCapCategory, IsInt ] );

DeclareOperation( "ShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "UnsignedShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

DeclareOperation( "ChainToCochainComplexAsFunctor", [ IsChainComplexCategory, IsCochainComplexCategory ] );

DeclareOperation( "CochainToChainComplexAsFunctor", [ IsCochainComplexCategory, IsChainComplexCategory ] );

