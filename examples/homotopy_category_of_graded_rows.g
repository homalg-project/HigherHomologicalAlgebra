LoadPackage( "StableCategoriesForCAP" );
LoadPackage( "ComplexesForCAP" );
LoadPackage( "FreydCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/HomStructureForGradedRows.g" );

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" );
SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 0, 1 ], [ 0, 1 ], [ 1, 0 ], [ 1, 0 ] ] );
TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS( S );

rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldOfExternalHom( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( rows );
AddRandomMethodsToGradedRows( rows );
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( rows ), true );
Finalize( rows );

chains := ChainComplexCategory( rows : FinalizeCategory := false );
AddMorphismIntoColiftingObject( chains,
  function( a )
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
  end );;
Finalize( chains );

name := Concatenation( "Homotopy category of ", Name( rows ) );

homotopy_of_rows := StableCategoryByColiftingStructure( chains: Name := name, FinalizeCategory := false );

AddMorphismIntoColiftingObject( homotopy_of_rows,
  function( stable_C )
    local C, D, phi; 
    
    C := UnderlyingCapCategoryObject( stable_C );
    
    D := StalkChainComplex( C[ 1 ], 1 );
    
    phi := ChainMorphism( C, D, [ IdentityMorphism( C[1] ) ], 1 );
    
    return AsStableCategoryMorphism( CapCategory( stable_C ), phi );
    
end );;


stable_homotopy_cat_of_rows := StableCategoryByColiftingStructure( homotopy_of_rows );

a1 := GradedRow( [ [ [ 0, -2 ], 1 ], [ [ 0, 0 ], 1 ] ], S );
a0 := GradedRow( [ [ [ 0, -1 ], 1 ], [ [ -2, 0 ], 1 ] ], S );
mat_a := HomalgMatrix( "-x_2,0,0,0", 2, 2, S );
f_a := GradedRowOrColumnMorphism( a1, mat_a, a0 );

b1 := GradedRow( [ [ [ 0, -1 ], 2 ] ], S );
b0 := GradedRow( [ [ [ 1, 1 ], 1 ], [ [ 0, 0 ], 1 ] ] , S );
mat_b := HomalgMatrix( "6*x_0*x_1*x_2,5*x_2,3*x_0*x_2^2+5*x_2^2*y_0,-2*x_2", 2, 2, S );
f_b := GradedRowOrColumnMorphism( b1, mat_b, b0 );

IsWellDefined( f_a );
IsWellDefined( f_b );

a := ChainComplex( [ f_a ], 1 );
b := ChainComplex( [ f_b ], 1 );

H_ab := HomomorphismStructureOnObjects( a, b );

aa := AsStableCategoryObject( homotopy_of_rows, a );
bb := AsStableCategoryObject( homotopy_of_rows, b );

H_aabb := HomomorphismStructureOnObjects( aa, bb );

aaa := AsStableCategoryObject( stable_homotopy_cat_of_rows, aa );
bbb := AsStableCategoryObject( stable_homotopy_cat_of_rows, bb );

H_aaabbb := HomomorphismStructureOnObjects( aaa, bbb );

fr_a := FreydCategoryObject( f_a );
fr_b := FreydCategoryObject( f_b );

H_fr_a_fr_b := HomomorphismStructureOnObjects( fr_a, fr_b );

