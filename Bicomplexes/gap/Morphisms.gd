










#! @Chapter Constructors

#! @Section Constructing morphisms

#! @Description
#!  GAP-categories of the complex morphisms.
#! @Arguments phi
DeclareCategory( "IsChainOrCochainBicomplexMorphism", IsCapCategoryMorphism );

#! @Description
#!  GAP-categories of the chain complex morphisms.
#! @Arguments phi
DeclareCategory( "IsCochainBicomplexMorphism", IsChainOrCochainBicomplexMorphism );

#! @Description
#!  GAP-categories of the cochain complex morphisms.
#! @Arguments phi
DeclareCategory( "IsChainBicomplexMorphism", IsChainOrCochainBicomplexMorphism );

DeclareOperation( "CreateBicomplexMorphism",
          [ IsBicomplexesCategory, IsChainOrCochainBicomplex, IsFunction, IsChainOrCochainBicomplex ] );

DeclareAttribute( "MorphismFunction", IsChainOrCochainBicomplexMorphism );
#DeclareOperation( "MorphismAt", [ IsChainOrCochainBicomplexMorphism, IsInt, IsInt ] );
