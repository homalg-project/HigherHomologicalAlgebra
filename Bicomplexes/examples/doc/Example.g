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
#! Z
F1 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 4 ] ]", 1, 1, ZZ ), F1 );
#! <A morphism in Category of left presentations of Z>
d6 := CokernelProjection( d7 );
#! <An epimorphism in Category of left presentations of Z>
C10 := ChainComplex( [ d6, d7 ], 6 );
#! <An object in Chain complexes( Category of left presentations of Z ) with active lower bound 5 and active upper bound 7>
t7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ ), F1 );
#! <A morphism in Category of left presentations of Z>
t6 := CokernelProjection( t7 );
#! <An epimorphism in Category of left presentations of Z>
C9 := ChainComplex( [ t6, t7 ], 6 );
#! <An object in Chain complexes( Category of left presentations of Z ) with active lower bound 5 and active upper bound 7>
phi5 := PresentationMorphism( C10[ 5 ], HomalgIdentityMatrix( 1, ZZ ),  C9[ 5 ] );
#! <A morphism in Category of left presentations of Z>
phi6 := PresentationMorphism( F1, HomalgIdentityMatrix( 1, ZZ ), F1 );
#! <A morphism in Category of left presentations of Z>
phi7 := PresentationMorphism( F1, 2 * HomalgIdentityMatrix( 1, ZZ ), F1 );
#! <A morphism in Category of left presentations of Z>
phi := ChainMorphism( C10, C9, [ phi5, phi6, phi7 ], 5 );
#! <A morphism in Chain complexes( Category of left presentations of Z ) with active lower bound 5 and active upper bound 7>
C := ChainComplex( [ phi ], 10 );
#! <An object in Chain complexes( Chain complexes( Category of left presentations of Z ) ) with active lower bound 
#! 9 and active upper bound 10>
B := HomologicalBicomplex( C );
#! <A homological bicomplex in Category of left presentations of Z concentrated in window [ 8 .. 11 ] x [ 4 .. 8 ]>
T := TotalComplex( B );
#! <An object in Chain complexes( Category of left presentations of Z ) with active lower bound 14 and active upper bound 17>
T[ 13 ];
#! <A zero object in Category of left presentations of Z>
T[ 14 ];
#! <An object in Category of left presentations of Z>
T[ 15 ];
#! <An object in Category of left presentations of Z>
T[ 16 ];
#! <An object in Category of left presentations of Z>
T[ 17 ];
#! <An object in Category of left presentations of Z>
T[ 18 ];
#! <A zero object in Category of left presentations of Z>
Display( T^16 );
#! [ [  -2,   0 ],
#!   [   1,   1 ] ]
#! 
#! A morphism in Category of left presentations of Z
IsExact( T );
#! true
#! @EndExample
