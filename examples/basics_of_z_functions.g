LoadPackage( "ComplexesCategories" );


# let us define the list
#       ...    -3    -2    -1   0  1   2    3   ....
# L = [ ..., 1/2^3, 1/2^2, 1/2, 1, 2, 2^2, 2^3, .... ]

# method 1
z_func_1 := AsZFunction( i -> 2 ^ i );


# method 2
pos_side_func := a -> a * 2;
neg_side_func := a -> a / 2;
z_func_2 := ZFunctionWithInductiveSides( 0, 1, neg_side_func, pos_side_func, \= );

