#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Complexes categories
##
#############################################################################

if not IsBound( Reasons ) then 
    DeclareGlobalVariable( "Reasons" );
    InstallValue( Reasons, [ fail ] );
    DeclareGlobalVariable( "AddToReasons" );
    DeclareGlobalVariable( "why" );
    InstallValue( AddToReasons, function( s )
                                Add( Reasons, s, 1 ); 
                                MakeReadWriteGlobal("why");
                                why := s;
                                MakeReadOnlyGlobal("why");
                                end );
fi;

InfoComplexCategoriesForCAP := NewInfoClass( "InfoComplexCategoriesForCAP" );

SetInfoLevel( InfoComplexCategoriesForCAP, 1 );

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
#! The input is chain (or cochain category) $Com(A)$ of some additive category $A$ and 
#! a function $F$. This operation adds the given function $F$ to the category $Com(A)$ for the basic 
#! operation <C>IsNullHomotopic</C>. So, $F$ should be a function whose input is a chain or cochain morphism 
#! $\phi\in Com(A)$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
#! @Returns <C>true</C> or <C>false</C>
#! @Arguments Com(A), F
DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList ] );

DeclareOperation( "AddHomotopyMorphisms",
                   [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddHomotopyMorphisms",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddHomotopyMorphisms",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddHomotopyMorphisms",
                   [ IsCapCategory, IsList ] );


DeclareOperation( "\/", [ IsCapCategoryObject, IsChainOrCochainComplexCategory ] );
DeclareOperation( "\/", [ IsCapCategoryMorphism, IsChainOrCochainComplexCategory ] );



# this is taken to chains morphisms file
# @Description
# The input is a chain or cochain morphism 
# $\phi$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
# @Arguments phi
# DeclareProperty( "IsNullHomotopic", IsChainOrCochainMorphism );

#! @Section Examples
#! @InsertChunk vec_0

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "ADD_TENSOR_UNIT_CHAIN" );

DeclareGlobalFunction( "ADD_BRAIDING_FOR_CHAINS" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM" );

DeclareGlobalFunction( "ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE" );

DeclareOperation( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS", [ IsChainComplex, IsChainComplex ] );

# DeclareProperty( "HasEnoughProjectives", IsCapCategory );
# DeclareProperty( "HasEnoughInjectives", IsCapCategory );


# THIS IS TEMPORARILY, IT SHOULD BE INTRODUCED IN CONTEXT OF K OR R-LINEAR CATEGORIES AS IN QUIVERS.
DeclareOperation( "GeneratorsOfExternalHom", [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddGeneratorsOfExternalHom",
                   [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddGeneratorsOfExternalHom",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddGeneratorsOfExternalHom",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddGeneratorsOfExternalHom",
                   [ IsCapCategory, IsList ] );

if not IsBound( RANDOM_TEXT_ATTR ) then
  
  ##
  DeclareGlobalFunction( "RANDOM_TEXT_ATTR" );
  
  ##
  InstallGlobalFunction( RANDOM_TEXT_ATTR,
    function (  )
      return [ Random( [ "\033[31m", "\033[32m", "\033[33m", "\033[34m", "\033[35m",
                #" \033[41m", " \033[42m", " \033[43m", " \033[44m", " \033[45m", " \033[46m", " \033[4m"
                ] ), "\033[0m" ];
  end );
  
fi;

