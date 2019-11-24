LoadPackage( "HomotopyCategories" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "FreydCategories" );
ReadPackage( "HomotopyCategories", "/examples/random_methods_for_categories_of_rows.g" );

#R := HomalgFieldOfRationals( );
R := HomalgRingOfIntegers( );
#R := HomalgFieldOfRationalsInSingular( )*"x,y";

rows := CategoryOfRows( R : FinalizeCategory := false );
AddRandomMethodsToRows( rows );
Finalize( rows );

homotopy_of_rows := HomotopyCategory( rows );

#                      α1  
# a:   0 <------ a0 <-------- a1 <------- 0
#                  \                     
#                     \
#                        \ f
#                           \   
#                             V
# b:   0 <------ b0 <-------- b1 <------- 0
#                      β1

alpha_1 := RandomMorphism( rows, [ 6 .. 12 ] );
a := ChainComplex( [ alpha_1 ], 1 );
beta_1 := RandomMorphism( rows, [ 6 .. 12 ] );
b := ChainComplex( [ beta_1 ], 1 );
f := RandomMorphismWithFixedSourceAndRange( a[0], b[1], [1] );
phi := ChainMorphism( a, b, [ PreCompose( f, b^1 ), PreCompose( a^1, f ) ], 0 );
homotopy_phi := HomotopyCategoryMorphism( homotopy_of_rows, phi );
Display( IsZero( homotopy_phi ) );
# true

IsNullHomotopic( phi );
H := HomotopyMorphisms( phi );  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]
