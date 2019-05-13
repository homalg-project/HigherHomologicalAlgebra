LoadPackage( "HomotopyCategoriesForCAP" );
ReadPackage( "HomotopyCategoriesForCAP", "/examples/HomStructureForGradedRows.g" );

#R := HomalgFieldOfRationals( );
R := HomalgRingOfIntegers( );
#R := HomalgFieldOfRationalsInSingular( )*"x,y";

rows := CategoryOfRows( R : FinalizeCategory := false );
AddRandomMethodsToRows( rows );
Finalize( rows );

homotopy_of_rows := HomotopyCategory( rows );

alpha_1 := RandomMorphism( rows, [ 6 .. 12 ] );
a := ChainComplex( [ alpha_1 ], 1 );
beta_1 := RandomMorphism( rows, [ 6 .. 12 ] );
b := ChainComplex( [ beta_1 ], 1 );
f := RandomMorphismWithFixedSourceAndRange( a[0], b[1], [1] );
phi := ChainMorphism( a, b, [ PreCompose( f, b^1 ), PreCompose( a^1, f ) ], 0 );
homotopy_phi := HomotopyCategoryMorphism( homotopy_of_rows, phi );
IsZero( homotopy_phi );
# true

IsNullHomotopic( phi );
H := HomotopyMorphisms( phi );  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]
Display( H[ 0 ] );

