LoadPackage( "ModulePresentation" );
LoadPackage( "ComplexesForCAP" );;

ZZ := HomalgRingOfIntegers( );
cat := LeftPresentations( ZZ );
m1 := HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ );
M1 := AsLeftPresentation( m1 );
m2 := HomalgMatrix( "[ [ 3 ] ]", 1, 1, ZZ );
M2 := AsLeftPresentation( m2 );
M := DirectSum( M1, M2 );

