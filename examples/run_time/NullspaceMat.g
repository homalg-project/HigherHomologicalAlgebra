LoadPackage( "DerivedCategories" );


nr_rows := 150;
nr_cols := 90;

magma := HomalgFieldOfRationalsInMAGMA( );
singular := HomalgFieldOfRationalsInSingular( );

rows := List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> Random( [ -6 .. 6 ] ) ) );

##########################################################################
M := MatrixByRows( Rationals, rows );

Print( "with Gap Rationals:                     " );
Print( Time( NullspaceMat, [ M ] ), "\n" );

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( GLOBAL_FIELD_FOR_QPA!.default_field, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );

Print( "with HomalgFieldOfRationals( ):         " );
Print( Time( NullspaceMat, [ M ] ), "\n" );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( magma, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );

Print( "with HomalgFieldOfRationalsInMAGMA():   " );
Print( Time( NullspaceMat, [ M ] ), "\n" );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( singular, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );

Print( "with HomalgFieldOfRationalsInSingular():" );
Print( Time( NullspaceMat, [ M ] ), "\n" );
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

