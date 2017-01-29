################################################
#  chainmaps.gd         complex package
#  Kamal Saleh
#  2017
#
#  Working with chain morphisms
#
################################################

#! @Chapter complexes morphisms
#! @Section categories and filters

#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedBelowChainOrCochainMorphism", IsChainOrCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedAboveChainOrCochainMorphism", IsChainOrCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedChainOrCochainMorphism", IsBoundedBelowChainOrCochainMorphism and IsBoundedAboveChainOrCochainMorphism );

##
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedBelowChainMorphism", IsBoundedBelowChainOrCochainMorphism and IsChainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedAboveChainMorphism", IsBoundedAboveChainOrCochainMorphism and IsChainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedChainMorphism", IsBoundedChainOrCochainMorphism and IsChainMorphism );

##
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedBelowCochainMorphism", IsBoundedBelowChainOrCochainMorphism and IsCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedAboveCochainMorphism", IsBoundedAboveChainOrCochainMorphism and IsCochainMorphism );
#! @Description
#!  bla bla
#! @Arguments phi
DeclareCategory( "IsBoundedCochainMorphism", IsBoundedChainOrCochainMorphism and IsCochainMorphism );
#! @EndSection

DeclareCategoryFamily( "IsChainMorphism" );
DeclareCategoryFamily( "IsCochainMorphism" );

######################################
#
# Constructors of co-chain morphisms 
#
######################################

#! @Section Creating chain and cochain morphisms

#! @Description
#! The input is two chain complexes $C,D$ and an infinite list $l$. 
#! The output is the chain morphism $\phi:C\rightarrow D$ defined by $\phi_i :=l[i]$.
#! @Arguments C, D, l
#! @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                   [ IsChainComplex, IsChainComplex, IsZList ] );

#! @Description
#! The input is two chain complexes $C,D$, dense list $l$ and an integer $k$. 
#! The output is the chain morphism $\phi:C\rightarrow D$ such that $\phi_{k}=l[1]$, $\phi_{k+1}=l[2]$, etc. 
#! @Arguments C, D, l, k
#! @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                  [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ] );

#! @Description
#! The output is the chain morphism $\phi:C\rightarrow D$, where $C_m = c[ 1 ], C_{m+1} =c[ 2 ],$ etc.
#! $D_n = d[ 1 ], D_{n+1} =d[ 2 ],$ etc. and $\phi_{k}=l[1]$, $\phi_{k+1}=l[2]$, etc. 
#! @Arguments c,m,d,n,l, k
#! @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );


#! @Description
#! The input is two cochain complexes $C,D$ and an infinite list $l$. 
#! The output is the cochain morphism $\phi:C\rightarrow D$ defined by $\phi_i :=l[i]$.
#! @Arguments C, D, l
#! @Returns a cochain morphism
DeclareOperation( "CochainMorphism",
		   [ IsCochainComplex, IsCochainComplex, IsZList ] );

#! @Description
#! The input is two cochain complexes $C,D$, dense list $l$ and an integer $k$. 
#! The output is the cochain morphism $\phi:C\rightarrow D$ such that $\phi^{k}=l[1]$, $\phi^{k+1}=l[2]$, etc. 
#! @Arguments C, D, l, k
#! @Returns a chain morphism
DeclareOperation( "CochainMorphism",
                  [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ] );

#! @Description
#! The output is the cochain morphism $\phi:C\rightarrow D$, where $C^m = c[ 1 ], C^{m+1} =c[ 2 ],$ etc.
#! $D^n = d[ 1 ], D^{n+1} =d[ 2 ],$ etc. and $\phi^{k}=l[1]$, $\phi^{k+1}=l[2]$, etc. 
#! @Arguments c,m,d,n,l, k
#! @Returns a cochain morphism
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

DeclareAttribute( "IsQuasiIsomorphism_", IsChainOrCochainMorphism );

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


