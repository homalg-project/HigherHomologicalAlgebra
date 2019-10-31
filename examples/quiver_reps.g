LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );
ReadPackage( "DerivedCategories", "examples/random_methods_for_categories_of_quiver_reps.g" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( 7, 12 );
cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );
SetIsLinearCategoryOverCommutativeRing( cat, true );
SetCommutativeRingOfLinearCategory( cat, field );
AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, \* );
AddHomomorphismStructureUsingExternalHom( cat );
AddRandomMethodsToQuiverRepresentations( cat );
Finalize( cat );

collection_1 := CreateExceptionalCollection( IndecProjRepresentations( A ) );
collection_2 := CreateExceptionalCollection( IndecInjRepresentations( A ) );

