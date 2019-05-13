LoadPackage( "HomotopyCategory" );
LoadPackage( "ExamplesForModelCategories" );

A := CotangentBeilinsonQuiverAlgebra( Rationals, 2: VariableString := "x" );

quiver_reps := CategoryOfQuiverRepresentations( A );

homotopy_of_quiver_reps := HomotopyCategory( quiver_reps );

a_0 := RandomObject( quiver_reps, 3 );

alpha_1 := RandomMorphismWithFixedRange( a_0, 3 );
a := ChainComplex( [ alpha_1 ], 1 );

f := RandomMorphismWithFixedSource( a_0, 3 );
b_1 := Range( f );

beta_1 := RandomMorphismWithFixedSource( b_1, 3 );

b := ChainComplex( [ beta_1 ], 1 );

phi := ChainMorphism( a, b, [ PreCompose( f, b^1 ), PreCompose( a^1, f ) ], 0 );

homotopy_phi := HomotopyCategoryMorphism( homotopy_of_quiver_reps, phi );

IsZero( homotopy_phi );
# true

IsNullHomotopic( phi );
H := HomotopyMorphisms( phi );  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]
Display( H[ 0 ] );
