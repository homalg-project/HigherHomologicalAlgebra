gap> LoadPackage( "Algebroids", false );;
gap> LoadPackage( "HomotopyCategories", false );;
gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -2, 2 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -2, 2 ] ], [ "E", [ -2, 2 ] ] ];;
gap> morphisms := [  [ "h0A",  [ 1, 2 ],  0, [-2, 2 ], "h_{0,A}" ],
>                    [ "h0B",  [ 2, 3 ],  0, [-2, 2 ], "h_{0,B}" ],
>                    [ "h0C",  [ 3, 4 ],  0, [-2, 2 ], "h_{0,C}" ],
>                    [ "h0D",  [ 4, 5 ],  0, [-2, 2 ], "h_{0,D}" ],
>                    [ "h1A", [ 1, 3 ], -1, [ -1, 2 ], "h_{1,A}" ],
>                    [ "h1B", [ 2, 4 ], -1, [ -1, 2 ], "h_{1,B}" ],
>                    [ "h1C", [ 3, 5 ], -1, [ -1, 2 ], "h_{1,C}" ],
>                    [ "h2A", [ 1, 4 ], -2, [ 0, 2 ], "h_{2,A}" ],
>                    [ "h2B", [ 2, 5 ], -2, [ 0, 2 ], "h_{2,B}" ],
>                    [ "h3A", [ 1, 5 ], -3, [ 1, 2 ], "h_{3,A}" ]
>                  ];;
gap> relations := [  [ "Differential( h0A )", 1 ],
>                    [ "Differential( h0B )", 2 ],
>                    [ "Differential( h0C )", 3 ],
>                    [ "Differential( h0D )", 4 ],
>                    [ "PreCompose( h0A, h0B ) - Differential( h1A )", 1 ],
>                    [ "PreCompose( h0B, h0C ) - Differential( h1B )", 2 ],
>                    [ "PreCompose( h0C, h0D ) - Differential( h1C )", 3 ],
>                    [ "PreCompose( h0A, h1B ) - PreCompose( h1A, h0C ) - Differential( h2A )", 1 ],
>                    [ "PreCompose( h0B, h1C ) - PreCompose( h1B, h0D ) - Differential( h2B )", 2 ],
>                    [ "PreCompose( h0A, h2B ) - PreCompose( h1A, h1C ) + PreCompose( h2A, h0D ) - Differential( h3A )", 1 ],
>                  ];;
gap> q := FinQuiver( "q(A_m2,A_m1,A_0,A_1,A_2,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m2,D_m1,D_0,D_1,D_2,E_m2,E_m1,E_0,E_1,E_2)[dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,dE_m2:E_m2->E_m1,dE_m1:E_m1->E_0,dE_0:E_0->E_1,dE_1:E_1->E_2,h0A_m2:A_m2->B_m2,h0A_m1:A_m1->B_m1,h0A_0:A_0->B_0,h0A_1:A_1->B_1,h0A_2:A_2->B_2,h0B_m2:B_m2->C_m2,h0B_m1:B_m1->C_m1,h0B_0:B_0->C_0,h0B_1:B_1->C_1,h0B_2:B_2->C_2,h0C_m2:C_m2->D_m2,h0C_m1:C_m1->D_m1,h0C_0:C_0->D_0,h0C_1:C_1->D_1,h0C_2:C_2->D_2,h0D_m2:D_m2->E_m2,h0D_m1:D_m1->E_m1,h0D_0:D_0->E_0,h0D_1:D_1->E_1,h0D_2:D_2->E_2,h1A_m1:A_m1->C_m2,h1A_0:A_0->C_m1,h1A_1:A_1->C_0,h1A_2:A_2->C_1,h1B_m1:B_m1->D_m2,h1B_0:B_0->D_m1,h1B_1:B_1->D_0,h1B_2:B_2->D_1,h1C_m1:C_m1->E_m2,h1C_0:C_0->E_m1,h1C_1:C_1->E_0,h1C_2:C_2->E_1,h2A_0:A_0->D_m2,h2A_1:A_1->D_m1,h2A_2:A_2->D_0,h2B_0:B_0->E_m2,h2B_1:B_1->E_m1,h2B_2:B_2->E_0,h3A_1:A_1->E_m2,h3A_2:A_2->E_m1]" );;
gap> o := [ "A^{-2}", "A^{-1}", "A^{0}", "A^{1}", "A^{2}", "B^{-2}", "B^{-1}", "B^{0}", "B^{1}", "B^{2}", "C^{-2}", "C^{-1}", "C^{0}", "C^{1}", "C^{2}", "D^{-2}", "D^{-1}", "D^{0}", "D^{1}", "D^{2}", "E^{-2}", "E^{-1}", "E^{0}", "E^{1}", "E^{2}" ];;
gap> m := [ "\\partial_{A}^{-2}", "\\partial_{A}^{-1}", "\\partial_{A}^{0}", "\\partial_{A}^{1}", "\\partial_{B}^{-2}", "\\partial_{B}^{-1}", "\\partial_{B}^{0}", "\\partial_{B}^{1}", "\\partial_{C}^{-2}", "\\partial_{C}^{-1}", "\\partial_{C}^{0}", "\\partial_{C}^{1}", "\\partial_{D}^{-2}", "\\partial_{D}^{-1}", "\\partial_{D}^{0}", "\\partial_{D}^{1}", "\\partial_{E}^{-2}", "\\partial_{E}^{-1}", "\\partial_{E}^{0}", "\\partial_{E}^{1}", "h_{0,A}^{-2}", "h_{0,A}^{-1}", "h_{0,A}^{0}", "h_{0,A}^{1}", "h_{0,A}^{2}", "h_{0,B}^{-2}", "h_{0,B}^{-1}", "h_{0,B}^{0}", "h_{0,B}^{1}", "h_{0,B}^{2}", "h_{0,C}^{-2}", "h_{0,C}^{-1}", "h_{0,C}^{0}", "h_{0,C}^{1}", "h_{0,C}^{2}", "h_{0,D}^{-2}", "h_{0,D}^{-1}", "h_{0,D}^{0}", "h_{0,D}^{1}", "h_{0,D}^{2}", "h_{1,A}^{-1}", "h_{1,A}^{0}", "h_{1,A}^{1}", "h_{1,A}^{2}", "h_{1,B}^{-1}", "h_{1,B}^{0}", "h_{1,B}^{1}", "h_{1,B}^{2}", "h_{1,C}^{-1}", "h_{1,C}^{0}", "h_{1,C}^{1}", "h_{1,C}^{2}", "h_{2,A}^{0}", "h_{2,A}^{1}", "h_{2,A}^{2}", "h_{2,B}^{0}", "h_{2,B}^{1}", "h_{2,B}^{2}", "h_{3,A}^{1}", "h_{3,A}^{2}" ];;
gap> SetLaTeXStringsOfObjects( q, o );;
gap> SetLaTeXStringsOfMorphisms( q, m );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [ PreCompose(dA_m2, dA_m1),
> PreCompose(dA_m1, dA_0),
> PreCompose(dA_0, dA_1),
> PreCompose(dB_m2, dB_m1),
> PreCompose(dB_m1, dB_0),
> PreCompose(dB_0, dB_1),
> PreCompose(dC_m2, dC_m1),
> PreCompose(dC_m1, dC_0),
> PreCompose(dC_0, dC_1),
> PreCompose(dD_m2, dD_m1),
> PreCompose(dD_m1, dD_0),
> PreCompose(dD_0, dD_1),
> PreCompose(dE_m2, dE_m1),
> PreCompose(dE_m1, dE_0),
> PreCompose(dE_0, dE_1),
> -PreCompose(h0A_m2, dB_m2) + PreCompose(dA_m2, h0A_m1),
> -PreCompose(h0A_m1, dB_m1) + PreCompose(dA_m1, h0A_0),
> -PreCompose(h0A_0, dB_0) + PreCompose(dA_0, h0A_1),
> -PreCompose(h0A_1, dB_1) + PreCompose(dA_1, h0A_2),
> -PreCompose(h0B_m2, dC_m2) + PreCompose(dB_m2, h0B_m1),
> -PreCompose(h0B_m1, dC_m1) + PreCompose(dB_m1, h0B_0),
> -PreCompose(h0B_0, dC_0) + PreCompose(dB_0, h0B_1),
> -PreCompose(h0B_1, dC_1) + PreCompose(dB_1, h0B_2),
> -PreCompose(h0C_m2, dD_m2) + PreCompose(dC_m2, h0C_m1),
> -PreCompose(h0C_m1, dD_m1) + PreCompose(dC_m1, h0C_0),
> -PreCompose(h0C_0, dD_0) + PreCompose(dC_0, h0C_1),
> -PreCompose(h0C_1, dD_1) + PreCompose(dC_1, h0C_2),
> -PreCompose(h0D_m2, dE_m2) + PreCompose(dD_m2, h0D_m1),
> -PreCompose(h0D_m1, dE_m1) + PreCompose(dD_m1, h0D_0),
> -PreCompose(h0D_0, dE_0) + PreCompose(dD_0, h0D_1),
> -PreCompose(h0D_1, dE_1) + PreCompose(dD_1, h0D_2),
> PreCompose(h0A_m2, h0B_m2) - PreCompose(dA_m2, h1A_m1),
> -PreCompose(h1A_m1, dC_m2) + PreCompose(h0A_m1, h0B_m1) - PreCompose(dA_m1, h1A_0),
> -PreCompose(h1A_0, dC_m1) + PreCompose(h0A_0, h0B_0) - PreCompose(dA_0, h1A_1),
> -PreCompose(h1A_1, dC_0) + PreCompose(h0A_1, h0B_1) - PreCompose(dA_1, h1A_2),
> -PreCompose(h1A_2, dC_1) + PreCompose(h0A_2, h0B_2),
> PreCompose(h0B_m2, h0C_m2) - PreCompose(dB_m2, h1B_m1),
> -PreCompose(h1B_m1, dD_m2) + PreCompose(h0B_m1, h0C_m1) - PreCompose(dB_m1, h1B_0),
> -PreCompose(h1B_0, dD_m1) + PreCompose(h0B_0, h0C_0) - PreCompose(dB_0, h1B_1),
> -PreCompose(h1B_1, dD_0) + PreCompose(h0B_1, h0C_1) - PreCompose(dB_1, h1B_2),
> -PreCompose(h1B_2, dD_1) + PreCompose(h0B_2, h0C_2),
> PreCompose(h0C_m2, h0D_m2) - PreCompose(dC_m2, h1C_m1),
> -PreCompose(h1C_m1, dE_m2) + PreCompose(h0C_m1, h0D_m1) - PreCompose(dC_m1, h1C_0),
> -PreCompose(h1C_0, dE_m1) + PreCompose(h0C_0, h0D_0) - PreCompose(dC_0, h1C_1),
> -PreCompose(h1C_1, dE_0) + PreCompose(h0C_1, h0D_1) - PreCompose(dC_1, h1C_2),
> -PreCompose(h1C_2, dE_1) + PreCompose(h0C_2, h0D_2),
> -PreCompose(h1A_m1, h0C_m2) + PreCompose(h0A_m1, h1B_m1) - PreCompose(dA_m1, h2A_0),
> PreCompose(h2A_0, dD_m2) - PreCompose(h1A_0, h0C_m1) + PreCompose(h0A_0, h1B_0) - PreCompose(dA_0, h2A_1),
> PreCompose(h2A_1, dD_m1) - PreCompose(h1A_1, h0C_0) + PreCompose(h0A_1, h1B_1) - PreCompose(dA_1, h2A_2),
> PreCompose(h2A_2, dD_0) - PreCompose(h1A_2, h0C_1) + PreCompose(h0A_2, h1B_2),
> -PreCompose(h1B_m1, h0D_m2) + PreCompose(h0B_m1, h1C_m1) - PreCompose(dB_m1, h2B_0),
> PreCompose(h2B_0, dE_m2) - PreCompose(h1B_0, h0D_m1) + PreCompose(h0B_0, h1C_0) - PreCompose(dB_0, h2B_1),
> PreCompose(h2B_1, dE_m1) - PreCompose(h1B_1, h0D_0) + PreCompose(h0B_1, h1C_1) - PreCompose(dB_1, h2B_2),
> PreCompose(h2B_2, dE_0) - PreCompose(h1B_2, h0D_1) + PreCompose(h0B_2, h1C_2),
> PreCompose(h2A_0, h0D_m2) - PreCompose(h1A_0, h1C_m1) + PreCompose(h0A_0, h2B_0) - PreCompose(dA_0, h3A_1),
> -PreCompose(h3A_1, dE_m2) + PreCompose(h2A_1, h0D_m1) - PreCompose(h1A_1, h1C_0) + PreCompose(h0A_1, h2B_1) - PreCompose(dA_1, h3A_2),
> -PreCompose(h3A_2, dE_m1) + PreCompose(h2A_2, h0D_0) - PreCompose(h1A_2, h1C_1) + PreCompose(h0A_2, h2B_2) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> cat := AdditiveClosure( oid );;
gap> homotopy_cat := HomotopyCategoryByCochains( cat );;
gap> complex_cat := UnderlyingCategory( homotopy_cat );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         ObjectConstructor(
>           homotopy_cat,
>           CreateComplex(
>             complex_cat,
>             List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>               i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / cat ),
>             object_info[2][1] ) ) );
>    od;
gap> for morphism_info in morphisms{[1..4]} do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         MorphismConstructor(
>           homotopy_cat,
>           EvalString( objects[morphism_info[2][1]][1] ),
>           CreateComplexMorphism(
>             complex_cat,
>             UnderlyingCell( EvalString( objects[morphism_info[2][1]][1] ) ),
>             List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / cat ),
>             morphism_info[4][1],
>             UnderlyingCell( EvalString( objects[morphism_info[2][2]][1] ) ) ),
>           EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
gap> IsWellDefined( Convolution( CreateComplex( HomotopyCategoryByCochains( homotopy_cat ), [ h0A, h0B, h0C, h0D ], 0 ) ) );
true
