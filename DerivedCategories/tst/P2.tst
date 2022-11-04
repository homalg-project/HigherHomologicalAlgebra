gap> LoadPackage( "DerivedCategories", false );
true
gap> q := RightQuiver( "q",
>           [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
>           [ "x0", "x1", "x2", "y0", "y1", "y2" ],
>           [ 1, 1, 1, 2, 2, 2 ],
>           [ 2, 2, 2, 3, 3, 3 ]
>         );;
gap> field := HomalgFieldOfRationals( );;
gap> kq := PathAlgebra( field, q );;
gap> A := kq  / [ kq.x0*kq.y1-kq.x1*kq.y0, kq.x0*kq.y2-kq.x2*kq.y0, kq.x1*kq.y2-kq.x2*kq.y1 ];;
gap> Dimension( A );
15
gap> QRows := QuiverRows( A );;
gap> a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 3 ] ], QRows );;
gap> a_m1 := QuiverRowsObject( [ [ q.("𝓞(1)"), 3 ] ], QRows );;
gap> a_m2 := QuiverRowsObject( [ [ q.("𝓞(2)"), 1 ] ], QRows );;
gap> d_0 := QuiverRowsMorphism(
>           a_0,
>           [
>             [ A.x1, -A.x0, Zero(A) ],
>             [ A.x2, Zero(A), -A.x0 ],
>             [ Zero(A), A.x2, -A.x1 ]
>           ],
>           a_m1
>         );;
gap> d_m1 := QuiverRowsMorphism(
>           a_m1,
>           [
>             [ A.y0 ],
>             [ A.y1 ],
>             [ A.y2 ]
>           ],
>           a_m2
>         );;
gap> 
gap> omega_0 := HomotopyCategoryObject( [ d_m1, d_0 ], -1 );;
gap> 
gap> a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 3 ] ], QRows );;
gap> a_m1 := QuiverRowsObject( [ [ q.("𝓞(1)"), 1 ] ], QRows );;
gap> d_0 := QuiverRowsMorphism(
>           a_0,
>           [
>             [ A.x0 ],
>             [ A.x1 ],
>             [ A.x2 ]
>           ],
>           a_m1
>         );;
gap> omega_1 := HomotopyCategoryObject( [ d_0 ], 0 );;
gap> a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 1 ] ], QRows );;
gap> d_0 := UniversalMorphismIntoZeroObject( a_0 );;
gap> omega_2 := HomotopyCategoryObject( [ d_0 ], 0 );;
gap> vl := [ "Ω^0(0)", "Ω^1(1)", "Ω^2(2)" ];;
gap> c := CreateStrongExceptionalCollection( [ omega_0, omega_1, omega_2 ] : vertices_labels := vl );;
gap> G := ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( c );;
gap> F := ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( c );;
gap> o0 := SourceOfFunctor( G ).( "𝓞(0)" );;
gap> FG_o0 := F( G( o0 ) );;
