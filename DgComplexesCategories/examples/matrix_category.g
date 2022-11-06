LoadPackage( "DerivedCategories" );
LoadPackage( "DgComplexesCategories" );


q := RightQuiver( "q(A0,A1,A2,A3,A4,B0,B1,B2,C0,C1,C2,D0,D1,D2,)[dA_0:A0->A1,dA_1:A1->A2,dA_2:A2->A3,dA_3:A3->A4,dB_0:B0->B1,dB_1:B1->B2,dC_0:C0->C1,dC_1:C1->C2,dD_0:D0->D1,dD_1:D1->D2,phi_2:A2->B0,phi_3:A3->B1,phi_4:A4->B2,psi_0:C0->D1,psi_1:C1->D2,z2:B2->C0,i1:B1->C0,i2:B2->C1,p0:B0->C0,p1:B1->C1,p2:B2->C2,q0:B0->C1,q1:B1->C2,r0:B0->C2]" );

F := FreeCategory( q );
Q := HomalgFieldOfRationals( );
QF := Q[F];
oid := QF / [ QF.dA_0 * QF.dA_1, QF.dA_1 * QF.dA_2, QF.dA_2 * QF.dA_3, QF.dB_0 * QF.dB_1,  QF.dC_0 * QF.dC_1,  QF.dD_0 * QF.dD_1 ];

#AssignSetOfObjects( oid );
#AssignSetOfGeneratingMorphisms( oid );

Aoid := AdditiveClosure( oid );
#dgCh_Aoid := DgCochainComplexCategory( Aoid );
dgCh_Aoid := DgComplexesOfAdditiveClosureOfAlgebroid( oid );

A := DgCochainComplex( dgCh_Aoid, [ Aoid.dA_0, Aoid.dA_1, Aoid.dA_2, Aoid.dA_3 ], 0 );
B := DgCochainComplex( dgCh_Aoid, [ Aoid.dB_0, Aoid.dB_1 ], 0 );
C := DgCochainComplex( dgCh_Aoid, [ Aoid.dC_0, Aoid.dC_1 ], 0 );
D := DgCochainComplex( dgCh_Aoid, [ Aoid.dD_0, Aoid.dD_1 ], 0 );

phi := DgCochainComplexMorphism( A, B, -2, [ Aoid.phi_2, Aoid.phi_3, Aoid.phi_4 ], 2 );
psi := DgCochainComplexMorphism( C, D, 1, [ Aoid.psi_0, Aoid.psi_1 ], 0 );
z := DgCochainComplexMorphism( B, C, -2, [ Aoid.z2 ], 2 );
i := DgCochainComplexMorphism( B, C, -1, [ Aoid.i1, Aoid.i2 ], 1 );
p := DgCochainComplexMorphism( B, C, 0, [ Aoid.p0, Aoid.p1, Aoid.p2 ], 0 );
q := DgCochainComplexMorphism( B, C, 1, [ Aoid.q0, Aoid.q1 ], 0 );
r := DgCochainComplexMorphism( B, C, 2, [ Aoid.r0 ], 0 );

Display( ForAll( [ z, i, p, q, r ] , m -> HomStructure( PreCompose( [ phi, m, psi ] ) ) = PreCompose( HomStructure( m ), HomStructure( phi, psi ) ) ) );
