




DeclareGlobalVariable( "ALL_FUNCTORS_METHODS" );
DeclareGlobalVariable( "ENABLE_COLORS" );

DeclareOperation( "KnownFunctors", [ IsCapCategory, IsCapCategory ] );
DeclareOperation( "Functor", [ IsCapCategory, IsCapCategory, IsInt ] );

DeclareOperation( "AddFunctor", [ IsDenseList ] );
DeclareOperation( "AddFunctor", [ IsObject, IsObject, IsFunction, IsFunction, IsString ] );

DeclareOperation( "ExtendFunctorMethod", [ IsDenseList, IsFunction, IsFunction, IsFunction, IsString ] );

DeclareGlobalFunction( "CheckNaturality" );
DeclareGlobalFunction( "CheckFunctoriality" );
DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );
DeclareGlobalFunction( "RandomTextColor" );
DeclareGlobalFunction( "RandomBoldTextColor" );
DeclareGlobalFunction( "RandomBackgroundColor" );
DeclareGlobalFunction( "CreateDisplayNameWithColorsForFunctor" );

