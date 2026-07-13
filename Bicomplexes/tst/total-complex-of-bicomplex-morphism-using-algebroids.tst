# This test constructs two parallel complexes of cochain complexes A, B in the
# additive closure of a path algebroid over Q, together with a chain map f : A -> B,
# and verifies the total complex functor on bicomplex morphisms.
#
# Setup:
#   - A1, A2, A3, A4 and B1, B2, B3, B4 are cochain complexes in degrees [-2..2].
#   - dA_1 : A1 -> A2, dA_2 : A2 -> A3, dA_3 : A3 -> A4 are horizontal differentials.
#   - dB_1 : B1 -> B2, dB_2 : B2 -> B3, dB_3 : B3 -> B4 are horizontal differentials.
#   - f1, f2, f3, f4 form a chain map f : A -> B between the two rows.
#
# The test verifies:
#   (1) TotalComplexFunctorial is well-defined for the cochain bicomplex.
#   (2) TotalComplexFunctorial is well-defined for the chain bicomplex.

gap> START_TEST("total-complex-of-bicomplex-morphism-using-algebroids.tst");

gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "Bicomplexes", false );
true
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A1", [ -2, 2 ], "A_{1}" ], [ "A2", [ -2, 2 ], "A_{2}" ], [ "A3", [ -2, 2 ], "A_{3}" ], [ "A4", [ -2, 2 ], "A_{4}" ],
>                  [ "B1", [ -2, 2 ], "B_{1}" ], [ "B2", [ -2, 2 ], "B_{2}" ], [ "B3", [ -2, 2 ], "B_{3}" ], [ "B4", [ -2, 2 ], "B_{4}" ] ];;
gap> morphisms := [ [ "dA_1", [ 1, 2 ], 0, [ -2, 2 ], "\\partial_{A}^{1}" ],
>                    [ "dA_2", [ 2, 3 ], 0, [ -2, 2 ], "\\partial_{A}^{2}" ],
>                    [ "dA_3", [ 3, 4 ], 0, [ -2, 2 ], "\\partial_{A}^{3}" ],
>                    [ "dB_1", [ 5, 6 ], 0, [ -2, 2 ], "\\partial_{B}^{1}" ],
>                    [ "dB_2", [ 6, 7 ], 0, [ -2, 2 ], "\\partial_{B}^{2}" ],
>                    [ "dB_3", [ 7, 8 ], 0, [ -2, 2 ], "\\partial_{B}^{3}" ],
>                    [ "f1", [ 1, 5 ], 0, [ -2, 2 ], "f^{1}" ],
>                    [ "f2", [ 2, 6 ], 0, [ -2, 2 ], "f^{2}" ],
>                    [ "f3", [ 3, 7 ], 0, [ -2, 2 ], "f^{3}" ],
>                    [ "f4", [ 4, 8 ], 0, [ -2, 2 ], "f^{4}" ] ];;
gap> relations := [ [ "PreCompose( dA_1, dA_2 )", 1 ],
>    [ "PreCompose( dA_2, dA_3 )", 2 ],
>    [ "PreCompose( dB_1, dB_2 )", 5 ],
>    [ "PreCompose( dB_2, dB_3 )", 6 ],
>    [ "PreCompose( dA_1, f2 ) - PreCompose( f1, dB_1 )", 1 ],
>    [ "PreCompose( dA_2, f3 ) - PreCompose( f2, dB_2 )", 2 ],
>    [ "PreCompose( dA_3, f4 ) - PreCompose( f3, dB_3 )", 3 ],
>    [ "Differential( dA_1 )", 1 ],
>    [ "Differential( dA_2 )", 2 ],
>    [ "Differential( dA_3 )", 3 ],
>    [ "Differential( dB_1 )", 5 ],
>    [ "Differential( dB_2 )", 6 ],
>    [ "Differential( dB_3 )", 7 ],
>    [ "Differential( f1 )", 1 ],
>    [ "Differential( f2 )", 2 ],
>    [ "Differential( f3 )", 3 ],
>    [ "Differential( f4 )", 4 ],
>    ];;
gap> q := FinQuiver( "q(A1_m2,A1_m1,A1_0,A1_1,A1_2,A2_m2,A2_m1,A2_0,A2_1,A2_2,A3_m2,A3_m1,A3_0,A3_1,A3_2,A4_m2,A4_m1,A4_0,A4_1,A4_2,B1_m2,B1_m1,B1_0,B1_1,B1_2,B2_m2,B2_m1,B2_0,B2_1,B2_2,B3_m2,B3_m1,B3_0,B3_1,B3_2,B4_m2,B4_m1,B4_0,B4_1,B4_2)[dA1_m2:A1_m2->A1_m1,dA1_m1:A1_m1->A1_0,dA1_0:A1_0->A1_1,dA1_1:A1_1->A1_2,dA2_m2:A2_m2->A2_m1,dA2_m1:A2_m1->A2_0,dA2_0:A2_0->A2_1,dA2_1:A2_1->A2_2,dA3_m2:A3_m2->A3_m1,dA3_m1:A3_m1->A3_0,dA3_0:A3_0->A3_1,dA3_1:A3_1->A3_2,dA4_m2:A4_m2->A4_m1,dA4_m1:A4_m1->A4_0,dA4_0:A4_0->A4_1,dA4_1:A4_1->A4_2,dB1_m2:B1_m2->B1_m1,dB1_m1:B1_m1->B1_0,dB1_0:B1_0->B1_1,dB1_1:B1_1->B1_2,dB2_m2:B2_m2->B2_m1,dB2_m1:B2_m1->B2_0,dB2_0:B2_0->B2_1,dB2_1:B2_1->B2_2,dB3_m2:B3_m2->B3_m1,dB3_m1:B3_m1->B3_0,dB3_0:B3_0->B3_1,dB3_1:B3_1->B3_2,dB4_m2:B4_m2->B4_m1,dB4_m1:B4_m1->B4_0,dB4_0:B4_0->B4_1,dB4_1:B4_1->B4_2,dA_1_m2:A1_m2->A2_m2,dA_1_m1:A1_m1->A2_m1,dA_1_0:A1_0->A2_0,dA_1_1:A1_1->A2_1,dA_1_2:A1_2->A2_2,dA_2_m2:A2_m2->A3_m2,dA_2_m1:A2_m1->A3_m1,dA_2_0:A2_0->A3_0,dA_2_1:A2_1->A3_1,dA_2_2:A2_2->A3_2,dA_3_m2:A3_m2->A4_m2,dA_3_m1:A3_m1->A4_m1,dA_3_0:A3_0->A4_0,dA_3_1:A3_1->A4_1,dA_3_2:A3_2->A4_2,dB_1_m2:B1_m2->B2_m2,dB_1_m1:B1_m1->B2_m1,dB_1_0:B1_0->B2_0,dB_1_1:B1_1->B2_1,dB_1_2:B1_2->B2_2,dB_2_m2:B2_m2->B3_m2,dB_2_m1:B2_m1->B3_m1,dB_2_0:B2_0->B3_0,dB_2_1:B2_1->B3_1,dB_2_2:B2_2->B3_2,dB_3_m2:B3_m2->B4_m2,dB_3_m1:B3_m1->B4_m1,dB_3_0:B3_0->B4_0,dB_3_1:B3_1->B4_1,dB_3_2:B3_2->B4_2,f1_m2:A1_m2->B1_m2,f1_m1:A1_m1->B1_m1,f1_0:A1_0->B1_0,f1_1:A1_1->B1_1,f1_2:A1_2->B1_2,f2_m2:A2_m2->B2_m2,f2_m1:A2_m1->B2_m1,f2_0:A2_0->B2_0,f2_1:A2_1->B2_1,f2_2:A2_2->B2_2,f3_m2:A3_m2->B3_m2,f3_m1:A3_m1->B3_m1,f3_0:A3_0->B3_0,f3_1:A3_1->B3_1,f3_2:A3_2->B3_2,f4_m2:A4_m2->B4_m2,f4_m1:A4_m1->B4_m1,f4_0:A4_0->B4_0,f4_1:A4_1->B4_1,f4_2:A4_2->B4_2]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [
>    PreCompose( kF.dA1_m2, kF.dA1_m1 ),
>    PreCompose( kF.dA1_m1, kF.dA1_0 ),
>    PreCompose( kF.dA1_0, kF.dA1_1 ),
>    PreCompose( kF.dA2_m2, kF.dA2_m1 ),
>    PreCompose( kF.dA2_m1, kF.dA2_0 ),
>    PreCompose( kF.dA2_0, kF.dA2_1 ),
>    PreCompose( kF.dA3_m2, kF.dA3_m1 ),
>    PreCompose( kF.dA3_m1, kF.dA3_0 ),
>    PreCompose( kF.dA3_0, kF.dA3_1 ),
>    PreCompose( kF.dA4_m2, kF.dA4_m1 ),
>    PreCompose( kF.dA4_m1, kF.dA4_0 ),
>    PreCompose( kF.dA4_0, kF.dA4_1 ),
>    PreCompose( kF.dB1_m2, kF.dB1_m1 ),
>    PreCompose( kF.dB1_m1, kF.dB1_0 ),
>    PreCompose( kF.dB1_0, kF.dB1_1 ),
>    PreCompose( kF.dB2_m2, kF.dB2_m1 ),
>    PreCompose( kF.dB2_m1, kF.dB2_0 ),
>    PreCompose( kF.dB2_0, kF.dB2_1 ),
>    PreCompose( kF.dB3_m2, kF.dB3_m1 ),
>    PreCompose( kF.dB3_m1, kF.dB3_0 ),
>    PreCompose( kF.dB3_0, kF.dB3_1 ),
>    PreCompose( kF.dB4_m2, kF.dB4_m1 ),
>    PreCompose( kF.dB4_m1, kF.dB4_0 ),
>    PreCompose( kF.dB4_0, kF.dB4_1 ),
>    PreCompose( kF.dA_1_m2, kF.dA_2_m2 ),
>    PreCompose( kF.dA_1_m1, kF.dA_2_m1 ),
>    PreCompose( kF.dA_1_0, kF.dA_2_0 ),
>    PreCompose( kF.dA_1_1, kF.dA_2_1 ),
>    PreCompose( kF.dA_1_2, kF.dA_2_2 ),
>    PreCompose( kF.dA_2_m2, kF.dA_3_m2 ),
>    PreCompose( kF.dA_2_m1, kF.dA_3_m1 ),
>    PreCompose( kF.dA_2_0, kF.dA_3_0 ),
>    PreCompose( kF.dA_2_1, kF.dA_3_1 ),
>    PreCompose( kF.dA_2_2, kF.dA_3_2 ),
>    PreCompose( kF.dB_1_m2, kF.dB_2_m2 ),
>    PreCompose( kF.dB_1_m1, kF.dB_2_m1 ),
>    PreCompose( kF.dB_1_0, kF.dB_2_0 ),
>    PreCompose( kF.dB_1_1, kF.dB_2_1 ),
>    PreCompose( kF.dB_1_2, kF.dB_2_2 ),
>    PreCompose( kF.dB_2_m2, kF.dB_3_m2 ),
>    PreCompose( kF.dB_2_m1, kF.dB_3_m1 ),
>    PreCompose( kF.dB_2_0, kF.dB_3_0 ),
>    PreCompose( kF.dB_2_1, kF.dB_3_1 ),
>    PreCompose( kF.dB_2_2, kF.dB_3_2 ),
>    -PreCompose( kF.f1_m2, kF.dB_1_m2 ) + PreCompose( kF.dA_1_m2, kF.f2_m2 ),
>    -PreCompose( kF.f1_m1, kF.dB_1_m1 ) + PreCompose( kF.dA_1_m1, kF.f2_m1 ),
>    -PreCompose( kF.f1_0, kF.dB_1_0 ) + PreCompose( kF.dA_1_0, kF.f2_0 ),
>    -PreCompose( kF.f1_1, kF.dB_1_1 ) + PreCompose( kF.dA_1_1, kF.f2_1 ),
>    -PreCompose( kF.f1_2, kF.dB_1_2 ) + PreCompose( kF.dA_1_2, kF.f2_2 ),
>    -PreCompose( kF.f2_m2, kF.dB_2_m2 ) + PreCompose( kF.dA_2_m2, kF.f3_m2 ),
>    -PreCompose( kF.f2_m1, kF.dB_2_m1 ) + PreCompose( kF.dA_2_m1, kF.f3_m1 ),
>    -PreCompose( kF.f2_0, kF.dB_2_0 ) + PreCompose( kF.dA_2_0, kF.f3_0 ),
>    -PreCompose( kF.f2_1, kF.dB_2_1 ) + PreCompose( kF.dA_2_1, kF.f3_1 ),
>    -PreCompose( kF.f2_2, kF.dB_2_2 ) + PreCompose( kF.dA_2_2, kF.f3_2 ),
>    -PreCompose( kF.f3_m2, kF.dB_3_m2 ) + PreCompose( kF.dA_3_m2, kF.f4_m2 ),
>    -PreCompose( kF.f3_m1, kF.dB_3_m1 ) + PreCompose( kF.dA_3_m1, kF.f4_m1 ),
>    -PreCompose( kF.f3_0, kF.dB_3_0 ) + PreCompose( kF.dA_3_0, kF.f4_0 ),
>    -PreCompose( kF.f3_1, kF.dB_3_1 ) + PreCompose( kF.dA_3_1, kF.f4_1 ),
>    -PreCompose( kF.f3_2, kF.dB_3_2 ) + PreCompose( kF.dA_3_2, kF.f4_2 ),
>    -PreCompose( kF.dA_1_m2, kF.dA2_m2 ) + PreCompose( kF.dA1_m2, kF.dA_1_m1 ),
>    -PreCompose( kF.dA_1_m1, kF.dA2_m1 ) + PreCompose( kF.dA1_m1, kF.dA_1_0 ),
>    -PreCompose( kF.dA_1_0, kF.dA2_0 ) + PreCompose( kF.dA1_0, kF.dA_1_1 ),
>    -PreCompose( kF.dA_1_1, kF.dA2_1 ) + PreCompose( kF.dA1_1, kF.dA_1_2 ),
>    -PreCompose( kF.dA_2_m2, kF.dA3_m2 ) + PreCompose( kF.dA2_m2, kF.dA_2_m1 ),
>    -PreCompose( kF.dA_2_m1, kF.dA3_m1 ) + PreCompose( kF.dA2_m1, kF.dA_2_0 ),
>    -PreCompose( kF.dA_2_0, kF.dA3_0 ) + PreCompose( kF.dA2_0, kF.dA_2_1 ),
>    -PreCompose( kF.dA_2_1, kF.dA3_1 ) + PreCompose( kF.dA2_1, kF.dA_2_2 ),
>    -PreCompose( kF.dA_3_m2, kF.dA4_m2 ) + PreCompose( kF.dA3_m2, kF.dA_3_m1 ),
>    -PreCompose( kF.dA_3_m1, kF.dA4_m1 ) + PreCompose( kF.dA3_m1, kF.dA_3_0 ),
>    -PreCompose( kF.dA_3_0, kF.dA4_0 ) + PreCompose( kF.dA3_0, kF.dA_3_1 ),
>    -PreCompose( kF.dA_3_1, kF.dA4_1 ) + PreCompose( kF.dA3_1, kF.dA_3_2 ),
>    -PreCompose( kF.dB_1_m2, kF.dB2_m2 ) + PreCompose( kF.dB1_m2, kF.dB_1_m1 ),
>    -PreCompose( kF.dB_1_m1, kF.dB2_m1 ) + PreCompose( kF.dB1_m1, kF.dB_1_0 ),
>    -PreCompose( kF.dB_1_0, kF.dB2_0 ) + PreCompose( kF.dB1_0, kF.dB_1_1 ),
>    -PreCompose( kF.dB_1_1, kF.dB2_1 ) + PreCompose( kF.dB1_1, kF.dB_1_2 ),
>    -PreCompose( kF.dB_2_m2, kF.dB3_m2 ) + PreCompose( kF.dB2_m2, kF.dB_2_m1 ),
>    -PreCompose( kF.dB_2_m1, kF.dB3_m1 ) + PreCompose( kF.dB2_m1, kF.dB_2_0 ),
>    -PreCompose( kF.dB_2_0, kF.dB3_0 ) + PreCompose( kF.dB2_0, kF.dB_2_1 ),
>    -PreCompose( kF.dB_2_1, kF.dB3_1 ) + PreCompose( kF.dB2_1, kF.dB_2_2 ),
>    -PreCompose( kF.dB_3_m2, kF.dB4_m2 ) + PreCompose( kF.dB3_m2, kF.dB_3_m1 ),
>    -PreCompose( kF.dB_3_m1, kF.dB4_m1 ) + PreCompose( kF.dB3_m1, kF.dB_3_0 ),
>    -PreCompose( kF.dB_3_0, kF.dB4_0 ) + PreCompose( kF.dB3_0, kF.dB_3_1 ),
>    -PreCompose( kF.dB_3_1, kF.dB4_1 ) + PreCompose( kF.dB3_1, kF.dB_3_2 ),
>    -PreCompose( kF.f1_m2, kF.dB1_m2 ) + PreCompose( kF.dA1_m2, kF.f1_m1 ),
>    -PreCompose( kF.f1_m1, kF.dB1_m1 ) + PreCompose( kF.dA1_m1, kF.f1_0 ),
>    -PreCompose( kF.f1_0, kF.dB1_0 ) + PreCompose( kF.dA1_0, kF.f1_1 ),
>    -PreCompose( kF.f1_1, kF.dB1_1 ) + PreCompose( kF.dA1_1, kF.f1_2 ),
>    -PreCompose( kF.f2_m2, kF.dB2_m2 ) + PreCompose( kF.dA2_m2, kF.f2_m1 ),
>    -PreCompose( kF.f2_m1, kF.dB2_m1 ) + PreCompose( kF.dA2_m1, kF.f2_0 ),
>    -PreCompose( kF.f2_0, kF.dB2_0 ) + PreCompose( kF.dA2_0, kF.f2_1 ),
>    -PreCompose( kF.f2_1, kF.dB2_1 ) + PreCompose( kF.dA2_1, kF.f2_2 ),
>    -PreCompose( kF.f3_m2, kF.dB3_m2 ) + PreCompose( kF.dA3_m2, kF.f3_m1 ),
>    -PreCompose( kF.f3_m1, kF.dB3_m1 ) + PreCompose( kF.dA3_m1, kF.f3_0 ),
>    -PreCompose( kF.f3_0, kF.dB3_0 ) + PreCompose( kF.dA3_0, kF.f3_1 ),
>    -PreCompose( kF.f3_1, kF.dB3_1 ) + PreCompose( kF.dA3_1, kF.f3_2 ),
>    -PreCompose( kF.f4_m2, kF.dB4_m2 ) + PreCompose( kF.dA4_m2, kF.f4_m1 ),
>    -PreCompose( kF.f4_m1, kF.dB4_m1 ) + PreCompose( kF.dA4_m1, kF.f4_0 ),
>    -PreCompose( kF.f4_0, kF.dB4_0 ) + PreCompose( kF.dA4_0, kF.f4_1 ),
>    -PreCompose( kF.f4_1, kF.dB4_1 ) + PreCompose( kF.dA4_1, kF.f4_2 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> cochains_Aoid := ComplexesCategoryByCochains( Aoid );;
gap> cochains_cochains_Aoid := ComplexesCategoryByCochains( cochains_Aoid );;
gap> cochains_bicomplexes_Aoid := BicomplexesCategoryByCochains( Aoid );;
gap> Assert( 0, IsIdenticalObj( cochains_cochains_Aoid, ModelingCategory( cochains_bicomplexes_Aoid ) ) );
gap> A1 := CreateComplex( cochains_Aoid, List( [ oid.dA1_m2, oid.dA1_m1, oid.dA1_0, oid.dA1_1 ], m -> m / Aoid ), -2 );;
gap> A2 := CreateComplex( cochains_Aoid, List( [ oid.dA2_m2, oid.dA2_m1, oid.dA2_0, oid.dA2_1 ], m -> m / Aoid ), -2 );;
gap> A3 := CreateComplex( cochains_Aoid, List( [ oid.dA3_m2, oid.dA3_m1, oid.dA3_0, oid.dA3_1 ], m -> m / Aoid ), -2 );;
gap> A4 := CreateComplex( cochains_Aoid, List( [ oid.dA4_m2, oid.dA4_m1, oid.dA4_0, oid.dA4_1 ], m -> m / Aoid ), -2 );;
gap> B1 := CreateComplex( cochains_Aoid, List( [ oid.dB1_m2, oid.dB1_m1, oid.dB1_0, oid.dB1_1 ], m -> m / Aoid ), -2 );;
gap> B2 := CreateComplex( cochains_Aoid, List( [ oid.dB2_m2, oid.dB2_m1, oid.dB2_0, oid.dB2_1 ], m -> m / Aoid ), -2 );;
gap> B3 := CreateComplex( cochains_Aoid, List( [ oid.dB3_m2, oid.dB3_m1, oid.dB3_0, oid.dB3_1 ], m -> m / Aoid ), -2 );;
gap> B4 := CreateComplex( cochains_Aoid, List( [ oid.dB4_m2, oid.dB4_m1, oid.dB4_0, oid.dB4_1 ], m -> m / Aoid ), -2 );;
gap> dA_1 := CreateComplexMorphism( cochains_Aoid, A1, List( [ oid.dA_1_m2, oid.dA_1_m1, oid.dA_1_0, oid.dA_1_1, oid.dA_1_2 ], m -> m / Aoid ), -2, A2 );;
gap> dA_2 := CreateComplexMorphism( cochains_Aoid, A2, List( [ oid.dA_2_m2, oid.dA_2_m1, oid.dA_2_0, oid.dA_2_1, oid.dA_2_2 ], m -> m / Aoid ), -2, A3 );;
gap> dA_3 := CreateComplexMorphism( cochains_Aoid, A3, List( [ oid.dA_3_m2, oid.dA_3_m1, oid.dA_3_0, oid.dA_3_1, oid.dA_3_2 ], m -> m / Aoid ), -2, A4 );;
gap> dB_1 := CreateComplexMorphism( cochains_Aoid, B1, List( [ oid.dB_1_m2, oid.dB_1_m1, oid.dB_1_0, oid.dB_1_1, oid.dB_1_2 ], m -> m / Aoid ), -2, B2 );;
gap> dB_2 := CreateComplexMorphism( cochains_Aoid, B2, List( [ oid.dB_2_m2, oid.dB_2_m1, oid.dB_2_0, oid.dB_2_1, oid.dB_2_2 ], m -> m / Aoid ), -2, B3 );;
gap> dB_3 := CreateComplexMorphism( cochains_Aoid, B3, List( [ oid.dB_3_m2, oid.dB_3_m1, oid.dB_3_0, oid.dB_3_1, oid.dB_3_2 ], m -> m / Aoid ), -2, B4 );;
gap> f1 := CreateComplexMorphism( cochains_Aoid, A1, List( [ oid.f1_m2, oid.f1_m1, oid.f1_0, oid.f1_1, oid.f1_2 ], m -> m / Aoid ), -2, B1 );;
gap> f2 := CreateComplexMorphism( cochains_Aoid, A2, List( [ oid.f2_m2, oid.f2_m1, oid.f2_0, oid.f2_1, oid.f2_2 ], m -> m / Aoid ), -2, B2 );;
gap> f3 := CreateComplexMorphism( cochains_Aoid, A3, List( [ oid.f3_m2, oid.f3_m1, oid.f3_0, oid.f3_1, oid.f3_2 ], m -> m / Aoid ), -2, B3 );;
gap> f4 := CreateComplexMorphism( cochains_Aoid, A4, List( [ oid.f4_m2, oid.f4_m1, oid.f4_0, oid.f4_1, oid.f4_2 ], m -> m / Aoid ), -2, B4 );;
gap> A := CreateComplex( cochains_cochains_Aoid, [ dA_1, dA_2, dA_3 ], 1 );;
gap> B := CreateComplex( cochains_cochains_Aoid, [ dB_1, dB_2, dB_3 ], 1 );;
gap> f := CreateComplexMorphism( cochains_cochains_Aoid, A, [ f1, f2, f3, f4 ], 1, B );;
gap> Assert( 0, ForAll( [ A, B, f ], IsWellDefined ) );
gap> A := CreateBicomplex( cochains_bicomplexes_Aoid, A );;
gap> B := CreateBicomplex( cochains_bicomplexes_Aoid, B );;
gap> f := CreateBicomplexMorphism( cochains_bicomplexes_Aoid, f );;
gap> Assert( 0, ForAll( [ A, B, f ], IsWellDefined ) );
gap> total_f := TotalComplexFunctorial( TotalComplex(A), f, TotalComplex(B) );;
gap> Assert( 0, IsWellDefined( total_f ) );
gap> chains_bicomplexes_Aoid := BicomplexesCategoryByChains( Aoid );;
gap> A := CreateBicomplex( chains_bicomplexes_Aoid, A );;
gap> B := CreateBicomplex( chains_bicomplexes_Aoid, B );;
gap> f := CreateBicomplexMorphism( chains_bicomplexes_Aoid, f );;
gap> total_f := TotalComplexFunctorial( TotalComplex(A), f, TotalComplex(B) );;
gap> Assert( 0, IsWellDefined( total_f ) );

#
gap> STOP_TEST("total-complex-of-bicomplex-morphism-using-algebroids.tst", 1);
