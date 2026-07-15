#! @Chapter Examples and Tests

#! @Section Dg cochain complex category from a generators-and-relations presentation

#! @Example
LoadPackage( "DgComplexesCategories", false );
#! true
q := FinQuiver( "q(A0,A1,A2,A3,A4,B0,B1,B2,C0,C1,C2,D0,D1,D2)\
[dA0:A0->A1,dA1:A1->A2,dA2:A2->A3,dA3:A3->A4,\
dB0:B0->B1,dB1:B1->B2,dC0:C0->C1,dC1:C1->C2,dD0:D0->D1,dD1:D1->D2,\
phi2:A2->B0,phi3:A3->B1,phi4:A4->B2,\
psi0:C0->D1,psi1:C1->D2,\
z2:B2->C0,i1:B1->C0,i2:B2->C1,\
p0:B0->C0,p1:B1->C1,p2:B2->C2,\
q0:B0->C1,q1:B1->C2,r0:B0->C2]" );;
F := PathCategory( q );;
k := HomalgFieldOfRationals();;
kF := k[ F ];;
kFmod := kF / [ kF.dA0 * kF.dA1, kF.dA1 * kF.dA2, kF.dA2 * kF.dA3,
                kF.dB0 * kF.dB1,
                kF.dC0 * kF.dC1,
                kF.dD0 * kF.dD1 ];;
Aoid := AdditiveClosure( kFmod );;
dgCh_Aoid := DgCochainComplexCategory( Aoid );;
A := DgCochainComplex( dgCh_Aoid,
    [ kFmod.dA0 / Aoid, kFmod.dA1 / Aoid, kFmod.dA2 / Aoid, kFmod.dA3 / Aoid ], 0 );;
B := DgCochainComplex( dgCh_Aoid,
    [ kFmod.dB0 / Aoid, kFmod.dB1 / Aoid ], 0 );;
C := DgCochainComplex( dgCh_Aoid,
    [ kFmod.dC0 / Aoid, kFmod.dC1 / Aoid ], 0 );;
D := DgCochainComplex( dgCh_Aoid,
    [ kFmod.dD0 / Aoid, kFmod.dD1 / Aoid ], 0 );;
phi := DgCochainComplexMorphism( A, B, -2,
    [ kFmod.phi2 / Aoid, kFmod.phi3 / Aoid, kFmod.phi4 / Aoid ], 2 );;
psi := DgCochainComplexMorphism( C, D, 1,
    [ kFmod.psi0 / Aoid, kFmod.psi1 / Aoid ], 0 );;
z   := DgCochainComplexMorphism( B, C, -2, [ kFmod.z2 / Aoid ], 2 );;
i   := DgCochainComplexMorphism( B, C, -1, [ kFmod.i1 / Aoid, kFmod.i2 / Aoid ], 1 );;
p   := DgCochainComplexMorphism( B, C,  0,
    [ kFmod.p0 / Aoid, kFmod.p1 / Aoid, kFmod.p2 / Aoid ], 0 );;
qq  := DgCochainComplexMorphism( B, C,  1, [ kFmod.q0 / Aoid, kFmod.q1 / Aoid ], 0 );;
r   := DgCochainComplexMorphism( B, C,  2, [ kFmod.r0 / Aoid ], 0 );;
# HomStructure is natural: Hom(phi*m*psi) = Hom(m) * Hom(phi,psi)
ForAll( [ z, i, p, qq, r ], m ->
    HomStructure( PreCompose( [ phi, m, psi ] ) ) =
    PreCompose( HomStructure( m ), HomStructure( phi, psi ) ) );
#! true
#! @EndExample

