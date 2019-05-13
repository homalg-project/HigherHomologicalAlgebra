

DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsStableCategoryMorphism );


DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategory, IsCapCategoryMorphism ] );

DeclareAttribute( "UnderlyingChainMorphism", IsHomotopyCategoryMorphism );

