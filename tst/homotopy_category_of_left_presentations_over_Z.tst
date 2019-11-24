gap> ZZ := HomalgRingOfIntegers( );;
gap> cat := LeftPresentations( ZZ );;
gap> homotopy_category := HomotopyCategory( cat );;
gap> m1 := 7;;
gap> m0 := 6;;
gap> n1 := 9;;
gap> n0 := 3;;
gap> C1 := FreeLeftPresentation( m1, ZZ );;
gap> C0 := FreeLeftPresentation( m0, ZZ );;
gap> D1 := FreeLeftPresentation( n1, ZZ );;
gap> D0 := FreeLeftPresentation( n0, ZZ );;
gap> m_10 := List( [ 1 .. m1 ], i -> List( [ 1 .. m0 ], j -> Random( [ -10 .. 10 ] ) ) );;
gap> m_10 := HomalgMatrix( m_10, m1, m0, ZZ );;
gap> n_10 := List( [ 1 .. n1 ], i -> List( [ 1 .. n0 ], j -> Random( [ -10 .. 10 ] ) ) );;
gap> n_10 := HomalgMatrix( n_10, n1, n0, ZZ );;
gap> h := List( [ 1 .. m0 ], i -> List( [ 1 .. n1 ], j -> Random( [ -10 .. 10 ] ) ) );;
gap> h := HomalgMatrix( h, m0, n1, ZZ );;
gap> c_1 := PresentationMorphism( C1, m_10, C0 );;
gap> d_1 := PresentationMorphism( D1, n_10, D0 );;
gap> h := PresentationMorphism( C0, h, D1 );;
gap> C := ChainComplex( [ c_1 ], 1 );;
gap> D := ChainComplex( [ d_1 ], 1 );;
gap> phi_1 := PreCompose( c_1, h );;
gap> phi_0 := PreCompose( h, d_1 );;
gap> phi := ChainMorphism( C, D, [ phi_0, phi_1 ], 0 );;
gap> homotopy_phi := HomotopyCategoryMorphism( homotopy_category, phi );;
gap> IsZero( homotopy_phi );;
gap> IsNullHomotopic( phi );
true
gap> H := HomotopyMorphisms( phi );;  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ];
gap> Display( H[ 0 ] );
[ [   -6,    0,    9,   -1,    5,   -7,    0,   -6,   -7 ],
  [   -1,    0,    1,   -6,    2,    5,    6,    9,   10 ],
  [   10,  -10,   -4,    3,   -7,   -8,   -1,   -6,    8 ],
  [   -1,    6,   -1,    6,   10,   -2,   10,    6,    3 ],
  [   -2,    6,    2,    7,   -5,   -3,   10,    0,    4 ],
  [    9,    1,   -4,   10,   10,    3,   -2,    7,    5 ] ]

A morphism in Category of left presentations of Z
gap> Display( H[ 1 ] );
(an empty 7 x 0 matrix)

A morphism in Category of left presentations of Z
gap> Display( H[ -1 ] );
(an empty 0 x 3 matrix)

A morphism in Category of left presentations of Z
