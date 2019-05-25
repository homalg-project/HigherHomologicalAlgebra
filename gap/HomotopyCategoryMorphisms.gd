

DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsStableCategoryMorphism );


DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategory, IsCapCategoryMorphism ] );

##
DeclareAttribute( "UnderlyingChainMorphism", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "UnderlyingChainCell", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "MappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalInjectionInMappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalProjectionFromMappingCone", IsHomotopyCategoryMorphism );

##
DeclareOperation( "MappingConeColift", [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

##
DeclareOperation( "MappingConePseudoFunctorial",
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

