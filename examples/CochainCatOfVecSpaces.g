
LoadPackage( "LinearAlgebraForCap" );
LoadPackage( "complex" );
#! @Chunk complexes_example_1
#! @BeginLatexOnly
#! bla latex code here.
#! @EndLatexOnly
#! @Example
Q := HomalgFieldOfRationals( );;
matrix_category := MatrixCategory( Q );
#! Category of matrices over Q
cochain_cat := CochainComplexCategory( matrix_category );
#! Cochain complexes category over category of matrices over Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
f := VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 3 ] ], 1, 2, Q ), B );
#! <A morphism in Category of matrices over Q>
g := VectorSpaceMorphism( B, HomalgMatrix( [ [ 0 ], [ 0 ] ], 2, 1, Q ), A );
#! <A morphism in Category of matrices over Q>
C := CochainComplex( [ f,g,f ], 3 );
#! <A bounded object in cochain complexes category over category of matrices over Q 
#! with active lower bound 2 and active upper bound 7.>
ActiveUpperBound( C );
#! 7
ActiveLowerBound( C );
#! 2
C[ 1 ];
#! <A vector space object over Q of dimension 0>
C[ 3 ];
#! <A vector space object over Q of dimension 1>
C^3;
#! <A morphism in Category of matrices over Q>
C^3 = f;
#! true
Display( CertainCycle( C, 4 ) );
#! [ [  1,  0 ],
#!   [  0,  1 ] ]
#!
#! A split monomorphism in Category of matrices over Q
diffs := Differentials( C );
#! <An infinite list>
diffs[ 1 ];
#! <A zero, isomorphism in Category of matrices over Q>
diffs[ 10000 ];
#! <A zero, isomorphism in Category of matrices over Q>
objs := Objects( C );
#! <An infinite list>
DefectOfExactness( C, 4 );
#! <A vector space object over Q of dimension 1>
DefectOfExactness( C, 3 );
#! <A vector space object over Q of dimension 0>
IsExactInIndex( C, 4 );
#! false
IsExactInIndex( C, 3 );
#! true
C;
#! <A not cyclic, bounded object in cochain complexes category over category of 
#! matrices over Q with active lower bound 2 and active upper bound 7.>
T := ShiftFunctor( cochain_cat, 3 );
#! Shift (3 times to the left) functor in cochain complexes category over category
#!  of matrices over Q
C_3 := ApplyFunctor( T, C );
#! <A not cyclic, bounded object in cochain complexes category over category of 
#! matrices over Q with active lower bound -1 and active upper bound 4.>
P := CochainComplex( matrix_category, diffs );
#! <An object in Cochain complexes category over category of matrices over Q>
SetUpperBound( P, 15 );
P;
#! <A bounded from above object in cochain complexes category over category of 
#! matrices over Q with active upper bound 15.>
SetUpperBound( P, 20 );
P;
#! <A bounded from above object in cochain complexes category over category of 
#! matrices over Q with active upper bound 15.>
ActiveUpperBound( P );
#! 15
SetUpperBound( P, 7 );
P;
#! <A bounded from above object in cochain complexes category over category of 
#! matrices over Q with active upper bound 7.>
ActiveUpperBound( P );
#! 7
#! @EndExample
#! @EndChunk

