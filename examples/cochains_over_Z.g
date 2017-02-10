LoadPackage( "ModulePresentation" );
LoadPackage( "complex" );

ZZ := HomalgRingOfIntegers( );
cat := LeftPresentations( ZZ:FinalizeCategory := false );
AddEpimorphismFromProjectiveObject( cat, CoverByFreeModule );
Finalize( cat );
SetHasEnoughProjectives( cat, true );
m1 := HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ );
M1 := AsLeftPresentation( m1 );
m2 := HomalgMatrix( "[ [ 3 ] ]", 1, 1, ZZ );
M2 := AsLeftPresentation( m2 );
M := DirectSum( M1, M2 );

