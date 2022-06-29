gap> EnhancePackage( "LinearAlgebraForCAP" );
true
gap> Q := HomalgFieldOfRationals( );;
gap> matrix_cat := MatrixCategory( Q );
Category of matrices over Q
gap> chains := ChainComplexCategory( matrix_cat );
Chain complexes( Category of matrices over Q )
gap> cochains := CochainComplexCategory( matrix_cat );
Cochain complexes( Category of matrices over Q )
gap> r := [ [ [ -417 ], [ 395 ] ], [ [ 225940/417, 572 ], [ 39500/139, 300 ] ], [ [ -21900/143, 292 ], [ 103800/143, -1384 ] ], [ [ 252234/73, 729 ], [ -344270/73, -995 ], [ 71622/73, 207 ] ] ];;
gap> s := [ [ [ -978 ], [ 520 ] ], [ [ -80600/163, -930 ], [ -176020/489, -677 ], [ -251420/489, -967 ] ], [ [ 267749/310, -568, -433 ], [ 69667/155, -646, 20 ], [ -438457/930, 192, 319 ] ], [ [ -173230/471, 80920/
> 471, -510 ], [ -478930/1413, 223720/1413, -470 ], [ -123299/157, 57596/157, -1089 ] ] ];;
gap> alpha := [ [ [ 0 ] ], [ [ 395/417, 1 ], [ 0, 0 ] ], [ [ -1550/1793, 0 ], [ -3385/5379, 0 ], [ -4835/5379, 0 ] ], [ [ 346/73, 1 ], [ 0, 0 ], [ 0, 0 ] ], [ [ 295415/343359, 1, 0 ], [ -478930/1030077, 0, 0 ], [ -
> 123299/114453, 0, 0 ] ] ];;
gap> s_diffs := List( s, e -> HomalgMatrix( e, Q ) / matrix_cat );;
gap> r_diffs := List( r, e -> HomalgMatrix( e, Q ) / matrix_cat );;
gap> alpha_maps := List( alpha, e -> HomalgMatrix( e, Q ) / matrix_cat );;
gap> alpha := [ s_diffs, -1, r_diffs, -1, alpha_maps, -2 ] / chains;
<A morphism in Chain complexes( Category of matrices over Q ) with active lower bound -2 and active upper bound 2>
gap> AsCochainMorphism( alpha );
<A morphism in Cochain complexes( Category of matrices over Q ) with active lower bound -2 and active upper bound 2>
gap> IsWellDefined( AsCochainMorphism( alpha ) );
true
gap> IsWellDefined( alpha );
true
gap> HomStructure( Source( alpha ), Range( alpha ) );
<A vector space object over Q of dimension 15>
gap> CoefficientsOfMorphism( alpha );
[ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 ]
gap> IsZero( alpha );
false
gap> IsNullHomotopic( alpha );
false
gap> Display( alpha );

== 2 =======================
[ [    295415/343359,                1,                0 ],
  [  -478930/1030077,                0,                0 ],
  [   -123299/114453,                0,                0 ] ]

A morphism in Category of matrices over Q

== 1 =======================
[ [  346/73,       1 ],
  [       0,       0 ],
  [       0,       0 ] ]

A morphism in Category of matrices over Q

== 0 =======================
[ [  -1550/1793,           0 ],
  [  -3385/5379,           0 ],
  [  -4835/5379,           0 ] ]

A morphism in Category of matrices over Q

== -1 =======================
[ [  395/417,        1 ],
  [        0,        0 ] ]

A morphism in Category of matrices over Q

== -2 =======================
[ [  0 ] ]

A zero morphism in Category of matrices over Q


A morphism in Chain complexes( Category of matrices over Q ) given by the above data
gap> Display( AsCochainMorphism( alpha ) );

== 2 =======================
[ [  0 ] ]

A zero morphism in Category of matrices over Q

== 1 =======================
[ [  395/417,        1 ],
  [        0,        0 ] ]

A morphism in Category of matrices over Q

== 0 =======================
[ [  -1550/1793,           0 ],
  [  -3385/5379,           0 ],
  [  -4835/5379,           0 ] ]

A morphism in Category of matrices over Q

== -1 =======================
[ [  346/73,       1 ],
  [       0,       0 ],
  [       0,       0 ] ]

A morphism in Category of matrices over Q

== -2 =======================
[ [    295415/343359,                1,                0 ],
  [  -478930/1030077,                0,                0 ],
  [   -123299/114453,                0,                0 ] ]

A morphism in Category of matrices over Q


A morphism in Cochain complexes( Category of matrices over Q ) given by the above data
gap> ViewChainMorphism( alpha );

== 2 =======================
<A morphism in Category of matrices over Q>
== 1 =======================
<A morphism in Category of matrices over Q>
== 0 =======================
<A morphism in Category of matrices over Q>
== -1 =======================
<A morphism in Category of matrices over Q>
== -2 =======================
<A zero morphism in Category of matrices over Q>

A morphism in Chain complexes( Category of matrices over Q ) given by the above data
gap> MorphismsSupport( alpha );
[ -1, 0, 1, 2 ]
gap> MorphismsSupport( AsCochainMorphism( alpha ) );
[ -2, -1, 0, 1 ]
gap> IsWellDefined( MappingConeColift( alpha, NaturalInjectionInMappingCone( alpha ) ) );
true
gap> IsWellDefined( MappingConeColift( AsCochainMorphism( alpha ), NaturalInjectionInMappingCone( AsCochainMorphism( alpha ) ) ) );
true
gap> IsZero( MappingConePseudoFunctorial( alpha, alpha, IdentityMorphism( Source( alpha ) ), IdentityMorphism( Range( alpha ) ) ) );
false
gap> IsWellDefined( NaturalMorphismFromMappingCylinderInMappingCone( alpha ) );;
gap> Display( NaturalInjectionOfSourceInMappingCylinder( alpha ) );

== 2 =======================
[ [  0,  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  0,  1 ] ]

A morphism in Category of matrices over Q

== 1 =======================
[ [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ] ]

A morphism in Category of matrices over Q

== 0 =======================
[ [  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  1 ] ]

A morphism in Category of matrices over Q

== -1 =======================
[ [  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  1 ] ]

A morphism in Category of matrices over Q

== -2 =======================
[ [  0,  1 ] ]

A morphism in Category of matrices over Q


A morphism in Chain complexes( Category of matrices over Q ) given by the above data
gap> NaturalInjectionOfRangeInMappingCylinder( alpha );;
gap> IsQuasiIsomorphism( NaturalMorphismFromSourceInMappingCocylinder( alpha ) );
true
gap> IsQuasiIsomorphism( NaturalMorphismFromSourceInMappingCocylinder( AsCochainMorphism( alpha ) ) );
true
gap> MorphismsSupport( ShiftLazy( BrutalTruncationAbove( BrutalTruncationBelow( alpha, -1 ), 1 ), 2 ) );
[ -3, -2 ]
gap> MappingCocylinder( alpha );
<An object in Chain complexes( Category of matrices over Q ) with active lower bound -3 and active upper bound 2>
gap> eta := NaturalIsomorphismFromIdentityIntoMinusOneFunctor( chains );
Natural isomorphism: Id => ⊝ 
gap> IsIsomorphism( eta( Source( alpha ) ) );
true
gap> eta := NaturalIsomorphismFromMinusOneFunctorIntoIdentity( chains );
Natural isomorphism: ⊝  => Id
gap> IsIsomorphism( eta( Source( alpha ) ) );
true
gap> DefectOfExactnessAt( Source( alpha ), 3 ) = DefectOfExactnessAt( AsCochainComplex( Source( alpha ) ), -3 );
true
gap> IsExact( Source( alpha ) ) = IsExact( AsCochainComplex( Source( alpha ) ) );
true
gap> CohomologySupport( AsCochainComplex( Source( alpha ) ) );
[ -2 ]
gap> DifferentialsSupport( Source( alpha ) );
[ -1, 0, 1, 2 ]
gap> IsWellDefined( ShiftUnsignedLazy( Source( alpha ), 34 ) );
true
gap> IsWellDefined( CokernelObjectFunctor( chains, matrix_cat, 0 )( alpha ) );
true
gap> IsWellDefined( KernelObjectFunctor( chains, matrix_cat, 0 )( alpha ) );
true
gap> IsWellDefined( KernelObjectFunctor( cochains, matrix_cat, 0 )( AsCochainMorphism( alpha ) ) );
true
gap> IsWellDefined( CokernelObjectFunctor( cochains, matrix_cat, 0 )( AsCochainMorphism( alpha ) ) );
true
gap> UnsignedShiftFunctor( chains, 3 )( alpha );
<A morphism in Chain complexes( Category of matrices over Q ) with active lower bound -5 and active upper bound -1>
gap> BrutalTruncationBelowFunctor( chains, 3 )( alpha );
<A morphism in Chain complexes( Category of matrices over Q ) with active lower bound 2 and active upper bound 2>
gap> BrutalTruncationAboveFunctor( chains, 3 )( alpha );
<A morphism in Chain complexes( Category of matrices over Q ) with active lower bound -2 and active upper bound 2>
gap> StalkCochainFunctor( chains, 0 )( alpha );
<A morphism in Cochain complexes( Chain complexes( Category of matrices over Q ) ) with active lower bound 0 and active upper bound 0>
gap> D1 := DoubleChainComplex( ChainComplex( [ alpha ], 3 ) );
<A double chain complex concentrated in window [ 2 .. 3 ] x [ -2 .. 2 ]>
gap> IsWellDefined( TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX( D1, 2, 3 ), -5, 5 );
true
gap> IsWellDefined( TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_DOUBLE_CHAIN_COMPLEX( D1, -2, 2 ), -5, 5 );
true
gap> IsWellDefined( TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_DOUBLE_CHAIN_COMPLEX( D1, -2, 2 ), -5, 5 );
true
gap> IsWellDefined( TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX( D1, -2, 2 ), -5, 5 );
true
gap> IsWellDefined( TotalComplex( DoubleCochainComplex( CochainComplex( [ AsCochainMorphism( alpha ) ], 3 ) ) ) );
true
