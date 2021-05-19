ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

#      -->      -->
# O(0) --> O(1) --> O(2)
#      -->      -->

k := HomalgFieldOfRationals( );
q := RightQuiver( "q",
          [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
          [ "x0", "x1", "x2", "y0", "y1", "y2" ],
          [ 1, 1, 1, 2, 2, 2 ],
          [ 2, 2, 2, 3, 3, 3 ]
        );

#q := RightQuiver( "q(3)[x0:1->2,x1:1->2,x2:1->2,y0:1->2,y1:1->2,y2:1->2]" );

kq := PathAlgebra( k, q );
A := kq  / [ kq.x0*kq.y1-kq.x1*kq.y0, kq.x0*kq.y2-kq.x2*kq.y0, kq.x1*kq.y2-kq.x2*kq.y1 ];
Dimension( A );
QRows := QuiverRows( A );

a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 3 ] ], QRows );
a_m1 := QuiverRowsObject( [ [ q.("𝓞(1)"), 3 ] ], QRows );
a_m2 := QuiverRowsObject( [ [ q.("𝓞(2)"), 1 ] ], QRows );
d_0 := QuiverRowsMorphism(
          a_0,
          [
            [ A.x1, -A.x0, Zero(A) ],
            [ A.x2, Zero(A), -A.x0 ],
            [ Zero(A), A.x2, -A.x1 ]
          ],
          a_m1
        );
d_m1 := QuiverRowsMorphism(
          a_m1,
          [
            [ A.y0 ],
            [ A.y1 ],
            [ A.y2 ]
          ],
          a_m2
        );

omega_0 := HomotopyCategoryObject( [ d_m1, d_0 ], -1 );

a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 3 ] ], QRows );
a_m1 := QuiverRowsObject( [ [ q.("𝓞(1)"), 1 ] ], QRows );
d_0 := QuiverRowsMorphism(
          a_0,
          [
            [ A.x0 ],
            [ A.x1 ],
            [ A.x2 ]
          ],
          a_m1
        );

omega_1 := HomotopyCategoryObject( [ d_0 ], 0 );

a_0 := QuiverRowsObject( [ [ q.("𝓞(0)"), 1 ] ], QRows );

d_0 := UniversalMorphismIntoZeroObject( a_0 );

omega_2 := HomotopyCategoryObject( [ d_0 ], 0 );

c := CreateStrongExcepptionalCollection( [ omega_0, omega_1, omega_2 ], [ "Ω^0(0)", "Ω^1(1)", "Ω^2(2)" ] );

G := ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( c );
F := ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( c );
I := EmbeddingFunctorIntoDerivedCategory( SourceOfFunctor( G ) );
J := EmbeddingFunctorIntoDerivedCategory( RangeOfFunctor( G ) );


o0 := SourceOfFunctor( G ).( "𝓞(0)" );
FG_o0 := F( G( o0 ) );

a := RandomObject( SourceOfFunctor(G), 3 );
FG_a := F( G( a ) );

a := I( a );
FG_a := I( FG_a );

List( HomologySupport( a ), i -> HomologyAt( a, i ) );
List( HomologySupport( FG_a ), i -> HomologyAt( FG_a, i ) );


