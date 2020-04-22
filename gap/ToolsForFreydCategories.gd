


DeclareGlobalFunction( "BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_ROWS" );
DeclareAttribute( "BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW", IsGradedRow );
DeclareGlobalFunction( "COEFFICIENTS_OF_MORPHISM_OF_GRADED_ROWS_WITH_GIVEN_BASIS_OF_EXTENRAL_HOM" );
DeclareGlobalFunction( "ADD_RANDOM_METHODS_TO_GRADED_ROWS" );
DeclareGlobalFunction( "IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS_IN_KERNEL_OF_SERRE_QUOTIENT" );
DeclareGlobalFunction( "ANNIHILATOR_OF_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS" );
DeclareAttribute( "UnderlyingCategoryOfRows", IsCategoryOfGradedRows );

DeclareOperation( "\/", [ IsList, IsCategoryOfGradedRows ] );
DeclareOperation( "\/", [ IsFreydCategoryObject, IsCapCategory ] );
DeclareOperation( "\/", [ IsFreydCategoryMorphism, IsCapCategory ] );
DeclareOperation( "\/", [ IsGradedLeftPresentation, IsFreydCategory ] );
#DeclareOperation( "\/", [ IsGradedLeftPresentationMorphism, IsFreydCategory ] );
DeclareOperation( "\/", [ IsGradedLeftPresentation, IsCategoryOfGradedRows ] );
DeclareOperation( "\/", [ IsGradedLeftPresentationMorphism, IsCategoryOfGradedRows ] );
DeclareOperation( "\/", [ IsGradedRow, IsFreydCategory ] );

DeclareOperation( "BoxProduct", [ IsList, IsCapCategory ] );
DeclareOperation( "BoxProduct",
      [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapCategory ]
    );

DeclareAttribute( "BeilinsonExperimental", IsHomalgGradedRing );
DeclareAttribute( "IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne", IsCategoryOfGradedRows );
DeclareAttribute( "FullSubcategoryGeneratedByGradedRowsOfRankOne", IsHomalgGradedRing );
DeclareAttribute( "DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces", IsGradedRowMorphism );
