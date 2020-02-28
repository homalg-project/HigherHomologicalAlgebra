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

F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );

a := RandomObject( C, [ -3, 3, 3 ] );
F(G(a));
