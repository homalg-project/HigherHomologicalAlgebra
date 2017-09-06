LoadPackage( "ComplexesForCAP" );;
LoadPackage( "ModulePresentations" );

R := HomalgFieldOfRationalsInSingular( )*"x,y,z";;
cat := LeftPresentations( R: FinalizeCategory := false );
#! Category of left presentations of Q[x,y,z]
AddEpimorphismFromProjectiveObject( cat, CoverByFreeModule );
SetHasEnoughProjectives( cat, true );;
Finalize( cat );
#! true
M := AsLeftPresentation( HomalgMatrix( "[ [ x ], [ y ], [ z ] ]", 3, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z]>
CM := StalkCochainComplex( M, 0 );
#! <A bounded object in cochain complexes category over category of left 
#! presentations of Q[x,y,z] with active lower bound -1 and active upper bound 1.>
P_M := ProjectiveResolution( M  );
P_CM := ProjectiveResolution(CM);
