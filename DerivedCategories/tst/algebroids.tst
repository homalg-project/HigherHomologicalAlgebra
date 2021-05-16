
gap> N := NanosecondsSinceEpoch( );;
gap> field := HomalgFieldOfRationals( );;
gap> A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreStrongExceptionalCollection( field, 2 + N mod 15, 2 + N mod 15, 2 + N mod 15 );;
gap> B := EndomorphismAlgebra( CreateStrongExceptionalCollection( SetOfObjects( Algebroid( A ) ) ) );;
gap> Dimension( A ) = Dimension( B );
true
gap> if Dimension( A ) <> Dimension( B ) then
> Display( QuiverOfAlgebra( A ) );
> Display( A );
> fi;
