############################################################################
#                                     GAP package
#
#  Copyright 2017,                    Kamal Saleh
#                                     Siegen University
#
#! @Chapter HomotopyCategories
#
#############################################################################

#! Objects of the homotopy category are the same of the original but morphisms ...

#! @Section Filters and categories

DeclareOperationWithCache( "IsNullHomotopic", [ IsCapCategoryMorphism ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList ] );

#! @Description
#!  bla bla
DeclareCategory( "IsHomotopyCategory",
                 IsCapCategory );

#! @Description
#!  The category of objects in the homotopy category.
#!  For actual objects this needs to be specialized.
DeclareCategory( "IsHomotopyCategoryObject",
                 IsChainOrCochainComplex );

#! @Description
DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsChainOrCochainMorphism );

DeclareFilter( "WasCreatedAsHomotopyCategory" );

#! @Section Attributes

#####################
##
## Attributes
##
#####################

#! @Description
#! This attribute is a function that tests if a given morphism can be factored through a projective function or not.
#! @Arguments A
#! @Returns <A>f</A>
DeclareAttribute( "TestFunctionForHomotopyCategory", IsCapCategory );

#! @Description
#! bla bla
#! @Arguments S
#! @Returns <A>A</A>
DeclareAttribute( "UnderlyingCategory" ,IsHomotopyCategory  );

#! @Description
#! bla bla
#! @Arguments f
#! @Returns <A>g</A>
DeclareAttribute( "UnderlyingMorphism" ,IsHomotopyCategoryMorphism  );

#! @Description
#! bla bla
#! @Arguments obj
#! @Returns <A>obj</A>
DeclareAttribute( "UnderlyingComplex_" ,IsHomotopyCategoryObject  );

#! @Description
#! bla bla
#! @Arguments A,func[,name]
#! @Returns a CAP category
DeclareAttribute( "HomotopyCategory", IsCapCategory );


#! @Description
#! c
#! @Arguments S, phi
#! @Returns a morphism
DeclareAttribute( "AsHomotopyCategoryMorphism", IsChainOrCochainMorphism );

#! @Description
#! c
#! @Arguments S, obj
#! @Returns an object
DeclareAttribute( "AsHomotopyCategoryObject", IsChainOrCochainComplex );

