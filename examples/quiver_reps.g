LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );
ReadPackage( "DerivedCategories", "examples/random_methods_for_categories_of_quiver_reps.g" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( 7, 12, 6 );
cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );
SetIsLinearCategoryOverCommutativeRing( cat, true );
SetCommutativeRingOfLinearCategory( cat, field );
AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, \* );
AddRandomMethodsToQuiverRepresentations( cat );
Finalize( cat );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );
#collection := CreateExceptionalCollection( IndecInjRepresentations( A ) );

B := QuiverAlgebraFromExceptionalCollection( collection, HomalgFieldOfRationals( ) );
algebroid := Algebroid( B );
F := IsomorphismFromFullSubcategoryGeneratedByECToAlgebroid( collection, algebroid );
G := EmbeddingOfAlgebroidInCategoryOfQuiverRepresentations( algebroid );

