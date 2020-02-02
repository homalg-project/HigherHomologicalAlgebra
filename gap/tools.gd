
DeclareOperation( "LiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
DeclareOperation( "ColiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareGlobalFunction( "Time" );

DeclareGlobalFunction( "CheckNaturality" );

DeclareGlobalFunction( "CheckFunctoriality" );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ] );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );

DeclareGlobalFunction( "ActivateCachingForCertainOperations" );

DeclareOperation( "FinalizeCategory", [ IsCapCategory, IsBool ] );

DeclareGlobalFunction( "RandomTextColor" );

DeclareGlobalFunction( "RandomBoldTextColor" );

DeclareGlobalFunction( "RandomBackgroundColor" );

DeclareGlobalFunction( "CreateNameWithColorsForFunctor" );

DeclareGlobalFunction( "CurrentCaching" );

