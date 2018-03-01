LoadPackage( "ModulePre" );
LoadPackage( "ComplexesForCAP" );;
ZZ := HomalgRingOfIntegers( );
#! Z
F1 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
f := 12*IdentityMorphism( F1 );
#! <A morphism in Category of left presentations of Z>
phi3 := CokernelProjection( f );
#! <An epimorphism in Category of left presentations of Z>
XX := ChainComplex( [ f ], 4 );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 5>
YY := StalkChainComplex( CokernelObject( f ), 3 );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 4>
phi := ChainMorphism( XX, YY, [ phi3 ], 3 );
#! <A bounded morphism in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 4>
g := 4*IdentityMorphism( F1 );
#! <A morphism in Category of left presentations of Z>
psi3 := CokernelProjection( g );
#! <An epimorphism in Category of left presentations of Z>
UU := ChainComplex( [ g ], 4 );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 5>
VV := StalkChainComplex( CokernelObject( g ), 3 );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 4>
psi := ChainMorphism( UU, VV, [ psi3 ], 3 );
#! <A bounded morphism in chain complexes category over category of left presentations of Z with active lower bound 2 and active upper bound 4>
T := TensorProductOnMorphisms( phi, psi );
#! <A bounded morphism in chain complexes category over category of left presentations of Z with active lower bound 5 and active upper bound 7>
S := Source( T );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 5 and active upper bound 9>
B := Range( T );
#! <A bounded object in chain complexes category over category of left presentations of Z with active lower bound 5 and active upper bound 7>
d := B!.UnderlyingDoubleComplex;
#! <A double chain complex concentrated in window [ 3 ... 3 ] X [ 3 ... 3 ]>
Display( ObjectAt( d, 3, 3 ) );
#! [ [   4 ],
#!   [  12 ] ]
#! 
#! An object in Category of left presentations of Z
IsZeroForObjects( ObjectAt( d, 3, 3 ) );
#! false
