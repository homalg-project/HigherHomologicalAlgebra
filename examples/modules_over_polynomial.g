
LoadPackage( "Homotop" );
LoadPackage( "ModulePres" );

R := HomalgFieldOfRationalsInSingular()*"x,y,z,t";
#! Q[x,y,z,t]
A1 := AsLeftPresentation( HomalgMatrix( "[ [ x ] ]",1,1,R) );              
#! <An object in Category of left presentations of Q[x,y,z,t]>
A2 := AsLeftPresentation( HomalgMatrix( "[ [ yx ] ]",1,1,R) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
B1 := AsLeftPresentation( HomalgMatrix( "[ [ yx ] ]",1,1,R) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
B2 := AsLeftPresentation( HomalgMatrix( "[ [ yxt ] ]",1,1,R) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
a12 := PresentationMorphism( A1, HomalgMatrix( "[ [ y ] ]",1,1, R ), A2 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
b12 := PresentationMorphism( B1, HomalgMatrix( "[ [ t ] ]",1,1, R ), B2 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
h := PresentationMorphism( A2, HomalgMatrix( "[ [ z ] ]",1,1,R ), B1 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
CA := CochainComplex( [ a12 ], 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Q[x,y,z,t] with active lower bound 0 and active upper bound 3.>
CB := CochainComplex( [ b12 ], 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Q[x,y,z,t] with active lower bound 0 and active upper bound 3.>
phi1 := PreCompose( CA^1, h );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
phi2 := PreCompose( h, CB^1 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
phi := CochainMorphism( CA, CB, [ phi1, phi2 ], 1 );

