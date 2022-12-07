gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, -1 ] ], [ "B", [ -4, 4 ] ], [ "U", [ -6, 2 ] ], [ "V", [ -5, 4 ] ] ];;
gap> morphisms := [  [ "alpha", [ 1, 2 ], 0, [ -3, -2 ], "\\alpha" ], [ "f", [ 1, 3 ], 0, [ -3, -1 ], "f" ], [ "nu", [ 3, 4 ], 0, [ -4, 1 ], "\\nu" ], [ "g", [ 2, 4 ], 0, [ -4, 1 ], "g" ] ];;
gap> relations := [  [ "Differential( alpha )", 1 ], [ "Differential( f )", 2 ], [ "Differential( nu )", 3 ], [ "Differential( g )", 3 ], [ "PreCompose( alpha, g )-PreCompose( f, nu )", 1 ] ];;
gap> q := RightQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,B_3,B_4,U_m6,U_m5,U_m4,U_m3,U_m2,U_m1,U_0,U_1,U_2,V_m5,V_m4,V_m3,V_m2,V_m1,V_0,V_1,V_2,V_3,V_4)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dB_2:B_2->B_3,dB_3:B_3->B_4,dU_m6:U_m6->U_m5,dU_m5:U_m5->U_m4,dU_m4:U_m4->U_m3,dU_m3:U_m3->U_m2,dU_m2:U_m2->U_m1,dU_m1:U_m1->U_0,dU_0:U_0->U_1,dU_1:U_1->U_2,dV_m5:V_m5->V_m4,dV_m4:V_m4->V_m3,dV_m3:V_m3->V_m2,dV_m2:V_m2->V_m1,dV_m1:V_m1->V_0,dV_0:V_0->V_1,dV_1:V_1->V_2,dV_2:V_2->V_3,dV_3:V_3->V_4,alpha_m3:A_m3->B_m3,alpha_m2:A_m2->B_m2,f_m3:A_m3->U_m3,f_m2:A_m2->U_m2,f_m1:A_m1->U_m1,nu_m4:U_m4->V_m4,nu_m3:U_m3->V_m3,nu_m2:U_m2->V_m2,nu_m1:U_m1->V_m1,nu_0:U_0->V_0,nu_1:U_1->V_1,g_m4:B_m4->V_m4,g_m3:B_m3->V_m3,g_m2:B_m2->V_m2,g_m1:B_m1->V_m1,g_0:B_0->V_0,g_1:B_1->V_1]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;

gap> rels := [ PreCompose( dA_m5, dA_m4 ),
> PreCompose( dA_m4, dA_m3 ),
> PreCompose( dA_m3, dA_m2 ),
> PreCompose( dB_m4, dB_m3 ),
> PreCompose( dB_m3, dB_m2 ),
> PreCompose( dB_m2, dB_m1 ),
> PreCompose( dB_m1, dB_0 ),
> PreCompose( dB_0, dB_1 ),
> PreCompose( dB_1, dB_2 ),
> PreCompose( dB_2, dB_3 ),
> PreCompose( dU_m6, dU_m5 ),
> PreCompose( dU_m5, dU_m4 ),
> PreCompose( dU_m4, dU_m3 ),
> PreCompose( dU_m3, dU_m2 ),
> PreCompose( dU_m2, dU_m1 ),
> PreCompose( dU_m1, dU_0 ),
> PreCompose( dU_0, dU_1 ),
> PreCompose( dV_m5, dV_m4 ),
> PreCompose( dV_m4, dV_m3 ),
> PreCompose( dV_m3, dV_m2 ),
> PreCompose( dV_m2, dV_m1 ),
> PreCompose( dV_m1, dV_0 ),
> PreCompose( dV_0, dV_1 ),
> PreCompose( dV_1, dV_2 ),
> PreCompose( dV_2, dV_3 ),
> PreCompose( dA_m4, alpha_m3 ),
> PreCompose( alpha_m3, dB_m3 ) - PreCompose( dA_m3, alpha_m2 ),
> PreCompose( alpha_m2, dB_m2 ),
> PreCompose( dA_m4, f_m3 ),
> PreCompose( f_m3, dU_m3 ) - PreCompose( dA_m3, f_m2 ),
> PreCompose( f_m2, dU_m2 ) - PreCompose( dA_m2, f_m1 ),
> PreCompose( f_m1, dU_m1 ),
> PreCompose( dU_m5, nu_m4 ),
> PreCompose( nu_m4, dV_m4 ) - PreCompose( dU_m4, nu_m3 ),
> PreCompose( nu_m3, dV_m3 ) - PreCompose( dU_m3, nu_m2 ),
> PreCompose( nu_m2, dV_m2 ) - PreCompose( dU_m2, nu_m1 ),
> PreCompose( nu_m1, dV_m1 ) - PreCompose( dU_m1, nu_0 ),
> PreCompose( nu_0, dV_0 ) - PreCompose( dU_0, nu_1 ),
> PreCompose( nu_1, dV_1 ),
> PreCompose( g_m4, dV_m4 ) - PreCompose( dB_m4, g_m3 ),
> PreCompose( g_m3, dV_m3 ) - PreCompose( dB_m3, g_m2 ),
> PreCompose( g_m2, dV_m2 ) - PreCompose( dB_m2, g_m1 ),
> PreCompose( g_m1, dV_m1 ) - PreCompose( dB_m1, g_0 ),
> PreCompose( g_0, dV_0 ) - PreCompose( dB_0, g_1 ),
> PreCompose( g_1, dV_1 ),
> PreCompose( f_m3, nu_m3 ) - PreCompose( alpha_m3, g_m3 ),
> PreCompose( f_m2, nu_m2 ) - PreCompose( alpha_m2, g_m2 ),
> PreCompose( f_m1, nu_m1 ) ];;

gap> oid := kF / rels;;
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
gap> for morphism_info in morphisms do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            Ch_AAoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            EvalString( objects[morphism_info[2][2]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            morphism_info[4][1] ) );
>    od;
gap> ForAll( [ f, g, alpha, nu ], IsWellDefined ) and IsZeroForMorphisms( PreCompose( alpha, g ) - PreCompose( f, nu ) );
true
gap> lambda := KernelObjectFunctorial( alpha, f, nu );;
gap> IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( KernelEmbedding( alpha ), f ) - PreCompose( lambda, KernelEmbedding( nu ) ) );
true
gap> lambda := CokernelObjectFunctorial( alpha, g, nu );;
gap> IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( CokernelProjection( alpha ), lambda ) - PreCompose( g, CokernelProjection( nu ) ) );
true
gap> SetInfoLevel( InfoWarning, 1 );
