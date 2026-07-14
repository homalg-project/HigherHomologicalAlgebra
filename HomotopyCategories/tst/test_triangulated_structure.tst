# This test constructs cochain complexes A, B, C, D in the homotopy category
# of an additive closure of a path algebroid over Q, together with degree-zero
# cochain maps alpha : A -> B, nu : B -> D, gamma : A -> D, mu : A -> C,
# beta : C -> D satisfying the relations encoded in the quiver, and verifies
# the triangulated structure axioms.
#
# Setup:
#   - A, B, C, D are cochain complexes concentrated in degrees [-2..2].
#   - alpha, nu, gamma, mu, beta are degree-zero morphisms in the homotopy category.
#   - Homotopies x and y (of degree -1) encode the relations
#     PreCompose( alpha, nu ) = PreCompose( mu, beta ) + d(x)
#     and PreCompose( alpha, nu ) = gamma + d(y) in the path algebra.
#
# The test verifies:
#   (1) Shift and inverse shift are mutually inverse on objects and morphisms.
#   (2) Standard cone construction and the rotation axiom.
#   (3) Inverse rotation axiom.
#   (4) Octahedral axiom.

gap> START_TEST("test_triangulated_structure.tst");
gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "HomotopyCategories", false );
true
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -2, 2 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -2, 2 ] ] ];;
gap> morphisms := [ [ "alpha",  [ 1, 2 ],  0, [ -2, 2 ] ],
>                    [ "nu",   [ 2, 4 ],  0, [ -2, 2 ] ],
>                    [ "gamma",  [ 1, 4 ],  0, [ -2, 2 ] ],
>                    [ "mu",  [ 1, 3 ],  0, [ -2, 2 ] ],
>                    [ "beta", [ 3, 4 ],  0, [ -2, 2 ] ],
>                    [ "x",      [ 1, 4 ], -1, [ -1, 2 ] ],
>                    [ "y",      [ 1, 4 ], -1, [ -1, 2 ] ],
>                  ];;
gap> relations := [ [ "Differential( alpha )", 1 ],
>                    [ "Differential( nu )",  2 ],
>                    [ "Differential( gamma )", 1 ],
>                    [ "Differential( mu )", 1 ],
>                    [ "Differential( beta )", 3 ],
>                    [ "PreCompose( alpha, nu ) - PreCompose( mu, beta ) - Differential( x )", 1 ],
>                    [ "PreCompose( alpha, nu ) - gamma - Differential( y )", 1 ],
>                  ];;
gap> q := FinQuiver( "q(A_m2,A_m1,A_0,A_1,A_2,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m2,D_m1,D_0,D_1,D_2)[dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,alpha_m2:A_m2->B_m2,alpha_m1:A_m1->B_m1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,alpha_2:A_2->B_2,nu_m2:B_m2->D_m2,nu_m1:B_m1->D_m1,nu_0:B_0->D_0,nu_1:B_1->D_1,nu_2:B_2->D_2,gamma_m2:A_m2->D_m2,gamma_m1:A_m1->D_m1,gamma_0:A_0->D_0,gamma_1:A_1->D_1,gamma_2:A_2->D_2,mu_m2:A_m2->C_m2,mu_m1:A_m1->C_m1,mu_0:A_0->C_0,mu_1:A_1->C_1,mu_2:A_2->C_2,beta_m2:C_m2->D_m2,beta_m1:C_m1->D_m1,beta_0:C_0->D_0,beta_1:C_1->D_1,beta_2:C_2->D_2,x_m1:A_m1->D_m2,x_0:A_0->D_m1,x_1:A_1->D_0,x_2:A_2->D_1,y_m1:A_m1->D_m2,y_0:A_0->D_m1,y_1:A_1->D_0,y_2:A_2->D_1]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [
>    PreCompose( kF.dA_m2, kF.dA_m1 ),
>    PreCompose( kF.dA_m1, kF.dA_0 ),
>    PreCompose( kF.dA_0, kF.dA_1 ),
>    PreCompose( kF.dB_m2, kF.dB_m1 ),
>    PreCompose( kF.dB_m1, kF.dB_0 ),
>    PreCompose( kF.dB_0, kF.dB_1 ),
>    PreCompose( kF.dC_m2, kF.dC_m1 ),
>    PreCompose( kF.dC_m1, kF.dC_0 ),
>    PreCompose( kF.dC_0, kF.dC_1 ),
>    PreCompose( kF.dD_m2, kF.dD_m1 ),
>    PreCompose( kF.dD_m1, kF.dD_0 ),
>    PreCompose( kF.dD_0, kF.dD_1 ),
>    -PreCompose( kF.alpha_m2, kF.dB_m2 ) + PreCompose( kF.dA_m2, kF.alpha_m1 ),
>    -PreCompose( kF.alpha_m1, kF.dB_m1 ) + PreCompose( kF.dA_m1, kF.alpha_0 ),
>    -PreCompose( kF.alpha_0, kF.dB_0 ) + PreCompose( kF.dA_0, kF.alpha_1 ),
>    -PreCompose( kF.alpha_1, kF.dB_1 ) + PreCompose( kF.dA_1, kF.alpha_2 ),
>    -PreCompose( kF.nu_m2, kF.dD_m2 ) + PreCompose( kF.dB_m2, kF.nu_m1 ),
>    -PreCompose( kF.nu_m1, kF.dD_m1 ) + PreCompose( kF.dB_m1, kF.nu_0 ),
>    -PreCompose( kF.nu_0, kF.dD_0 ) + PreCompose( kF.dB_0, kF.nu_1 ),
>    -PreCompose( kF.nu_1, kF.dD_1 ) + PreCompose( kF.dB_1, kF.nu_2 ),
>    -PreCompose( kF.gamma_m2, kF.dD_m2 ) + PreCompose( kF.dA_m2, kF.gamma_m1 ),
>    -PreCompose( kF.gamma_m1, kF.dD_m1 ) + PreCompose( kF.dA_m1, kF.gamma_0 ),
>    -PreCompose( kF.gamma_0, kF.dD_0 ) + PreCompose( kF.dA_0, kF.gamma_1 ),
>    -PreCompose( kF.gamma_1, kF.dD_1 ) + PreCompose( kF.dA_1, kF.gamma_2 ),
>    -PreCompose( kF.mu_m2, kF.dC_m2 ) + PreCompose( kF.dA_m2, kF.mu_m1 ),
>    -PreCompose( kF.mu_m1, kF.dC_m1 ) + PreCompose( kF.dA_m1, kF.mu_0 ),
>    -PreCompose( kF.mu_0, kF.dC_0 ) + PreCompose( kF.dA_0, kF.mu_1 ),
>    -PreCompose( kF.mu_1, kF.dC_1 ) + PreCompose( kF.dA_1, kF.mu_2 ),
>    -PreCompose( kF.beta_m2, kF.dD_m2 ) + PreCompose( kF.dC_m2, kF.beta_m1 ),
>    -PreCompose( kF.beta_m1, kF.dD_m1 ) + PreCompose( kF.dC_m1, kF.beta_0 ),
>    -PreCompose( kF.beta_0, kF.dD_0 ) + PreCompose( kF.dC_0, kF.beta_1 ),
>    -PreCompose( kF.beta_1, kF.dD_1 ) + PreCompose( kF.dC_1, kF.beta_2 ),
>    -PreCompose( kF.mu_m2, kF.beta_m2 ) + PreCompose( kF.alpha_m2, kF.nu_m2 ) - PreCompose( kF.dA_m2, kF.x_m1 ),
>    -PreCompose( kF.x_m1, kF.dD_m2 ) - PreCompose( kF.mu_m1, kF.beta_m1 ) + PreCompose( kF.alpha_m1, kF.nu_m1 ) - PreCompose( kF.dA_m1, kF.x_0 ),
>    -PreCompose( kF.x_0, kF.dD_m1 ) - PreCompose( kF.mu_0, kF.beta_0 ) + PreCompose( kF.alpha_0, kF.nu_0 ) - PreCompose( kF.dA_0, kF.x_1 ),
>    -PreCompose( kF.x_1, kF.dD_0 ) - PreCompose( kF.mu_1, kF.beta_1 ) + PreCompose( kF.alpha_1, kF.nu_1 ) - PreCompose( kF.dA_1, kF.x_2 ),
>    -PreCompose( kF.x_2, kF.dD_1 ) - PreCompose( kF.mu_2, kF.beta_2 ) + PreCompose( kF.alpha_2, kF.nu_2 ),
>    PreCompose( kF.alpha_m2, kF.nu_m2 ) - PreCompose( kF.dA_m2, kF.y_m1 ) - kF.gamma_m2,
>    -PreCompose( kF.y_m1, kF.dD_m2 ) + PreCompose( kF.alpha_m1, kF.nu_m1 ) - PreCompose( kF.dA_m1, kF.y_0 ) - kF.gamma_m1,
>    -PreCompose( kF.y_0, kF.dD_m1 ) + PreCompose( kF.alpha_0, kF.nu_0 ) - PreCompose( kF.dA_0, kF.y_1 ) - kF.gamma_0,
>    -PreCompose( kF.y_1, kF.dD_0 ) + PreCompose( kF.alpha_1, kF.nu_1 ) - PreCompose( kF.dA_1, kF.y_2 ) - kF.gamma_1,
>    -PreCompose( kF.y_2, kF.dD_1 ) + PreCompose( kF.alpha_2, kF.nu_2 ) - kF.gamma_2 ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> cat := AdditiveClosure( oid );;
gap> homotopy_cat := HomotopyCategoryByCochains( cat );;
gap> complex_cat := AmbientCategory( homotopy_cat );;
gap> A := ObjectConstructor( homotopy_cat,
>           CreateComplex( complex_cat,
>             List( [ oid.dA_m2, oid.dA_m1, oid.dA_0, oid.dA_1 ], m -> m / cat ),
>             -2 ) );;
gap> B := ObjectConstructor( homotopy_cat,
>           CreateComplex( complex_cat,
>             List( [ oid.dB_m2, oid.dB_m1, oid.dB_0, oid.dB_1 ], m -> m / cat ),
>             -2 ) );;
gap> C := ObjectConstructor( homotopy_cat,
>           CreateComplex( complex_cat,
>             List( [ oid.dC_m2, oid.dC_m1, oid.dC_0, oid.dC_1 ], m -> m / cat ),
>             -2 ) );;
gap> D := ObjectConstructor( homotopy_cat,
>           CreateComplex( complex_cat,
>             List( [ oid.dD_m2, oid.dD_m1, oid.dD_0, oid.dD_1 ], m -> m / cat ),
>             -2 ) );;
gap> alpha := MorphismConstructor( homotopy_cat,
>               A,
>               CreateComplexMorphism( complex_cat,
>                 UnderlyingCell( A ),
>                 List( [ oid.alpha_m2, oid.alpha_m1, oid.alpha_0, oid.alpha_1, oid.alpha_2 ], m -> m / cat ),
>                 -2,
>                 UnderlyingCell( B ) ),
>               B );;
gap> nu := MorphismConstructor( homotopy_cat,
>            B,
>            CreateComplexMorphism( complex_cat,
>              UnderlyingCell( B ),
>              List( [ oid.nu_m2, oid.nu_m1, oid.nu_0, oid.nu_1, oid.nu_2 ], m -> m / cat ),
>              -2,
>              UnderlyingCell( D ) ),
>            D );;
gap> gamma := MorphismConstructor( homotopy_cat,
>              A,
>              CreateComplexMorphism( complex_cat,
>                UnderlyingCell( A ),
>                List( [ oid.gamma_m2, oid.gamma_m1, oid.gamma_0, oid.gamma_1, oid.gamma_2 ], m -> m / cat ),
>                -2,
>                UnderlyingCell( D ) ),
>              D );;
gap> mu := MorphismConstructor( homotopy_cat,
>            A,
>            CreateComplexMorphism( complex_cat,
>              UnderlyingCell( A ),
>              List( [ oid.mu_m2, oid.mu_m1, oid.mu_0, oid.mu_1, oid.mu_2 ], m -> m / cat ),
>              -2,
>              UnderlyingCell( C ) ),
>            C );;
gap> beta := MorphismConstructor( homotopy_cat,
>              C,
>              CreateComplexMorphism( complex_cat,
>                UnderlyingCell( C ),
>                List( [ oid.beta_m2, oid.beta_m1, oid.beta_0, oid.beta_1, oid.beta_2 ], m -> m / cat ),
>                -2,
>                UnderlyingCell( D ) ),
>              D );;
gap> x := ShiftOfObject( InverseShiftOfObject( A ) ) = A and ShiftOfMorphism( InverseShiftOfMorphism( alpha ) ) = alpha;;
gap> x := Shift( Shift( A, -1 ), 1 ) = A and Shift( Shift( alpha, -1 ), 1 ) = alpha;;
gap> i_alpha := MorphismIntoStandardConeObject( alpha );;
gap> p_alpha := MorphismFromStandardConeObject( alpha );;
gap> i_beta := MorphismIntoStandardConeObject( beta );;
gap> p_beta := MorphismFromStandardConeObject( beta );;
gap> m := MorphismBetweenStandardConeObjects( alpha, mu, nu, beta );;
gap> x := ForAll( [ i_alpha, i_beta, p_alpha, p_beta, m ], IsWellDefined ) and
>                   PreCompose( i_alpha, m ) = PreCompose( nu, i_beta ) and
>                       PreCompose( p_alpha, ShiftOfMorphism(mu) ) = PreCompose( m, p_beta );;
gap> ii_alpha := MorphismIntoStandardConeObject( i_alpha );;
gap> pi_alpha := MorphismFromStandardConeObject( i_alpha );;
gap> w := WitnessIsomorphismIntoStandardConeObjectByRotationAxiom( alpha );;
gap> v := WitnessIsomorphismFromStandardConeObjectByRotationAxiom( alpha );;
gap> x := IsIsomorphism( w ) and InverseForMorphisms( w ) = v and
>                   IsCongruentForMorphisms( PreCompose( p_alpha, w ), ii_alpha ) and
>                     IsCongruentForMorphisms( PreCompose( w, pi_alpha ), -ShiftOfMorphism( alpha ) );;
gap> m_isigma_p_alpha := -InverseShiftOfMorphism( p_alpha );;
gap> i_m_isigma_p_alpha := MorphismIntoStandardConeObject( m_isigma_p_alpha );;
gap> p_m_isigma_p_alpha := MorphismFromStandardConeObject( m_isigma_p_alpha );;
gap> w := WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom( alpha );;
gap> v := WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiom( alpha );;
gap> x := IsIsomorphism( w ) and InverseForMorphisms( w ) = v and
>                   IsCongruentForMorphisms( PreCompose( alpha, w ), i_m_isigma_p_alpha ) and
>                     IsCongruentForMorphisms( PreCompose( w, p_m_isigma_p_alpha ), i_alpha );;
gap> i_nu := MorphismIntoStandardConeObject( nu );;
gap> p_nu := MorphismFromStandardConeObject( nu );;
gap> i_gamma := MorphismIntoStandardConeObject( gamma );;
gap> p_gamma := MorphismFromStandardConeObject( gamma );;
gap> u := DomainMorphismByOctahedralAxiom( alpha, nu, gamma );;
gap> i_u := MorphismIntoStandardConeObject( u );;
gap> p_u := MorphismFromStandardConeObject( u );;
gap> v := MorphismIntoConeObjectByOctahedralAxiom( alpha, nu, gamma );;
gap> w := MorphismFromConeObjectByOctahedralAxiom( alpha, nu, gamma );;
gap> lambda := WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiom( alpha, nu, gamma );;
gap> i_lambda := WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom( alpha, nu, gamma );;
gap> x := IsIsomorphism( lambda ) and
>                   InverseForMorphisms( lambda ) = i_lambda and
>                     PreCompose( v, lambda ) = i_u and
>                       PreCompose( lambda, p_u ) = w and
>                         PreCompose( i_alpha, u ) = PreCompose( nu, i_gamma ) and
>                           PreCompose( u, p_gamma ) = p_alpha and
>                             PreCompose( i_gamma, v ) = i_nu and
>                               PreCompose( v, p_nu ) = PreCompose( p_gamma, ShiftOfMorphism( alpha ) ) and
>                                 PreCompose( p_nu, ShiftOfMorphism( i_alpha ) ) = w;;
gap> # @drop_example_in_Julia (was manually added there)

#
gap> STOP_TEST("test_triangulated_structure.tst", 1);
