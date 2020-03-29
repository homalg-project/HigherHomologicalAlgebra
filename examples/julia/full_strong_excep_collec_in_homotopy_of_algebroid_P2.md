using HomalgProject
LoadPackageAndExposeGlobals( "DerivedCategories", Main, all_globals = true )
ReadPackage( g"DerivedCategories", g"examples/pre_settings.g" )
######################### start example #################################

S = GradedRing( HomalgFieldOfRationalsInSingular( ) * g"x0..2" )
B = BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S );
################## start ##################################

o = TwistedGradedFreeModule( S, 0 )
l = List( GAP.julia_to_gap( [ -2, -1, 0 ] ), i -> ApplyFunctor( B, o[ i ] ) )
name_for_quiver = g"quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}"
name_for_algebra = g"End( ⊕ {𝓞 (i)|i=-2,-1,0} )"
collection = CreateExceptionalCollection( l, name_for_underlying_quiver = name_for_quiver,
                                              name_for_endomorphism_algebra = name_for_algebra )

C = AmbientCategory( collection )
I = EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection )
Display( I )
F = ConvolutionFunctorFromHomotopyCategoryOfQuiverRows( collection )
Display( F )
G = ReplacementFunctorIntoHomotopyCategoryOfQuiverRows( collection )
Display( G )


# create object in the ambient category
a = RandomObject( C, GAP.julia_to_gap( [ -3, 3, 3 ] ) )
Display( a )

# take it by G and bring it back by F
G_a = G(a)
FG_a = F(G_a)
Display( FG_a )

# Embedding both of them in some derived category to compare homologies
I_a = I( a )
Display( I_a )

I_FG_a = I( FG_a )
Display( I_FG_a )

# compute homologies
List( GAP.julia_to_gap( -3:3 ), j -> GAP.julia_to_gap( [ HomologyAt( I_a, j ), HomologyAt( I_FG_a, j ) ] ) )

