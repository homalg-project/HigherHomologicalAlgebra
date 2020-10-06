# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
DeclareOperation( "LiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
DeclareOperation( "ColiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareGlobalFunction( "Time" );

DeclareGlobalFunction( "CheckNaturality" );

DeclareGlobalFunction( "CheckFunctoriality" );

DeclareOperation( "ViewCapCategoryCell", [ IsCapCategoryCell ] );

DeclareOperation( "DisplayCapCategoryCell", [ IsCapCategoryCell ] );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ] );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );

DeclareGlobalFunction( "ActivateCachingForCertainOperations" );

DeclareOperation( "FinalizeCategory", [ IsCapCategory, IsBool ] );

DeclareOperation( "SetOfKnownFunctors", [ IsCapCategory, IsCapCategory ] );

DeclareGlobalFunction( "RandomTextColor" );

DeclareGlobalFunction( "RandomBoldTextColor" );

DeclareGlobalFunction( "RandomBackgroundColor" );

DeclareGlobalFunction( "CreateNameWithColorsForFunctor" );

DeclareGlobalFunction( "CurrentCaching" );

DeclareOperation( "_WeakKernelEmbedding", [ IsCapCategoryMorphism ] );

