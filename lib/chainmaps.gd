################################################
#
#  Working with chain morphisms
#
################################################


DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );

DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsFiniteChainMorphism", IsChainMorphism );

DeclareCategoryFamily( "IsChainMorphism" );

DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsFiniteCochainMorphism" , IsCochainMorphism );

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

DeclareOperation( "FiniteChainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

DeclareOperation( "FiniteCochainMorphism",
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
