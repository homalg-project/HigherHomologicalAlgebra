gap> Z6 := HomalgRingOfIntegers( )/6;
Z/( 6 )
gap> cat := LeftPresentations( Z6 );
Category of left presentations of Z/( 6 )
gap> m := HomalgMatrix( "[ [ 3 ] ]", 1, 1, Z6 );
<A 1 x 1 matrix over a residue class ring>
gap> Z2 := AsLeftPresentation( m );
<An object in Category of left presentations of Z/( 6 )>
gap> proj_Z2 := ProjectiveResolution( Z2 );;
gap> Display( proj_Z2^-1 );
[ [ 3 ] ]

modulo [ 6 ]

A morphism in Category of left presentations of Z/( 6 )
gap> Display( proj_Z2^-2 );
[ [ 2 ] ]

modulo [ 6 ]

A morphism in Category of left presentations of Z/( 6 )
gap> Display( proj_Z2^-300 );
[ [ 2 ] ]

modulo [ 6 ]

A morphism in Category of left presentations of Z/( 6 )
gap> Display( proj_Z2^-301 );
[ [ 3 ] ]

modulo [ 6 ]

A morphism in Category of left presentations of Z/( 6 )
gap> A := AsChainComplex( BrutalTruncationBelow( proj_Z2, -9 ) );
<An object in Chain complexes( Category of left presentations of Z/( 6 ) ) with active lower bound 0 and active upper bound 9>
gap> IsWellDefined( TensorProduct( IdentityMorphism(A), IdentityMorphism(A) ) );
true
gap> IsWellDefined( InternalHom( IdentityMorphism(A), IdentityMorphism(A) ) );
true
gap> TensorUnit( CapCategory( A ) );
<An object in Chain complexes( Category of left presentations of Z/( 6 ) ) with active lower bound 0 and active upper bound 0>
gap> IsNullHomotopic( IdentityMorphism( MappingCone( IdentityMorphism( A ) ) ) );
true
gap> IsNullHomotopic( NaturalInjectionInMappingCone( IdentityMorphism( A ) ) );
true
gap> IsNullHomotopic( NaturalProjectionFromMappingCone( IdentityMorphism( A ) ) ) ;
true
gap> IsZero( MappingCylinder(IdentityMorphism(A)) );
false
gap> HomologySupport(A);
[ 0, 9 ]
gap> IsWellDefined( MorphismBetweenProjectiveResolutions( 2*IdentityMorphism(A) ), -10, 0 );
true
