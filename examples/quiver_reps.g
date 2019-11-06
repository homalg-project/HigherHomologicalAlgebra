LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 7, 12, 6 );
cat := CategoryOfQuiverRepresentations( A );
Finalize( cat );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );
#collection := CreateExceptionalCollection( IndecInjRepresentations( A ) );

B := EndomorphismAlgebraOfEC( collection );
algebroid := Algebroid( B );

F := IsomorphismFromFullSubcategoryGeneratedByECIntoAlgebroid( collection );
G := IsomorphismFromAlgebroidIntoFullSubcategoryGeneratedByEC( collection );

#G := EmbeddingOfAlgebroidInCategoryOfQuiverRepresentations( algebroid );

