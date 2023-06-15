gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, 5 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -5, 5 ] ] ];;
gap> morphisms := [ [ "x", [ 1, 2 ], -1, [ -1, 3 ], "x" ], [ "alpha", [ 1, 2 ], 0, [ -2, 2 ], "\\alpha" ], [ "y", [ 3, 4 ], -1, [ -2, 2 ], "y" ], [ "beta", [ 3, 4 ], 0, [ -2, 2 ], "\\beta" ] ];;
gap> relations := [  [ "alpha - Differential( x )", 1 ], [ "Differential( alpha )", 1 ], [ "beta - Differential( y )", 3 ], [ "Differential( beta )", 3 ] ];;
gap> q := RightQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,A_5,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m5,D_m4,D_m3,D_m2,D_m1,D_0,D_1,D_2,D_3,D_4,D_5)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,dA_4:A_4->A_5,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m5:D_m5->D_m4,dD_m4:D_m4->D_m3,dD_m3:D_m3->D_m2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,dD_2:D_2->D_3,dD_3:D_3->D_4,dD_4:D_4->D_5,x_m1:A_m1->B_m2,x_0:A_0->B_m1,x_1:A_1->B_0,x_2:A_2->B_1,x_3:A_3->B_2,alpha_m2:A_m2->B_m2,alpha_m1:A_m1->B_m1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,alpha_2:A_2->B_2,y_m2:C_m2->D_m3,y_m1:C_m1->D_m2,y_0:C_0->D_m1,y_1:C_1->D_0,y_2:C_2->D_1,beta_m2:C_m2->D_m2,beta_m1:C_m1->D_m1,beta_0:C_0->D_0,beta_1:C_1->D_1,beta_2:C_2->D_2]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [ PreCompose( dA_m5, dA_m4 ),
>    PreCompose( dA_m4, dA_m3 ),
>    PreCompose( dA_m3, dA_m2 ),
>    PreCompose( dA_m2, dA_m1 ),
>    PreCompose( dA_m1, dA_0 ),
>    PreCompose( dA_0, dA_1 ),
>    PreCompose( dA_1, dA_2 ),
>    PreCompose( dA_2, dA_3 ),
>    PreCompose( dA_3, dA_4 ),
>    PreCompose( dB_m2, dB_m1 ),
>    PreCompose( dB_m1, dB_0 ),
>    PreCompose( dB_0, dB_1 ),
>    PreCompose( dC_m2, dC_m1 ),
>    PreCompose( dC_m1, dC_0 ),
>    PreCompose( dC_0, dC_1 ),
>    PreCompose( dD_m5, dD_m4 ),
>    PreCompose( dD_m4, dD_m3 ),
>    PreCompose( dD_m3, dD_m2 ),
>    PreCompose( dD_m2, dD_m1 ),
>    PreCompose( dD_m1, dD_0 ),
>    PreCompose( dD_0, dD_1 ),
>    PreCompose( dD_1, dD_2 ),
>    PreCompose( dD_2, dD_3 ),
>    PreCompose( dD_3, dD_4 ),
>    -PreCompose( dA_m2, x_m1 ) + alpha_m2,
>    -PreCompose( x_m1, dB_m2 ) - PreCompose( dA_m1, x_0 ) + alpha_m1,
>    -PreCompose( x_0, dB_m1 ) - PreCompose( dA_0, x_1 ) + alpha_0,
>    -PreCompose( x_1, dB_0 ) - PreCompose( dA_1, x_2 ) + alpha_1,
>    -PreCompose( x_2, dB_1 ) - PreCompose( dA_2, x_3 ) + alpha_2,
>    PreCompose( dA_m3, alpha_m2 ),
>    -PreCompose( alpha_m2, dB_m2 ) + PreCompose( dA_m2, alpha_m1 ),
>    -PreCompose( alpha_m1, dB_m1 ) + PreCompose( dA_m1, alpha_0 ),
>    -PreCompose( alpha_0, dB_0 ) + PreCompose( dA_0, alpha_1 ),
>    -PreCompose( alpha_1, dB_1 ) + PreCompose( dA_1, alpha_2 ),
>    -PreCompose( y_m2, dD_m3 ) - PreCompose( dC_m2, y_m1 ) +  beta_m2,
>    -PreCompose( y_m1, dD_m2 ) - PreCompose( dC_m1, y_0 ) +  beta_m1,
>    -PreCompose( y_0, dD_m1 ) - PreCompose( dC_0, y_1 ) +  beta_0,
>    -PreCompose( y_1, dD_0 ) - PreCompose( dC_1, y_2 ) +  beta_1,
>    -PreCompose( y_2, dD_1 ) + beta_2,
>    -PreCompose( beta_m2, dD_m2 ) + PreCompose( dC_m2, beta_m1 ),
>    -PreCompose( beta_m1, dD_m1 ) + PreCompose( dC_m1, beta_0 ),
>    -PreCompose( beta_0, dD_0 ) + PreCompose( dC_0, beta_1 ),
>    -PreCompose( beta_1, dD_1 ) + PreCompose( dC_1, beta_2 ),
>    -PreCompose( beta_2, dD_2 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> Ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         CreateComplex(
>            Ch_AAoid,
>            List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>              i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            object_info[2][1] ) );
>    od;
gap> for morphism_info in [ morphisms[2], morphisms[4] ] do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            Ch_AAoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            morphism_info[4][1],
>            EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
gap> Assert( 0, ForAll( [ alpha, beta ], IsHomotopicToZeroMorphism ) );
gap> MorphismMatrix( MorphismDatum( WitnessForBeingHomotopicToZeroMorphism( DirectSumFunctorial( [ alpha, beta ] ) )[0] ) );
[ [ <1*x_0:(A_0) -≻ (B_m1)>, <0:(A_0) -≻ (D_m1)> ], [ <0:(C_0) -≻ (B_m1)>, <1*y_0:(C_0) -≻ (D_m1)> ] ]
gap> qA := QuasiIsomorphismFromProjectiveResolution( A, true );;
gap> qB := QuasiIsomorphismFromProjectiveResolution( B, true );;
gap> Aq :=  QuasiIsomorphismIntoInjectiveResolution( A, true );;
gap> Bq :=  QuasiIsomorphismIntoInjectiveResolution( B, true );;
gap> prj_res_alpha := MorphismBetweenProjectiveResolutions( alpha, true );;
gap> inj_res_alpha  := MorphismBetweenInjectiveResolutions( alpha, true );;
gap> Assert( 0, ForAll( [ qA, qB, Aq, Bq, prj_res_alpha, inj_res_alpha ], IsWellDefined ) );
gap> Assert( 0, PreCompose( qA, alpha ) = PreCompose( prj_res_alpha, qB ) and PostCompose( Bq, alpha ) = PostCompose( inj_res_alpha, Aq ) );
