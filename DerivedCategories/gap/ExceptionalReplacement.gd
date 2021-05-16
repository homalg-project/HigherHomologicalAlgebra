# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
##
##  Exceptional Resolutions
##
#############################################################################

DeclareOperation( "CandidatesForExceptionalShifts",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "MinimalExceptionalShift",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "MaximalExceptionalShift",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "ExceptionalShifts",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "MorphismFromExceptionalObjectAsList",
            [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ] );

DeclareOperation( "MorphismFromExceptionalObject",
            [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ] );

DeclareOperation( "MorphismBetweenExceptionalObjects",
            [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacementData",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "EXCEPTIONAL_REPLACEMENT",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection ] );

DeclareOperation( "ExceptionalReplacement",
            [ IsHomotopyCategoryCell, IsStrongExceptionalCollection, IsBool ] );
