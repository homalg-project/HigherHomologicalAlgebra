LoadPackage( "ModulePresentation" );
LoadPackage( "complex" );

Z6 := HomalgRingOfIntegers( )/6;
#! Z/( 6 )
cat := LeftPresentations( Z6:FinalizeCategory := false );
AddEpimorphismFromProjectiveObject( cat, CoverByFreeModule );
Finalize( cat );
cochains_cat := CochainComplexCategory( cat );
SetHasEnoughProjectives( cat, true );
m := HomalgMatrix( "[ [ 2 ] ]", 1, 1, Z6 );
#! <A 1 x 1 matrix over a residue class ring>
n := HomalgMatrix( "[ [ 3 ] ]", 1, 1, Z6 );
#! <A 1 x 1 matrix over a residue class ring>
M := AsLeftPresentation( m );
#! <An object in Category of left presentations of Z/( 6 )>
N := AsLeftPresentation( n );
#! <An object in Category of left presentations of Z/( 6 )>
Proj_M := ProjectiveResolution( M );
#! <A bounded from above object in cochain complexes category 
#! over category of left presentations of Z/( 6 ) with active upper bound 1.>

