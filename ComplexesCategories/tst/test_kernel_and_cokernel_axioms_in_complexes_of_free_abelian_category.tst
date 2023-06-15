gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "S", [ -5, -1 ] ], [ "A", [ -4, 4 ] ], [ "B", [ -6, 2 ] ], [ "T", [ -5, 4 ] ] ];;
gap> morphisms := [  [ "zeta", [ 1, 2 ], 0, [ -3, -2 ], "\\zeta" ], [ "phi", [ 2, 3 ], 0, [ -3, 0 ], "\\phi" ], [ "tau", [ 3, 4 ], 0, [ -4, 1 ], "\\tau" ] ];;
gap> relations := [  [ "Differential( zeta )", 1 ], [ "Differential( phi )", 2 ], [ "Differential( tau )", 3 ], [ "PreCompose( zeta, phi )", 1 ], [ "PreCompose( phi, tau )", 2 ] ];;
gap> q := RightQuiver( "q(S_m5,S_m4,S_m3,S_m2,S_m1,A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,B_m6,B_m5,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,T_m5,T_m4,T_m3,T_m2,T_m1,T_0,T_1,T_2,T_3,T_4)[dS_m5:S_m5->S_m4,dS_m4:S_m4->S_m3,dS_m3:S_m3->S_m2,dS_m2:S_m2->S_m1,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,dB_m6:B_m6->B_m5,dB_m5:B_m5->B_m4,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dT_m5:T_m5->T_m4,dT_m4:T_m4->T_m3,dT_m3:T_m3->T_m2,dT_m2:T_m2->T_m1,dT_m1:T_m1->T_0,dT_0:T_0->T_1,dT_1:T_1->T_2,dT_2:T_2->T_3,dT_3:T_3->T_4,zeta_m3:S_m3->A_m3,zeta_m2:S_m2->A_m2,phi_m3:A_m3->B_m3,phi_m2:A_m2->B_m2,phi_m1:A_m1->B_m1,phi_0:A_0->B_0,tau_m4:B_m4->T_m4,tau_m3:B_m3->T_m3,tau_m2:B_m2->T_m2,tau_m1:B_m1->T_m1,tau_0:B_0->T_0,tau_1:B_1->T_1]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [   PreCompose(dS_m5,dS_m4),
>    PreCompose(dS_m4,dS_m3),
>    PreCompose(dS_m3,dS_m2),
>    PreCompose(dA_m4,dA_m3),
>    PreCompose(dA_m3,dA_m2),
>    PreCompose(dA_m2,dA_m1),
>    PreCompose(dA_m1,dA_0),
>    PreCompose(dA_0,dA_1),
>    PreCompose(dA_1,dA_2),
>    PreCompose(dA_2,dA_3),
>    PreCompose(dB_m6,dB_m5),
>    PreCompose(dB_m5,dB_m4),
>    PreCompose(dB_m4,dB_m3),
>    PreCompose(dB_m3,dB_m2),
>    PreCompose(dB_m2,dB_m1),
>    PreCompose(dB_m1,dB_0),
>    PreCompose(dB_0,dB_1),
>    PreCompose(dT_m5,dT_m4),
>    PreCompose(dT_m4,dT_m3),
>    PreCompose(dT_m3,dT_m2),
>    PreCompose(dT_m2,dT_m1),
>    PreCompose(dT_m1,dT_0),
>    PreCompose(dT_0,dT_1),
>    PreCompose(dT_1,dT_2),
>    PreCompose(dT_2,dT_3),
>    PreCompose(dS_m4,zeta_m3),
>    PreCompose(zeta_m3,dA_m3) - PreCompose(dS_m3,zeta_m2),
>    PreCompose(zeta_m2,dA_m2),
>    PreCompose(dA_m4,phi_m3),
>    PreCompose(phi_m3,dB_m3) - PreCompose(dA_m3,phi_m2),
>    PreCompose(phi_m2,dB_m2) - PreCompose(dA_m2,phi_m1),
>    PreCompose(phi_m1,dB_m1) - PreCompose(dA_m1,phi_0),
>    PreCompose(phi_0,dB_0),
>    PreCompose(dB_m5,tau_m4),
>    PreCompose(tau_m4,dT_m4) - PreCompose(dB_m4,tau_m3),
>    PreCompose(tau_m3,dT_m3) - PreCompose(dB_m3,tau_m2),
>    PreCompose(tau_m2,dT_m2) - PreCompose(dB_m2,tau_m1),
>    PreCompose(tau_m1,dT_m1) - PreCompose(dB_m1,tau_0),
>    PreCompose(tau_0,dT_0) - PreCompose(dB_0,tau_1),
>    PreCompose(tau_1,dT_1),
>    PreCompose(zeta_m3,phi_m3),
>    PreCompose(zeta_m2,phi_m2),
>    PreCompose(phi_m3,tau_m3),
>    PreCompose(phi_m2,tau_m2),
>    PreCompose(phi_m1,tau_m1),
>    PreCompose(phi_0,tau_0) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         CreateComplex(
>            ch_AAoid,
>            List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>              i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            object_info[2][1] ) );
>    od;
gap> for morphism_info in morphisms do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            ch_AAoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            morphism_info[4][1],
>            EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
gap> Assert( 0, CohomologySupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, ObjectsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, DifferentialsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) - 1 ] );
gap> Assert( 0, ForAll( [ zeta, phi, tau ], IsWellDefined ) and ForAll( [ PreCompose( zeta, phi ), PreCompose( phi, tau ) ], IsZeroForMorphisms ) );
gap> Assert( 0, ForAll( [ CokernelColift( phi, tau ), KernelLift( phi, zeta ) ], IsWellDefined ) );
gap> Assert( 0, IsZero( tau - PreCompose( CokernelProjection( phi ), CokernelColift( phi, tau ) ) ) and IsZero( zeta - PostCompose( KernelEmbedding( phi ), KernelLift( phi, zeta ) ) ) );
gap> Assert( 0, RankOfObject( HomStructure( S, KernelObject( phi ) ) ) = RankOfObject( HomStructure( CokernelObject( phi ), T ) ) );
gap> iota := ImageEmbedding( phi );; pi := CoimageProjection( phi );;
gap> Assert( 0, ForAll( [ iota, pi ], IsWellDefined ) and IsMonomorphism( iota ) and IsEpimorphism( pi ) );
gap> Assert( 0, Length( LaTeXOutput( A ) ) = 4131 );
gap> Assert( 0, Length( LaTeXOutput( AsChainComplex( A ) ) ) = 4146 );
gap> Assert( 0, Length( LaTeXOutput( phi ) ) = 14104 );
gap> Assert( 0, Length( LaTeXOutput( AsChainComplexMorphism( phi ) ) ) = 14107 );
gap> SetInfoLevel( InfoWarning, 1 );
