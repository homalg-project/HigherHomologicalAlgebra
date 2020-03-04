ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
B := BeilinsonFunctor( S );
homotopy_reps_cat := AsCapCategory( Range( B ) );
reps_cat := DefiningCategory( homotopy_reps_cat );
Loc := LocalizationFunctorByProjectiveObjects( homotopy_reps_cat );
Eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( reps_cat );
Eq := ExtendFunctorToHomotopyCategories( Eq );
Loc := PreCompose( Loc, Eq );

################ create the collection o(-2), o(-1), o(0) as objects in abelian category #####################
o := TwistedGradedFreeModule( S, 0 );
l := List( [ -2, -1, 0 ], i -> ApplyFunctor( PreCompose( B, Loc ), o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=-2,-1,0} )";
collection := CreateExceptionalCollection(  l : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

C := AmbientCategory( collection );
F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );

I := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

quit;
a := Loc( RandomObject( homotopy_reps_cat, [ -1, 1, 2 ] ) );
FG_a := F(G(a));

I_a := I( a );
I_FG_a := I( FG_a );

List( [ -1 .. 1 ], j -> [ HomologyAt( I_a, j ), HomologyAt( I_FG_a, j ) ] );
