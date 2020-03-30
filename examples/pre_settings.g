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
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );
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
    IsQuiverRowsCategory
    # or some function
  ];

#
field := GLOBAL_FIELD_FOR_QPA!.default_field;
homalg_field := field;
#homalg_field := HomalgFieldOfRationalsInSingular( );
#homalg_field := HomalgFieldOfRationalsInMAGMA( );
SET_GLOBAL_FIELD_FOR_QPA( homalg_field );
#
########################################################################

