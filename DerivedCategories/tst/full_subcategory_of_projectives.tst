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
gap> full := FullSubcategoryGeneratedByProjectiveObjects( cat );;
gap> I := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( cat );;
gap> projs := IndecProjRepresentations( A );;
gap> for k in [ 1 .. 3 ] do
> L := List( [ 1 .. 5 ], i -> Random( projs ) );; a := DirectSum( L );;
> L := List( [ 1 .. 5 ], i -> Random( projs ) );; b := DirectSum( L );;
> B := BasisOfExternalHom( a, b );;
> if IsEmpty( B ) then B := [ ZeroMorphism( a, b ) ]; fi;;
> B := List( B, m -> m/full );;
> C := List( [ 1 .. Size( B ) ], i -> Random( [ -100 .. 100 ] ) );;
> if not IsEqualForMorphisms( ApplyFunctor( I, C * B ), C * List( B, m -> ApplyFunctor( I, m ) ) ) then
> Error( "Bug found" );
> fi;
> od;;
