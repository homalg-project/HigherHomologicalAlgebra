ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

# create graded polynomial ring
Q := HomalgFieldOfRationalsInSingular( );
S := CoxRingForProductOfProjectiveSpaces( Q, [ 1, 2 ] );
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P1xP2 := CoherentSheavesOverProductOfProjectiveSpaces( S );
Sh := SheafificationFunctor( coh_P1xP2 );

algebra_1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[1] );
algebra_2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[2] );

algebroid_1 := Algebroid( algebra_1 );
algebroid_2 := Algebroid( algebra_2 );

I1 := InterpretationIsomorphismFromAlgebroid( algebroid_1 );
I2 := InterpretationIsomorphismFromAlgebroid( algebroid_2 );

omegas_1 := RangeOfFunctor( I1 );
omegas_2 := RangeOfFunctor( I2 );

omegas := BoxProduct( omegas_1, omegas_2, freyd );
V := IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories( I1, I2, omegas );
V := ExtendFunctorToAdditiveClosures( I );
V := ExtendFunctorToHomotopyCategories( I );

B := BeilinsonExperimental( S );
quit;

o_11 := [1,1] / rows;

