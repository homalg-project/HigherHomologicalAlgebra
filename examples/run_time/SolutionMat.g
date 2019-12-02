LoadPackage( "DerivedCategories" );


nr_rows := 50;
nr_cols := 30;
nr_vectors := 330;

magma := HomalgFieldOfRationalsInMAGMA( );
singular := HomalgFieldOfRationalsInSingular( );

rows := List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> Random( [ -6 .. 6 ] ) ) );
vectors_lists := List( [ 1 .. nr_vectors ], i -> List( [ 1 .. nr_cols ], j ->  Random( [ -6 .. 6 ] ) ) );


##########################################################################
M := MatrixByRows( Rationals, rows );
vectors := List( vectors_lists, v -> StandardVector( Rationals, v ) );

Print( "\nwith Gap Rationals:                     " );
Print( Time( SolutionMat, [M, vectors ] ), " " );
Print( Time( function() List( vectors, v -> SolutionMat( M, v ) ); end, [] ) );

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( GLOBAL_FIELD_FOR_QPA!.default_field, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );
vectors := List( vectors_lists, v -> StandardVector( Rationals, v ) );

Print( "\nwith HomalgFieldOfRationals( ):         " );
Print( Time( SolutionMat, [ M, vectors ] ), " " );
Print( Time( function() List( vectors, v -> SolutionMat( M, v ) ); end, [] ) );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( magma, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );
vectors := List( vectors_lists, v -> StandardVector( Rationals, v ) );

Print( "\nwith HomalgFieldOfRationalsInMAGMA():   " );
Print( Time( SolutionMat, [M, vectors ] ), " " );
Print( Time( function() List( vectors, v -> SolutionMat( M, v ) ); end, [] ) );
RESET_GLOBAL_FIELD_FOR_QPA();
GLOBAL_FIELD_FOR_QPA!.is_locked := false;

###########################################################################
SET_GLOBAL_FIELD_FOR_QPA( singular, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
M := MatrixByRows( Rationals, rows );
vectors := List( vectors_lists, v -> StandardVector( Rationals, v ) );

Print( "\nwith HomalgFieldOfRationalsInSingular():" );
Print( Time( SolutionMat, [M, vectors ] ), " " );
Print( Time( function() List( vectors, v -> SolutionMat( M, v ) ); end, [] ) );
GLOBAL_FIELD_FOR_QPA!.is_locked := false;
Print( "\n" );
