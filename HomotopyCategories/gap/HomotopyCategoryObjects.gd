# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################


DeclareCategory( "IsHomotopyCategoryCell",
                 IsStableCategoryCell );

DeclareCategory( "IsHomotopyCategoryObject",
                 IsHomotopyCategoryCell and IsStableCategoryObject );

DeclareOperation( "HomotopyCategoryObject",
            [ IsHomotopyCategory, IsCapCategoryObject ] );

DeclareOperation( "HomotopyCategoryObject",
            [ IsHomotopyCategory, IsZFunction ] );

DeclareOperation( "HomotopyCategoryObject",
            [ IsHomotopyCategory, IsList, IsInt ] );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareOperation( "\^",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareAttribute( "AsChainComplex", IsHomotopyCategoryObject );

DeclareAttribute( "AsCochainComplex", IsHomotopyCategoryObject );

DeclareOperation( "BoxProduct",
            [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsCapCategory ] );

DeclareOperation( "ViewHomotopyCategoryObject",
            [ IsHomotopyCategoryObject ] );
