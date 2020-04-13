ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

field := HomalgFieldOfRationalsInSingular( );

S_1 := GradedRing( field * "x0..2" );
full_1 := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_1 );
o_full_1 := SetOfKnownObjects( full_1 );
B_1 := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S_1 );
B_1 := RestrictFunctorToFullSubcategoryOfSource( B_1, full_1 );
C_1 := AsCapCategory( Range( B_1 ) );
algebroid_1 := UnderlyingCategory( DefiningCategory( C_1 ) );

S_2 := GradedRing( field * "y0..1" );
full_2 := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_2 );
o_full_2 := SetOfKnownObjects( full_2 );
B_2 := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S_2 );
B_2 := RestrictFunctorToFullSubcategoryOfSource( B_2, full_2 );
C_2 := AsCapCategory( Range( B_2 ) );
algebroid_2 := UnderlyingCategory( DefiningCategory( C_2 ) );

I := EmbeddingFromProductOfAlgebroidsIntoTensorProduct( algebroid_1, algebroid_2 );
I := ExtendFunctorFromProductCategoryToAdditiveClosures( I );
I := ExtendFunctorFromProductCategoryToHomotopyCategories( I );

product_C_1_2 := AsCapCategory( Source( I ) );
product_full_1_2 := Product( full_1, full_2 );

B := ProductOfFunctors( product_full_1_2, [ B_1, B_2 ], product_C_1_2 );
B := PreCompose( B, I );

o := AsZFunction( i -> AsZFunction( j -> [ o_full_1[i], o_full_2[j] ] / product_full_1_2 ) );

o_00 := B( o[0][0] );

Display( o_00 );

## Now we create another full strong exceptional collection
images := ListX( [ -1, 0, 1 ], [ -1, 0 ], { i, j } -> B( o[ i ][ j ] ) );
vertices_labels := ListX( [ -1, 0, 1 ], [ -1, 0 ],
                      { i, j } -> Concatenation( "𝓞 (", String(i), ",", String(j), ")" )
                    );
collection := CreateExceptionalCollection( images : vertices_labels := vertices_labels );

F := ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( collection );
G := ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( collection );

C := AmbientCategory( collection ); # = Source(G)
D := AsCapCategory( Range( G ) );

