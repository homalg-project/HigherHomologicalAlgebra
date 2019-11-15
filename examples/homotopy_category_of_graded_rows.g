LoadPackage( "HomotopyCategories" );
LoadPackage( "FreydCategories" );
LoadPackage( "4ti2Interface" ); # or NConvex
LoadPackage( "LinearAlgebra" );
ReadPackage( "HomotopyCategories", "/examples/random_methods_for_categories_of_graded_rows.g" );

Q := HomalgFieldOfRationalsInSingular( );;
S := GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" );;
#SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ] );
#S := KoszulDualRing( GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" ) );


rows := CategoryOfGradedRows( S: FinalizeCategory := false );;

## Adding the random methods
AddRandomMethodsToGradedRows( rows );;

## Adding the external hom methods
AddBasisOfExternalHom( rows, BasisOfExternalHomBetweenGradedRows );;
AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( rows,
  CoefficientsOfMorphismOfGradedRowsWRTBasisOfExternalHom );;

## Defining rows as linear category
SetIsLinearCategoryOverCommutativeRing( rows, true );;
SetCommutativeRingOfLinearCategory( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );;
AddMultiplyWithElementOfCommutativeRingForMorphisms( rows, 
  {r,phi} -> GradedRowOrColumnMorphism( Source( phi ), r*UnderlyingHomalgMatrix( phi ), Range( phi ) ) );;
Finalize( rows );;

SetIsProjective( DistinguishedObjectOfHomomorphismStructure( rows ), true );;

homotopy_of_rows := HomotopyCategory( rows : FinalizeCategory := false );;

# construction of alternative model for Freyed categories
AddMorphismIntoColiftingObject( homotopy_of_rows,
  function( stable_C )
    local C, D, phi; 
    
    C := UnderlyingCapCategoryObject( stable_C );
    
    D := StalkChainComplex( C[ 1 ], 1 );
    
    phi := ChainMorphism( C, D, [ IdentityMorphism( C[1] ) ], 1 );
    
    return StableCategoryMorphism( CapCategory( stable_C ), phi );
    
end );;

Finalize( homotopy_of_rows );;
stable_homotopy_cat_of_rows := StableCategoryByColiftingStructure( homotopy_of_rows );;
f_a := RandomMorphism( rows, 3 );;
f_b := RandomMorphism( rows, 6 );;
IsWellDefined( f_a );;
IsWellDefined( f_b );;
fr_a := FreydCategoryObject( f_a );;
fr_b := FreydCategoryObject( f_b );;
H_fr_a_fr_b := HomomorphismStructureOnObjects( fr_a, fr_b );;
a := ChainComplex( [ f_a ], 1 );;
b := ChainComplex( [ f_b ], 1 );;
H_ab := HomomorphismStructureOnObjects( a, b );;
aa := HomotopyCategoryObject( homotopy_of_rows, a );;
bb := HomotopyCategoryObject( homotopy_of_rows, b );;
H_aabb := HomomorphismStructureOnObjects( aa, bb );;
aaa := StableCategoryObject( stable_homotopy_cat_of_rows, aa );;
bbb := StableCategoryObject( stable_homotopy_cat_of_rows, bb );;
H_aaabbb := HomomorphismStructureOnObjects( aaa, bbb );;
Display( IsEqualForObjects( H_fr_a_fr_b, H_aaabbb ) );

