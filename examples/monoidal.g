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
Display( a_o_b, -2, 4 );
#! 
#! -----------------------------------------------------------------
#! In index -2
#! 
#! Object is
#! A zero object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index -1
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 6 x 0 matrix)
#! 
#! A zero, split epimorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 0
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [  -11,  -12,  -13,    0,    0,    0 ],
#!   [    0,    0,    0,  -11,  -12,  -13 ],
#!   [  -10,    0,    0,    0,    0,    0 ],
#!   [    0,  -10,    0,    0,    0,    0 ],
#!   [    0,    0,  -10,    0,    0,    0 ],
#!   [    8,    0,    0,    0,    0,    0 ],
#!   [    0,    8,    0,    0,    0,    0 ],
#!   [    0,    0,    8,    0,    0,    0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 1
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [  -10,    0,   11,   12,   13,    0,    0,    0 ],
#!   [    8,    0,    0,    0,    0,   11,   12,   13 ],
#!   [    0,    0,    0,    0,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    0,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    0,    0,    0,    0,    0 ],
#!   [    0,    0,    4,    0,    0,    5,    0,    0 ],
#!   [    0,    0,    0,    4,    0,    0,    5,    0 ],
#!   [    0,    0,    0,    0,    4,    0,    0,    5 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 2
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [    0,    0,  -11,  -12,  -13,    0,    0,    0 ],
#!   [    4,    5,    0,    0,    0,  -11,  -12,  -13 ],
#!   [    0,    0,    6,    0,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    6,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    0,    6,    0,    0,    0 ],
#!   [    0,    0,    7,    0,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    7,    0,    0,    0,    0 ],
#!   [    0,    0,    0,    0,    7,    0,    0,    0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 3
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [   6,   0,  11,  12,  13,   0,   0,   0 ],
#!   [   7,   0,   0,   0,   0,  11,  12,  13 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 4
#! 
#! Object is
#! A zero object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 0 x 2 matrix)
#! 
#! A zero, split monomorphism in Category of matrices over Q
Display( b_o_a, -2, 4 );
#! 
#! -----------------------------------------------------------------
#! In index -2
#! 
#! Object is
#! A zero object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index -1
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 6 x 0 matrix)
#! 
#! A zero, split epimorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 0
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [  -10,    0,    0,    0,    0,    0 ],
#!   [    8,    0,    0,    0,    0,    0 ],
#!   [    0,    0,  -10,    0,    0,    0 ],
#!   [    0,    0,    8,    0,    0,    0 ],
#!   [    0,    0,    0,    0,  -10,    0 ],
#!   [    0,    0,    0,    0,    8,    0 ],
#!   [   11,    0,   12,    0,   13,    0 ],
#!   [    0,   11,    0,   12,    0,   13 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 1
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   4,   5,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   4,   5,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   4,   5,   0,   0 ],
#!   [  11,   0,  12,   0,  13,   0,  10,   0 ],
#!   [   0,  11,   0,  12,   0,  13,  -8,   0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 2
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [   6,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   7,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   6,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   7,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   6,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   7,   0,   0,   0 ],
#!   [  11,   0,  12,   0,  13,   0,   0,   0 ],
#!   [   0,  11,   0,  12,   0,  13,  -4,  -5 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 3
#! 
#! Object is
#! An object in Category of matrices over Q.
#! 
#! Differential is
#! [ [  11,   0,  12,   0,  13,   0,  -6,   0 ],
#!   [   0,  11,   0,  12,   0,  13,  -7,   0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 4
#! 
#! Object is
#! A zero object in Category of matrices over Q.
#! 
#! Differential is
#! (an empty 0 x 2 matrix)
#! 
#! A zero, split monomorphism in Category of matrices over Q
phi := Braiding( a, b );
#! <A bounded morphism in chain complexes category over category of matrices over Q with active lower bound -2 and active upper bound 4>
IsWellDefined( phi, -2, 4 );
#! true
IsIsomorphism( phi );
#! true
Display( phi, -2, 4 );
#! In index -2
#! 
#! Morphism is
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index -1
#! 
#! Morphism is
#! [ [  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0 ],
#!   [  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1 ] ]
#! 
#! An isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 0
#! 
#! Morphism is
#! [ [   0,   0,   0,   0,   0,   0,  -1,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,  -1 ],
#!   [   1,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   1,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   1,   0,   0,   0 ],
#!   [   0,   1,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   1,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   1,   0,   0 ] ]
#! 
#! An isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 1
#! 
#! Morphism is
#! [ [  0,  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0,  1 ],
#!   [  1,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0,  0 ] ]
#! 
#! An isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 2
#! 
#! Morphism is
#! [ [   0,   0,   0,   0,   0,   0,  -1,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,  -1 ],
#!   [   1,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   1,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   1,   0,   0,   0 ],
#!   [   0,   1,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   1,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   1,   0,   0 ] ]
#! 
#! An isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 3
#! 
#! Morphism is
#! [ [  1,  0 ],
#!   [  0,  1 ] ]
#! 
#! An isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
#! In index 4
#! 
#! Morphism is
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of matrices over Q
#! -----------------------------------------------------------------
