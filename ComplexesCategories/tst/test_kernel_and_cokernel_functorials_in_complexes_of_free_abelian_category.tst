# This test constructs complexes A, B, U, V in the Adelman category of an
# additive closure of a path algebroid over Q, together with cochain maps
# alpha : A -> B, f : A -> U, nu : U -> V, g : B -> V satisfying
# PreCompose( alpha, g ) = PreCompose( f, nu ), and verifies the functoriality
# of the kernel and cokernel.
#
# Setup:
#   - A is a cochain complex concentrated in degrees [-5..-1].
#   - B is a cochain complex concentrated in degrees [-4..4].
#   - U is a cochain complex concentrated in degrees [-6..2].
#   - V is a cochain complex concentrated in degrees [-5..4].
#   - alpha : A -> B and f : A -> U are cochain maps.
#   - nu : U -> V and g : B -> V with PreCompose( alpha, g ) = PreCompose( f, nu ).
#
# The test verifies:
#   (1) KernelObjectFunctorial and CokernelObjectFunctorial are well-defined.
#   (2) The induced maps are compatible with kernel embeddings and cokernel projections.
#   (3) Universal morphisms into fiber products and from pushouts are well-defined.

gap> START_TEST("test_kernel_and_cokernel_functorials_in_complexes_of_free_abelian_category.tst");

gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "ComplexesCategories", false );
true
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, -1 ] ], [ "B", [ -4, 4 ] ], [ "U", [ -6, 2 ] ], [ "V", [ -5, 4 ] ] ];;
gap> morphisms := [ [ "alpha", [ 1, 2 ], 0, [ -3, -2 ], "\\alpha" ], [ "f", [ 1, 3 ], 0, [ -3, -1 ], "f" ], [ "nu", [ 3, 4 ], 0, [ -4, 1 ], "\\nu" ], [ "g", [ 2, 4 ], 0, [ -4, 1 ], "g" ] ];;
gap> relations := [ [ "Differential( alpha )", 1 ], [ "Differential( f )", 2 ], [ "Differential( nu )", 3 ], [ "Differential( g )", 3 ], [ "PreCompose( alpha, g )-PreCompose( f, nu )", 1 ] ];;
gap> q := FinQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,B_3,B_4,U_m6,U_m5,U_m4,U_m3,U_m2,U_m1,U_0,U_1,U_2,V_m5,V_m4,V_m3,V_m2,V_m1,V_0,V_1,V_2,V_3,V_4)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dB_2:B_2->B_3,dB_3:B_3->B_4,dU_m6:U_m6->U_m5,dU_m5:U_m5->U_m4,dU_m4:U_m4->U_m3,dU_m3:U_m3->U_m2,dU_m2:U_m2->U_m1,dU_m1:U_m1->U_0,dU_0:U_0->U_1,dU_1:U_1->U_2,dV_m5:V_m5->V_m4,dV_m4:V_m4->V_m3,dV_m3:V_m3->V_m2,dV_m2:V_m2->V_m1,dV_m1:V_m1->V_0,dV_0:V_0->V_1,dV_1:V_1->V_2,dV_2:V_2->V_3,dV_3:V_3->V_4,alpha_m3:A_m3->B_m3,alpha_m2:A_m2->B_m2,f_m3:A_m3->U_m3,f_m2:A_m2->U_m2,f_m1:A_m1->U_m1,nu_m4:U_m4->V_m4,nu_m3:U_m3->V_m3,nu_m2:U_m2->V_m2,nu_m1:U_m1->V_m1,nu_0:U_0->V_0,nu_1:U_1->V_1,g_m4:B_m4->V_m4,g_m3:B_m3->V_m3,g_m2:B_m2->V_m2,g_m1:B_m1->V_m1,g_0:B_0->V_0,g_1:B_1->V_1]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [
>    PreCompose( kF.dA_m5, kF.dA_m4 ),
>    PreCompose( kF.dA_m4, kF.dA_m3 ),
>    PreCompose( kF.dA_m3, kF.dA_m2 ),
>    PreCompose( kF.dB_m4, kF.dB_m3 ),
>    PreCompose( kF.dB_m3, kF.dB_m2 ),
>    PreCompose( kF.dB_m2, kF.dB_m1 ),
>    PreCompose( kF.dB_m1, kF.dB_0 ),
>    PreCompose( kF.dB_0, kF.dB_1 ),
>    PreCompose( kF.dB_1, kF.dB_2 ),
>    PreCompose( kF.dB_2, kF.dB_3 ),
>    PreCompose( kF.dU_m6, kF.dU_m5 ),
>    PreCompose( kF.dU_m5, kF.dU_m4 ),
>    PreCompose( kF.dU_m4, kF.dU_m3 ),
>    PreCompose( kF.dU_m3, kF.dU_m2 ),
>    PreCompose( kF.dU_m2, kF.dU_m1 ),
>    PreCompose( kF.dU_m1, kF.dU_0 ),
>    PreCompose( kF.dU_0, kF.dU_1 ),
>    PreCompose( kF.dV_m5, kF.dV_m4 ),
>    PreCompose( kF.dV_m4, kF.dV_m3 ),
>    PreCompose( kF.dV_m3, kF.dV_m2 ),
>    PreCompose( kF.dV_m2, kF.dV_m1 ),
>    PreCompose( kF.dV_m1, kF.dV_0 ),
>    PreCompose( kF.dV_0, kF.dV_1 ),
>    PreCompose( kF.dV_1, kF.dV_2 ),
>    PreCompose( kF.dV_2, kF.dV_3 ),
>    PreCompose( kF.dA_m4, kF.alpha_m3 ),
>    PreCompose( kF.alpha_m3, kF.dB_m3 ) - PreCompose( kF.dA_m3, kF.alpha_m2 ),
>    PreCompose( kF.alpha_m2, kF.dB_m2 ),
>    PreCompose( kF.dA_m4, kF.f_m3 ),
>    PreCompose( kF.f_m3, kF.dU_m3 ) - PreCompose( kF.dA_m3, kF.f_m2 ),
>    PreCompose( kF.f_m2, kF.dU_m2 ) - PreCompose( kF.dA_m2, kF.f_m1 ),
>    PreCompose( kF.f_m1, kF.dU_m1 ),
>    PreCompose( kF.dU_m5, kF.nu_m4 ),
>    PreCompose( kF.nu_m4, kF.dV_m4 ) - PreCompose( kF.dU_m4, kF.nu_m3 ),
>    PreCompose( kF.nu_m3, kF.dV_m3 ) - PreCompose( kF.dU_m3, kF.nu_m2 ),
>    PreCompose( kF.nu_m2, kF.dV_m2 ) - PreCompose( kF.dU_m2, kF.nu_m1 ),
>    PreCompose( kF.nu_m1, kF.dV_m1 ) - PreCompose( kF.dU_m1, kF.nu_0 ),
>    PreCompose( kF.nu_0, kF.dV_0 ) - PreCompose( kF.dU_0, kF.nu_1 ),
>    PreCompose( kF.nu_1, kF.dV_1 ),
>    PreCompose( kF.g_m4, kF.dV_m4 ) - PreCompose( kF.dB_m4, kF.g_m3 ),
>    PreCompose( kF.g_m3, kF.dV_m3 ) - PreCompose( kF.dB_m3, kF.g_m2 ),
>    PreCompose( kF.g_m2, kF.dV_m2 ) - PreCompose( kF.dB_m2, kF.g_m1 ),
>    PreCompose( kF.g_m1, kF.dV_m1 ) - PreCompose( kF.dB_m1, kF.g_0 ),
>    PreCompose( kF.g_0, kF.dV_0 ) - PreCompose( kF.dB_0, kF.g_1 ),
>    PreCompose( kF.g_1, kF.dV_1 ),
>    PreCompose( kF.f_m3, kF.nu_m3 ) - PreCompose( kF.alpha_m3, kF.g_m3 ),
>    PreCompose( kF.f_m2, kF.nu_m2 ) - PreCompose( kF.alpha_m2, kF.g_m2 ),
>    PreCompose( kF.f_m1, kF.nu_m1 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> Ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> A := CreateComplex( Ch_AAoid,
>           [ oid.dA_m5 / Aoid / AAoid, oid.dA_m4 / Aoid / AAoid, oid.dA_m3 / Aoid / AAoid, oid.dA_m2 / Aoid / AAoid ],
>           -5 );;
gap> B := CreateComplex( Ch_AAoid,
>           [ oid.dB_m4 / Aoid / AAoid, oid.dB_m3 / Aoid / AAoid, oid.dB_m2 / Aoid / AAoid, oid.dB_m1 / Aoid / AAoid,
>             oid.dB_0 / Aoid / AAoid, oid.dB_1 / Aoid / AAoid, oid.dB_2 / Aoid / AAoid, oid.dB_3 / Aoid / AAoid ],
>           -4 );;
gap> U := CreateComplex( Ch_AAoid,
>           [ oid.dU_m6 / Aoid / AAoid, oid.dU_m5 / Aoid / AAoid, oid.dU_m4 / Aoid / AAoid, oid.dU_m3 / Aoid / AAoid,
>             oid.dU_m2 / Aoid / AAoid, oid.dU_m1 / Aoid / AAoid, oid.dU_0 / Aoid / AAoid, oid.dU_1 / Aoid / AAoid ],
>           -6 );;
gap> V := CreateComplex( Ch_AAoid,
>           [ oid.dV_m5 / Aoid / AAoid, oid.dV_m4 / Aoid / AAoid, oid.dV_m3 / Aoid / AAoid, oid.dV_m2 / Aoid / AAoid,
>             oid.dV_m1 / Aoid / AAoid, oid.dV_0 / Aoid / AAoid, oid.dV_1 / Aoid / AAoid, oid.dV_2 / Aoid / AAoid,
>             oid.dV_3 / Aoid / AAoid ],
>           -5 );;
gap> alpha := CreateComplexMorphism( Ch_AAoid, A,
>               [ oid.alpha_m3 / Aoid / AAoid, oid.alpha_m2 / Aoid / AAoid ],
>               -3, B );;
gap> f := CreateComplexMorphism( Ch_AAoid, A,
>           [ oid.f_m3 / Aoid / AAoid, oid.f_m2 / Aoid / AAoid, oid.f_m1 / Aoid / AAoid ],
>           -3, U );;
gap> nu := CreateComplexMorphism( Ch_AAoid, U,
>            [ oid.nu_m4 / Aoid / AAoid, oid.nu_m3 / Aoid / AAoid, oid.nu_m2 / Aoid / AAoid,
>              oid.nu_m1 / Aoid / AAoid, oid.nu_0 / Aoid / AAoid, oid.nu_1 / Aoid / AAoid ],
>            -4, V );;
gap> g := CreateComplexMorphism( Ch_AAoid, B,
>           [ oid.g_m4 / Aoid / AAoid, oid.g_m3 / Aoid / AAoid, oid.g_m2 / Aoid / AAoid,
>             oid.g_m1 / Aoid / AAoid, oid.g_0 / Aoid / AAoid, oid.g_1 / Aoid / AAoid ],
>           -4, V );;
gap> Assert( 0, ForAll( [ f, g, alpha, nu ], IsWellDefined ) and IsZeroForMorphisms( PreCompose( alpha, g ) - PreCompose( f, nu ) ) );
gap> lambda := KernelObjectFunctorial( alpha, f, nu );;
gap> Assert( 0, IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( KernelEmbedding( alpha ), f ) - PreCompose( lambda, KernelEmbedding( nu ) ) ) );
gap> lambda := CokernelObjectFunctorial( alpha, g, nu );;
gap> Assert( 0, IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( CokernelProjection( alpha ), lambda ) - PreCompose( g, CokernelProjection( nu ) ) ) );
gap> u := UniversalMorphismIntoFiberProduct( Ch_AAoid, [ g, nu ], A, [ alpha, f ] );;
gap> Assert( 0, IsWellDefined( u ) );
gap> u := UniversalMorphismFromPushout( Ch_AAoid, [ alpha, f ], V, [ g, nu ] );;
gap> Assert( 0, IsWellDefined( u ) );

#
gap> STOP_TEST("test_kernel_and_cokernel_functorials_in_complexes_of_free_abelian_category.tst", 1);
