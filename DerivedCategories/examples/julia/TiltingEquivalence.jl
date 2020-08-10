
using HomalgProject

SizeScreen( [ 1000, 100 ] )

LoadPackage( "DerivedCategories" )

ReadPackage( g"DerivedCategories", g"examples/pre_settings.g" ); GAP.Globals.ENABLE_COLORS = true

ℚ = HomalgFieldOfRationals()

q = RightQuiver( "q",
          [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
          [ "x0", "x1", "x2", "y0", "y1", "y2" ],
          [ 1, 1, 1, 2, 2, 2 ],
          [ 2, 2, 2, 3, 3, 3 ] )

Qq = PathAlgebra( ℚ, q )

A = Qq / [ Qq.x0*Qq.y1-Qq.x1*Qq.y0, Qq.x0*Qq.y2-Qq.x2*Qq.y0, Qq.x1*Qq.y2-Qq.x2*Qq.y1 ];

SetName( A, g"End( 𝓞(0) ⊕ 𝓞(1) ⊕ 𝓞(2) )" ); A

Dimension( A )

Aop = OppositeAlgebra( A ); SetName( Aop, g"End( 𝓞(0) ⊕ 𝓞(1) ⊕ 𝓞(2) )^op" ); Aop

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

IsWellDefined( d_0 )

d_m1 = QuiverRowsMorphism(
          a_m1,
          [ [ A.y0 ],
            [ A.y1 ],
            [ A.y2 ] ],
          a_m2
        )

IsWellDefined( d_m1 )

Ω00 = HomotopyCategoryObject( [ d_m1, d_0 ], -1 )

IsWellDefined( Ω00 )

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

collection = CreateExceptionalCollection( [ Ω00, Ω11, Ω22 ], [ "Ω^0(0)", "Ω^1(1)", "Ω^2(2)" ] )

F = ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( collection )

Display( F )

HoEndT = SourceOfFunctor( F )

HoA = RangeOfFunctor( F )

G = ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( collection )

Display( G )

𝓞0 = SourceOfFunctor( G )."𝓞(0)"

𝓞1 = SourceOfFunctor( G )."𝓞(1)"

𝓞2 = SourceOfFunctor( G )."𝓞(2)"

Display( 𝓞0 )

G𝓞0 = G( 𝓞0 )

Display( G𝓞0 )

G𝓞1 = G( 𝓞1 )

Display( G𝓞1 )

G𝓞2 = G( 𝓞2 )

Display( G𝓞2 )

I = EmbeddingFunctorIntoDerivedCategory( HoA )

Display( I )

J = EmbeddingFunctorIntoDerivedCategory( HoEndT )

Display( J )

FΩ00 = F( HoEndT."Ω^0(0)" )

Display( FΩ00 )

Display( Ω00 )

FΩ11 = F( HoEndT."Ω^1(1)" )

FΩ22 = F( HoEndT."Ω^2(2)" )

IFΩ00 = I( FΩ00 )

HomologySupport( IFΩ00 )

IFΩ11 = I( FΩ11 )

HomologySupport( IFΩ11 )

IFΩ22 = I( FΩ22 )

HomologySupport( IFΩ22 )

JG𝓞0 = J( G𝓞0 )

HomologySupport( JG𝓞0 )

JG𝓞1 = J( G𝓞1 )

HomologySupport( JG𝓞1 )

JG𝓞2 = J( G𝓞2 )

HomologySupport( JG𝓞2 )


