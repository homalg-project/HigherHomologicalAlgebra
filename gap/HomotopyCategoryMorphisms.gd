

DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsStableCategoryMorphism );


DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategory, IsCapCategoryMorphism ] );

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

