ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S_1 := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
full_1 := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S_1 );
o_full_1 := SetOfKnownObjects( full_1 );
B_1 := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S_1 );
B_1 := RestrictFunctorToFullSubcategoryOfSource( B_1, full_1 );
C_1 := AsCapCategory( Range( B_1 ) );
algebroid_1 := UnderlyingCategory( DefiningCategory( C_1 ) );

S_2 := GradedRing( HomalgFieldOfRationalsInSingular( ) * "y0..1" );
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

