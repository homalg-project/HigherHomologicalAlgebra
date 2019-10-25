LoadPackage( "HomotopyCategoriesForCAP" );
LoadPackage( "ModulePresentations" );

ZZ := HomalgRingOfIntegers( );
cat := LeftPresentations( ZZ );
homotopy_category := HomotopyCategory( cat );
m1 := 7;
m0 := 6;
n1 := 9;
n0 := 3;

#                      c_1
# C:   0 <------ C0 <-------- C1 <------- 0
#                  \                     
#                     \
#                        \ h
#                           \   
#                             V
# D:   0 <------ D0 <-------- D1 <------- 0
#                      d_1

C1 := FreeLeftPresentation( m1, ZZ );
C0 := FreeLeftPresentation( m0, ZZ );
D1 := FreeLeftPresentation( n1, ZZ );
D0 := FreeLeftPresentation( n0, ZZ );
m_10 := List( [ 1 .. m1 ], i -> List( [ 1 .. m0 ], j -> Random( [ -10 .. 10 ] ) ) );
m_10 := HomalgMatrix( m_10, m1, m0, ZZ );
n_10 := List( [ 1 .. n1 ], i -> List( [ 1 .. n0 ], j -> Random( [ -10 .. 10 ] ) ) );
n_10 := HomalgMatrix( n_10, n1, n0, ZZ );
h := List( [ 1 .. m0 ], i -> List( [ 1 .. n1 ], j -> Random( [ -10 .. 10 ] ) ) );
h := HomalgMatrix( h, m0, n1, ZZ );
c_1 := PresentationMorphism( C1, m_10, C0 );
d_1 := PresentationMorphism( D1, n_10, D0 );
h := PresentationMorphism( C0, h, D1 );
C := ChainComplex( [ c_1 ], 1 );
D := ChainComplex( [ d_1 ], 1 );
phi_1 := PreCompose( c_1, h );
phi_0 := PreCompose( h, d_1 );
phi := ChainMorphism( C, D, [ phi_0, phi_1 ], 0 );
homotopy_phi := HomotopyCategoryMorphism( homotopy_category, phi );
IsZero( homotopy_phi );

IsNullHomotopic( phi );
H := HomotopyMorphisms( phi );  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]

