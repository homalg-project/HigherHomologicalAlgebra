#! @System AsCategoryOfBicomplexes

LoadPackage( "M2" );
LoadPackage( "Bicomplexes" );

#! @BeginLatexOnly
#! Let us create the following chain complex of chain complexes of left presentations over $\mathbb{Z}$:
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=3em,column sep=3em,minimum width=2em]
#!   {
#!    &   0   &          0   &          0   & 0 & 8 \\
#!    &   0   & \mathbb{Z}   & \mathbb{Z}   & 0 & 7 \\
#!    &   0   & \mathbb{Z}   & \mathbb{Z}   & 0 & 6 \\ 
#!    &   0   & \mathbb{Z}_2 & \mathbb{Z}_4 & 0 & 5 \\ 
#!    &   0   & 0            & 0            & 0 & 4 \\
#!    &\mathbf{0} & C_9 & C_{10} & \mathbf{0} &\\};
#!   \path[-stealth]
#!     (m-2-2) edge[ <-,thick] (m-2-3)
#!     (m-2-2) edge[ ->,thick] (m-3-2)

#!     (m-3-2) edge[ ->,thick] (m-4-2)
#!     (m-1-2) edge[ ->,thick] (m-2-2)
#!     (m-1-5) edge[ ->,thick] (m-2-5)
#!     (m-2-3) edge[ <-,thick] node[above]{$(2)$} (m-2-4)
#!     (m-1-3) edge[ <-,thick] (m-1-4)
#!     (m-1-2) edge[ <-,thick] (m-1-3)
#!     (m-2-4) edge[ <-,thick]  (m-2-5)
#!     (m-3-2) edge[ <-,thick] (m-3-3)
#!     (m-1-4) edge[ <-,thick] (m-1-5)
#!     (m-3-3) edge[ <-,thick] node[above]{$(1)$} (m-3-4)
#!     (m-3-4) edge[ <-,thick] (m-3-5)
#!     (m-2-3) edge[ <-,thick] (m-1-3)
#!     (m-2-4) edge[ <-,thick] (m-1-4)
#!     (m-3-3) edge[ <-,thick] node[left]{$(2)$} (m-2-3)
#!     (m-3-4) edge[ <-,thick] node[right]{$(4)$} (m-2-4)
#!     (m-3-5) edge[ <-,thick] (m-2-5)
#!     (m-4-5) edge[ <-,thick] (m-3-5)
#!     (m-4-3) edge[ <-,thick] node[left]{$1\mapsto \bar{1}$} (m-3-3)
#!     (m-4-4) edge[ <-,thick] node[right]{$1\mapsto \bar{1}$} (m-3-4)
#!     (m-5-4) edge[ <-,thick]  (m-4-4)
#!     (m-5-3) edge[ <-,thick]  (m-4-3)
#!     (m-4-2) edge[ <-,thick] (m-4-3)
#!     (m-4-3) edge[ <-,thick] node[below]{$\bar{1}\mapsto \bar{1}$} (m-4-4)
#!     (m-4-4) edge[ <-,thick]  (m-4-5)
#!     (m-5-4) edge[ <-,thick]  (m-5-5)
#!     (m-5-3) edge[ <-,thick]  (m-5-4)
#!     (m-5-2) edge[ <-,thick]  (m-5-3)
#!     (m-5-2) edge[ <-,thick]  (m-4-2)
#!     (m-5-5) edge[ <-,thick]  (m-4-5)

#!     (m-6-4) edge[ double distance = 1.5pt,<-,thin]  (m-6-5)
#!     (m-6-3) edge[ double distance = 1.5pt,<-,thin]  node[above]{$\phi$} (m-6-4)
#!     (m-6-2) edge[ double distance = 1.5pt,<-,thin]  (m-6-3)

#! ;
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
lp_cat := CategoryOfHomalgLeftModules( ZZ );
#! intrinsic Category of left presentations of Z with ambient objects
chains_lp_cat := ChainComplexCategory( lp_cat );
#! Chain complexes category over intrinsic Category
#! of left presentations of Z with ambient objects
chains_chains_lp_cat := ChainComplexCategory( chains_lp_cat );
#! Chain complexes category over chain complexes category over
#! intrinsic Category of left presentations of Z with ambient objects
Bicomplexes_cat := AsCategoryOfBicomplexes( chains_chains_lp_cat );
#! Chain complexes category over chain complexes category over
#! intrinsic Category of left presentations of Z with ambient objects
#! as bicomplexes
F1 := HomalgFreeLeftModule( 1, ZZ );
#! <A free left module of rank 1 on a free generator>
d7 := HomalgMap( HomalgMatrix( "[ [ 4 ] ]", 1, 1, ZZ ), F1, F1 );
#! <An endo"morphism" of a left module>
d6 := CokernelProjection( d7 );
#! <An epimorphism of left modules>
C10 := ChainComplex( [ d6, d7 ], 6 );
#! <A bounded object in chain complexes category over intrinsic 
#! Category of left presentations of Z with ambient objects with 
#! active lower bound 4 and active upper bound 8>
t7 := HomalgMap( HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ ), F1, F1 );
#! <An endo"morphism" of a left module>
t6 := CokernelProjection( t7 );
#! <An epimorphism of left modules>
C9 := ChainComplex( [ t6, t7 ], 6 );
#! <A bounded object in chain complexes category over intrinsic 
#! Category of left presentations of Z with ambient objects with 
#! active lower bound 4 and active upper bound 8>
phi5 := HomalgMap( HomalgIdentityMatrix( 1, ZZ ), C10[ 5 ], C9[ 5 ] );
#! <A "homomorphism" of left modules>
phi6 := HomalgMap( HomalgIdentityMatrix( 1, ZZ ), F1, F1 );
#! <An endo"morphism" of a left module>
phi7 := HomalgMap( 2 * HomalgIdentityMatrix( 1, ZZ ), F1, F1 );
#! <An endo"morphism" of a left module>
phi := ChainMorphism( C10, C9, [ phi5, phi6, phi7 ], 5 );
#! <A bounded morphism in chain complexes category over intrinsic 
#! Category of left presentations of Z with ambient objects with 
#! active lower bound 4 and active upper bound 8>
C := ChainComplex( [ phi ], 10 );
#! <A bounded object in chain complexes category over chain complexes 
#! category over intrinsic Category of left presentations of Z with 
#! ambient objects with active lower bound 8 and active upper bound 11>
#! @EndExample
#! @BeginLatexOnly
#! Now we compute its associated homological bicomplex $B$ and the total complex of $B$:
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=3em,column sep=3em,minimum width=2em]
#!   {
#!    &   0   &          0   &          0   & 0 & 8 \\
#!    &   0   & \mathbb{Z}   & \mathbb{Z}   & 0 & 7 \\
#!    &   0   & \mathbb{Z}   & \mathbb{Z}   & 0 & 6 \\ 
#!    &   0   & \mathbb{Z}_2 & \mathbb{Z}_4 & 0 & 5 \\ 
#!    &   0   & 0            & 0            & 0 & 4 \\
#!    &   8   & 9 & 10 & 11 &\\};
#!   \path[-stealth]
#!     (m-2-2) edge[ <-,thick] (m-2-3)
#!     (m-2-2) edge[ ->,thick] (m-3-2)

#!     (m-3-2) edge[ ->,thick] (m-4-2)
#!     (m-1-2) edge[ ->,thick] (m-2-2)
#!     (m-1-5) edge[ ->,thick] (m-2-5)
#!     (m-2-3) edge[ <-,thick] node[above]{$(2)$} (m-2-4)
#!     (m-1-3) edge[ <-,thick] (m-1-4)
#!     (m-1-2) edge[ <-,thick] (m-1-3)
#!     (m-2-4) edge[ <-,thick]  (m-2-5)
#!     (m-3-2) edge[ <-,thick] (m-3-3)
#!     (m-1-4) edge[ <-,thick] (m-1-5)
#!     (m-3-3) edge[ <-,thick] node[above]{$(1)$} (m-3-4)
#!     (m-3-4) edge[ <-,thick] (m-3-5)
#!     (m-2-3) edge[ <-,thick] (m-1-3)
#!     (m-2-4) edge[ <-,thick] (m-1-4)
#!     (m-3-3) edge[ <-,thick] node[left]{$(-2)$} (m-2-3)
#!     (m-3-4) edge[ <-,thick] node[right]{$(4)$} (m-2-4)
#!     (m-3-5) edge[ <-,thick] (m-2-5)
#!     (m-4-5) edge[ <-,thick] (m-3-5)
#!     (m-4-3) edge[ <-,thick] node[left]{$1\mapsto \bar{1}$} (m-3-3)
#!     (m-4-4) edge[ <-,thick] node[right]{$1\mapsto \bar{1}$} (m-3-4)
#!     (m-5-4) edge[ <-,thick]  (m-4-4)
#!     (m-5-3) edge[ <-,thick]  (m-4-3)
#!     (m-4-2) edge[ <-,thick] (m-4-3)
#!     (m-4-3) edge[ <-,thick] node[below]{$\bar{1}\mapsto \bar{1}$} (m-4-4)
#!     (m-4-4) edge[ <-,thick]  (m-4-5)
#!     (m-5-4) edge[ <-,thick]  (m-5-5)
#!     (m-5-3) edge[ <-,thick]  (m-5-4)
#!     (m-5-2) edge[ <-,thick]  (m-5-3)
#!     (m-5-2) edge[ <-,thick]  (m-4-2)
#!     (m-5-5) edge[ <-,thick]  (m-4-5)
#! ;
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Example
B := HomologicalBicomplex( C );
#! <A homological bicomplex in intrinsic Category of left presentations 
#! of Z with ambient objects concentrated in window [ 8 .. 11 ] x [ 4 .. 8 ]>
Display( VerticalDifferentialAt( B, 9, 7 ) );
#! [ [  -2 ] ]
#! 
#! the map is currently represented by the above 1 x 1 matrix
T := TotalComplex( B );
#! <A bounded object in chain complexes category over intrinsic Category 
#! of left presentations of Z with ambient objects with active lower 
#! bound 13 and active upper bound 18>
T[ 13 ];
#! <A zero left module>
T[ 14 ];
#! <A cyclic torsion left module presented by 1 relation
#!  for a cyclic generator>
T[ 15 ];
#! <A non-torsion left module presented by 1 relation for 2 generators>
T[ 16 ];
#! <A free left module of rank 2 on free generators>
T[ 17 ];
#! <A free left module of rank 1 on a free generator>
T[ 18 ];
#! <A zero left module>
Display( T^16 );
#! [ [  -2,   0 ],
#!   [   1,   1 ] ]
#! 
#! the map is currently represented by the above 2 x 2 matrix
IsExact( T );
#! true
T;
#! <A cyclic, bounded object in chain complexes category over intrinsic 
#! Category of left presentations of Z with ambient objects with active 
#! lower bound 13 and active upper bound 18>
Display( T, 13, 18 );
#! 
#! -----------------------------------------------------------------
#! In index 13
#! 
#! Object is
#! 0
#! 
#! Differential is
#! (an empty 0 x 0 matrix)
#! 
#! the map is currently represented by the above 0 x 0 matrix
#! 
#! -----------------------------------------------------------------
#! In index 14
#! 
#! Object is
#! Z/< 2 > 
#! 
#! Differential is
#! (an empty 1 x 0 matrix)
#! 
#! the map is currently represented by the above 1 x 0 matrix
#! 
#! -----------------------------------------------------------------
#! In index 15
#! 
#! Object is
#! [ [  0,  4 ] ]
#! 
#! Cokernel of the map
#! 
#! Z^(1x1) --> Z^(1x2),
#! 
#! currently represented by the above matrix
#! 
#! Differential is
#! [ [  -1 ],
#!   [   1 ] ]
#! 
#! the map is currently represented by the above 2 x 1 matrix
#! 
#! -----------------------------------------------------------------
#! In index 16
#! 
#! Object is
#! Z^(1 x 2)
#! 
#! Differential is
#! [ [  -2,   0 ],
#!   [   1,   1 ] ]
#! 
#! the map is currently represented by the above 2 x 2 matrix
#! 
#! -----------------------------------------------------------------
#! In index 17
#! 
#! Object is
#! Z^(1 x 1)
#! 
#! Differential is
#! [ [  2,  4 ] ]
#! 
#! the map is currently represented by the above 1 x 2 matrix
#! 
#! -----------------------------------------------------------------
#! In index 18
#! 
#! Object is
#! 0
#! 
#! Differential is
#! (an empty 0 x 1 matrix)
#! 
#! the map is currently represented by the above 0 x 1 matrix
#! @EndExample
