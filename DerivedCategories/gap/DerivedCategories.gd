# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
DeclareCategory( "IsDerivedCategory", IsCapCategory );

DeclareCategory( "IsDerivedCategoryByCochains", IsDerivedCategory );
DeclareCategory( "IsDerivedCategoryByChains", IsDerivedCategory );


DeclareAttribute( "DerivedCategoryByCochains", IsCapCategory );
DeclareAttribute( "DerivedCategoryByChains", IsCapCategory );

DeclareAttribute( "DefiningCategory", IsDerivedCategory );

DeclareGlobalFunction( "ADD_EXTRA_FUNCTIONS_TO_DERIVED_CATEGORY_VIA_LOCALIZATION_BY_PROJECTIVE_OBJECTS" );
