
using HomalgProject

SizeScreen( [ 1000, 100 ] )

LoadPackage( "DerivedCategories" )

ReadPackage( g"DerivedCategories", g"examples/pre_settings.g" ); GAP.Globals.ENABLE_COLORS = true

ℚ = HomalgFieldOfRationals()

q = RightQuiver( "q_𝓞",
          [ "𝓞(0)", "𝓞(1)", "𝓞(2)" ],
          [ "x0", "x1", "x2", "y0", "y1", "y2" ],
          [ 1, 1, 1, 2, 2, 2 ],
          [ 2, 2, 2, 3, 3, 3 ] )

Qq = PathAlgebra( ℚ, q )

EndT_𝓞 = Qq / [ Qq.x0*Qq.y1-Qq.x1*Qq.y0, Qq.x0*Qq.y2-Qq.x2*Qq.y0, Qq.x1*Qq.y2-Qq.x2*Qq.y1 ];

SetName( EndT_𝓞, g"End( 𝓞(0) ⊕ 𝓞(1) ⊕ 𝓞(2) )" ); EndT_𝓞

Dimension( EndT_𝓞 )

EndT_𝓞op = OppositeAlgebra( EndT_𝓞 ); SetName( EndT_𝓞op, g"End( 𝓞(0) ⊕ 𝓞(1) ⊕ 𝓞(2) )^op" ); EndT_𝓞op

QRows = QuiverRows( EndT_𝓞 )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 3 ] ], QRows )

a_m1 = QuiverRowsObject( [ [ q."𝓞(1)", 3 ] ], QRows )

a_m2 = QuiverRowsObject( [ [ q."𝓞(2)", 1 ] ], QRows )

d_0 = QuiverRowsMorphism(
          a_0,
          [ [ EndT_𝓞.x1, -EndT_𝓞.x0, Zero(EndT_𝓞) ],
            [ EndT_𝓞.x2, Zero(EndT_𝓞), -EndT_𝓞.x0 ],
            [ Zero(EndT_𝓞), EndT_𝓞.x2, -EndT_𝓞.x1 ] ],
          a_m1 )

IsWellDefined( d_0 )

d_m1 = QuiverRowsMorphism(
          a_m1,
          [ [ EndT_𝓞.y0 ],
            [ EndT_𝓞.y1 ],
            [ EndT_𝓞.y2 ] ],
          a_m2 )

IsWellDefined( d_m1 )

Ω00 = HomotopyCategoryObject( [ d_m1, d_0 ], -1 )

IsWellDefined( Ω00 )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 3 ] ], QRows )

a_m1 = QuiverRowsObject( [ [ q."𝓞(1)", 1 ] ], QRows )

d_0 = QuiverRowsMorphism(
          a_0,
          [ [ EndT_𝓞.x0 ],
            [ EndT_𝓞.x1 ],
            [ EndT_𝓞.x2 ] ],
          a_m1 )

Ω11 = HomotopyCategoryObject( [ d_0 ], 0 )

a_0 = QuiverRowsObject( [ [ q."𝓞(0)", 1 ] ], QRows )

d_0 = UniversalMorphismIntoZeroObject( a_0 )

Ω22 = HomotopyCategoryObject( [ d_0 ], 0 )

Ω = CreateExceptionalCollection( [ Ω00, Ω11, Ω22 ], [ "Ω^0(0)", "Ω^1(1)", "Ω^2(2)" ] )

EndT_Ω = EndomorphismAlgebra( Ω )

Dimension( EndT_Ω )

F = ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( Ω )

Display( F )

HoEndT_Ω = SourceOfFunctor( F )

HoEndT_𝓞 = RangeOfFunctor( F )

G = ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( Ω )

Display( G )

𝓞0 = HoEndT_𝓞."𝓞(0)"

𝓞1 = HoEndT_𝓞."𝓞(1)"

𝓞2 = HoEndT_𝓞."𝓞(2)"

Display( 𝓞0 )

G𝓞0 = G( 𝓞0 )

Display( G𝓞0 )

G𝓞1 = G( 𝓞1 )

Display( G𝓞1 )

G𝓞2 = G( 𝓞2 )

Display( G𝓞2 )

FΩ00 = F( HoEndT_Ω."Ω^0(0)" )

Display( FΩ00 )

Display( Ω00 )

FΩ11 = F( HoEndT_Ω."Ω^1(1)" )

FΩ22 = F( HoEndT_Ω."Ω^2(2)" )

I = EmbeddingFunctorIntoDerivedCategory( HoEndT_𝓞 )

Display( I )

J = EmbeddingFunctorIntoDerivedCategory( HoEndT_Ω )

Display( J )

IFΩ00 = I( FΩ00 )

HomologySupport( IFΩ00 )

IFΩ11 = I( FΩ11 )

HomologySupport( IFΩ11 )

IFΩ22 = I( FΩ22 )

HomologySupport( IFΩ22 )

JG𝓞0 = J( G𝓞0 )

HomologySupport( JG𝓞0 )

DimensionVector( HomologyAt( JG𝓞0, 0 ) )

JG𝓞1 = J( G𝓞1 )

HomologySupport( JG𝓞1 )

DimensionVector( HomologyAt( JG𝓞1, 0 ) )

JG𝓞2 = J( G𝓞2 )

HomologySupport( JG𝓞2 )

HomologyAt( JG𝓞2, 0 )

a = RandomObject( HoEndT_𝓞, 2 )

Display( a )

FGa = F( G( a ) )

Display( FGa )

Ia = I( a )

suppIa = HomologySupport( Ia )

List( suppIa, i -> HomologyAt( Ia, i ) )

IFGa = I( FGa )

suppIFGa = HomologySupport( IFGa )

List( suppIa, i -> HomologyAt( IFGa, i ) )

Length( BasisOfExternalHom( a, FGa ) )

Length( BasisOfExternalHom( Ia, IFGa ) )


