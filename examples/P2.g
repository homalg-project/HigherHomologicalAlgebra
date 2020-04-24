ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

# create graded polynomial ring
S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P2 := CoherentSheavesOverProjectiveSpace( S );
twisted_omegas := UnderlyingCategory( DefiningCategory( RangeOfFunctor( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules( S ) ) ) );
Sh := SheafificationFunctor( coh_P2 );

o1 := [1] / rows;

# create a Beilinson functor from Freyd category into quiver algebraic model
U := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S );
algebra := EndomorphismAlgebraOfCotangentBeilinsonCollection( S );

U_o1 := U( o1 * freyd );
Display( U_o1 );

# or Interpret the output in the homotopy of the quiver representations over the opposite algebra
U_o1 := U( o1 * freyd ) * HomotopyCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) )
ViewHomotopyCategoryObject( U_o1 );

# or Interpret the output in the derived category of the quiver representations over the opposite algebra
U_o1 := U( o1 * freyd ) * DerivedCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) );

# or Interpret the output in the homotopy of the quiver rows
U_o1 := U( o1 * freyd ) * HomotopyCategory( QuiverRows( algebra ) );
Display( U_o1 );

# or Interpret the output in the homotopy of twisted cotangent modules
U_o1 := U( o1 * freyd ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) );

# or interpret the output in the homotopy of the freyd category
U_o1 := U( o1 * freyd ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd );
Display( U_o1 );

# or interpret the output in the homotopy of the graded rows, i.e., in terms of the collection O(-3),O(-2),O(-1)
U_o1 := U( o1 * freyd ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows );
Display( U_o1 );

# or interpret the output in the homotopy of graded left presentations
U_o1 := U( o1 * freyd ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows ) * HomotopyCategory( fpres );
ViewHomotopyCategoryObject( U_o1 );
