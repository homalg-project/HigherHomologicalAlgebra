#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################


DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsHomotopyCategoryCell and IsStableCategoryMorphism );


DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategory, IsCapCategoryMorphism ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsList, IsInt ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsZFunction ] );

DeclareOperation( "\[\]",
            [ IsHomotopyCategoryMorphism, IsInt ] );

DeclareProperty( "IsQuasiIsomorphism", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "MappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalInjectionInMappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalProjectionFromMappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "HomotopyMorphisms", IsChainComplex );

##
DeclareOperation( "MappingConeColift", [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

##
DeclareOperation( "MappingConePseudoFunctorial",
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

DeclareOperation( "BoxProduct",
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsCapCategory ] );

DeclareOperation( "ViewHomotopyCategoryMorphism",
            [ IsHomotopyCategoryMorphism ] );
