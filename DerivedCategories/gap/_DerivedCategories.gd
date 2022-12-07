# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
##
#############################################################################


InfoDerivedCategories := NewInfoClass( "InfoDerivedCategories" );

SetInfoLevel( InfoDerivedCategories, 1 );

DeclareCategory( "IsDerivedCategory", IsCapCategory );

DeclareCategory( "IsRoof", IsObject );

DeclareCategory( "IsDerivedCategoryCell", IsCapCategoryCell );

DeclareCategory( "IsDerivedCategoryObject", IsCapCategoryObject and IsDerivedCategoryCell );

DeclareCategory( "IsDerivedCategoryMorphism", IsCapCategoryMorphism and IsDerivedCategoryCell );

DeclareOperation( "Roof", [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

DeclareAttribute( "SourceMorphism", IsRoof );

DeclareSynonym( "QuasiIsomorphism", SourceMorphism );

DeclareAttribute( "RangeMorphism", IsRoof );

DeclareAttribute( "Source", IsRoof );

DeclareAttribute( "Range", IsRoof );

DeclareAttribute( "MiddleObject", IsRoof );

DeclareAttribute( "AmbientCategory", IsRoof );

DeclareAttribute( "AsMorphismBetweenProjectiveResolutions", IsRoof );

DeclareAttribute( "AsMorphismBetweenInjectiveResolutions", IsRoof );

DeclareAttribute( "AsHonestMorphism", IsRoof );

DeclareProperty( "IsHonest", IsRoof );

DeclareOperation( "PreComposeRoofs", [ IsRoof, IsRoof ] );

DeclareOperation( "DerivedCategoryObject", [ IsDerivedCategory, IsHomotopyCategoryObject ] );

DeclareOperation( "\[\]", [ IsDerivedCategoryObject, IsInt ] );

DeclareOperation( "\^", [ IsDerivedCategoryObject, IsInt ] );

DeclareOperation( "\/", [ IsHomotopyCategoryObject, IsDerivedCategory ] );

DeclareAttribute( "UnderlyingCell", IsDerivedCategoryObject );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategoryObject, IsRoof, IsDerivedCategoryObject ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsRoof ] );

DeclareOperation( "\/", [ IsRoof, IsDerivedCategory ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsDenseList ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsHomotopyCategoryMorphism ] );

DeclareOperation( "\/", [ IsHomotopyCategoryMorphism, IsDerivedCategory ] );

DeclareAttribute( "UnderlyingRoof", IsDerivedCategoryMorphism );

KeyDependentOperation( "DerivedCategory", IsCapCategory, IsBool, ReturnTrue );

DeclareAttribute( "DerivedCategoryByChains", IsCapCategory );

DeclareAttribute( "DerivedCategoryByCochains", IsCapCategory );

DeclareAttribute( "DerivedCategoryAttr", IsCapCategory );

DeclareAttribute( "DefiningCategory", IsDerivedCategory );

DeclareGlobalFunction( "ADD_SPECIAL_METHODS_BY_ENOUGH_PROJECTIVE_OBJECTS" );

DeclareGlobalFunction( "ADD_SPECIAL_METHODS_BY_ENOUGH_INJECTIVE_OBJECTS" );

