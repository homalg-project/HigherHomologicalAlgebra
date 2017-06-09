LoadPackage( "LinearAlgebra" );
LoadPackage( "complex" );

Q := HomalgFieldOfRationals( );
#! Q
F1 := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
F2 := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
F3 := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
f0 := VectorSpaceMorphism( F2, HomalgMatrix( "[ -10, 0, 8, 0]", 2, 2, Q ), F2 );
#! <A morphism in Category of matrices over Q>
f1 := VectorSpaceMorphism( F2, HomalgMatrix( "[ 0, 0, 4, 5]", 2, 2, Q ), F2 );
#! <A morphism in Category of matrices over Q>
f2 := VectorSpaceMorphism( F2, HomalgMatrix( "[ 6, 0, 7, 0]", 2, 2, Q ), F2 );
#! <A morphism in Category of matrices over Q>
a := ChainComplex( [ f0, f1, f2 ], 0 );
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 3>
g1 := VectorSpaceMorphism( F1, HomalgMatrix( "[11, 12, 13]", 1, 3, Q ), F3 );
#! <A morphism in Category of matrices over Q>
b := ChainComplex( [ g1 ], 1 );
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -1 and active upper bound 2>
a_o_b := TensorProductOnObjects( a, b );
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 4>
b_o_a := TensorProductOnObjects( b, a );
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 4>
s := a_o_b;
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 4>
t := b_o_a;
#! <A bounded object in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 4>
