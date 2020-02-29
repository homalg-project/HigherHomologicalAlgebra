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
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "MorphismFromSomeExceptionalObject",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "EXCEPTIONAL_REPLACEMENT",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsExceptionalCollection, IsBool ] );
