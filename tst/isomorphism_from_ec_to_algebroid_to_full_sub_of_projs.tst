
gap> field := HomalgFieldOfRationals( );;
gap> ok := false;;
gap> while ok = false do
> N := NanosecondsSinceEpoch( );;
> A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 4 + ( N mod 7 ), 8 + ( N mod 7 ), 4 + ( N mod 10) );;
> if Dimension( A ) > 0 then
> ok := true;
> fi;
> od;;
gap> cat := CategoryOfQuiverRepresentations( A );;
gap> Finalize( cat );;
gap> collection := CreateExceptionalCollection( IndecProjRepresentations( A ) );;
gap> B := EndomorphismAlgebraOfEC( collection );;
gap> algebroid := Algebroid( B );;
gap> F := IsomorphismFromFullSubcategoryGeneratedByECIntoAlgebroid( collection );;
gap> G := IsomorphismFromAlgebroidIntoFullSubcategoryGeneratedByEC( collection );;
gap> FG := PreCompose( F, G );;
gap> N := 20;;
gap> for i in [ 1 .. N ] do
> nr_vertices := NumberOfVertices( QuiverOfAlgebra( A ) );
> j := Random( [ 1 .. nr_vertices - 2 ] );
> p := Paths( collection, j, Random( [ j + 1 .. nr_vertices ] ) );
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
gap> I := IsomorphismFromAlgebroidIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverTheOppositeAlgebra( algebroid );;
gap> vertices := Vertices( QuiverOfAlgebra( B ) );;
gap> objects := List( vertices, v -> ObjectInAlgebroid( algebroid, v ) );;
gap> for i in [ 1 .. N ] do
> A := Random( objects{ [ 1 .. Int( Size( objects )/2 ) + 1 ] } );
> B := Random( objects{ [ Int( Size( objects )/2 ) + 1 .. Size( objects ) ] } );
> H := HomomorphismStructureOnObjects( A, B );
> H := BasisOfExternalHom( DistinguishedObjectOfHomomorphismStructure( algebroid ), H );
> H := List( H, h -> InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( A, B, h ) );
> c := List( [ 1 .. Size( H ) ], k -> Random( [ -100 .. 100 ] ) );
> if IsEmpty( c ) then
>   continue;
> fi;
> c_H := c * H;
> I_H := List( H, h -> ApplyFunctor( I, h ) );
> if not IsEqualForMorphisms( c * I_H, ApplyFunctor( I, c_H ) ) then
>   Error( "Bug detected!" );
> fi;
> od;;
