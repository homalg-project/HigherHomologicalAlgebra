ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfIndecProjectiveObjects( S );

########### create the collection o(-2), o(-1), o(0) ####################

o := TwistedGradedFreeModule( S, 0 );
l := List( [ -2, -1, 0 ], i -> ApplyFunctor( B, o[ i ] ) );
vertices_labels := [ "𝓞 (-2)", "𝓞 (-1)", "𝓞 (0)" ];
collection := CreateExceptionalCollection(  l : vertices_labels := vertices_labels );

C := AmbientCategory( collection );
F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );

I := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

quit;
# a := RandomObject( C, 3 );
# alpha := RandomMorphism( C, [ [-3,3,3], [-3,3,3], [3] ] );
# alpha := RandomMorphism( C, 3 );
a := RandomObject( C, [ -3, 3, 3 ] );

FG_a := F(G(a));

I_a := I( a );
I_FG_a := I( FG_a );

List( [ -1 .. 1 ], j -> [ HomologyAt( I_a, j ), HomologyAt( I_FG_a, j ) ] );
