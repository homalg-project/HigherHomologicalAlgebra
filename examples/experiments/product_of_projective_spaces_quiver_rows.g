ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

field := HomalgFieldOfRationalsInSingular( );

S := CoxRingForProductOfProjectiveSpaces( field, [ 2, 1 ] );
S_P2 := S!.factor_rings[ 1 ];
S_P2_fpres := GradedLeftPresentations( S_P2 );
O_P2 := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_P2 );
objs_O_P2 := SetOfKnownObjects( O_P2 );
B_P2 := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S_P2 );
B_P2 := RestrictFunctorToFullSubcategoryOfSource( B_P2, O_P2 );
Add_B_P2 := ExtendFunctorToAdditiveClosureOfSource( B_P2 );
Add_O_P2 := AsCapCategory( Source( Add_B_P2 ) );
Ch_Add_O_P2 := ChainComplexCategory( Add_O_P2 );
D_P2 := AsCapCategory( Range( Add_B_P2 ) );
QRows_P2 := DefiningCategory( D_P2 );

S_P1 := S!.factor_rings[ 2 ];
S_P1_fpres := GradedLeftPresentations( S_P1 );
O_P1 := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_P1 );
objs_O_P1 := SetOfKnownObjects( O_P1 );
B_P1 := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S_P1 );
B_P1 := RestrictFunctorToFullSubcategoryOfSource( B_P1, O_P1 );
Add_B_P1 := ExtendFunctorToAdditiveClosureOfSource( B_P1 );
Add_O_P1 := AsCapCategory( Source( Add_B_P1 ) );
Ch_Add_O_P1 := ChainComplexCategory( Add_O_P1 );
D_P1 := AsCapCategory( Range( Add_B_P1 ) );
QRows_P1 := DefiningCategory( D_P1 );

T := FunctorFromProductOfQuiverRowsOntoQuiverRowsOfTensorProductAlgebra( QRows_P2, QRows_P1 );
Ch_T := ExtendFunctorFromProductCategoryToChainComplexCategories( T );
Ho_T := ExtendFunctorFromProductCategoryToHomotopyCategories( T );

D_P2_x_D_P1 := AsCapCategory( Source( Ho_T ) );
D_P2_x_P1 := AsCapCategory( Range( Ho_T ) );
O_P2_x_O_P1 := Product( O_P2, O_P1 );
Add_O_P2_x_Add_O_P1 := Product( Add_O_P2, Add_O_P1 );

B := ProductOfFunctors( [ B_P2, B_P1 ] );
B := PreCompose( B, Ho_T );

Add_B := ProductOfFunctors( [ Add_B_P2, Add_B_P1 ] );
Add_B := PreCompose( Add_B, Ho_T );
L := ExtendFunctorFromProductCategoryToChainComplexCategories( Add_B );

objs_O_P2_x_O_P1 := AsZFunction( i -> AsZFunction( j -> [ objs_O_P2[i], objs_O_P1[j] ] / O_P2_x_O_P1 ) );
o_00 := B( objs_O_P2_x_O_P1[0][0] );

Display( o_00 );

## Now we create another full strong exceptional collection
## { "𝓞 (-1,-1)", "𝓞 (-1,0)", "𝓞 (0,-1)", "𝓞 (0,0)", "𝓞 (1,-1)", "𝓞 (1,0)" }
images := ListX( [ -1, 0, 1 ], [ -1, 0 ], { i, j } -> B( objs_O_P2_x_O_P1[ i ][ j ] ) );
vertices_labels := ListX( [ -1, 0, 1 ], [ -1, 0 ],
                      { i, j } -> Concatenation( "𝓞 (", String(i), ",", String(j), ")" )
                    );
collection := CreateExceptionalCollection( images : vertices_labels := vertices_labels );

F := ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( collection );
G := ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( collection );

D := AsCapCategory( Range( G ) );

D_P2_x_P1.("Ω^0(0)xΩ^1(1)");
D.("𝓞 (-1,0)");

##
## connect these categories with geometry

Coh_P2 := CoherentSheavesOverProjectiveSpace( S_P2 );
Coh_P1 := CoherentSheavesOverProjectiveSpace( S_P1 );
Coh_P2_x_P1 := CoherentSheavesOverProductOfProjectiveSpaces( S );

i_O_P2 := InclusionFunctor( O_P2 );
i_Add_O_P2 := ExtendFunctorToAdditiveClosureOfSource( i_O_P2 );
i_Ch_Add_O_P2 := ExtendFunctorToChainComplexCategories( i_Add_O_P2 );

i_O_P1 := InclusionFunctor( O_P1 );
i_Add_O_P1 := ExtendFunctorToAdditiveClosureOfSource( i_O_P1 );
i_Ch_Add_O_P1 := ExtendFunctorToChainComplexCategories( i_Add_O_P1 );

i_Ch_Add_O_P2_x_Ch_Add_O_P1 := ProductOfFunctors( [ i_Ch_Add_O_P2, i_Ch_Add_O_P1 ] );

H := BoxProductOnProductOfProjectiveSpaces( S );
H := ExtendFunctorFromProductCategoryToChainComplexCategories( H );
H := PreCompose( i_Ch_Add_O_P2_x_Ch_Add_O_P1, H );
###################

Ch_Add_O_P2_x_Ch_Add_O_P1 := Product( Ch_Add_O_P2, Ch_Add_O_P1 );

Display( H );
Display( L );

a := [ RandomObject( Ch_Add_O_P2, 1 ), RandomObject( Ch_Add_O_P1, 1 ) ] / Ch_Add_O_P2_x_Ch_Add_O_P1;

