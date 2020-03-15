#! @Chunk AsZFunction

LoadPackage( "ComplexesCategories" );

#! @Example
z_func := AsZFunction( i -> i ^ 2 );
#! <ZFunction>
z_func[ 3 ];
#! 9
z_func[ 5 ];
#! 25
Display( UnderlyingFunction( z_func ) );
#! function ( i )
#!     return i ^ 2;
#! end
ComputedZFunctionValues( z_func );
#! [ 3, 9, 5, 25 ]
#! @EndExample
