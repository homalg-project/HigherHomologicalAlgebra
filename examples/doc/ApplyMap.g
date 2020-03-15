#! @Chunk ApplyMap

LoadPackage( "ComplexesCategories" );

#! @Example
z_func_1 := AsZFunction( i -> i^3+i );
#! <ZFunction>
z_func_2 := AsZFunction( i -> 1/(i^2+1) );
#! <ZFunction>
F := { a, b } -> a * b;;
z_func := ApplyMap( [ z_func_1, z_func_2 ], F );
#! <ZFunction>
z_func[2];
#! 2
z_func[3];
#! 3
z_func[-3];
#! -3
com_z_func := CombineZFunctions( [ z_func_1, z_func_2, z_func ] );
#! <ZFunction>
com_z_func[ 1 ];
#! [ 2, 1/2, 1 ]
com_z_func[ 100 ];
#! [ 1000100, 1/10001, 100 ]
#! @EndExample
