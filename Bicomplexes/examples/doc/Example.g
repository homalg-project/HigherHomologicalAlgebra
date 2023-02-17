#! @Chunk TotalComplex

LoadPackage( "ModulePresentations");
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
lp := LeftPresentations( ZZ );;
Ch_lp := ComplexesCategoryByChains( lp );
ChCh_lp := ComplexesCategoryByChains( Ch_lp );
F1 := FreeLeftPresentation( 1, ZZ );
d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 4 ] ]", 1, 1, ZZ ), F1 );
d6 := CokernelProjection( d7 );
C10 := CreateComplex( Ch_lp, [ d6, d7 ], 6 );
t7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ ), F1 );
t6 := CokernelProjection( t7 );
C9 := CreateComplex( Ch_lp, [ t6, t7 ], 6 );
phi5 := PresentationMorphism( C10[ 5 ], HomalgIdentityMatrix( 1, ZZ ),  C9[ 5 ] );
phi6 := PresentationMorphism( F1, HomalgIdentityMatrix( 1, ZZ ), F1 );
phi7 := PresentationMorphism( F1, 2 * HomalgIdentityMatrix( 1, ZZ ), F1 );
phi := CreateComplexMorphism( C10, [ phi5, phi6, phi7 ], 5, C9 );
C := CreateComplex( ChCh_lp, [ phi ], 10 );
B := HomologicalBicomplex( C );
T := TotalComplex( B );
T[ 13 ];
T[ 14 ];
T[ 15 ];
T[ 16 ];
T[ 17 ];
T[ 18 ];
Display( T^16 );
IsExact( T );
#! @EndExample
