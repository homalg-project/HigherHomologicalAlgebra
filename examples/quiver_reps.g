LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 7, 12, 6 );
cat := CategoryOfQuiverRepresentations( A );
Finalize( cat );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );
#collection := CreateExceptionalCollection( IndecInjRepresentations( A ) );

B := EndomorphismAlgebraOfExceptionalCollection( collection );
algebroid := Algebroid( B );

F := IsomorphismFromFullSubcategoryGeneratedByExceptionalCollectionIntoAlgebroid( collection );
G := IsomorphismFromAlgebroidIntoFullSubcategoryGeneratedByExceptionalCollection( collection );
I := IsomorphismFromAlgebroidIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverTheOppositeAlgebra( algebroid );
 
