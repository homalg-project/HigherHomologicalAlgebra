#############################################################################
##
##  DerivedCategories: Derived categories for additive categories
##
##  Copyright 2019, Kamal Saleh, University of Siegen
##
#! @Chapter Exceptional collections
#!
#############################################################################



####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The GAP category of exceptional collections.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsStrongExceptionalCollection", IsObject );

#! @Description
#! Returns the exceptional collection defined by a non-empty list of objects.
#! @Arguments objects
#! @Returns IsStrongExceptionalCollection
DeclareGlobalFunction( "CreateStrongExceptionalCollection" );

#! @Description
#! Returns the number of objects of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns IsInt
DeclareAttribute( "NumberOfObjects", IsStrongExceptionalCollection );

#! @Description
#! Returns a list of the objects of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns IsList
DeclareAttribute( "UnderlyingObjects", IsStrongExceptionalCollection );


