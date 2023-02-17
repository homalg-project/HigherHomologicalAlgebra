gap> LoadPackage( "Bicomplexes" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> ZZ := HomalgRingOfIntegers( );
Z
gap> lp := LeftPresentations( ZZ );;
gap> Ch_lp := ComplexesCategoryByChains( lp );
Complexes category by chains( Category of left presentations of Z )
gap> ChCh_lp := ComplexesCategoryByChains( Ch_lp );
Complexes category by chains( Complexes category by chains( Category of left presentations of Z ) )
gap> F1 := FreeLeftPresentation( 1, ZZ );
<A projective object in Category of left presentations of Z>
gap> d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 4 ] ]", 1, 1, ZZ ), F1 );
<A morphism in Category of left presentations of Z>
gap> d6 := CokernelProjection( d7 );
<An epimorphism in Category of left presentations of Z>
gap> C10 := CreateComplex( Ch_lp, [ d6, d7 ], 6 );
<An object in Complexes category by chains( Category of left presentations of Z ) supported on the interval [ 5 .. 7 ]>
gap> t7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ ), F1 );
<A morphism in Category of left presentations of Z>
gap> t6 := CokernelProjection( t7 );
<An epimorphism in Category of left presentations of Z>
gap> C9 := CreateComplex( Ch_lp, [ t6, t7 ], 6 );
<An object in Complexes category by chains( Category of left presentations of Z ) supported on the interval [ 5 .. 7 ]>
gap> phi5 := PresentationMorphism( C10[ 5 ], HomalgIdentityMatrix( 1, ZZ ),  C9[ 5 ] );
<A morphism in Category of left presentations of Z>
gap> phi6 := PresentationMorphism( F1, HomalgIdentityMatrix( 1, ZZ ), F1 );
<A morphism in Category of left presentations of Z>
gap> phi7 := PresentationMorphism( F1, 2 * HomalgIdentityMatrix( 1, ZZ ), F1 );
<A morphism in Category of left presentations of Z>
gap> phi := CreateComplexMorphism( C10, [ phi5, phi6, phi7 ], 5, C9 );
<A morphism in Complexes category by chains( Category of left presentations of Z ) supported on the interval [ 5 .. 7 ]>
gap> C := CreateComplex( ChCh_lp, [ phi ], 10 );
<An object in Complexes category by chains( Complexes category by chains( Category of left presentations of Z ) ) supported \
on the interval [ 9 .. 10 ]>
gap> B := HomologicalBicomplex( C );
<A homological bicomplex in Category of left presentations of Z concentrated in window [ 8 .. 11 ] x [ 4 .. 8 ]>
gap> T := TotalComplex( B );
<An object in Complexes category by chains( Category of left presentations of Z ) supported on the interval [ 14 .. 17 ]>
gap> T[ 13 ];
<A zero object in Category of left presentations of Z>
gap> T[ 14 ];
<An object in Category of left presentations of Z>
gap> T[ 15 ];
<An object in Category of left presentations of Z>
gap> T[ 16 ];
<An object in Category of left presentations of Z>
gap> T[ 17 ];
<An object in Category of left presentations of Z>
gap> T[ 18 ];
<A zero object in Category of left presentations of Z>
gap> Display( T^16 );
[ [  -2,   0 ],
  [   1,   1 ] ]

A morphism in Category of left presentations of Z
gap> IsExact( T );
true
