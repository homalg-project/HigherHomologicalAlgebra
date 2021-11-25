LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "HomotopyCategories" );

EnhancePackage( "RingsForHomalg" );
EnhancePackage( "FreydCategoriesForCAP" );


#R := HomalgFieldOfRationals( );
R := HomalgRingOfIntegers( );
#R := HomalgFieldOfRationalsInSingular( ) * "x,y";

EnhanceHomalgRingWithRandomFunctions( R );

rows := CategoryOfRows( R );

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
A := HomotopyCategoryObject( [ alpha_1 ], 1 );

beta_1 := RandomMorphism( rows, [ 6 .. 12 ] );
B := HomotopyCategoryObject( [ beta_1 ], 1 );

f := RandomMorphismWithFixedSourceAndRange( A[0], B[1], [1] );
phi := HomotopyCategoryMorphism( A, [ PreCompose( f, B^1 ), PreCompose( A^1, f ) ], 0, B );
IsZero( phi );
# true

H := HomotopyMorphisms( phi );  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]
