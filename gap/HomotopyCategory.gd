


DeclareCategory( "IsHomotopyCategory",
                 IsStableCategory );
                 
DeclareCategory( "IsHomotopyCategoryObject",
                 IsStableCategoryObject );

DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsStableCategoryMorphism );

DeclareAttribute( "HomotopyCategory", IsCapCategory );

DeclareOperation( "HomotopyCategoryObject",
            [ IsStableCategory, IsCapCategoryObject ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsStableCategory, IsCapCategoryMorphism ] );


