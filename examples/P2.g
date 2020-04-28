ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

# Create graded polynomial ring
Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x0..2" );

# Geometry
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P2 := CoherentSheavesOverProjectiveSpace( S );
twisted_omegas := FullSubcategoryGeneratedByTwistedCotangentModules( S );
Sh := SheafificationFunctor( coh_P2 );

o1 := [1] / rows;

# Create a Beilinson functor from Freyd category into quiver algebraic model
U := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S );
algebra := EndomorphismAlgebraOfCotangentBeilinsonCollection( S );
algebroid := Algebroid( algebra );
qrows := QuiverRows( algebra );

quit;

U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) );

# Or interpret the output in the homotopy of the quiver representations over the opposite algebra
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) );

# Or interpret the output in the derived category of the quiver representations over the opposite algebra
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * DerivedCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) );

# Or interpret the output as a quiver representation
U_o1 := HomologyAt( o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * DerivedCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) ), 0 );

# Or interpret the output in the homotopy of the quiver rows
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( qrows );

# Or interpret the output in the homotopy of twisted cotangent modules
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) );

# or interpret the output in the homotopy of the freyd category
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd );

# Or interpret the output in the homotopy of the graded rows, i.e., in terms of the collection O(-3),O(-2),O(-1)
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows );

# Or interpret the output in the homotopy of graded left presentations
U_o1 := o1 * freyd * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows ) * HomotopyCategory( fpres );
