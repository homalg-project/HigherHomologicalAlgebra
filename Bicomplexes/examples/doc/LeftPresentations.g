# @Chunk TotalComplex


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

LoadPackage( "ModulePresentations" );
LoadPackage( "BicomplexesCategories" );

zz := HomalgRingOfIntegers( );;
lp := LeftPresentations( zz );;
bicomplexes_cat := BicomplexesCategoryByChains( lp );;
modeling_category := ModelingCategory( bicomplexes_cat );;
complexes_cat := UnderlyingCategory( modeling_category );;
F1 := AsLeftPresentation( HomalgZeroMatrix( 0, 1, zz ) );;
d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 4 ] ]", 1, 1, zz ), F1 );;
d6 := CokernelProjection( d7 );;
o_10 := CreateComplex( complexes_cat, [ d6, d7 ], 6 );;
d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 2 ] ]", 1, 1, zz ), F1 );;
d6 := CokernelProjection( d7 );;
o_9 := CreateComplex( complexes_cat, [ d6, d7 ], 6 );;
phi5 := PresentationMorphism( o_10[5], HomalgIdentityMatrix( 1, zz ),  o_9[5] );;
phi6 := PresentationMorphism( F1, HomalgIdentityMatrix( 1, zz ), F1 );;
phi7 := PresentationMorphism( F1, 2 * HomalgIdentityMatrix( 1, zz ), F1 );;
phi := CreateComplexMorphism( o_10, [ phi5, phi6, phi7 ], 5, o_9 );;
o := CreateComplex( modeling_category, [ phi ], 10 );;
o := CreateBicomplex( bicomplexes_cat, o );;
t := TotalComplex( o );;
IsWellDefined( t ) and IsExact( t );
o := CreateBicomplex( BicomplexesCategoryByCochains( lp ), o );
t := TotalComplex( o );;
IsWellDefined( t ) and IsExact( t );

