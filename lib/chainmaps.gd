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

