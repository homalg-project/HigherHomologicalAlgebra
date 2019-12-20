LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 3, 3, 3 );
cat := CategoryOfQuiverRepresentations( A );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );

B := EndomorphismAlgebraOfExceptionalCollection( collection );
algebroid := Algebroid( B );

F := IsomorphismIntoAlgebroid( collection );
G := IsomorphismFromAlgebroid( collection );
I := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

 
