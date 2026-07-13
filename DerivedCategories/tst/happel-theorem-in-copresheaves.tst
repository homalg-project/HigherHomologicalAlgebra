gap> START_TEST("happel-theorem-in-copresheaves.tst");

gap> LoadPackage( "FunctorCategories", false );
true
gap> LoadPackage( "DerivedCategories", false );
true
gap> q := FinQuiver( "q(v1,v2,v3,v4)[a:v1->v2,b:v2->v4,c:v1->v3,d:v3->v4]" );;
gap> k := HomalgFieldOfRationals( );;
gap> F_q := PathCategory( q );;
gap> kF_q := k[F_q];;
gap> rho := [ PreCompose( kF_q.a, kF_q.b ) - PreCompose( kF_q.c, kF_q.d ) ];;
gap> B :=  kF_q / rho;;
gap> IsAdmissibleAlgebroid( B );;
gap> B := AlgebroidFromDataTables( B );;
gap> Assert( 0, IsAdmissibleAlgebroid( B ) );;
gap> AB := AdditiveClosure( B );;
gap> K_AB := HomotopyCategoryByCochains( AB );;
gap> coPSh_B := CoPreSheaves( B : overhead := false );;
gap> K_coPSh_B := HomotopyCategoryByCochains( coPSh_B : overhead := false );;
gap> D_coPSh_B := DerivedCategoryByCochains( coPSh_B : overhead := false );;
gap> I := ExtendFunctorToAdditiveClosureOfSource( CoYonedaEmbedding( B ) );;
gap> P1 := I( [ B.("v1") ] / AB );;
gap> P2 := I( [ B.("v2") ] / AB );;
gap> P3 := I( [ B.("v3") ] / AB );;
gap> P4 := I( [ B.("v4") ] / AB );;
gap> f := AdditiveClosureMorphism( [ B.("v2"), B.("v3") ] / AB, [ [ B.("b") ], [ B.("d") ] ], [ B.("v4") ] / AB );;
gap> U := KernelObject( I( f ) );;
gap> seq := CreateStrongExceptionalSequence( [ P1, U, P2, P3 ] );;
gap> seq_oid := AbstractionAlgebroid( seq );;
gap> Assert( 0, Dimension( seq_oid ) = 9 );
gap> H := ExtendFunctorToHomotopyCategoriesByCochains( HomFunctorOfStrongExceptionalSequence( seq ) );;
gap> T := ExtendFunctorToHomotopyCategoriesByCochains( TensorProductFunctorOfStrongExceptionalSequence( seq ) );;
gap> epsilon := ExtendNaturalTransformationToHomotopyCategoriesByCochains( CounitOfTensorHomAdjunction( seq ) );;
gap> KP4 := CreateComplex( K_coPSh_B, P4, 0 );;
gap> Assert( 0, IsQuasiIsomorphism( PreCompose( T(QuasiIsomorphismFromProjectiveResolution( H( KP4 ), true )), epsilon( KP4 ) ) ) );
gap> K_PSh := RangeOfFunctor( H );;
gap> PSh := DefiningCategory( K_PSh );;
gap> D := EquivalenceFromFullSubcategoryOfProjectivesObjectsIntoAdditiveClosureOfSource( PSh );;
gap> D := ExtendFunctorToHomotopyCategoriesByCochains( D );;
gap> L := LocalizationFunctorByProjectiveObjects( K_PSh );;
gap> Q := D( L( H( KP4 ) ) );;
gap> Assert( 0, IsWellDefined( Q ) );
gap> Assert( 0, RankOfObject( HomStructure( Q, Q ) ) = 1 );
gap> W := CreateComplex( K_coPSh_B, DirectSum( [ P1, U, P2, P3 ] ), 0 ) / D_coPSh_B;;
gap> Assert( 0, RankOfObject( HomStructure( W, W ) ) = 9 );
gap> Assert( 0, IsZeroForObjects( HomStructure( Shift( W, 1 ), W ) ) and IsZeroForObjects( HomStructure( Shift( W, -1 ), W ) ) );
gap> basis := BasisOfExternalHom( W, W );;
gap> Assert( 0, ForAll( basis, IsWellDefined ) );
gap> Assert( 0, IsCongruentForMorphisms( basis[1] + basis[2] - basis[1], basis[2] ) );
gap> Assert( 0, HomStructure( PreCompose( [ basis[1], basis[2], basis[3] ] ) ) = PreCompose( HomStructure( basis[2] ), HomStructure( basis[1], basis[3] ) ) );
gap> Assert( 0, CoefficientsOfMorphism( Sum( basis ) ) = [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ] );
gap> # @drop_example_in_Julia

#
gap> STOP_TEST("happel-theorem-in-copresheaves.tst", 1);
