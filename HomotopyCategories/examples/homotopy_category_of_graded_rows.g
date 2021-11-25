LoadPackage( "GradedRingForHomalg" );
LoadPackage( "HomotopyCategories" );


EnhancePackage( "GradedRingForHomalg" );
EnhancePackage( "FreydCategoriesForCAP" );


Q := HomalgFieldOfRationalsInSingular( );;
S := GradedRing( Q * "x_0,x_1" );;

EnhanceHomalgGradedRingWithRandomFunctions( S );

grows := CategoryOfGradedRows( S );
A_grows := FreydCategory( grows );
Ch_A_grows := CochainComplexCategory( A_grows );
K_A_grows := HomotopyCategoryByCochains( A_grows );

a := FreydCategoryObject( RandomMorphism( grows, 3 ) );
b := FreydCategoryObject( RandomMorphism( grows, 6 ) );


