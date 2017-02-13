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

#! @Description
#!  bla bla
DeclareCategory( "IsHomotopyCategory",
                 IsCapCategory );

#! @Description
#!  The category of objects in the homotopy category.
#!  For actual objects this needs to be specialized.
DeclareCategory( "IsHomotopyCategoryObject",
                 IsCapCategoryObject );

#! @Description
DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareFilter( "WasCreatedAsHomotopyCategory" );

#! @Section General operations
#! @Description
#!  Creates a homotopy category <A>S</A> with name <A>name</A> out of an Abelian category <A>A</A>.
#!  If <A>name</A> is not given, a generic name is constructed out of the name of <A>A</A>.
#!  The argument <A>func</A> is the membership function. If <A>func</A> applied on a morphism <A>mor</A>
#! returns true, then this <A>mor</A> will be null-homotopic, i.e, zero in the homotopy category.
#! @Arguments A,func[,name]
#! @Returns a CAP category
DeclareOperation( "HomotopyCategory",
                  [ IsCapCategory, IsFunction ] );


#! @Description
#!  Given a homotopy category <A>S</A> and a morphism <A>phi</A> in
#!  the underlying category <A>A</A>,this constructor returns the 
#! corresponding morphism in the homotopy category.
#! @Arguments S, phi
#! @Returns a morphism
DeclareOperation( "AsHomotopyCategoryMorphism", 
                   [ IsCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  Given a homotopy category <A>S</A> and an object <A>obj</A> in
#!  the underlying category <A>A</A>,this constructor returns the 
#! corresponding object in the homotopy category.
#! @Arguments S, obj
#! @Returns an object
DeclareOperation( "AsHomotopyCategoryObject", 
                   [ IsCapCategory, IsCapCategoryObject ] );

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
DeclareAttribute( "UnderlyingComplex" ,IsHomotopyCategoryObject  );
