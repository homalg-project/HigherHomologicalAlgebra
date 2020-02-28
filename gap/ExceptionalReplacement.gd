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

DeclareOperation( "MorphismFromSomeExceptionalObject",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "EXCEPTIONAL_REPLACEMENT",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryObject, IsExceptionalCollection, IsBool ] );
