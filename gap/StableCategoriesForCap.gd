############################################################################
#                                     GAP package
#
#  Copyright 2015,       Kamal Saleh  RWTH Aachen University
#
#! @Chapter StableCategoriesForCap
##
#############################################################################

#! Objects of the stable category are the same of the original but morphisms ...

#! @Section Filters

#! @Description
#!  bla bla
DeclareCategory( "IsStableCategory",
                 IsCapCategory );
                 
#! @Description
#!  The category of objects in the stable category.
#!  For actual objects this needs to be specialized.
DeclareCategory( "IsStableCategoryObject",
                 IsCapCategoryObject );

#! @Description
#!  The category of morphisms in the category of Serre quotients.
#!  For actual morphisms this needs to be specialized.
DeclareCategory( "IsStableCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareFilter( "WasCreatedAsStableCategory" );

#! @Section General operations
#! @Description
#!  Creates a stable category <A>S</A> with name <A>name</A> out of an Abelian category <A>A</A>.
#!  If <A>name</A> is not given, a generic name is constructed out of the name of <A>A</A>.
#!  The argument <A>func</A> is the membership function. If <A>func</A> applied on a morphism <A>mor</A>
#! returns true, then this <A>mor</A> will be zero in the stable category.
#! @Arguments A,func[,name]
#! @Returns a CAP category
DeclareOperation( "StableCategory",
                  [ IsCapCategory, IsFunction ] );


#! @Description
#!  Given a stable category <A>S</A> and a morphism <A>phi</A> in
#!  the underlying category <A>A</A>,this constructor returns the 
#! corresponding morphism in the stable category.
#! @Arguments S, phi
#! @Returns a morphism
DeclareOperation( "AsStableCategoryMorphism", 
                   [ IsCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  Given a stable category <A>S</A> and an object <A>obj</A> in
#!  the underlying category <A>A</A>,this constructor returns the 
#! corresponding object in the stable category.
#! @Arguments S, obj
#! @Returns an object
DeclareOperation( "AsStableCategoryObject", 
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
DeclareAttribute( "TestFunctionForStableCategories", IsCapCategory );

#! @Description
#! bla bla
#! @Arguments S
#! @Returns <A>A</A>
DeclareAttribute( "UnderlyingCategory" ,IsStableCategory  );

#! @Description
#! bla bla
#! @Arguments f
#! @Returns <A>g</A>
DeclareAttribute( "UnderlyingMorphismOfTheStableMorphism" ,IsStableCategoryMorphism  );

#! @Description
#! bla bla
#! @Arguments f
#! @Returns <A>g</A>
DeclareAttribute( "UnderlyingMatrix" ,IsStableCategoryMorphism  );

#! @Description
#! bla bla
#! @Arguments obj
#! @Returns <A>obj</A>
DeclareAttribute( "UnderlyingObjectOfTheStableObject" ,IsStableCategoryObject  );

#! @Description
#! bla bla
#! @Arguments obj
#! @Returns <A>obj</A>
DeclareAttribute( "UnderlyingMatrix" ,IsStableCategoryObject  );


#####################
##
##   Methods
##
#####################









