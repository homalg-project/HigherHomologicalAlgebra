ReadPackage( "HomotopyCategoriesForCAP", "/examples/HomStructureForGradedRows.g" );
LoadPackage( "HomotopyCategoriesForCAP" );
LoadPackage( "FreydCategoriesForCAP" );

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" );
#SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ] );
#S := KoszulDualRing( GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" ) );

TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS2( S );

rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldForHomomorphismStructure( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( rows );
AddRandomMethodsToGradedRows( rows );
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( rows ), true );
Finalize( rows );

homotopy_of_rows := HomotopyCategory( rows : FinalizeCategory := false );

AddMorphismIntoColiftingObject( homotopy_of_rows,
  function( stable_C )
    local C, D, phi; 
    
    C := UnderlyingCapCategoryObject( stable_C );
    
    D := StalkChainComplex( C[ 1 ], 1 );
    
    phi := ChainMorphism( C, D, [ IdentityMorphism( C[1] ) ], 1 );
    
    return StableCategoryMorphism( CapCategory( stable_C ), phi );
    
end );;

Finalize( homotopy_of_rows );

stable_homotopy_cat_of_rows := StableCategoryByColiftingStructure( homotopy_of_rows );

f_a := RandomMorphism( rows, 3 );
f_b := RandomMorphism( rows, 6 );

IsWellDefined( f_a );
IsWellDefined( f_b );

fr_a := FreydCategoryObject( f_a );
fr_b := FreydCategoryObject( f_b );

H_fr_a_fr_b := HomomorphismStructureOnObjects( fr_a, fr_b );

a := ChainComplex( [ f_a ], 1 );
b := ChainComplex( [ f_b ], 1 );

H_ab := HomomorphismStructureOnObjects( a, b );

aa := HomotopyCategoryObject( homotopy_of_rows, a );
bb := HomotopyCategoryObject( homotopy_of_rows, b );

H_aabb := HomomorphismStructureOnObjects( aa, bb );

aaa := StableCategoryObject( stable_homotopy_cat_of_rows, aa );
bbb := StableCategoryObject( stable_homotopy_cat_of_rows, bb );

H_aaabbb := HomomorphismStructureOnObjects( aaa, bbb );

Display( H_aaabbb );
Display("\n");
Display( IsEqualForObjects( H_fr_a_fr_b, H_aaabbb ) );

