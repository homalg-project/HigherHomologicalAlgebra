LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/HomStructureForGradedRows.g" );

#R := HomalgFieldOfRationals( );
R := HomalgRingOfIntegers( );
#R := HomalgFieldOfRationalsInSingular( )*"x,y";

rows := CategoryOfRows( R : FinalizeCategory := false );
AddRandomMethodsToRows( rows );
Finalize( rows );

chains := ChainComplexCategory( rows : FinalizeCategory := false );

AddMorphismIntoColiftingObject( chains,
  function( a )
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
end );

Finalize( chains );

name := Concatenation( "Homotopy category of ", Name( rows ) );

homotopy_of_rows := StableCategoryByColiftingStructure( chains: Name := name );

alpha_1 := RandomMorphism( rows, [ 6 .. 12 ] );
a := ChainComplex( [ alpha_1 ], 1 );
beta_1 := RandomMorphism( rows, [ 6 .. 12 ] );
b := ChainComplex( [ beta_1 ], 1 );
f := RandomMorphismWithFixedSourceAndRange( a[0], b[1], [1] );
phi := ChainMorphism( a, b, [ PreCompose( f, b^1 ), PreCompose( a^1, f ) ], 0 );
stable_phi := AsStableCategoryMorphism( homotopy_of_rows, phi );
IsZero( stable_phi );
# true

# Ask Sebastian when does Freyd categories have hom structure.
