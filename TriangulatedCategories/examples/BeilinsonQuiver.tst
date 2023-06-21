gap> field := HomalgFieldOfRationals( );;
gap> quiver := RightQuiver(
>             "quiver",
>             [ "O_0", "O_1", "O_2" ],
>             [ "x0", "x1", "x2", "y0",
>             "y1", "y2" ],
>             [ 1, 1, 1, 2, 2, 2 ],
>             [ 2, 2, 2, 3, 3, 3 ]
>           );;
gap> Qq := PathAlgebra( field, quiver );;
gap> A := QuotientOfPathAlgebra(
>   Qq,
>   [
>     Qq.x0 * Qq.y1 - Qq.x1 * Qq.y0,
>     Qq.x0 * Qq.y2 - Qq.x2 * Qq.y0,
>     Qq.x1 * Qq.y2 - Qq.x2 * Qq.y1,
>   ]
> );;
gap> C := Algebroid( A );
Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] )
gap> AC := AdditiveClosure( C );
Additive closure( Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) )
gap> Ho_AC := HomotopyCategory( AC );
Homotopy category( Additive closure( Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1),
-1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) ) )
gap> Tr := CategoryOfExactTriangles( Ho_AC );
Category of exact triangles( Homotopy category( Additive closure( Algebroid(
(Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) ) ) )
gap> I := EquivalenceOntoDerivedCategory( Ho_AC );
Equivalence functor from homotopy category onto derived category
