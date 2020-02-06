ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 4, 5, 2 );

C := CategoryOfQuiverRepresentations( A );
Ho_C := HomotopyCategory( C );
Ch_C := UnderlyingCategory( Ho_C );
Der_C := DerivedCategory( C );

collection := CreateExceptionalCollection( IndecProjectiveObjects( C ) );

H := HomFunctor( collection );
R_H := RightDerivedFunctor( H );
HI := HomFunctorOnInjectiveObjects( collection );
homotopy_H := PreCompose( LocalizationFunctorByInjectiveObjects( Ho_C ), ExtendFunctorToHomotopyCategories( HI ) );

D := AsCapCategory( Range( H ) );
Ho_D := HomotopyCategory( D );

T := TensorFunctor( collection );
L_T := LeftDerivedFunctor( T );

TP := TensorFunctorOnProjectiveObjects( collection );
I := ExtendFunctorToAdditiveClosureOfSource( InclusionFunctor( DefiningFullSubcategory( collection ) ) );
T := PreCompose( TP, I );
homotopy_T := PreCompose( LocalizationFunctorByProjectiveObjects( Ho_D ), ExtendFunctorToHomotopyCategories( T ) );

a := RANDOM_CHAIN_COMPLEX( Ch_C, -3, 3, 2 )/Ho_C/Der_C;

