
gap> field := HomalgFieldOfRationals( );;
gap> ok := false;;
gap> while ok = false do
> N := NanosecondsSinceEpoch( );;
> A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreStrongExceptionalCollection( field, 4 + ( N mod 7 ), 8 + ( N mod 7 ), 4 + ( N mod 10) );;
> if Dimension( A ) > 0 then
> ok := true;
> fi;
> od;;
gap> cat := CategoryOfQuiverRepresentations( A );;
gap> collection := CreateStrongExceptionalCollection( IndecProjRepresentations( A ) );;
gap> B := EndomorphismAlgebra( collection );;
gap> algebroid := Algebroid( B );;
gap> F := IsomorphismOntoAlgebroid( collection );;
gap> G := IsomorphismFromAlgebroid( collection );;
gap> FG := PreCompose( F, G );;
gap> N := 20;;
gap> for i in [ 1 .. N ] do
> nr_vertices := NumberOfVertices( QuiverOfAlgebra( A ) );
> j := Random( [ 1 .. nr_vertices - 2 ] );
> p := AllPaths( collection, j, Random( [ j + 1 .. nr_vertices ] ) );
> if not IsEmpty( p ) then
>   c := List( [ 1 .. Size( p ) ], i -> Random( [ -100 .. 100 ] ) );
>   cp := c * p;
>   F_cp := ApplyFunctor( F, cp );
>   c_Fp := c * List( p, a -> ApplyFunctor( F, a ) );
>   if not IsEqualForMorphisms( F_cp, c_Fp ) then
>     Display( A );
>     Display( QuiverOfAlgebra( A ) );
>     Error( "Bug detected!" );
>   fi;
>   if not IsEqualForMorphisms( cp, ApplyFunctor( FG, cp ) ) then
>     Error( "Bug detected" );
>   fi;
> fi;
> od;;
