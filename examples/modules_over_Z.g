LoadPackage( "Homotopy" );
LoadPackage( "ModulePres" );

#   0      1      2       3     4      5    6
#   0      Z  5   Z   0   Z  6  Z   0  Z    0
#
#                        715 
#
#   0      0      Z   5   Z     Z   6  Z  0 Z   0


ZZ := HomalgRingOfIntegers( );
#! Z
A1 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
A2 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
A3 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
A4 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
A5 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
d12 := PresentationMorphism( A1, HomalgMatrix( "[ [ 5 ] ]",1,1, ZZ ), A2 );
#! <A morphism in Category of left presentations of Z>
d23 := PresentationMorphism( A1, HomalgMatrix( "[ [ 0 ] ]",1,1, ZZ ), A2 );
#! <A morphism in Category of left presentations of Z>
d34 := PresentationMorphism( A1, HomalgMatrix( "[ [ 6 ] ]",1,1, ZZ ), A2 );
#! <A morphism in Category of left presentations of Z>
d45 := PresentationMorphism( A1, HomalgMatrix( "[ [ 0 ] ]",1,1, ZZ ), A2 );
#! <A morphism in Category of left presentations of Z>
CA := CochainComplex( [ d12,d23,d34,d45 ], 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Z with active lower bound 0 and active upper bound 6.>
CB := ShiftUnsignedLazy( CA, 1 );
#! <A bounded object in cochain complexes category over category of left presentations of Z with active lower bound -1 and active upper bound 5.>
CA[ 0 ];
#! <A zero object in Category of left presentations of Z>
CB[ 1 ];
#! <An object in Category of left presentations of Z>
CB := ShiftUnsignedLazy( CA, -1 );
#! <A bounded object in cochain complexes category over category of left presentations of Z with active lower bound 1 and active upper bound 7.>
h3 := PresentationMorphism( CA[ 3 ], HomalgMatrix( "[ [ 17 ] ]", 1, 1, ZZ ), CB[ 2 ] );
#! <A morphism in Category of left presentations of Z>
h4 := PresentationMorphism( CA[ 4 ], HomalgMatrix( "[ [ 105 ] ]", 1, 1, ZZ ), CB[ 3 ] );
#! <A morphism in Category of left presentations of Z>
h5 := PresentationMorphism( CA[ 5 ], HomalgMatrix( "[ [ -13 ] ]", 1, 1, ZZ ), CB[ 4 ] );
#! <A morphism in Category of left presentations of Z>
phi3 := PreCompose( CA^3,h4 ) + PreCompose( h3, CB^2 );                                 
#! <A morphism in Category of left presentations of Z>
phi := CochainMorphism( CA, CB, [ phi3 ], 3 );

