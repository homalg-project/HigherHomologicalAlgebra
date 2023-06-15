gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
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
gap> q := RightQuiver( "q(A1_m2,A1_m1,A1_0,A1_1,A1_2,A2_m2,A2_m1,A2_0,A2_1,A2_2,A3_m2,A3_m1,A3_0,A3_1,A3_2,A4_m2,A4_m1,A4_0,A4_1,A4_2,B1_m2,B1_m1,B1_0,B1_1,B1_2,B2_m2,B2_m1,B2_0,B2_1,B2_2,B3_m2,B3_m1,B3_0,B3_1,B3_2,B4_m2,B4_m1,B4_0,B4_1,B4_2)[dA1_m2:A1_m2->A1_m1,dA1_m1:A1_m1->A1_0,dA1_0:A1_0->A1_1,dA1_1:A1_1->A1_2,dA2_m2:A2_m2->A2_m1,dA2_m1:A2_m1->A2_0,dA2_0:A2_0->A2_1,dA2_1:A2_1->A2_2,dA3_m2:A3_m2->A3_m1,dA3_m1:A3_m1->A3_0,dA3_0:A3_0->A3_1,dA3_1:A3_1->A3_2,dA4_m2:A4_m2->A4_m1,dA4_m1:A4_m1->A4_0,dA4_0:A4_0->A4_1,dA4_1:A4_1->A4_2,dB1_m2:B1_m2->B1_m1,dB1_m1:B1_m1->B1_0,dB1_0:B1_0->B1_1,dB1_1:B1_1->B1_2,dB2_m2:B2_m2->B2_m1,dB2_m1:B2_m1->B2_0,dB2_0:B2_0->B2_1,dB2_1:B2_1->B2_2,dB3_m2:B3_m2->B3_m1,dB3_m1:B3_m1->B3_0,dB3_0:B3_0->B3_1,dB3_1:B3_1->B3_2,dB4_m2:B4_m2->B4_m1,dB4_m1:B4_m1->B4_0,dB4_0:B4_0->B4_1,dB4_1:B4_1->B4_2,dA_1_m2:A1_m2->A2_m2,dA_1_m1:A1_m1->A2_m1,dA_1_0:A1_0->A2_0,dA_1_1:A1_1->A2_1,dA_1_2:A1_2->A2_2,dA_2_m2:A2_m2->A3_m2,dA_2_m1:A2_m1->A3_m1,dA_2_0:A2_0->A3_0,dA_2_1:A2_1->A3_1,dA_2_2:A2_2->A3_2,dA_3_m2:A3_m2->A4_m2,dA_3_m1:A3_m1->A4_m1,dA_3_0:A3_0->A4_0,dA_3_1:A3_1->A4_1,dA_3_2:A3_2->A4_2,dB_1_m2:B1_m2->B2_m2,dB_1_m1:B1_m1->B2_m1,dB_1_0:B1_0->B2_0,dB_1_1:B1_1->B2_1,dB_1_2:B1_2->B2_2,dB_2_m2:B2_m2->B3_m2,dB_2_m1:B2_m1->B3_m1,dB_2_0:B2_0->B3_0,dB_2_1:B2_1->B3_1,dB_2_2:B2_2->B3_2,dB_3_m2:B3_m2->B4_m2,dB_3_m1:B3_m1->B4_m1,dB_3_0:B3_0->B4_0,dB_3_1:B3_1->B4_1,dB_3_2:B3_2->B4_2,f1_m2:A1_m2->B1_m2,f1_m1:A1_m1->B1_m1,f1_0:A1_0->B1_0,f1_1:A1_1->B1_1,f1_2:A1_2->B1_2,f2_m2:A2_m2->B2_m2,f2_m1:A2_m1->B2_m1,f2_0:A2_0->B2_0,f2_1:A2_1->B2_1,f2_2:A2_2->B2_2,f3_m2:A3_m2->B3_m2,f3_m1:A3_m1->B3_m1,f3_0:A3_0->B3_0,f3_1:A3_1->B3_1,f3_2:A3_2->B3_2,f4_m2:A4_m2->B4_m2,f4_m1:A4_m1->B4_m1,f4_0:A4_0->B4_0,f4_1:A4_1->B4_1,f4_2:A4_2->B4_2]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [ PreCompose( dA1_m2, dA1_m1 ),
>  PreCompose( dA1_m1, dA1_0 ),
>  PreCompose( dA1_0, dA1_1 ),
>  PreCompose( dA2_m2, dA2_m1 ),
>  PreCompose( dA2_m1, dA2_0 ),
>  PreCompose( dA2_0, dA2_1 ),
>  PreCompose( dA3_m2, dA3_m1 ),
>  PreCompose( dA3_m1, dA3_0 ),
>  PreCompose( dA3_0, dA3_1 ),
>  PreCompose( dA4_m2, dA4_m1 ),
>  PreCompose( dA4_m1, dA4_0 ),
>  PreCompose( dA4_0, dA4_1 ),
>  PreCompose( dB1_m2, dB1_m1 ),
>  PreCompose( dB1_m1, dB1_0 ),
>  PreCompose( dB1_0, dB1_1 ),
>  PreCompose( dB2_m2, dB2_m1 ),
>  PreCompose( dB2_m1, dB2_0 ),
>  PreCompose( dB2_0, dB2_1 ),
>  PreCompose( dB3_m2, dB3_m1 ),
>  PreCompose( dB3_m1, dB3_0 ),
>  PreCompose( dB3_0, dB3_1 ),
>  PreCompose( dB4_m2, dB4_m1 ),
>  PreCompose( dB4_m1, dB4_0 ),
>  PreCompose( dB4_0, dB4_1 ),
>  PreCompose( dA_1_m2, dA_2_m2 ),
>  PreCompose( dA_1_m1, dA_2_m1 ),
>  PreCompose( dA_1_0, dA_2_0 ),
>  PreCompose( dA_1_1, dA_2_1 ),
>  PreCompose( dA_1_2, dA_2_2 ),
>  PreCompose( dA_2_m2, dA_3_m2 ),
>  PreCompose( dA_2_m1, dA_3_m1 ),
>  PreCompose( dA_2_0, dA_3_0 ),
>  PreCompose( dA_2_1, dA_3_1 ),
>  PreCompose( dA_2_2, dA_3_2 ),
>  PreCompose( dB_1_m2, dB_2_m2 ),
>  PreCompose( dB_1_m1, dB_2_m1 ),
>  PreCompose( dB_1_0, dB_2_0 ),
>  PreCompose( dB_1_1, dB_2_1 ),
>  PreCompose( dB_1_2, dB_2_2 ),
>  PreCompose( dB_2_m2, dB_3_m2 ),
>  PreCompose( dB_2_m1, dB_3_m1 ),
>  PreCompose( dB_2_0, dB_3_0 ),
>  PreCompose( dB_2_1, dB_3_1 ),
>  PreCompose( dB_2_2, dB_3_2 ),
> -PreCompose( f1_m2, dB_1_m2 ) +  PreCompose( dA_1_m2, f2_m2 ),
> -PreCompose( f1_m1, dB_1_m1 ) +  PreCompose( dA_1_m1, f2_m1 ),
> -PreCompose( f1_0, dB_1_0 ) +  PreCompose( dA_1_0, f2_0 ),
> -PreCompose( f1_1, dB_1_1 ) +  PreCompose( dA_1_1, f2_1 ),
> -PreCompose( f1_2, dB_1_2 ) +  PreCompose( dA_1_2, f2_2 ),
> -PreCompose( f2_m2, dB_2_m2 ) +  PreCompose( dA_2_m2, f3_m2 ),
> -PreCompose( f2_m1, dB_2_m1 ) +  PreCompose( dA_2_m1, f3_m1 ),
> -PreCompose( f2_0, dB_2_0 ) +  PreCompose( dA_2_0, f3_0 ),
> -PreCompose( f2_1, dB_2_1 ) +  PreCompose( dA_2_1, f3_1 ),
> -PreCompose( f2_2, dB_2_2 ) +  PreCompose( dA_2_2, f3_2 ),
> -PreCompose( f3_m2, dB_3_m2 ) +  PreCompose( dA_3_m2, f4_m2 ),
> -PreCompose( f3_m1, dB_3_m1 ) +  PreCompose( dA_3_m1, f4_m1 ),
> -PreCompose( f3_0, dB_3_0 ) +  PreCompose( dA_3_0, f4_0 ),
> -PreCompose( f3_1, dB_3_1 ) +  PreCompose( dA_3_1, f4_1 ),
> -PreCompose( f3_2, dB_3_2 ) +  PreCompose( dA_3_2, f4_2 ),
> -PreCompose( dA_1_m2, dA2_m2 ) +  PreCompose( dA1_m2, dA_1_m1 ),
> -PreCompose( dA_1_m1, dA2_m1 ) +  PreCompose( dA1_m1, dA_1_0 ),
> -PreCompose( dA_1_0, dA2_0 ) +  PreCompose( dA1_0, dA_1_1 ),
> -PreCompose( dA_1_1, dA2_1 ) +  PreCompose( dA1_1, dA_1_2 ),
> -PreCompose( dA_2_m2, dA3_m2 ) +  PreCompose( dA2_m2, dA_2_m1 ),
> -PreCompose( dA_2_m1, dA3_m1 ) +  PreCompose( dA2_m1, dA_2_0 ),
> -PreCompose( dA_2_0, dA3_0 ) +  PreCompose( dA2_0, dA_2_1 ),
> -PreCompose( dA_2_1, dA3_1 ) +  PreCompose( dA2_1, dA_2_2 ),
> -PreCompose( dA_3_m2, dA4_m2 ) +  PreCompose( dA3_m2, dA_3_m1 ),
> -PreCompose( dA_3_m1, dA4_m1 ) +  PreCompose( dA3_m1, dA_3_0 ),
> -PreCompose( dA_3_0, dA4_0 ) +  PreCompose( dA3_0, dA_3_1 ),
> -PreCompose( dA_3_1, dA4_1 ) +  PreCompose( dA3_1, dA_3_2 ),
> -PreCompose( dB_1_m2, dB2_m2 ) +  PreCompose( dB1_m2, dB_1_m1 ),
> -PreCompose( dB_1_m1, dB2_m1 ) +  PreCompose( dB1_m1, dB_1_0 ),
> -PreCompose( dB_1_0, dB2_0 ) +  PreCompose( dB1_0, dB_1_1 ),
> -PreCompose( dB_1_1, dB2_1 ) +  PreCompose( dB1_1, dB_1_2 ),
> -PreCompose( dB_2_m2, dB3_m2 ) +  PreCompose( dB2_m2, dB_2_m1 ),
> -PreCompose( dB_2_m1, dB3_m1 ) +  PreCompose( dB2_m1, dB_2_0 ),
> -PreCompose( dB_2_0, dB3_0 ) +  PreCompose( dB2_0, dB_2_1 ),
> -PreCompose( dB_2_1, dB3_1 ) +  PreCompose( dB2_1, dB_2_2 ),
> -PreCompose( dB_3_m2, dB4_m2 ) +  PreCompose( dB3_m2, dB_3_m1 ),
> -PreCompose( dB_3_m1, dB4_m1 ) +  PreCompose( dB3_m1, dB_3_0 ),
> -PreCompose( dB_3_0, dB4_0 ) +  PreCompose( dB3_0, dB_3_1 ),
> -PreCompose( dB_3_1, dB4_1 ) +  PreCompose( dB3_1, dB_3_2 ),
> -PreCompose( f1_m2, dB1_m2 ) +  PreCompose( dA1_m2, f1_m1 ),
> -PreCompose( f1_m1, dB1_m1 ) +  PreCompose( dA1_m1, f1_0 ),
> -PreCompose( f1_0, dB1_0 ) +  PreCompose( dA1_0, f1_1 ),
> -PreCompose( f1_1, dB1_1 ) +  PreCompose( dA1_1, f1_2 ),
> -PreCompose( f2_m2, dB2_m2 ) +  PreCompose( dA2_m2, f2_m1 ),
> -PreCompose( f2_m1, dB2_m1 ) +  PreCompose( dA2_m1, f2_0 ),
> -PreCompose( f2_0, dB2_0 ) +  PreCompose( dA2_0, f2_1 ),
> -PreCompose( f2_1, dB2_1 ) +  PreCompose( dA2_1, f2_2 ),
> -PreCompose( f3_m2, dB3_m2 ) +  PreCompose( dA3_m2, f3_m1 ),
> -PreCompose( f3_m1, dB3_m1 ) +  PreCompose( dA3_m1, f3_0 ),
> -PreCompose( f3_0, dB3_0 ) +  PreCompose( dA3_0, f3_1 ),
> -PreCompose( f3_1, dB3_1 ) +  PreCompose( dA3_1, f3_2 ),
> -PreCompose( f4_m2, dB4_m2 ) +  PreCompose( dA4_m2, f4_m1 ),
> -PreCompose( f4_m1, dB4_m1 ) +  PreCompose( dA4_m1, f4_0 ),
> -PreCompose( f4_0, dB4_0 ) +  PreCompose( dA4_0, f4_1 ),
> -PreCompose( f4_1, dB4_1 ) +  PreCompose( dA4_1, f4_2) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> cochains_Aoid := ComplexesCategoryByCochains( Aoid );;
gap> cochains_cochains_Aoid := ComplexesCategoryByCochains( cochains_Aoid );;
gap> cochains_bicomplexes_Aoid := BicomplexesCategoryByCochains( Aoid );;
gap> Assert( 0, IsIdenticalObj( cochains_cochains_Aoid, ModelingCategory( cochains_bicomplexes_Aoid ) ) );
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         CreateComplex(
>            cochains_Aoid,
>            List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>              i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid ),
>            object_info[2][1] ) );
>    od;
gap> for morphism_info in morphisms do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            cochains_Aoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid ),
>            morphism_info[4][1],
>            EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
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
