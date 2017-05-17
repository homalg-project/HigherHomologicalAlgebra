#! @System AsCategoryOfBicomplexes

LoadPackage( "M2" );
LoadPackage( "Bicomplexes" );

#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
LoadPackage( "M2" );
#! true
A := CategoryOfHomalgLeftModules( ZZ );
#! intrinsic Category of left presentations of Z with ambient objects
C := ChainComplexCategory( A );
#! Chain complexes category over intrinsic Category
#! of left presentations of Z with ambient objects
D := ChainComplexCategory( C );
#! Chain complexes category over chain complexes category over
#! intrinsic Category of left presentations of Z with ambient objects
B := AsCategoryOfBicomplexes( D );
#! Chain complexes category over chain complexes category over
#! intrinsic Category of left presentations of Z with ambient objects
#! as bicomplexes
#! @EndExample
