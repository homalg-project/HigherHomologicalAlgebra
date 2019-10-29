LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );
LoadPackage( "HomotopyCategoriesForCAP" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( 7, 12 );
cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );
SetIsLinearCategoryOverCommutativeRing( cat, true );
SetCommutativeRingOfLinearCategory( cat, field );
AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, \* );
AddHomomorphismStructureUsingExternalHom( cat );
Finalize( cat );

collection_1 := CreateStrongExceptionalCollection( IndecProjRepresentations( A ) );
collection_2 := CreateStrongExceptionalCollection( IndecInjRepresentations( A ) );

homotopy := HomotopyCategory( cat );

chains := UnderlyingCapCategory( homotopy );


