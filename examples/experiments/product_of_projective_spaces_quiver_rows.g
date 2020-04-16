ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

field := HomalgFieldOfRationalsInSingular( );

S := CoxRingForProductOfProjectiveSpaces( field, [ 2, 1 ] );
S_X := S!.factor_rings[ 1 ];
O_X := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_X );
objs_O_X := SetOfKnownObjects( O_X );
B_X := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S_X );
B_X := RestrictFunctorToFullSubcategoryOfSource( B_X, O_X );
Add_B_X := ExtendFunctorToAdditiveClosureOfSource( B_X );
Add_O_X := AsCapCategory( Source( Add_B_X ) );
D_X := AsCapCategory( Range( Add_B_X ) );
QRows_X := DefiningCategory( D_X );

S_Y := S!.factor_rings[ 2 ];
O_Y := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_Y );
objs_O_Y := SetOfKnownObjects( O_Y );
B_Y := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S_Y );
B_Y := RestrictFunctorToFullSubcategoryOfSource( B_Y, O_Y );
Add_B_Y := ExtendFunctorToAdditiveClosureOfSource( B_Y );
Add_O_Y := AsCapCategory( Source( Add_B_Y ) );
D_Y := AsCapCategory( Range( Add_B_Y ) );
QRows_Y := DefiningCategory( D_Y );

T := FunctorFromProductOfQuiverRowsOntoQuiverRowsOfTensorProductAlgebra( QRows_X, QRows_Y );
Ch_T := ExtendFunctorFromProductCategoryToChainComplexCategories( T );
Ho_T := ExtendFunctorFromProductCategoryToHomotopyCategories( T );

D_X_x_D_Y := AsCapCategory( Source( Ho_T ) );
D_XxY := AsCapCategory( Range( Ho_T ) );
O_X_x_O_Y := Product( O_X, O_Y );
Add_O_X_x_Add_O_Y := Product( Add_O_X, Add_O_Y );

B := ProductOfFunctors( O_X_x_O_Y, [ B_X, B_Y ], D_X_x_D_Y );
B := PreCompose( B, Ho_T );

Add_B := ProductOfFunctors( Add_O_X_x_Add_O_Y, [ Add_B_X, Add_B_Y ], D_X_x_D_Y );
Add_B := PreCompose( Add_B, Ho_T );

o := AsZFunction( i -> AsZFunction( j -> [ objs_O_X[i], objs_O_Y[j] ] / O_X_x_O_Y ) );
o_00 := B( o[0][0] );

Display( o_00 );

## Now we create another full strong exceptional collection
## { "𝓞 (-1,-1)", "𝓞 (-1,0)", "𝓞 (0,-1)", "𝓞 (0,0)", "𝓞 (1,-1)", "𝓞 (1,0)" }
images := ListX( [ -1, 0, 1 ], [ -1, 0 ], { i, j } -> B( o[ i ][ j ] ) );
vertices_labels := ListX( [ -1, 0, 1 ], [ -1, 0 ],
                      { i, j } -> Concatenation( "𝓞 (", String(i), ",", String(j), ")" )
                    );
collection := CreateExceptionalCollection( images : vertices_labels := vertices_labels );

F := ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( collection );
G := ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( collection );

D := AsCapCategory( Range( G ) );

D_XxY.("Ω^0(0)xΩ^1(1)");
D.("𝓞 (-1,0)");

