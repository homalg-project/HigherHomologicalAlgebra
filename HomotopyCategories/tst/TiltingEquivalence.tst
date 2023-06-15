gap> q_O := RightQuiver( "q_O(O0,O1,O2)[x0:O0->O1,x1:O0->O1,x2:O0->O1,y0:O1->O2,y1:O1->O2,y2:O1->O2]" );;
gap> SetLabelsAsLaTeXStrings( q_O,    [ "\\mathcal{O}_{0}", "\\mathcal{O}_{1}", "\\mathcal{O}_{2}" ], [ "x_0", "x_1", "x_2", "y_0", "y_1", "y_2" ] );;
gap> q_O_op := OppositeQuiver( q_O );;
gap> SetLabelsAsLaTeXStrings( q_O_op, [ "\\mathcal{O}_{0}", "\\mathcal{O}_{1}", "\\mathcal{O}_{2}" ], [ "x_0", "x_1", "x_2", "y_0", "y_1", "y_2" ] );;
gap> F_O := FreeCategory( q_O );;
gap> QQ := HomalgFieldOfRationals( );;
gap> k := QQ;;
gap> kF_O := k[F_O];;
gap> rho_O := [ PreCompose( kF_O.x0, kF_O.y1 ) - PreCompose( kF_O.x1, kF_O.y0 ), PreCompose( kF_O.x0, kF_O.y2 ) - PreCompose( kF_O.x2, kF_O.y0 ),
>                                               PreCompose( kF_O.x1, kF_O.y2 ) - PreCompose( kF_O.x2, kF_O.y1 ) ];;
gap> A_O := AlgebroidFromDataTables( kF_O / rho_O );;
gap> phi := 2 * A_O.x0 + 3 * A_O.x1 - A_O.x2;;
gap> A_Oadd := AdditiveClosure( A_O );;
gap> KA_Oadd := HomotopyCategoryByCochains( A_Oadd );;
gap> E10 := [ A_O.O0, A_O.O0, A_O.O0 ] / A_Oadd;;
gap> E11 := [ A_O.O1, A_O.O1, A_O.O1 ] / A_Oadd;;
gap> E12 := [ A_O.O2 ] / A_Oadd;;
gap> delta_0 := AdditiveClosureMorphism(
>        E10,
>        [ [ A_O.x1, -A_O.x0, ZeroMorphism(A_O.O0, A_O.O1) ],
>          [ A_O.x2, ZeroMorphism(A_O.O0, A_O.O1), -A_O.x0 ],
>          [ ZeroMorphism(A_O.O0, A_O.O1), A_O.x2, -A_O.x1 ] ],
>        E11 );;
gap> delta_1 := AdditiveClosureMorphism(
>        E11,
>        [ [ A_O.y0 ],
>          [ A_O.y1 ],
>          [ A_O.y2 ] ],
>        E12 );;
gap> E1 := CreateComplex( KA_Oadd, [ delta_0, delta_1 ], 0 );;
gap> E20 := [ A_O.O0, A_O.O0, A_O.O0 ] / A_Oadd;;
gap> E21 := [ A_O.O1] / A_Oadd;;
gap> delta_0 := AdditiveClosureMorphism(
>      E20,
>      [ [ A_O.x0 ],
>        [ A_O.x1 ],
>        [ A_O.x2 ] ],
>      E21 );;
gap> E2 := CreateComplex( KA_Oadd, [ delta_0 ], 0 );;
gap> E3 := CreateComplex( KA_Oadd, A_O.O0 / A_Oadd, 0 );;
gap> seq := CreateStrongExceptionalSequence( [ E1, E2, E3 ] );;
gap> T := DirectSum( [ E1, E2, E3 ] );;
gap> Assert( 0, RankOfObject( HomStructure( E1, E1 ) ) = 1 and
>               RankOfObject( HomStructure( E2, E2 ) ) = 1 and
>                 RankOfObject( HomStructure( E3, E3 ) ) = 1, true );
gap> Assert( 0, IsZero( HomStructure( E3, E2 ) ) and
>               IsZero( HomStructure( E2, E1 ) ) and
>                 IsZero( HomStructure( E3, E1 ) ), true );
gap> Assert( 0, IsZero( HomStructure( T, Shift( T, -2 ) ) ) and
>               IsZero( HomStructure( T, Shift( T, -1 ) ) ) and
>                 IsZero( HomStructure( T, Shift( T, 1 ) ) ) and
>                   IsZero( HomStructure( T, Shift( T, 2 ) ) ), true );
gap> Assert( 0, RankOfObject( HomStructure( T, T ) ) = 12 );
gap> A_E := AbstractionAlgebroid( seq );;
gap> q_E := UnderlyingQuiver( A_E );;
gap> B_E := UnderlyingQuiverAlgebra( A_E );;
gap> Assert( 0, Dimension( B_E ) = 12 );
gap> rho_E := RelationsOfAlgebroid( A_E );;
gap> a := IsomorphismIntoAbstractionAlgebroid( seq );;
gap> r := IsomorphismFromAbstractionAlgebroid( seq );;
gap> m := A_E.("m1_2_1");;
gap> Assert( 0, m = ApplyFunctor( a, ApplyFunctor( r, m ) ) );
gap> T_E := TriangulatedSubcategory( seq );;
gap> O0 := CreateComplex( KA_Oadd, A_O.("O0") / A_Oadd, 0 );;
gap> O1 := CreateComplex( KA_Oadd, A_O.("O1") / A_Oadd, 0 );;
gap> O2 := CreateComplex( KA_Oadd, A_O.("O2") / A_Oadd, 0 );;
gap> Assert( 0, IsWellDefined( AsSubcategoryCell( T_E, O0 ) ) and
>                 IsWellDefined( AsSubcategoryCell( T_E, O1 ) ) and
>                   IsWellDefined( AsSubcategoryCell( T_E, O2 ) ) = true );
gap> G := ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( seq );;
gap> F := ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( seq );;
gap> G_O0 := ApplyFunctor( G, O0 );;
gap> G_O1 := ApplyFunctor( G, O1 );;
gap> G_O2 := ApplyFunctor( G, O2 );;
gap> epsilon := CounitOfConvolutionReplacementAdjunction( seq );;
gap> epsilon_O0 := ApplyNaturalTransformation( epsilon, O0 );;
gap> epsilon_O1 := ApplyNaturalTransformation( epsilon, O1 );;
gap> epsilon_O2 := ApplyNaturalTransformation( epsilon, O2 );;
gap> Assert( 0, ForAll( [ epsilon_O0, epsilon_O1, epsilon_O2 ], IsIsomorphism ) = true );
gap> i := InverseForMorphisms( DirectSumFunctorial( [ epsilon_O0, epsilon_O1, epsilon_O2 ] ) );;
gap> Assert( 0, IsWellDefined( i ) and IsIsomorphism( i ) );
