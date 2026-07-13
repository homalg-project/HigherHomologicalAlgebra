# This test constructs two explicit null-homotopic chain maps in the Adelman
# category of an additive closure of a path algebroid over Q, and verifies
# the projective and injective resolution operations.
#
# Setup:
#   - A, B are cochain complexes concentrated in degrees [-5..5] and [-2..2].
#   - C, D are cochain complexes concentrated in degrees [-2..2] and [-5..5].
#   - alpha : A → B and beta : C → D are chain maps (of degree-0 in the language of dg-complexes)
#
# By construction (via quiver relations), both alpha and beta are
# null-homotopic: alpha = d(x) and beta = d(y) for explicit homotopies x, y.
#
# The test verifies:
#   (1) Projective and injective resolutions of A and B are well-defined.
#   (2) The quasi-isomorphisms qA, qB (from projective resolutions) and
#       Aq, Bq (into injective resolutions) satisfy the expected naturality:
#         qA ∘ alpha = prj_res_alpha ∘ qB
#         Bq ∘ alpha = inj_res_alpha ∘ Aq
#

gap> START_TEST("test_resolutions_operations.tst");
gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "ComplexesCategories", false );
true
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, 5 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -5, 5 ] ] ];;
gap> morphisms := [ [ "x", [ 1, 2 ], -1, [ -1, 3 ], "x" ], [ "alpha", [ 1, 2 ], 0, [ -2, 2 ], "\\alpha" ], [ "y", [ 3, 4 ], -1, [ -2, 2 ], "y" ], [ "beta", [ 3, 4 ], 0, [ -2, 2 ], "\\beta" ] ];;
gap> relations := [  [ "alpha - Differential( x )", 1 ], [ "Differential( alpha )", 1 ], [ "beta - Differential( y )", 3 ], [ "Differential( beta )", 3 ] ];;
gap> q := FinQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,A_5,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m5,D_m4,D_m3,D_m2,D_m1,D_0,D_1,D_2,D_3,D_4,D_5)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,dA_4:A_4->A_5,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m5:D_m5->D_m4,dD_m4:D_m4->D_m3,dD_m3:D_m3->D_m2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,dD_2:D_2->D_3,dD_3:D_3->D_4,dD_4:D_4->D_5,x_m1:A_m1->B_m2,x_0:A_0->B_m1,x_1:A_1->B_0,x_2:A_2->B_1,x_3:A_3->B_2,alpha_m2:A_m2->B_m2,alpha_m1:A_m1->B_m1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,alpha_2:A_2->B_2,y_m2:C_m2->D_m3,y_m1:C_m1->D_m2,y_0:C_0->D_m1,y_1:C_1->D_0,y_2:C_2->D_1,beta_m2:C_m2->D_m2,beta_m1:C_m1->D_m1,beta_0:C_0->D_0,beta_1:C_1->D_1,beta_2:C_2->D_2]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [
>    PreCompose( kF.dA_m5, kF.dA_m4 ),
>    PreCompose( kF.dA_m4, kF.dA_m3 ),
>    PreCompose( kF.dA_m3, kF.dA_m2 ),
>    PreCompose( kF.dA_m2, kF.dA_m1 ),
>    PreCompose( kF.dA_m1, kF.dA_0 ),
>    PreCompose( kF.dA_0, kF.dA_1 ),
>    PreCompose( kF.dA_1, kF.dA_2 ),
>    PreCompose( kF.dA_2, kF.dA_3 ),
>    PreCompose( kF.dA_3, kF.dA_4 ),
>    PreCompose( kF.dB_m2, kF.dB_m1 ),
>    PreCompose( kF.dB_m1, kF.dB_0 ),
>    PreCompose( kF.dB_0, kF.dB_1 ),
>    PreCompose( kF.dC_m2, kF.dC_m1 ),
>    PreCompose( kF.dC_m1, kF.dC_0 ),
>    PreCompose( kF.dC_0, kF.dC_1 ),
>    PreCompose( kF.dD_m5, kF.dD_m4 ),
>    PreCompose( kF.dD_m4, kF.dD_m3 ),
>    PreCompose( kF.dD_m3, kF.dD_m2 ),
>    PreCompose( kF.dD_m2, kF.dD_m1 ),
>    PreCompose( kF.dD_m1, kF.dD_0 ),
>    PreCompose( kF.dD_0, kF.dD_1 ),
>    PreCompose( kF.dD_1, kF.dD_2 ),
>    PreCompose( kF.dD_2, kF.dD_3 ),
>    PreCompose( kF.dD_3, kF.dD_4 ),
>    -PreCompose( kF.dA_m2, kF.x_m1 ) + kF.alpha_m2,
>    -PreCompose( kF.x_m1, kF.dB_m2 ) - PreCompose( kF.dA_m1, kF.x_0 ) + kF.alpha_m1,
>    -PreCompose( kF.x_0, kF.dB_m1 ) - PreCompose( kF.dA_0, kF.x_1 ) + kF.alpha_0,
>    -PreCompose( kF.x_1, kF.dB_0 ) - PreCompose( kF.dA_1, kF.x_2 ) + kF.alpha_1,
>    -PreCompose( kF.x_2, kF.dB_1 ) - PreCompose( kF.dA_2, kF.x_3 ) + kF.alpha_2,
>    PreCompose( kF.dA_m3, kF.alpha_m2 ),
>    -PreCompose( kF.alpha_m2, kF.dB_m2 ) + PreCompose( kF.dA_m2, kF.alpha_m1 ),
>    -PreCompose( kF.alpha_m1, kF.dB_m1 ) + PreCompose( kF.dA_m1, kF.alpha_0 ),
>    -PreCompose( kF.alpha_0, kF.dB_0 ) + PreCompose( kF.dA_0, kF.alpha_1 ),
>    -PreCompose( kF.alpha_1, kF.dB_1 ) + PreCompose( kF.dA_1, kF.alpha_2 ),
>    -PreCompose( kF.y_m2, kF.dD_m3 ) - PreCompose( kF.dC_m2, kF.y_m1 ) +  kF.beta_m2,
>    -PreCompose( kF.y_m1, kF.dD_m2 ) - PreCompose( kF.dC_m1, kF.y_0 ) +  kF.beta_m1,
>    -PreCompose( kF.y_0, kF.dD_m1 ) - PreCompose( kF.dC_0, kF.y_1 ) +  kF.beta_0,
>    -PreCompose( kF.y_1, kF.dD_0 ) - PreCompose( kF.dC_1, kF.y_2 ) +  kF.beta_1,
>    -PreCompose( kF.y_2, kF.dD_1 ) + kF.beta_2,
>    -PreCompose( kF.beta_m2, kF.dD_m2 ) + PreCompose( kF.dC_m2, kF.beta_m1 ),
>    -PreCompose( kF.beta_m1, kF.dD_m1 ) + PreCompose( kF.dC_m1, kF.beta_0 ),
>    -PreCompose( kF.beta_0, kF.dD_0 ) + PreCompose( kF.dC_0, kF.beta_1 ),
>    -PreCompose( kF.beta_1, kF.dD_1 ) + PreCompose( kF.dC_1, kF.beta_2 ),
>    -PreCompose( kF.beta_2, kF.dD_2 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> Ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> A := CreateComplex( Ch_AAoid,
>            List( [ oid.dA_m5, oid.dA_m4, oid.dA_m3, oid.dA_m2, oid.dA_m1,
>                    oid.dA_0, oid.dA_1, oid.dA_2, oid.dA_3, oid.dA_4 ],
>                  m -> m / Aoid / AAoid ),
>            -5 );;
gap> B := CreateComplex( Ch_AAoid,
>            List( [ oid.dB_m2, oid.dB_m1, oid.dB_0, oid.dB_1 ],
>                  m -> m / Aoid / AAoid ),
>            -2 );;
gap> C := CreateComplex( Ch_AAoid,
>            List( [ oid.dC_m2, oid.dC_m1, oid.dC_0, oid.dC_1 ],
>                  m -> m / Aoid / AAoid ),
>            -2 );;
gap> D := CreateComplex( Ch_AAoid,
>            List( [ oid.dD_m5, oid.dD_m4, oid.dD_m3, oid.dD_m2, oid.dD_m1,
>                    oid.dD_0, oid.dD_1, oid.dD_2, oid.dD_3, oid.dD_4 ],
>                  m -> m / Aoid / AAoid ),
>            -5 );;
gap> alpha := CreateComplexMorphism( Ch_AAoid, A,
>               List( [ oid.alpha_m2, oid.alpha_m1, oid.alpha_0, oid.alpha_1, oid.alpha_2 ],
>                     m -> m / Aoid / AAoid ),
>               -2, B );;
gap> beta := CreateComplexMorphism( Ch_AAoid, C,
>               List( [ oid.beta_m2, oid.beta_m1, oid.beta_0, oid.beta_1, oid.beta_2 ],
>                     m -> m / Aoid / AAoid ),
>               -2, D );;
gap> qA := QuasiIsomorphismFromProjectiveResolution( A, true );;
gap> qB := QuasiIsomorphismFromProjectiveResolution( B, true );;
gap> Aq :=  QuasiIsomorphismIntoInjectiveResolution( A, true );;
gap> Bq :=  QuasiIsomorphismIntoInjectiveResolution( B, true );;
gap> prj_res_alpha := MorphismBetweenProjectiveResolutions( alpha, true );;
gap> inj_res_alpha  := MorphismBetweenInjectiveResolutions( alpha, true );;
gap> Assert( 0, ForAll( [ qA, qB, Aq, Bq, prj_res_alpha, inj_res_alpha ], IsWellDefined ) );
gap> Assert( 0, PreCompose( qA, alpha ) = PreCompose( prj_res_alpha, qB ) and PostCompose( Bq, alpha ) = PostCompose( inj_res_alpha, Aq ) );

#
gap> STOP_TEST("test_resolutions_operations.tst", 1);
