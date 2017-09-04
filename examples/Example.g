#! @System AsCategoryOfBicomplexes2

LoadPackage( "M2" );
LoadPackage( "BiComplexes" );

#  Chain complex of chian complexes
#
#  8             0 <---  0  <------ 0   <--- 0
#                        |          |      
#                        |          |      
#                        v    (2)   v
#  7             0 <---  Z  <------ Z   <--- 0
#                        |          |      
#               t7 = (2) |          | d7 = (4)      
#                        v    (1)   v
#  6             0 <---  Z  <------ Z   <--- 0
#                        |          |      
#       t6 = coker( t7 ) |          | d6 = coker( d7 )     
#                        v          v
#  5             0 <--- Z_2 <------ Z_4 <--- 0
#                        |          |      
#                        |          |      
#                        v          v
#  4             0 <---  0  <------ 0   <--- 0
#
#  .
#  .   ....      8       9         10        11       ....        



#  Homological bicomplex
#
#  8             0 <---  0  <------ 0   <--- 0
#                        |          |      
#                        |          |      
#                        v    (2)   v
#  7             0 <---  Z  <------ Z   <--- 0
#                        |          |      
#             -t7 = (-2) |          | d7 = (4)      
#                        v    (1)   v
#  6             0 <---  Z  <------ Z   <--- 0
#                        |          |      
#     -t6 = -coker( t7 ) |          | d6 = coker( d7 )     
#                        v          v
#  5             0 <--- Z_2 <------ Z_4 <--- 0
#                        |          |      
#                        |          |      
#                        v          v
#  4             0 <---  0  <------ 0   <--- 0
#
#  .
#  .   ....      8       9         10        11       ....        

#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
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
B := HomologicalBicomplex( C );
#! <A homological bicomplex in intrinsic Category of left presentations 
#! of Z with ambient objects concentrated in window [ 8 .. 11 ] x [ 4 .. 8 ]>
T := TotalComplex( B );
#! <A bounded object in chain complexes category over intrinsic Category 
#! of left presentations of Z with ambient objects with active lower 
#! bound 13 and active upper bound 18>
T[ 13 ];
#! <A zero left module>
T[ 14 ];
#! <A cyclic left module presented by 1 relation for a cyclic generator>
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