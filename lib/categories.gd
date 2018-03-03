#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Complexes categories
##
#############################################################################

#! @Section Constructing chain and cochain categories


###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  Gap-categories of the chain or cochain complexes category.
DeclareCategory( "IsChainOrCochainComplexCategory", IsCapCategory );

#! @Description
#!  Gap-categories of the chain complexes category.
DeclareCategory( "IsChainComplexCategory", IsChainOrCochainComplexCategory );

#! @Description
#!  Gap-category of the cochain complexes category.
DeclareCategory( "IsCochainComplexCategory", IsChainOrCochainComplexCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

#! @Description
#!  Creates the chain complex category $\mathrm{Ch}_\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{ChainComplexCategory(A:FinalizeCategory := false)}$. 
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ChainComplexCategory", IsCapCategory );

#! @Description
#!  Creates the cochain complex category $\mathrm{Ch}^\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{CochainComplexCategory(A:FinalizeCategory := false)}$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "CochainComplexCategory", IsCapCategory );

#! @Description
#! The input is a chain or cochain complex category $B=C(A)$ constructed by one of the previous commands. 
#! The outout is $A$
#! @Arguments B
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsChainOrCochainComplexCategory );

#! @Description
#! The input is chain (or cochain category) $Ch(A)$ of some additive category $A$ and 
#! a function $F$. This operation adds the given function $F$ to the category $Ch(A)$ for the basic 
#! operation <C>IsNullHomotopic</C>. So, $F$ should be a function whose input is a chain or cochain morphism 
#! $\phi\in Ch(A)$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
#! @Returns <C>true</C> or <C>false</C>
#! @Arguments A, F
DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList ] );

# this is taken to chains morphisms file
# @Description
# The input is a chain or cochain morphism 
# $\phi$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
# @Arguments phi
# DeclareProperty( "IsNullHomotopic", IsChainOrCochainMorphism );

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

# DeclareProperty( "HasEnoughProjectives", IsCapCategory );
# DeclareProperty( "HasEnoughInjectives", IsCapCategory );
