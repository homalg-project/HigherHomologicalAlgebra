################################################
#
#  Working with chain morphisms
#
################################################

##
DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );

DeclareCategory( "IsBoundedBellowChainOrCochainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsBoundedAboveChainOrCochainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsBoundedChainOrCochainMorphism", IsBoundedBellowChainOrCochainMorphism and IsBoundedAboveChainOrCochainMorphism );

##
DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsBoundedBellowChainMorphism", IsBoundedBellowChainOrCochainMorphism and IsChainMorphism );

DeclareCategory( "IsBoundedAboveChainMorphism", IsBoundedAboveChainOrCochainMorphism and IsChainMorphism );

DeclareCategory( "IsBoundedChainMorphism", IsBoundedChainOrCochainMorphism and IsChainMorphism );

##
DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsBoundedBellowCochainMorphism", IsBoundedBellowChainOrCochainMorphism and IsCochainMorphism );

DeclareCategory( "IsBoundedAboveCochainMorphism", IsBoundedAboveChainOrCochainMorphism and IsCochainMorphism );

DeclareCategory( "IsBoundedCochainMorphism", IsBoundedChainOrCochainMorphism and IsCochainMorphism );

DeclareCategoryFamily( "IsChainMorphism" );
DeclareCategoryFamily( "IsCochainMorphism" );

######################################
#
# Constructors of co-chain morphisms 
#
######################################

DeclareOperation( "ChainMorphism",
                   [ IsChainComplex, IsChainComplex, IsZList ] );

DeclareOperation( "CochainMorphism",
		   [ IsCochainComplex, IsCochainComplex, IsZList ] );

DeclareOperation( "ChainMorphism",
                  [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ] );

DeclareOperation( "CochainMorphism",
                  [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ] );

DeclareOperation( "ChainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

DeclareOperation( "CochainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

######################################
#
#  Attribtes, Operations ..
#
######################################

DeclareAttribute( "Morphisms", IsChainOrCochainMorphism );

DeclareAttribute( "MappingCone", IsChainOrCochainMorphism );

DeclareAttribute( "NaturalInjectionInMappingCone", IsChainOrCochainMorphism );

DeclareAttribute( "NaturalProjectionFromMappingCone", IsChainOrCochainMorphism );

DeclareOperation( "Display", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

DeclareOperation( "HasActiveLowerBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "HasActiveUpperBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "ActiveLowerBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "ActiveUpperBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "SetLowerBound", [ IsChainOrCochainMorphism, IsInt ] );

DeclareOperation( "SetUpperBound", [ IsChainOrCochainMorphism, IsInt ] );

KeyDependentOperation( "CertainMorphism", IsChainOrCochainMorphism, IsInt, ReturnTrue );

#######################################
#
#  Global functions and variables
#
#######################################

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_CO_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "TODO_LIST_TO_CHANGE_MORPHISM_FILTERS_WHEN_NEEDED" );

DeclareAttribute( "FAL_BOUND", IsChainOrCochainMorphism );

DeclareAttribute( "FAL_BOUND", IsChainOrCochainMorphism );

DeclareProperty( "HAS_FAL_BOUND", IsChainOrCochainMorphism );

DeclareProperty( "HAS_FAL_BOUND", IsChainOrCochainMorphism );


