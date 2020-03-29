ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..1" );

B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S );
################## start ##################################

o := TwistedGradedFreeModule( S, 0 );
l := List( [ -3, -2 ], i -> ApplyFunctor( B, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-3) -{2}-> 𝓞 (-2)}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=-3,-2} )";
collection := CreateExceptionalCollection( l : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

C := AmbientCategory( collection );
I := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

F := ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAlgebroid( collection );
G := ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( collection );

quit;

# create object in the ambient category
a := RandomObject( C, [ -3, 3, 3 ] );

# take it by G and bring it back by F
FG_a := F(G(a));

# Embedding both of them in some derived category to compare homologies
I_a := I( a );
I_FG_a := I( FG_a );

# compute homologies
List( [ -3 .. 3 ], j -> [ HomologyAt( I_a, j ), HomologyAt( I_FG_a, j ) ] );

