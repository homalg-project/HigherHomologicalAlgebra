gap> q := RightQuiver( "q(v₁,v₂,v₃,v₄)[a:v₁->v₂,b:v₂->v₄,c:v₁->v₃,d:v₃->v₄]" );;
gap> k := HomalgFieldOfRationals();;
gap> F_q := FreeCategory( q );;
gap> kF_q := k[F_q];;
gap> rho := [ PreCompose( kF_q.a, kF_q.b ) - PreCompose( kF_q.c, kF_q.d ) ];;
gap> B :=  kF_q / rho;;
gap> AB := AdditiveClosure( B );;
gap> K_AB := HomotopyCategoryByCochains( AB );;
gap> coPSh_B := CoPreSheaves( B );;
gap> K_coPSh_B := HomotopyCategoryByCochains( coPSh_B );;
gap> D_coPSh_B := DerivedCategoryByCochains( coPSh_B );;
gap> I := ExtendFunctorToAdditiveClosureOfSource( CoYonedaEmbedding( B ) );;
gap> P1 := I( [ B.("v₁") ] / AB );;
gap> P2 := I( [ B.("v₂") ] / AB );;
gap> P3 := I( [ B.("v₃") ] / AB );;
gap> P4 := I( [ B.("v₄") ] / AB );;
gap> f := AdditiveClosureMorphism( [ B.("v₂"), B.("v₃") ] / AB, [ [ B.("b") ], [ B.("d") ] ], [ B.("v₄") ] / AB );;
gap> U := KernelObject( I( f ) );;
gap> seq := CreateStrongExceptionalSequence( [ P1, U, P2, P3 ] );;
gap> seq_oid := AbstractionAlgebroid( seq );;
gap> Dimension( UnderlyingQuiverAlgebra( seq_oid ) );
9
gap> H := ExtendFunctorToHomotopyCategoriesByCochains( HomFunctorOfStrongExceptionalSequence( seq ) );;
gap> T := ExtendFunctorToHomotopyCategoriesByCochains( TensorProductFunctorOfStrongExceptionalSequence( seq ) );;
gap> epsilon := ExtendNaturalTransformationToHomotopyCategoriesByCochains( CounitOfTensorHomAdjunction( seq ) );;
gap> KP4 := CreateComplex( K_coPSh_B, P4, 0 );;
gap> IsQuasiIsomorphism( PreCompose( T(QuasiIsomorphismFromProjectiveResolution( H( KP4 ), true )), epsilon( KP4 ) ) );
true
gap> K_PSh := RangeOfFunctor( H );;
gap> PSh := DefiningCategory( K_PSh );;
gap> D := EquivalenceFromFullSubcategoryOfProjectivesObjectsIntoAdditiveClosureOfSource( PSh );;
gap> D := ExtendFunctorToHomotopyCategoriesByCochains( D );;
gap> L := LocalizationFunctorByProjectiveObjects( K_PSh );;
gap> Q := D( L( H( KP4 ) ) );;
gap> IsWellDefined( Q );
true
gap> HomStructure( Q, Q );
<A row module over Q of rank 1>
gap> W := CreateComplex( K_coPSh_B, DirectSum( [ P1, U, P2, P3 ] ), 0 ) / D_coPSh_B;;
gap> RankOfObject( HomStructure( W, W ) );
9
gap> IsZero( HomStructure( Shift( W, 1 ), W ) ) and IsZero( HomStructure( Shift( W, -1 ), W ) );
true
