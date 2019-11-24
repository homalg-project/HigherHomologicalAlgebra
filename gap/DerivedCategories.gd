#
# DerivedCategories: Gap package to create derived categories
#
# Declarations
#

DeclareCategory( "IsDerivedCategory", IsCapCategory );

DeclareCategory( "IsRoof", IsObject );

DeclareCategory( "IsDerivedCategoryObject", IsCapCategoryObject );

DeclareCategory( "IsDerivedCategoryMorphism", IsCapCategoryMorphism );

DeclareOperation( "Roof", [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

DeclareAttribute( "SourceMorphism", IsRoof );

DeclareSynonym( "QuasiIsomorphism", SourceMorphism );

DeclareAttribute( "RangeMorphism", IsRoof );

DeclareAttribute( "Source", IsRoof );

DeclareAttribute( "Range", IsRoof );

DeclareAttribute( "MiddleObject", IsRoof );

DeclareAttribute( "AsHonestMorphism", IsRoof );

DeclareProperty( "IsHonest", IsRoof );

DeclareOperation( "DerivedCategoryObject", [ IsDerivedCategory, IsHomotopyCategoryObject ] );

DeclareOperation( "\/", [ IsHomotopyCategoryObject, IsDerivedCategory ] );

DeclareAttribute( "UnderlyingCell", IsDerivedCategoryObject );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategoryObject, IsRoof, IsDerivedCategoryObject ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsRoof ] );

DeclareOperation( "\/", [ IsRoof, IsDerivedCategory ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsDenseList ] );

DeclareOperation( "DerivedCategoryMorphism", [ IsDerivedCategory, IsHomotopyCategoryMorphism ] );

DeclareOperation( "\/", [ IsHomotopyCategoryMorphism, IsDerivedCategory ] );

DeclareAttribute( "UnderlyingRoof", IsDerivedCategoryMorphism );

DeclareAttribute( "DerivedCategory", IsCapCategory );

DeclareAttribute( "DefiningCategory", IsDerivedCategory );
