LoadPackage( "DerivedCategories" );
LoadPackage( "BBGG" );

########################### global options ###############################
#
SetInfoLevel( InfoDerivedCategories, 0 );
SetInfoLevel( InfoHomotopyCategories, 0 );
SetInfoLevel( InfoComplexesCategories, 0 );
#
DISABLE_ALL_SANITY_CHECKS := true;
SWITCH_LOGIC_OFF := true;
ENABLE_COLORS := true;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS :=
  [ IsMatrixCategory,
    IsChainComplexCategory,
    IsCochainComplexCategory,
    IsHomotopyCategory,
    IsAdditiveClosureCategory,
    IsQuiverRepresentationCategory,
    IsAlgebroid,
    IsQuiverRowsCategory,
    cat -> IsBound( cat!.ring_for_representation_category ),
    IsCapProductCategory,
    IsCategoryOfGradedRows,
    IsFreydCategory ];

HOMALG_MATRICES.PreferDenseMatrices := false; # Caution: Be carefull when chaning this to true
