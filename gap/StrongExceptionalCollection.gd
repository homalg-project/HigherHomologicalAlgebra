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

#! @Description
#! Returns the $i$'th object in <A>E</A>.
#! @Arguments E, i
#! @Returns IsList
DeclareOperation( "\[\]", [ IsStrongExceptionalCollection, IsInt ] );

####################################
##
#! @Section General Operations
##
####################################

#! @Description
#! The input is a list of morphisms $(f_i:A\to B)$ for $i=1,\dots,n$ that live in 
#! a category equipped with homomorphism structure $(1,H(-,-),\nu)$. The output is
#! the morphism $\langle \nu(f_1),\nu(f_2),\dots,\nu(f_n)\rangle:\oplus_{i=1}^n 1 \to H(A,B)$.
#! @Arguments A, B, morphisms
#! @Returns IsCapCategoryMorphism
DeclareOperation( "InterpretListOfMorphismsAsOneMorphism",
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! It returns a right quiver with $m$ vertices and $n$ arrows and whose indecomposable 
#! projective or injective objects defines an exceptional collection.
#! @Arguments m, n
#! @Returns IsRightQuiver
DeclareGlobalFunction( "RandomQuiverWhoseIndecProjectiveRepsAreExceptionalCollection" );

