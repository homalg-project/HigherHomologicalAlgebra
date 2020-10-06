#
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
##
##  Exceptional Resolutions
##
#############################################################################

DeclareOperation( "CandidatesForExceptionalShifts",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "MinimalExceptionalShift",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "MaximalExceptionalShift",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalShifts",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "MorphismFromExceptionalObjectAsList",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "MorphismFromExceptionalObject",
            [ IsHomotopyCategoryObject, IsExceptionalCollection ] );

DeclareOperation( "MorphismBetweenExceptionalObjects",
            [ IsHomotopyCategoryMorphism, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacementData",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "EXCEPTIONAL_REPLACEMENT",
            [ IsHomotopyCategoryCell, IsExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsExceptionalCollection, IsBool ] );
