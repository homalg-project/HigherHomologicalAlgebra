


DeclareGlobalFunction( "BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_ROWS" );
DeclareAttribute( "BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW", IsGradedRow );
DeclareGlobalFunction( "COEFFICIENTS_OF_MORPHISM_OF_GRADED_ROWS_WITH_GIVEN_BASIS_OF_EXTENRAL_HOM" );
DeclareGlobalFunction( "ADD_RANDOM_METHODS_TO_GRADED_ROWS" );
DeclareGlobalFunction( "IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS_IN_KERNEL_OF_SERRE_QUOTIENT" );
DeclareGlobalFunction( "ANNIHILATOR_OF_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS" );
DeclareAttribute( "UnderlyingCategoryOfRows", IsCategoryOfGradedRows );
DeclareGlobalFunction( "IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PS_IN_KERNEL_OF_SERRE_QUOTIENT" );
KeyDependentOperation( "MONOMIALS_OF_DEGREE", IsHomalgGradedRing, IsHomalgModuleElement, ReturnTrue );

DeclareOperation( "BoxProduct", [ IsList, IsCapCategory ] );
DeclareOperation( "BoxProduct",
      [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapCategory ]
    );

DeclareAttribute( "BeilinsonExperimental", IsHomalgGradedRing );
DeclareAttribute( "EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsOntoGradedRows", IsFreydCategory );
DeclareAttribute( "IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne", IsCategoryOfGradedRows );
DeclareAttribute( "FullSubcategoryGeneratedByGradedRowsOfRankOne", IsHomalgGradedRing );
DeclareAttribute( "DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces", IsGradedRowMorphism );
