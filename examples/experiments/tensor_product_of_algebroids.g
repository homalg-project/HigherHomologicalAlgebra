ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
#LoadPackage( "DerivedCategories" );

Q := HomalgFieldOfRationals();

#     u      v
# r1 --> r2 --> r3
#
quiver_1 := RightQuiver("quiver_1(r1,r2,r3)[u:r1->r2,v:r2->r3]");
A_1 := Algebroid( Q, quiver_1 );

#            y
#     t     -->
# c1 --> c2     c3
#           -->
#            z
#
quiver_2 := RightQuiver("quiver_2(c1,c2,c3)[t:c1->c2,y:c2->c3,z:c2->c3]");
A_2 := Algebroid( Q, quiver_2 );

tensor_A_1_A2 := TensorProductOnObjects( A_1, A_2 );

#                            r1xy
#              r1xt         ------>
#       r1xc1 ------> r1xc2         r1xc3
#         |             |   ------>   |
#         |             |    r1xz     |
#    uxc1 |        uxc2 |             | uxc3
#         |             |             |    
#         |             |    r2xy     |
#         v    r2xt     v   ------>   v
#       r2xc1 ------> r2xc2         r2xc3
#         |             |   ------>   |
#         |             |    r2xz     |
#    vxc1 |        vxc2 |             | vxc3
#         |             |             |
#         |             |    r3xy     |
#         v    r3xt     v   ------>   v
#       r3xc1 ------> r3xc2         r3xc3
#                           ------>
#                            r3xz

I := EmbeddingFromProductOfAlgebroidsIntoTensorProduct( A_1, A_2 );
I := ExtendFunctorFromProductCategoryToAdditiveClosures( I );
P := AsCapCategory( Source( I ) );
add_A_1 := P[ 1 ];
add_A_2 := P[ 2 ];

alpha_1 := RandomMorphism( add_A_1, 2 );
alpha_2 := RandomMorphism( add_A_2, 3 );
beta_1 := RandomMorphismWithFixedSource( Range( alpha_1 ), 2 );
beta_2 := RandomMorphismWithFixedSource( Range( alpha_2 ), 3 );

alpha := [ alpha_1, alpha_2 ] / P;
beta := [ beta_1, beta_2 ] / P;

CheckFunctoriality( I, alpha, beta );

I := ExtendFunctorFromProductCategoryToHomotopyCategories( I );
