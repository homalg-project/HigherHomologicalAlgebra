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
gap> I := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );;
gap> J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );; 
gap> vertices := Vertices( QuiverOfAlgebra( B ) );;
gap> objects := List( vertices, v -> ObjectInAlgebroid( algebroid, v ) );;
gap> N := 20;;
gap> for i in [ 1 .. N ] do
> A := Random( objects{ [ 1 .. Int( Size( objects )/2 ) + 1 ] } );
> B := Random( objects{ [ Int( Size( objects )/2 ) + 1 .. Size( objects ) ] } );
> H := HomomorphismStructureOnObjects( A, B );
> H := BasisOfExternalHom( DistinguishedObjectOfHomomorphismStructure( algebroid ), H );
> H := List( H, h -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( A, B, h ) );
> c := List( [ 1 .. Size( H ) ], k -> Random( [ -100 .. 100 ] ) );
> if IsEmpty( c ) then
>   continue;
> fi;
> c_H := c * H;
> I_H := List( H, h -> ApplyFunctor( I, h ) );
> if not IsEqualForMorphisms( c * I_H, ApplyFunctor( I, c_H ) ) then
>   Error( "Bug detected!" );
> fi;
> if not IsEqualForMorphisms( c_H, ApplyFunctor( J, c * I_H ) ) then
>  Error( "Bug detected" );
> fi;
> od;;
