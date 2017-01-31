
LoadPackage( "LinearAlgebraForCap" );;
LoadPackage( "complex" );;
#! @Chunk vec_1
#! @BeginLatexOnly
#! Let $\mathbb{Q}$ be the field of rationals and let $\mathrm{Vec}_\mathbb{Q}$ be the category of $\mathbb{Q}$-vector spaces.
#! In the below example we define the complex
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=1em,column sep=3em,minimum width=2em]
#!   {
#!    \cdots & 2& 3& 4& 5 & 6 & 7 &\cdots\\
#!     & & \phantom{u}& &  &  & &\\
#!     \cdots      & 0& \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & 0&\cdots\\};
#!   \path[-stealth]
#!     (m-3-2) edge (m-3-3)
#!     (m-3-3) edge node[above=0.5ex] {$\left(\begin{array}{cc}
#!                                          1 & 3  
#!                                          \end{array}
#!                                   \right)$}(m-3-4)
#!     (m-3-4) edge node[above=0.5ex] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-3-5)
#!     (m-3-5) edge node[above=0.5ex] {$\left(\begin{array}{cc}
#!                                          2& 6  
#!                                          \end{array}
#!                                   \right)$}(m-3-6)
#!     (m-3-6) edge (m-3-7)
#!     (m-3-1) edge (m-3-2)
#!     (m-3-7) edge (m-3-8);
#! \end{tikzpicture}
#! \end{center}
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
C := CochainComplex( [ f, g, 2*f ], 3 );
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

#! @Chunk vec_2
#! @BeginLatexOnly
#! Let us define a morphism
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=4em,column sep=3em,minimum width=2em]
#!   {
#!    \cdots & 2& 3& 4& 5 & 6 & 7 &\cdots\\
#!     \cdots      & 0& \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & 0&\cdots\\
#!     \cdots      & 0& 0 & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 1} & 0 & 0&\cdots\\};
#!     
#!   \path[-stealth]
#!     (m-2-2) edge (m-2-3)
#!     (m-2-3) edge node[above=0.5ex] {$\left(\begin{array}{cc}
#!                                          1 & 3  
#!                                          \end{array}
#!                                   \right)$}(m-2-4)
#!     (m-2-4) edge node[above=0.5ex] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-2-5)
#!     (m-2-5) edge node[above=0.5ex] {$\left(\begin{array}{cc}
#!                                          2& 6  
#!                                          \end{array}
#!                                   \right)$}(m-2-6)
#!     (m-2-6) edge (m-2-7)
#!     (m-2-1) edge (m-2-2)
#!     (m-2-7) edge (m-2-8)
#!     (m-2-4) edge node[left=0.225ex] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-3-4)
#!     (m-2-5) edge node[right=0.225ex] {$\left(\begin{array}{c}
#!                                          10 
#!                                          \end{array}
#!                                   \right)$} (m-3-5)
#!     (m-3-4) edge node[below=0.225ex] {$\left(\begin{array}{c}
#!                                          5
#!                                          \end{array}
#!                                   \right)$} (m-3-5)
#!     (m-3-5) edge (m-3-6)
#!     (m-3-7) edge (m-3-8)
#!(m-3-3) edge (m-3-4)
#! (m-3-2) edge (m-3-3)
#! (m-3-1) edge (m-3-2)
#! (m-3-6) edge (m-3-7);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Example
h := VectorSpaceMorphism( A, HomalgMatrix( [ [ 5 ] ], 1, 1, Q ), A );
#! <A morphism in Category of matrices over Q>
phi4 := g;           
#! <A morphism in Category of matrices over Q>
phi5 := 2*h;
#! <A morphism in Category of matrices over Q>
D := CochainComplex( [ h ], 4 );
#! <A bounded object in cochain complexes category over category of matrices 
#! over Q with active lower bound 3 and active upper bound 6.> 
phi := CochainMorphism( C, D, [ phi4, phi5 ], 4 );
#! <A bounded morphism in cochain complexes category over category of matrices
#!  over Q with active lower bound 3 and active upper bound 6.>
cone := MappingCone( phi );
#! <A bounded object in cochain complexes category over category of matrices 
#! over Q with active lower bound 1 and active upper bound 6.>
Display( cone^4 );
#! [ [   -2,   -6,  -10 ],
#!   [    0,    0,    5 ] ]
#! 
#! A morphism in Category of matrices over Q
ActiveLowerBound( phi );
#! 3
IsZeroForMorphisms( phi );
#! false
phi;
#! <A bounded morphism in cochain complexes category over category of matrices 
#! over Q with active lower bound 4 and active upper bound 6.>
ActiveLowerBound( phi );
#! 4
#! @EndExample
#! @EndChunk


