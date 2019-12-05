LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );


field := HomalgFieldOfRationals( );

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 3, 3, 3 );
cat := CategoryOfQuiverRepresentations( A );

CapCategorySwitchLogicOff( cat );
DisableSanityChecks( cat );

collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );
#collection := CreateExceptionalCollection( IndecInjRepresentations( A ) );

B := EndomorphismAlgebraOfExceptionalCollection( collection );
algebroid := Algebroid( B );

F := IsomorphismIntoAlgebroid( collection );
G := IsomorphismFromAlgebroid( collection );
I := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

 
