# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#


DeclareCategory( "IsDerivedCategoryMorphism", IsCapCategoryMorphism );

DeclareCategory( "IsDerivedCategoryByCochainsMorphism", IsDerivedCategoryMorphism );
DeclareCategory( "IsDerivedCategoryByChainsMorphism", IsDerivedCategoryMorphism );

DeclareAttribute( "DefiningPairOfMorphisms", IsCapCategoryMorphism );
