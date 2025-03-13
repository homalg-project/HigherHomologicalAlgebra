# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################

DeclareCategory( "IsHomotopyCategoryObject", IsQuotientCategoryObject );

DeclareCategory( "IsHomotopyCategoryByCochainsObject", IsHomotopyCategoryObject );
DeclareCategory( "IsHomotopyCategoryByChainsObject", IsHomotopyCategoryObject );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareOperation( "\^",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareAttribute( "AsChainComplex", IsHomotopyCategoryObject );
DeclareAttribute( "AsCochainComplex", IsHomotopyCategoryObject );


KeyDependentOperation( "ApplyShift", IsHomotopyCategoryObject, IsInt, ReturnTrue );
KeyDependentOperation( "ApplyUnsignedShift", IsHomotopyCategoryObject, IsInt, ReturnTrue );

