
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
#!    \cdots\phantom{0} & 2& 3& 4& 5 & 6 & 7 &\phantom{0}\cdots\\
#!     \cdots\phantom{0}      & 0& \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & 0&\phantom{0}\cdots\\
#!     \cdots \phantom{0}     & 0& 0 & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 1} & 0 & 0&\phantom{0}\cdots\\};
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
Display( phi[ 5 ] );
#! [ [ 10 ] ]
#! 
#! A morphism in Category of matrices over Q
ActiveLowerBound( phi );
#! 3
IsZeroForMorphisms( phi );
#! false
IsExact( D );
#! true
IsExact( C );
#! false
#! @EndExample
#! @BeginLatexOnly
#! Now lets define the previous morphism using the command \texttt{CochainMorphism(c, m, d, n, l, k)}.
#! @EndLatexOnly
#! @Example
psi := CochainMorphism( [ f, g, 2*f ], 3, [ h ], 4, [ phi4, phi5 ], 4 );
#! <A bounded morphism in cochain complexes category over category of matrices 
#! over Q with active lower bound 3 and active upper bound 6.>
#! @EndExample
#! @BeginLatexOnly
#! In some cases the morphism can change its lower bound when we apply the function \texttt{ IsZeroForMorphisms }.
#! @EndLatexOnly
#! @Example
IsZeroForMorphisms( psi );
#! false
psi;
#! <A bounded morphism in cochain complexes category over category of matrices 
#! over Q with active lower bound 4 and active upper bound 6.>
#! @EndExample
#! @BeginLatexOnly
#! In the following we compute the mapping come of $\psi$ and its natural injection and projection.
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=4em,column sep=3.4em,minimum width=2em]
#!   {
#!     \cdots\phantom{0}      & 2& 3& 4& 5 & 6 & \phantom{0}\cdots\\
#!     \phantom{0}\color{blue}{C}\color{black}{:}      & 0& \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \phantom{0}\cdots\\
#!     \phantom{0}\color{blue}{D}\color{black}{:}     & 0& 0 & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 1} & 0 &\phantom{0}\cdots\\
#!     \phantom{0}\color{blue}{Cone(\psi)}\color{black}{:}     & \mathbb{Q}^{1\times 1}& \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 3} & 0 & \phantom{0}\cdots\\
#!     \phantom{:}\color{blue}{C[1]}\color{black}{:}      & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & \mathbb{Q}^{1\times 1} & \mathbb{Q}^{1\times 2} & 0&\phantom{0}\cdots\\};
#!
#!   \path[-stealth]
#!     (m-2-2) edge (m-2-3)
#!     (m-2-3) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                          1 & 3  
#!                                          \end{array}
#!                                   \right)$}(m-2-4)
#!     (m-2-4) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-2-5)
#!     (m-2-5) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                          2& 6  
#!                                          \end{array}
#!                                   \right)$}(m-2-6)
#!     (m-2-6) edge (m-2-7)
#!     (m-2-1) edge (m-2-2)
#     (m-2-7) edge (m-2-8)
#!     (m-2-4) edge node[left=0.225ex, scale=0.6] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-3-4)
#!     (m-2-5) edge node[right=0.225ex, scale=0.6] {$\left(\begin{array}{c}
#!                                          10 
#!                                          \end{array}
#!                                   \right)$} (m-3-5)
#!     (m-3-4) edge node[below=0.225ex, scale=0.6] {$\left(\begin{array}{c}
#!                                          5
#!                                          \end{array}
#!                                   \right)$} (m-3-5)
#!     (m-3-5) edge (m-3-6)
#     (m-3-7) edge (m-3-8)
#! (m-3-3) edge (m-3-4)
#! (m-3-2) edge (m-3-3)
#! (m-3-1) edge (m-3-2)
#! (m-3-6) edge (m-3-7)
#! (m-4-2) edge node[above=0.225ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                          -1 & -3
#!                                          \end{array}
#!                                   \right)$}(m-4-3)
#! (m-4-3) edge node[above=0.225ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                            0&0 \\
#!                                            0&0
#!                                          \end{array}
#!                                   \right)$}(m-4-4)
#! (m-4-4) edge node[above=0.225ex, scale=0.5] {$\left(\begin{array}{ccc}
#!                                            -2&-6&-10 \\
#!                                            0&0&5
#!                                          \end{array}
#!                                   \right)$}(m-4-5)
#! (m-4-5) edge (m-4-6)
#! (m-4-6) edge (m-4-7)
# (m-4-7) edge (m-4-8)
#! (m-4-1) edge (m-4-2)
#! (m-3-4) edge node[left=0.225ex, scale=0.6]{$\left(\begin{array}{ccc}
#!                                            0&1 \\
#!                                          \end{array}
#!                                   \right)$} (m-4-4)
#! (m-3-5) edge node[right=0.225ex, scale=0.6]{$\left(\begin{array}{ccc}
#!                                            0&0&1
#!                                          \end{array}
#!                                   \right)$} (m-4-5)
#!     (m-5-1) edge (m-5-2)
#!     (m-5-2) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                          -1 & -3
#!                                          \end{array}
#!                                   \right)$}(m-5-3)
#!     (m-5-3) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{c}
#!                                          0  \\ 0  
#!                                          \end{array}
#!                                   \right)$} (m-5-4)
#!     (m-5-4) edge node[above=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                          -2& -6
#!                                          \end{array}
#!                                   \right)$}(m-5-5)
#!     (m-5-5) edge (m-5-6)
#!     (m-5-1) edge (m-5-2)
#!     (m-5-6) edge (m-5-7)
#!     (m-4-2) edge node[left=0.5ex, scale=0.6] {$\left(\begin{array}{c}
#!                                           1
#!                                          \end{array}
#!                                   \right)$} (m-5-2)
#!     (m-4-3) edge node[left=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                           1,0\\
#!                                           0,1
#!                                          \end{array}
#!                                   \right)$} (m-5-3)
#!     (m-4-4) edge node[right=0.5ex, scale=0.6] {$\left(\begin{array}{c}
#!                                           1\\
#!                                           0
#!                                          \end{array}
#!                                   \right)$} (m-5-4)
#!     (m-4-5) edge node[right=0.5ex, scale=0.6] {$\left(\begin{array}{cc}
#!                                           1&0\\
#!                                           0&1\\
#!                                           0&0
#!                                          \end{array}
#!                                   \right)$} (m-5-5)
#!     (m-2-1) edge[blue, very thick] node[left=0.5ex]{$\psi$} (m-3-1)
#!     (m-3-1) edge[blue, very thick] node[left=0.5ex]{$i$} (m-4-1)
#!     (m-4-1) edge[blue, very thick] node[left=0.5ex]{$p$} (m-5-1)
#! ;
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Example
cone := MappingCone( psi );
#! <A bounded object in cochain complexes category over category of matrices over 
#! Q with active lower bound 1 and active upper bound 6.>
cone^4;
#! <A morphism in Category of matrices over Q>
Display( cone^4 );
#! [ [   -2,   -6,  -10 ],
#!   [    0,    0,    5 ] ]
#!
#! A morphism in Category of matrices over Q
i := NaturalInjectionInMappingCone( psi );
#! <A bounded morphism in cochain complexes category over category of matrices over
#! Q with active lower bound 3 and active upper bound 6.>
p := NaturalProjectionFromMappingCone( psi );
#! <A bounded morphism in cochain complexes category over category of matrices over
#! Q with active lower bound 1 and active upper bound 6.>
#! @EndExample
#! @EndChunk


#! @Chunk vec_3
#! @BeginLatexOnly
#! The theory tells us that each of the compositions $i\psi$ is null-homotopic. That implies that the morphisms 
#! induced on cohomologies are all zero.
#! @EndLatexOnly
#! @Example
i_o_psi := PreCompose( psi, i );
#! <A bounded morphism in cochain complexes category over category of matrices
#! over Q with active lower bound 4 and active upper bound 6.>
#! over Q with active lower bound 3 and active upper bound 6.>
H5 := CohomologyFunctor( cochain_cat, matrix_category, 5 );
#! 5-th cohomology functor in category of matrices over Q
IsZeroForMorphisms( ApplyFunctor( H5, i_o_psi ) );
#! true
#! true
#! @EndExample
#! @BeginLatexOnly
#! Next we define a functor $\mathbf{F}:\mathrm{Vec}_\mathbb{Q}\rightarrow \mathrm{Vec}_\mathbb{Q}$ 
#! that maps every $\mathbb{Q}$-vector space $A$ to $A\oplus A$ and every morphism $f:A\rightarrow B$ to $f\oplus f$. Then we extend it 
#! to the functor $\mathbf{Coch_F}:\mathrm{Coch}(\mathrm{Vec}_\mathbb{Q})\rightarrow \mathrm{Coch}(\mathrm{Vec}_\mathbb{Q})$
#! that maps each cochain complex $C$ to the cochain complex we get after applying the functor $\mathbf{F}$ on every object and differential in $C$ and 
#! maps any morphism $\phi:C\rightarrow D$ to the morphism we get after applying the functor $\mathbf{F}$ on every object,
#! differential or morphism in $C,D$ and $\phi$.
#! 
#! @EndLatexOnly
#! @Example
F := CapFunctor( "double functor", matrix_category, matrix_category );
#! double functor
u := function( obj ) return DirectSum( [ obj, obj ] ); end;;
AddObjectFunction( F, u );
v := function( s, mor, r ) return DirectSumFunctorial( [ mor, mor ] ); end;;
AddMorphismFunction( F, v );
Display( f );
#! [ [  1,  3 ] ]
#! 
#! A morphism in Category of matrices over Q
Display( ApplyFunctor( F, f ) );
#! [ [  1,  3,  0,  0 ],
#!   [  0,  0,  1,  3 ] ]
#! 
#! A morphism in Category of matrices over Q
Coch_F := ExtendFunctorToCochainComplexCategoryFunctor( F );
#! Extended version of double functor from cochain complexes category over category 
#! of matrices over Q to cochain complexes category over category of matrices over Q
psi;
#! <A bounded morphism in cochain complexes category over category of matrices 
#! over Q with active lower bound 4 and active upper bound 6.>
Coch_F_psi := ApplyFunctor( Coch_F, psi );
#! <A bounded morphism in cochain complexes category over category of matrices 
#! over Q with active lower bound 4 and active upper bound 6.>
Display( psi[ 5 ] );
#! [ [  10 ] ]
#! 
#! A morphism in Category of matrices over Q
Display( Coch_F_psi[ 5 ] );
#! [ [  10,   0 ],
#!   [   0,  10 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample
#! Next we will compute the shift $C[3]$. As we know the standard shift functor may change
#! the sign of the differentials since $d^i_{C[n]}=(-1)^n d^{i+n}_C$. Hence if we don't want the signs to be 
#! changed we may use the unsigned shift functor.
#! @Example
T := ShiftFunctor( cochain_cat, 3 );
#! Shift (3 times to the left) functor in cochain complexes category over category
#!  of matrices over Q
C;
#! <A not cyclic, bounded object in cochain complexes category over category of 
#! matrices over Q with active lower bound 2 and active upper bound 7.>
C_3 := ApplyFunctor( T, C );
#! <A not cyclic, bounded object in cochain complexes category over category of 
#! matrices over Q with active lower bound -1 and active upper bound 4.>
Display( C^3 );
#! [ [  1,  3 ] ]
#! 
#! A morphism in Category of matrices over Q
Display( C_3^0 );
#! [ [  -1,  -3 ] ]
#!
#! A morphism in Category of matrices over Q
S := UnsignedShiftFunctor( cochain_cat, 3 );
#! Unsigned shift (3 times to the left) functor in cochain complexes category over 
#! category of matrices over Q
C_3_unsigned := ApplyFunctor( S, C );
#! <A bounded object in cochain complexes category over category of matrices over 
#! Q with active lower bound -1 and active upper bound 4.>
Display( C_3_unsigned^0 );
#! [ [  1,  3 ] ]
#!
#! A morphism in Category of matrices over Q
#! @EndExample
#! @EndChunk
