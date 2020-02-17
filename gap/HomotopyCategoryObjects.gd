

DeclareCategory( "IsHomotopyCategoryCell",
                 IsStableCategoryCell );

DeclareCategory( "IsHomotopyCategoryObject",
                 IsHomotopyCategoryCell and IsStableCategoryObject );

DeclareOperation( "HomotopyCategoryObject",
            [ IsHomotopyCategory, IsCapCategoryObject ] );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareOperation( "\^",
            [ IsHomotopyCategoryObject, IsInt ] );

