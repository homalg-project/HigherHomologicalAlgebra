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

#! @Description
#! It returns a basis for the vector space of morphisms from $E_i$ to $E_j$ that can not be factored
#! along any other object in the exceptional collection.
#! @Arguments E, i, j
#! @Returns IsList
DeclareOperation( "ArrowsBetweenTwoObjects", [ IsStrongExceptionalCollection, IsInt, IsInt ] );

#! @Description
#! It returns a generating set for the vector space of morphisms from $E_i$ to $E_j$ that can be factored
#! along at least one object in the exceptional collection.
#! @Arguments E, i, j
#! @Returns IsList
DeclareOperation( "OtherPathsBetweenTwoObjects", [ IsStrongExceptionalCollection, IsInt, IsInt ] );

#! @Description
#! It returns the union of <A>ArrowsBetweenTwoObjects</A> and <A>OtherPathsBetweenTwoObjects</A> applied
#! on the same input. In other words it returns a generating set for the vector space Hom$(E_i,E_j)$.
#! @Arguments E, i, j
#! @Returns IsList
DeclareOperation( "PathsBetweenTwoObjects", [ IsStrongExceptionalCollection, IsInt, IsInt ] );




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
DeclareGlobalFunction( "RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection" );

