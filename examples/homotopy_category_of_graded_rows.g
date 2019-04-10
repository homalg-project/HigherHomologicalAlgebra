LoadPackage( "StableCategoriesForCAP" );
LoadPackage( "ComplexesForCAP" );
LoadPackage( "FreydCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/HomStructureForGradedRows.g" );

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" );
SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ] );
TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS( S );

rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldOfExternalHom( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( rows );
AddRandomMethodsToGradedRows( rows );
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
    
    if ActiveLowerBound( C ) < -1 or ActiveUpperBound( C ) > 2 then
      
      Error( "The complex should be concentrated in 0, 1" );
      
    fi;
    
    D := StalkChainComplex( C[ 1 ], 1 );
    
    phi := ChainMorphism( C, D, [ IdentityMorphism( C[1] ) ], 1 );
    
    return AsStableCategoryMorphism( CapCategory( stable_C ), phi );
    
end );;


stable_homotopy_cat_of_rows := StableCategoryByColiftingStructure( homotopy_of_rows );


