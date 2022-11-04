gap> LoadPackage( "DerivedCategories", false );
true
gap> N := NanosecondsSinceEpoch( );;
gap> q := RightQuiver( "q",
>           [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
>           [ "x0", "x1", "x2", "y0", "y1", "y2" ],
>           [ 1, 1, 1, 2, 2, 2 ],
>           [ 2, 2, 2, 3, 3, 3 ]
>         );;
gap> field := HomalgFieldOfRationals( );;
gap> kq := PathAlgebra( field, q );;
gap> A := kq  / [ kq.x0*kq.y1-kq.x1*kq.y0, kq.x0*kq.y2-kq.x2*kq.y0, kq.x1*kq.y2-kq.x2*kq.y1 ];;
gap> B := EndomorphismAlgebra( CreateStrongExceptionalCollection( SetOfObjects( Algebroid( A ) ) ) );;
gap> Dimension( A ) = Dimension( B );
true
gap> if Dimension( A ) <> Dimension( B ) then
> Display( QuiverOfAlgebra( A ) );
> Display( A );
> fi;
