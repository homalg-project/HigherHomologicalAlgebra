# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#! @Chapter Constructors
##
#############################################################################

InfoComplexesCategories := NewInfoClass( "InfoComplexesCategories" );

SetInfoLevel( InfoComplexesCategories, 1 );

#! @Section Constructing categories

###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  GAP-categories of the chain or cochain complexes category.
#! @Arguments C
DeclareCategory( "IsComplexesCategory", IsCapCategory );

#! @Description
#!  GAP-categories of the chain complexes category.
#! @Arguments C
DeclareCategory( "IsComplexesCategoryByChains", IsComplexesCategory );

#! @Description
#!  GAP-category of the cochain complexes category.
#! @Arguments C
DeclareCategory( "IsComplexesCategoryByCochains", IsComplexesCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

DeclareGlobalFunction( "COMPLEXES_CATEGORY_BY_COCHAINS_AS_TOWER" );

#! @Description
#!  Creates the complexes category by cochains $\mathcal{C}^b(A)$ of an additive category $A$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ComplexesCategoryByCochains", IsCapCategory );

#! @Description
#!  Creates the complexes category by chains $\mathcal{C}^b(A)$ of an additive category $A$.
#! @Arguments A
#! @Returns a CAP category
DeclareAttribute( "ComplexesCategoryByChains", IsCapCategory );

#! @Description
#! The input is a complexes category by (co)chains $C:=\mathcal{C}^b(A)$.
#! The outout is $A$.
#! @Arguments C
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsComplexesCategory );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_LIST_FOR_COCHAIN_COMPLEXES_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY" );
DeclareGlobalFunction( "ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY" );
