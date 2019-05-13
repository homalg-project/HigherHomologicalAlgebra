
DeclareCategory( "IsHomotopyCategoryObject",
                 IsStableCategoryObject );

DeclareOperation( "HomotopyCategoryObject",
            [ IsHomotopyCategory, IsCapCategoryObject ] );

DeclareAttribute( "UnderlyingChainComplex", IsHomotopyCategoryObject );

