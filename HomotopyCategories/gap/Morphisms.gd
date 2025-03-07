# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################

DeclareCategory( "IsHomotopyCategoryMorphism", IsQuotientCategoryMorphism );

DeclareCategory( "IsHomotopyCategoryByCochainsMorphism", IsHomotopyCategoryMorphism );
DeclareCategory( "IsHomotopyCategoryByChainsMorphism", IsHomotopyCategoryMorphism );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryMorphism, IsInt ] );

KeyDependentOperation( "ApplyShift", IsHomotopyCategoryMorphism, IsInt, ReturnTrue );
KeyDependentOperation( "ApplyUnsignedShift", IsHomotopyCategoryMorphism, IsInt, ReturnTrue );

