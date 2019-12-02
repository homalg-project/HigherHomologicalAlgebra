LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 5, 10, 6 );
cat := CategoryOfQuiverRepresentations( A );

magma := HomalgFieldOfRationalsInMAGMA( );
singular := HomalgFieldOfRationalsInSingular( );

a := RandomObject( cat, 20 );
b := RandomObject( cat, 30 );

##########################################################################
Print( "with Gap Rationals:                     " );
GASMAN( "collect" );
Print( Time( BasisOfExternalHom, [ a, b ] ), "\n" );

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( GLOBAL_FIELD_FOR_QPA!.default_field, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );

Print( "with HomalgFieldOfRationals( ):         " );
GASMAN( "collect" );
Print( Time( BasisOfExternalHom, [ a, b ] ), "\n" );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( magma, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );

Print( "with HomalgFieldOfRationalsInMAGMA():   " );
GASMAN( "collect" );
Print( Time( BasisOfExternalHom, [ a, b ] ), "\n" );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( singular, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );

Print( "with HomalgFieldOfRationalsInSingular():" );
GASMAN( "collect" );
Print( Time( BasisOfExternalHom, [ a, b ] ), "\n" );
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

