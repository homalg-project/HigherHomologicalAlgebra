LoadPackage( "DerivedCategories" );
LoadPackage( "BBGG" );

##########################################
operations_to_activate := [
            "PreCompose",
            "HomomorphismStructureOnObjects",
            "HomomorphismStructureOnMorphisms",
            "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
            "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
            "DistinguishedObjectOfHomomorphismStructure",
            "BasisOfExternalHom",
            "CoefficientsOfMorphismWithGivenBasisOfExternalHom"
                      ];
                      
operations_to_deactivate := [
            #"PreCompose",
            "AdditionForMorphisms",
            "AdditiveInverse",
            "MultiplyWithElementOfCommutativeRingForMorphisms",
            "IsZeroForObjects"
                      ];

########################### global options ###############################
#
SetInfoLevel( InfoDerivedCategories, 0 );
SetInfoLevel( InfoHomotopyCategories, 0 );
SetInfoLevel( InfoComplexCategoriesForCAP, 0 );
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
    IsFreydCategory
    
  ];

#
field := GLOBAL_FIELD_FOR_QPA!.default_field;
homalg_field := field;
HOMALG_MATRICES.PreferDenseMatrices := true;
#homalg_field := HomalgFieldOfRationalsInSingular( );
#homalg_field := HomalgFieldOfRationalsInMAGMA( );
SET_GLOBAL_FIELD_FOR_QPA( homalg_field );
#
########################################################################

