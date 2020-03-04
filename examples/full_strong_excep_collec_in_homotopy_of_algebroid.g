ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
graded_lp := GradedLeftPresentations( S );
BB := BeilinsonFunctor3( S );
omegas := UnderlyingCategory( DefiningCategory( AsCapCategory( Range( BB ) ) ) );
collection := CreateExceptionalCollection( omegas : name_for_underlying_quiver := "quiver{Ω^2(2)-{3}->Ω^1(1)-{3}->Ω^0(0)}",
                                                    name_for_endomorphism_algebra := "End( ⊕ {Ω^i(i)|i=0,1,2} )"
                                                  );
algebroid := Algebroid( collection );
DeactivateCachingForCertainOperations( algebroid, operations_to_deactivate );
iso := IsomorphismIntoAlgebroid( collection );
iso := ExtendFunctorToAdditiveClosures( iso );
iso := ExtendFunctorToHomotopyCategories( iso );
BB := PreCompose( BB, iso );
################## start ##################################

o := TwistedGradedFreeModule( S, 0 );
L := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=-2,-1,0} )";
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

C := AmbientCategory( collection );
L := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );

quit;

# create object in the ambient category
a := RandomObject( C, [ -3, 3, 3 ] );

# take it by G and bring it back by F
FG_a := F(G(a));

# Embedding both of them in some derived category to compare homologies
L_a := L( a );
L_FG_a := L( FG_a );

# compute homologies
List( [ -3 .. 3 ], i -> [ HomologyAt( L_a, i ), HomologyAt( L_FG_a, i ) ] );

