# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareGlobalVariable( "ALL_FUNCTORS_METHODS" );
DeclareGlobalVariable( "ENABLE_COLORS" );

DeclareOperation( "KnownFunctors", [ IsCapCategory, IsCapCategory ] );
DeclareOperation( "Functor", [ IsCapCategory, IsCapCategory, IsInt ] );

DeclareOperation( "AddFunctor", [ IsDenseList ] );
DeclareOperation( "AddFunctor", [ IsObject, IsObject, IsFunction, IsFunction, IsString, IsString ] );

DeclareOperation( "ExtendFunctorMethod", [ IsDenseList, IsFunction, IsFunction, IsFunction, IsString ] );
DeclareOperation( "ExtendFunctorMethodToAdditiveClosures", [ IsDenseList ] );
DeclareOperation( "PreComposeFunctorMethods", [ IsList, IsList, IsFunction, IsFunction ] );

DeclareGlobalFunction( "CheckNaturality" );
DeclareGlobalFunction( "CheckFunctoriality" );
DeclareOperation( "CreateAdditiveFunctorByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

DeclareOperation( "AdditiveFunctorByTwoFunctionsData",
    [ IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

DeclareGlobalFunction( "RandomTextColor" );
DeclareGlobalFunction( "RandomBoldTextColor" );
DeclareGlobalFunction( "RandomBackgroundColor" );
DeclareGlobalFunction( "CreateDisplayNameWithColorsForFunctor" );

