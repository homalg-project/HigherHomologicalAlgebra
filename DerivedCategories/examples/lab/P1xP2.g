ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

# create graded polynomial ring
Q := HomalgFieldOfRationalsInSingular( );
S := CoxRingForProductOfProjectiveSpaces( Q, [ 1, 2 ] );

# create the Beilinson functor
U := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S );
twisted_omegas := FullSubcategoryGeneratedByBoxProductOfTwistedCotangentModules( S );

# Geometry
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P1xP2 := CoherentSheavesOverProductOfProjectiveSpaces( S );
Sh := SheafificationFunctor( coh_P1xP2 );

# Algebra
A_1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[1] );
A_2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[2] );
algebra := TensorProductOfAlgebras( A_1, A_2 );

algebroid := Algebroid( algebra );
qrows := QuiverRows( algebra );
qreps := CategoryOfQuiverRepresentations( algebra );

quit;

o11 := [1,1] / rows;

# Or interpret the o11 in the freyd category
U_o11 := o11 * freyd;

# Or interpret the output in the homotopy of the additive closure of 'algebroid'
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ); 

# Or interpret the output in the homotopy of the quiver rows
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( QuiverRows( algebra ) );

# Or interpret the output in the homotopy of the quiver representations over the opposite algebra
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) );

# Or interpret the output in the derived category of the quiver representations over the opposite algebra
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * DerivedCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) );

# Or interpret the output as a quiver representation
U_o11 := HomologyAt( o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * DerivedCategory( CategoryOfQuiverRepresentations( OppositeAlgebra( algebra ) ) ), 0 );

# Or interpret the output in the homotopy of twisted cotangent modules
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) );

# Or interpret the output in the homotopy of the freyd category
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd );

# Or interpret the output in the homotopy of the graded rows, i.e., in terms of the collection O(-3),O(-2),O(-1)
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows );

# Or interpret the output in the homotopy of graded left presentations
U_o11 := o11 * HomotopyCategory( AdditiveClosure( algebroid ) ) * HomotopyCategory( AdditiveClosure( twisted_omegas ) ) * HomotopyCategory( freyd ) * HomotopyCategory( rows ) * HomotopyCategory( fpres );

