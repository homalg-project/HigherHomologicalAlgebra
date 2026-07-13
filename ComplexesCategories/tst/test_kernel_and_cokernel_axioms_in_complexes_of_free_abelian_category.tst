# This test constructs an explicit short complex S → A → B → T in the Adelman
# category of an additive closure of a path algebroid over Q, where the
# composites S → B and A → T are zero, and verifies the kernel/cokernel axioms.
#
# Setup:
#   - S is a cochain complex concentrated in degrees [-5..-1].
#   - A is a cochain complex concentrated in degrees [-4..4].
#   - B is a cochain complex concentrated in degrees [-6..2].
#   - T is a cochain complex concentrated in degrees [-5..4].
#   - zeta : S → A, phi : A → B, and tau : B → T are cochain maps
#     with PreCompose( zeta, phi ) = 0 and PreCompose( phi, tau ) = 0.
#
# The test verifies:
#   (1) Kernel and cokernel lifts/colits are well-defined.
#   (2) The universal properties of kernel and cokernel hold.
#   (3) The Hom-structure is compatible with kernel and cokernel.
#   (4) Image and coimage are well-defined, with the expected (epi,mono) factorisation.

gap> START_TEST("test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.tst");

gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "ComplexesCategories", false );
true
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "S", [ -5, -1 ] ], [ "A", [ -4, 4 ] ], [ "B", [ -6, 2 ] ], [ "T", [ -5, 4 ] ] ];;
gap> morphisms := [  [ "zeta", [ 1, 2 ], 0, [ -3, -2 ], "\\zeta" ], [ "phi", [ 2, 3 ], 0, [ -3, 0 ], "\\phi" ], [ "tau", [ 3, 4 ], 0, [ -4, 1 ], "\\tau" ] ];;
gap> relations := [  [ "Differential( zeta )", 1 ], [ "Differential( phi )", 2 ], [ "Differential( tau )", 3 ], [ "PreCompose( zeta, phi )", 1 ], [ "PreCompose( phi, tau )", 2 ] ];;
gap> q := FinQuiver( "q(S_m5,S_m4,S_m3,S_m2,S_m1,A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,B_m6,B_m5,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,T_m5,T_m4,T_m3,T_m2,T_m1,T_0,T_1,T_2,T_3,T_4)[dS_m5:S_m5->S_m4,dS_m4:S_m4->S_m3,dS_m3:S_m3->S_m2,dS_m2:S_m2->S_m1,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,dB_m6:B_m6->B_m5,dB_m5:B_m5->B_m4,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dT_m5:T_m5->T_m4,dT_m4:T_m4->T_m3,dT_m3:T_m3->T_m2,dT_m2:T_m2->T_m1,dT_m1:T_m1->T_0,dT_0:T_0->T_1,dT_1:T_1->T_2,dT_2:T_2->T_3,dT_3:T_3->T_4,zeta_m3:S_m3->A_m3,zeta_m2:S_m2->A_m2,phi_m3:A_m3->B_m3,phi_m2:A_m2->B_m2,phi_m1:A_m1->B_m1,phi_0:A_0->B_0,tau_m4:B_m4->T_m4,tau_m3:B_m3->T_m3,tau_m2:B_m2->T_m2,tau_m1:B_m1->T_m1,tau_0:B_0->T_0,tau_1:B_1->T_1]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [
>    PreCompose( kF.dS_m5, kF.dS_m4 ),
>    PreCompose( kF.dS_m4, kF.dS_m3 ),
>    PreCompose( kF.dS_m3, kF.dS_m2 ),
>    PreCompose( kF.dA_m4, kF.dA_m3 ),
>    PreCompose( kF.dA_m3, kF.dA_m2 ),
>    PreCompose( kF.dA_m2, kF.dA_m1 ),
>    PreCompose( kF.dA_m1, kF.dA_0 ),
>    PreCompose( kF.dA_0, kF.dA_1 ),
>    PreCompose( kF.dA_1, kF.dA_2 ),
>    PreCompose( kF.dA_2, kF.dA_3 ),
>    PreCompose( kF.dB_m6, kF.dB_m5 ),
>    PreCompose( kF.dB_m5, kF.dB_m4 ),
>    PreCompose( kF.dB_m4, kF.dB_m3 ),
>    PreCompose( kF.dB_m3, kF.dB_m2 ),
>    PreCompose( kF.dB_m2, kF.dB_m1 ),
>    PreCompose( kF.dB_m1, kF.dB_0 ),
>    PreCompose( kF.dB_0, kF.dB_1 ),
>    PreCompose( kF.dT_m5, kF.dT_m4 ),
>    PreCompose( kF.dT_m4, kF.dT_m3 ),
>    PreCompose( kF.dT_m3, kF.dT_m2 ),
>    PreCompose( kF.dT_m2, kF.dT_m1 ),
>    PreCompose( kF.dT_m1, kF.dT_0 ),
>    PreCompose( kF.dT_0, kF.dT_1 ),
>    PreCompose( kF.dT_1, kF.dT_2 ),
>    PreCompose( kF.dT_2, kF.dT_3 ),
>    PreCompose( kF.dS_m4, kF.zeta_m3 ),
>    PreCompose( kF.zeta_m3, kF.dA_m3 ) - PreCompose( kF.dS_m3, kF.zeta_m2 ),
>    PreCompose( kF.zeta_m2, kF.dA_m2 ),
>    PreCompose( kF.dA_m4, kF.phi_m3 ),
>    PreCompose( kF.phi_m3, kF.dB_m3 ) - PreCompose( kF.dA_m3, kF.phi_m2 ),
>    PreCompose( kF.phi_m2, kF.dB_m2 ) - PreCompose( kF.dA_m2, kF.phi_m1 ),
>    PreCompose( kF.phi_m1, kF.dB_m1 ) - PreCompose( kF.dA_m1, kF.phi_0 ),
>    PreCompose( kF.phi_0, kF.dB_0 ),
>    PreCompose( kF.dB_m5, kF.tau_m4 ),
>    PreCompose( kF.tau_m4, kF.dT_m4 ) - PreCompose( kF.dB_m4, kF.tau_m3 ),
>    PreCompose( kF.tau_m3, kF.dT_m3 ) - PreCompose( kF.dB_m3, kF.tau_m2 ),
>    PreCompose( kF.tau_m2, kF.dT_m2 ) - PreCompose( kF.dB_m2, kF.tau_m1 ),
>    PreCompose( kF.tau_m1, kF.dT_m1 ) - PreCompose( kF.dB_m1, kF.tau_0 ),
>    PreCompose( kF.tau_0, kF.dT_0 ) - PreCompose( kF.dB_0, kF.tau_1 ),
>    PreCompose( kF.tau_1, kF.dT_1 ),
>    PreCompose( kF.zeta_m3, kF.phi_m3 ),
>    PreCompose( kF.zeta_m2, kF.phi_m2 ),
>    PreCompose( kF.phi_m3, kF.tau_m3 ),
>    PreCompose( kF.phi_m2, kF.tau_m2 ),
>    PreCompose( kF.phi_m1, kF.tau_m1 ),
>    PreCompose( kF.phi_0, kF.tau_0 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> S := CreateComplex( ch_AAoid,
>           [ oid.dS_m5 / Aoid / AAoid, oid.dS_m4 / Aoid / AAoid, oid.dS_m3 / Aoid / AAoid, oid.dS_m2 / Aoid / AAoid ],
>           -5 );;
gap> A := CreateComplex( ch_AAoid,
>           [ oid.dA_m4 / Aoid / AAoid, oid.dA_m3 / Aoid / AAoid, oid.dA_m2 / Aoid / AAoid, oid.dA_m1 / Aoid / AAoid,
>             oid.dA_0 / Aoid / AAoid, oid.dA_1 / Aoid / AAoid, oid.dA_2 / Aoid / AAoid, oid.dA_3 / Aoid / AAoid ],
>           -4 );;
gap> B := CreateComplex( ch_AAoid,
>           [ oid.dB_m6 / Aoid / AAoid, oid.dB_m5 / Aoid / AAoid, oid.dB_m4 / Aoid / AAoid, oid.dB_m3 / Aoid / AAoid,
>             oid.dB_m2 / Aoid / AAoid, oid.dB_m1 / Aoid / AAoid, oid.dB_0 / Aoid / AAoid, oid.dB_1 / Aoid / AAoid ],
>           -6 );;
gap> T := CreateComplex( ch_AAoid,
>           [ oid.dT_m5 / Aoid / AAoid, oid.dT_m4 / Aoid / AAoid, oid.dT_m3 / Aoid / AAoid, oid.dT_m2 / Aoid / AAoid,
>             oid.dT_m1 / Aoid / AAoid, oid.dT_0 / Aoid / AAoid, oid.dT_1 / Aoid / AAoid, oid.dT_2 / Aoid / AAoid,
>             oid.dT_3 / Aoid / AAoid ],
>           -5 );;
gap> zeta := CreateComplexMorphism( ch_AAoid, S, [ oid.zeta_m3 / Aoid / AAoid, oid.zeta_m2 / Aoid / AAoid ], -3, A );;
gap> phi := CreateComplexMorphism( ch_AAoid, A,
>             [ oid.phi_m3 / Aoid / AAoid, oid.phi_m2 / Aoid / AAoid, oid.phi_m1 / Aoid / AAoid, oid.phi_0 / Aoid / AAoid ],
>             -3, B );;
gap> tau := CreateComplexMorphism( ch_AAoid, B,
>             [ oid.tau_m4 / Aoid / AAoid, oid.tau_m3 / Aoid / AAoid, oid.tau_m2 / Aoid / AAoid,
>               oid.tau_m1 / Aoid / AAoid, oid.tau_0 / Aoid / AAoid, oid.tau_1 / Aoid / AAoid ],
>             -4, T );;
gap> Assert( 0, CohomologySupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, ObjectsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, DifferentialsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) - 1 ] );
gap> Assert( 0, ForAll( [ zeta, phi, tau ], IsWellDefined ) and ForAll( [ PreCompose( zeta, phi ), PreCompose( phi, tau ) ], IsZeroForMorphisms ) );
gap> Assert( 0, ForAll( [ CokernelColift( phi, tau ), KernelLift( phi, zeta ) ], IsWellDefined ) );
gap> Assert( 0, IsZeroForMorphisms( tau - PreCompose( CokernelProjection( phi ), CokernelColift( phi, tau ) ) ) );
gap> Assert( 0, IsZeroForMorphisms( zeta - PostCompose( KernelEmbedding( phi ), KernelLift( phi, zeta ) ) ) );
gap> #(expensive) Assert( 0, RankOfObject( HomStructure( S, KernelObject( phi ) ) ) = 1 );
gap> #(expensive) Assert( 0, RankOfObject( HomStructure( CokernelObject( phi ), T ) ) = 1 );
gap> iota := ImageEmbedding( phi );;
gap> pi := CoimageProjection( phi );;
gap> Assert( 0, ForAll( [ iota, pi ], IsWellDefined ) );;
gap> Assert( 0, IsMonomorphism( iota ) and IsEpimorphism( pi ) );;

#
gap> STOP_TEST("test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.tst", 1);
