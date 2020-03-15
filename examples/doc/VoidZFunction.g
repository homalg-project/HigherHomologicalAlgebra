#! @Chunk Reflection

LoadPackage( "ComplexesCategories" );

#! @Example
z_func := VoidZFunction( );;
SetStableUpperValue( z_func, 3, SymmetricGroup( 3 ) );
SetStableLowerValue( z_func, 2, SymmetricGroup( 2 ) );
z_func[20];
#! Sym( [ 1 .. 3 ] )
z_func[-20];
#! Sym( [ 1 .. 2 ] )
ref_z_func := Reflection( z_func );
#! <ZFunction>
ref_z_func[20];
#! Sym( [ 1 .. 2 ] )
#! @EndExample
