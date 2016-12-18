################################################
#
#  Working with chain morphisms
#
################################################


DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );

DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsFiniteChainMorphism", IsChainMorphism );

DeclareCategoryFamily( "IsChainMorphisms" );

DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );

DeclareCategory( "IsFiniteCochainMorphism" , IsCochainMorphism );

DeclareCategoryFamily( "IsCochainMorphisms" );

######################################
#
# Constructors of co-chain morphisms 
#
######################################

DeclareOperation( "ChainMorphism",
                   [ IsChainComplex, IsChainComplex, IsZList ] );

DeclareOperation( "CochainMorphism",
		   [ IsCochainComplex, IsCochainComplex, IsZList ] );

DeclareOperation( "FiniteChainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

DeclareOperation( "FiniteChainMorphism",
		   [ IsDenseList, IsDenseList, IsDenseList ] );

DeclareOperation( "FiniteChainMorphism",
                  [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ] );

DeclareOperation( "FiniteChainMorphism",
                  [ IsChainComplex, IsChainComplex, IsDenseList ] );

DeclareOperation( "FiniteCochainMorphism",
		   [ IsCochainComplex, IsCochainComplex, IsInt, IsDenseList ] );

DeclareOperation( "FiniteCochainMorphism",
                  [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

DeclareOperation( "FiniteCochainMorphism",
		   [ IsDenseList, IsDenseList, IsDenseList ] );

DeclareOperation( "FiniteCochainMorphism",
                  [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ] );

DeclareOperation( "FiniteCochainMorphism",
                  [ IsCochainComplex, IsCochainComplex, IsDenseList ] );

DeclareOperation( "FiniteChainMorphism",
		   [ IsChainComplex, IsChainComplex, IsInt, IsDenseList ] );


