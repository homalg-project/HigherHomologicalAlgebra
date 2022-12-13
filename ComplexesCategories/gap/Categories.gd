# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#! @Chapter Complexes categories
##
#############################################################################

InfoComplexesCategories := NewInfoClass( "InfoComplexesCategories" );

SetInfoLevel( InfoComplexesCategories, 1 );

#! @Section Constructing chain and cochain categories

###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  Gap-categories of the chain or cochain complexes category.
DeclareCategory( "IsComplexesCategory", IsCapCategory );

#! @Description
#!  Gap-categories of the chain complexes category.
DeclareCategory( "IsComplexesCategoryByChains", IsComplexesCategory );

#! @Description
#!  Gap-category of the cochain complexes category.
DeclareCategory( "IsComplexesCategoryByCochains", IsComplexesCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

#! @Description
#!  Creates the chain complex category $\mathrm{Ch}_\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{ChainComplexCategory(A : FinalizeCategory := false )}$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ComplexesCategoryByChains", IsCapCategory );

#! @Description
#!  Creates the cochain complex category $\mathrm{Ch}^\bullet(A)$ an additive category $A$. If you want to contruct the category without finalizing it so that you can add
#! your own methods, you can run the command $\texttt{ComplexesCategoryByCochains(A : FinalizeCategory := false )}$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ComplexesCategoryByCochains", IsCapCategory );

#! @Description
#! The input is a chain or cochain complex category $B=C(A)$ constructed by one of the previous commands.
#! The outout is $A$
#! @Arguments B
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsComplexesCategory );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_LIST_FOR_COCHAIN_COMPLEXES_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY" );
