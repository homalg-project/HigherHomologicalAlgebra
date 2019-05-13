LoadPackage( "HomotopyCategoriesForCAP" );
LoadPackage( "ModulePresentations" );

ZZ := HomalgRingOfIntegers( );
cat := LeftPresentations( ZZ );
homotopy_category := HomotopyCategory( cat );
m1 := 7;
m0 := 6;
n1 := 9;
n0 := 3;
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
Display( H[ 0 ] );


#! gap> LoadPackage( "ModulePresentations" );
#! true
#! gap> LoadPackage( "ComplexesForCAP" );
#! true
#! gap> LoadPackage( "StableCategoriesForCAP" );
#! true
#! gap> 
#! gap> ZZ := HomalgRingOfIntegers( );
#! Z
#! gap> cat := LeftPresentations( ZZ );
#! Category of left presentations of Z
#! gap> chains := ChainComplexCategory( cat : FinalizeCategory := false );
#! Chain complexes category over category of left presentations of Z
#! gap> AddMorphismIntoColiftingObject( chains,
#!        function( a )
#!          return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
#!        end );;
#! gap> Finalize( chains );
#! true
#! gap> name := Concatenation( "Homotopy category of ", Name( cat ) );
#! "Homotopy category of Category of left presentations of Z"
#! gap> stable_cat := StableCategoryByColiftingStructure( chains: Name := name );
#! Homotopy category of Category of left presentations of Z
#! gap> m1 := 7;
#! 7
#! gap> m0 := 6;
#! 6
#! gap> n1 := 9;
#! 9
#! gap> n0 := 3;
#! 3
#! gap> C1 := FreeLeftPresentation( m1, ZZ );
#! <An object in Category of left presentations of Z>
#! gap> C0 := FreeLeftPresentation( m0, ZZ );
#! <An object in Category of left presentations of Z>
#! gap> D1 := FreeLeftPresentation( n1, ZZ );
#! <An object in Category of left presentations of Z>
#! gap> D0 := FreeLeftPresentation( n0, ZZ );
#! <An object in Category of left presentations of Z>
#! gap> m_10 := List( [ 1 .. m1 ], i -> List( [ 1 .. m0 ], j -> Random( [ -10 .. 10 ] ) ) );
#! [ [ -6, 5, 10, -3, 6, -2 ], [ 1, 7, 10, -6, -8, 4 ], [ -1, 2, -1, 1, -1, 4 ], 
#!   [ -6, 7, 8, 0, 6, -1 ], [ -5, 0, -1, -4, -3, 6 ], [ -10, 9, -5, -10, 5, -2 ], 
#!   [ 10, 0, 8, 10, -9, 0 ] ]
#! gap> m_10 := HomalgMatrix( m_10, m1, m0, ZZ );
#! <A 7 x 6 matrix over an internal ring>
#! gap> n_10 := List( [ 1 .. n1 ], i -> List( [ 1 .. n0 ], j -> Random( [ -10 .. 10 ] ) ) );
#! [ [ 4, 7, -9 ], [ -10, -4, 4 ], [ 3, 5, -1 ], [ -6, -4, 10 ], [ -4, 5, -9 ], 
#!   [ 8, -3, -8 ], [ -8, 2, -8 ], [ 6, 3, 10 ], [ 7, -8, -8 ] ]
#! gap> n_10 := HomalgMatrix( n_10, n1, n0, ZZ );
#! <A 9 x 3 matrix over an internal ring>
#! gap> h := List( [ 1 .. m0 ], i -> List( [ 1 .. n1 ], j -> Random( [ -10 .. 10 ] ) ) );
#! [ [ -2, 0, 1, 0, -3, 0, 2, 0, 1 ], [ -9, 1, 3, 3, 8, 2, -3, 5, -5 ], 
#!   [ -8, 0, 7, -2, 3, 5, -9, -1, -6 ], [ -10, 5, -5, 4, 10, 1, 5, -6, -3 ], 
#!   [ -7, -2, 4, 8, -4, 5, 2, 8, 0 ], [ -10, 6, 10, 1, 7, -9, 3, 6, -5 ] ]
#! gap> h := HomalgMatrix( h, m0, n1, ZZ );
#! <A 6 x 9 matrix over an internal ring>
#! gap> c_1 := PresentationMorphism( C1, m_10, C0 );
#! <A morphism in Category of left presentations of Z>
#! gap> d_1 := PresentationMorphism( D1, n_10, D0 );
#! <A morphism in Category of left presentations of Z>
#! gap> h := PresentationMorphism( C0, h, D1 );
#! <A morphism in Category of left presentations of Z>
#! gap> C := ChainComplex( [ c_1 ], 1 );
#! <A bounded object in chain complexes category over category of left presentations of Z w\
#! ith active lower bound -1 and active upper bound 2>
#! gap> D := ChainComplex( [ d_1 ], 1 );
#! <A bounded object in chain complexes category over category of left presentations of Z w\
#! ith active lower bound -1 and active upper bound 2>
#! gap> phi_1 := PreCompose( c_1, h );
#! <A morphism in Category of left presentations of Z>
#! gap> phi_0 := PreCompose( h, d_1 );
#! <A morphism in Category of left presentations of Z>
#! gap> phi := ChainMorphism( C, D, [ phi_0, phi_1 ], 0 );
#! <A bounded morphism in chain complexes category over category of left presentations of Z\
#!  with active lower bound -1 and active upper bound 2>
#! gap> stable_phi := StableCategoryMorphism( stable_cat, phi );
#! <A morphism in Homotopy category of Category of left presentations of Z>
#! gap> IsZero( stable_phi );
#! true
