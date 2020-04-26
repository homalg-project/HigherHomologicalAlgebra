ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

# Create graded polynomial ring
Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x0..1" );

# Geometry
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P1 := CoherentSheavesOverProjectiveSpace( S );
twisted_omegas := FullSubcategoryGeneratedByTwistedCotangentModules( S );
Sh := SheafificationFunctor( coh_P1 );


# Create a Beilinson functor from Freyd category into quiver algebraic model
U := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S );
algebra := EndomorphismAlgebraOfCotangentBeilinsonCollection( S );

full := [ [1]/rows, [2]/rows ] / rows;
I := PreCompose( full/rows/freyd, U );

image := ImageOfFullyFaithfullFunctor( I );

c := CreateExceptionalCollection( image : vertices_labels := [ "𝓞 (1)", "𝓞 (2)" ] );
algebra_c := EndomorphismAlgebra( c );
algebroid_c := Algebroid( c );

quit;

o4 := [4]/rows;

# or in the homotopy of quiver rows over { Ω^0(0), Ω^1(1) }
o4 := U( [4]/rows * freyd );

# or in the homotopy of additive closure over { 𝓞 (1), 𝓞 (2) } using the replacement functor
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c);

# or embedd it in the homotopy category of the ambient category of c
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AmbientCategory( c ) );

# or in the homotopy of additive closure over the algebroid associated to { 𝓞 (1), 𝓞 (2) }
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AdditiveClosure( algebroid_c ) );

# or in the homotopy of quiver rows associated to { 𝓞 (1), 𝓞 (2) }
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AdditiveClosure( algebroid_c ) ) * HomotopyCategory( QuiverRows( algebra_c ) );

# or again in the homotopy category of additive closure of full
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AdditiveClosure( full ) );

# or better in the homotopy category of graded rows
o4 := U( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AdditiveClosure( full ) ) * HomotopyCategory( rows );

# or better in the homotopy category of freyd

o4 := ( [4]/rows * freyd ) * HomotopyCategory(c) * HomotopyCategory( AdditiveClosure( full ) ) * HomotopyCategory( rows );

