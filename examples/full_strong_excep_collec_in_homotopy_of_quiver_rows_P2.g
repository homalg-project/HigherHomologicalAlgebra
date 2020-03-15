ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
graded_lp := GradedLeftPresentations( S );
BB := BeilinsonFunctor3( S );
omegas := UnderlyingCategory( DefiningCategory( AsCapCategory( Range( BB ) ) ) );
name_for_quiver := "quiver{Ω^2(2)-{3}->Ω^1(1)-{3}->Ω^0(0)}";
name_for_algebra := "End( ⊕ {Ω^i(i)|i=0,1,2} )";
collection := CreateExceptionalCollection( omegas :
                name_for_underlying_quiver := name_for_quiver,
                  name_for_endomorphism_algebra := name_for_algebra );

A := EndomorphismAlgebra( collection );
algebroid := Algebroid( collection );
add_algebroid := AdditiveClosure( algebroid );
DeactivateCachingForCertainOperations( algebroid, operations_to_deactivate );
iso_1 := IsomorphismIntoAlgebroid( collection );
iso_1 := ExtendFunctorToAdditiveClosures( iso_1 );
iso_1 := ExtendFunctorToHomotopyCategories( iso_1 );
iso_2 := IsomorphismFunctorIntoQuiverRows( add_algebroid );
iso_2 := ExtendFunctorToHomotopyCategories( iso_2 );
BB := PreCompose( [ BB, iso_1, iso_2 ] );
################## start ##################################

o := TwistedGradedFreeModule( S, 0 );
l := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=-2,-1,0} )";
collection := CreateExceptionalCollection( l :
                name_for_underlying_quiver := name_for_quiver,
                  name_for_endomorphism_algebra := name_for_algebra );

C := AmbientCategory( collection );
D := AsCapCategory( Source( iso_2 ) );

I := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );

quit;

# create object in the ambient category
d := RandomObject( D, [ -3, 3, 3 ] );
c := iso_2( d );

# take it by G and bring it back by F
FG_c := F(G(c));

# Embedding both of them in some derived category to compare homologies
I_c := I( c );
I_FG_c := I( FG_c );

# compute homologies
List( [ -3 .. 3 ], j -> [ HomologyAt( I_c, j ), HomologyAt( I_FG_c, j ) ] );

