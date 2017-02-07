
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

#! @InsertChunk vec_0 
#! @EndSection