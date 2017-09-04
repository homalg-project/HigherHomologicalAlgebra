
#! @Chapter Complexes categories

#! @Section Constructing chain and cochain categories


###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  bla bla
DeclareCategory( "IsChainOrCochainComplexCategory", IsCapCategory );

#! @Description
#!  bla bla
DeclareCategory( "IsChainComplexCategory", IsChainOrCochainComplexCategory );

#! @Description
#!  bla bla
DeclareCategory( "IsCochainComplexCategory", IsChainOrCochainComplexCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

#! @Description
#!  Creates the chain complex category $\mathrm{Ch}_\bullet(A)$ an Abelian category $A$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ChainComplexCategory", IsCapCategory );

#! @Description
#!  Creates the cochain complex category $\mathrm{Ch}^\bullet(A)$ an Abelian category $A$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "CochainComplexCategory", IsCapCategory );

#! @Description
#! The input is a chain or cochain complex category $B=C(A)$ constructed by one of the previous commands. 
#! The outout is $A$
#! @Arguments B
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsChainOrCochainComplexCategory );

#! @EndSection

#! @Section Examples
#! @InsertChunk vec_0
#! @EndSection

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_TENSOR_UNIT_CHAIN" );

DeclareGlobalFunction( "ADD_BRAIDING_FOR_CHAINS" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP" );
DeclareGlobalFunction( "ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP" );

################# to change position

DeclareOperationWithCache( "ProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism  ] );

DeclareOperation( "AddProjectiveLift",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectiveLift",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddProjectiveLift",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectiveLift",
                   [ IsCapCategory, IsList ] );
