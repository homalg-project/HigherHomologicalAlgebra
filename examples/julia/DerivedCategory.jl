
using HomalgProject

LoadPackage( "DerivedCategories" )

ReadPackage( g"DerivedCategories", g"examples/pre_settings.g" ); GAP.Globals.ENABLE_COLORS = true

GAP.Globals.ENABLE_COLORS = true

ℚ = GAP.Globals.field

q = RightQuiver( "q(3)[x0:1->2,x1:1->2,x2:1->2,y0:2->3,y1:2->3,y2:2->3]" )

q = RightQuiver( "q",
          [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
          [ "x0", "x1", "x2", "y0", "y1", "y2" ],
          [ 1, 1, 1, 2, 2, 2 ],
          [ 2, 2, 2, 3, 3, 3 ]
        )

Qq = PathAlgebra( ℚ, q )

A = Qq / ConvertJuliaToGAP( [ Qq.x0*Qq.y1-Qq.x1*Qq.y0, Qq.x0*Qq.y2-Qq.x2*Qq.y0, Qq.x1*Qq.y2-Qq.x2*Qq.y1 ] )

Dimension( A )

QRows = QuiverRows( A )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 3 ] ], QRows )

a_m1 = QuiverRowsObject( [ [ q."𝓞(1)", 3 ] ], QRows )

a_m2 = QuiverRowsObject( [ [ q."𝓞(2)", 1 ] ], QRows )

d_0 = QuiverRowsMorphism(
          a_0,
          [ [ A.x1, -A.x0, Zero(A) ],
            [ A.x2, Zero(A), -A.x0 ],
            [ Zero(A), A.x2, -A.x1 ] ],
          a_m1
        )

d_m1 = QuiverRowsMorphism(
          a_m1,
          [ [ A.y0 ],
            [ A.y1 ],
            [ A.y2 ] ],
          a_m2
        )

Ω00 = HomotopyCategoryObject( [ d_m1, d_0 ], -1 )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 3 ] ], QRows )

a_m1 = QuiverRowsObject( [ [ q."𝓞(1)", 1 ] ], QRows )

d_0 = QuiverRowsMorphism(
          a_0,
          [ [ A.x0 ],
            [ A.x1 ],
            [ A.x2 ] ],
          a_m1
        )

Ω11 = HomotopyCategoryObject( [ d_0 ], 0 )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 1 ] ], QRows )

d_0 = UniversalMorphismIntoZeroObject( a_0 )

Ω22 = HomotopyCategoryObject( [ d_0 ], 0 )

c = CreateExceptionalCollection( [ Ω00, Ω11, Ω22 ], [ "Ω^0(0)", "Ω^1(1)", "Ω^2(2)" ] )

F = ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( c )

Display( F )

G = ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( c )

Display( G )

I = EmbeddingFunctorIntoDerivedCategory( AmbientCategory( c ) )

Display( I )

𝓞0 = SourceOfFunctor( G )."𝓞(0)"

𝓞1 = SourceOfFunctor( G )."𝓞(1)"

𝓞2 = SourceOfFunctor( G )."𝓞(2)"

Display( 𝓞0 )

r𝓞0 = ApplyFunctor( G, 𝓞0 )
