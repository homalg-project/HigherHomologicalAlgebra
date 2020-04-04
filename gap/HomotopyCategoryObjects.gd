#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
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
            [ IsList, IsInt ] );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareOperation( "\^",
            [ IsHomotopyCategoryObject, IsInt ] );

DeclareOperation( "ViewHomotopyCategoryObject",
            [ IsHomotopyCategoryObject ] );
