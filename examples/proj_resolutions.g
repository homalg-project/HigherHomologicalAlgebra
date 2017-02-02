LoadPackage( "complex" );
LoadPackage( "ModulePresentations" );

R := HomalgFieldOfRationalsInSingular( )*"x,y,z";;
cat := LeftPresentations( R: FinalizeCategory := false );
#! Category of left presentations of Q[x,y,z]
AddEpimorphismFromProjectiveObject( cat, CoverByFreeModule );
Finalize( cat );
#! true
M := AsLeftPresentation( HomalgMatrix( "[ [ x ], [ y ], [ z ] ]", 3, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z]>
CM := StalkCochainComplex( M, 0 );
#! <A bounded object in cochain complexes category over category of left 
#! presentations of Q[x,y,z] with active lower bound -1 and active upper bound 1.>
f := QuasiIsomorphismFromProjectiveResolution( CM );
#! <A bounded morphism in cochain complexes category over category of left 
#! presentations of Q[x,y,z] with active lower bound -1 and active upper bound 1.>
P := Source( f );
#! <A bounded from above object in cochain complexes category over category 
#! of left presentations of Q[x,y,z] with active upper bound 1.>
Display( P^0 );
#! (an empty 1 x 0 matrix)
#! 
#! A zero, split epimorphism in Category of left presentations of Q[x,y,z]
Display( P^-1 );
#! z,
#! y,
#! x 
#!
#! A morphism in Category of left presentations of Q[x,y,z]
Display( P^-2 );
#! y,-z,0, 
#! x,0, -z,
#! 0,x, -y 
#! 
#! A morphism in Category of left presentations of Q[x,y,z]
Display( P^-3 );
#! x,-y,z
#! 
#! A morphism in Category of left presentations of Q[x,y,z]
Display( P^-4 );
#! (an empty 0 x 1 matrix)
#! 
#! A morphism in Category of left presentations of Q[x,y,z]
Display( P^-5 );
#! (an empty 0 x 0 matrix)
#! 
#! A morphism in Category of left presentations of Q[x,y,z]

