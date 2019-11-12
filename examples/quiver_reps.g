LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );
A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 5, 10, 6 );
cat := CategoryOfQuiverRepresentations( A );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );
#collection := CreateExceptionalCollection( IndecInjRepresentations( A ) );

B := EndomorphismAlgebraOfExceptionalCollection( collection );
algebroid := Algebroid( B );

F := IsomorphismIntoAlgebroid( collection );
G := IsomorphismFromAlgebroid( collection );
I := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

 
