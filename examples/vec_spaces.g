# Read( "/usr/local/lib/gap4r8/local/pkg/HomotopyCategories/examples/vec_spaces.g" );

LoadPackage( "HomotopyCategories" );

Q := HomalgFieldOfRationals( );
#! Q
A1 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
A2 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
A3 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
A4 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
B1 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
B2 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
B3 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
B4 := FreeLeftPresentation( 1, Q );
#! <An object in Category of left presentations of Q>
f12 := PresentationMorphism( A1, HomalgMatrix( "[ [ 2 ] ]",1,1, Q ), A2 );
#! <A morphism in Category of left presentations of Q>
f23 := PresentationMorphism( A2, HomalgMatrix( "[ [ 0 ] ]",1,1, Q ), A3 );
#! <A morphism in Category of left presentations of Q>
f34 := PresentationMorphism( A3, HomalgMatrix( "[ [ 4 ] ]",1,1, Q ), A4 );
#! <A morphism in Category of left presentations of Q>
g12 := PresentationMorphism( A1, HomalgMatrix( "[ [ 0 ] ]",1,1, Q ), A2 );
#! <A morphism in Category of left presentations of Q>
g23 := PresentationMorphism( A2, HomalgMatrix( "[ [ 4 ] ]",1,1, Q ), A3 );
#! <A morphism in Category of left presentations of Q>
g34 := PresentationMorphism( A3, HomalgMatrix( "[ [ 0 ] ]",1,1, Q ), A4 );
#! <A morphism in Category of left presentations of Q>
CA := CochainComplex( [ f12, f23, f34 ], 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Q with active lower bound 0 and active upper bound 5.>
CB := CochainComplex( [ g12, g23, g34 ], 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Q with active lower bound 0 and active upper bound 5.>
phi1 := PresentationMorphism( CA[1], HomalgMatrix( "[ [ 6 ] ]", 1,1, Q ), CB[ 1 ] );
#! <A morphism in Category of left presentations of Q>
phi2 := PresentationMorphism( CA[2], HomalgMatrix( "[ [ 0 ] ]", 1,1, Q ), CB[ 2 ] );
#! <A morphism in Category of left presentations of Q>
phi3 := PresentationMorphism( CA[3], HomalgMatrix( "[ [ 36 ] ]", 1,1, Q ), CB[ 3 ] );
#! <A morphism in Category of left presentations of Q>
phi4 := PresentationMorphism( CA[4], HomalgMatrix( "[ [ 0 ] ]", 1,1, Q ), CB[ 4 ] );
#! <A morphism in Category of left presentations of Q>
phi := CochainMorphism( CA, CB, [ phi1, phi2, phi3, phi4 ], 1 );
#! <A bounded morphism in cochain complexes category over category of left presentations of Q with active lower bound 0 and active upper bound 5.>
t := Compute_Homotopy( phi, 4 );


