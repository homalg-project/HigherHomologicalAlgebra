#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
##
##  Exceptional Resolutions
##
#############################################################################

DeclareOperation( "ExceptionalShift",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "MorphismFromSomeExceptionalObjectIntoCertainShift",
            [ IsHomotopyCategoryObject, IsInt, IsExceptionalCollection ] );

DeclareOperation( "MorphismFromSomeExceptionalObject",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalResolution",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalResolution",
            [ IsHomotopyCategoryObject, IsExceptionalCollection, IsBool ] );
