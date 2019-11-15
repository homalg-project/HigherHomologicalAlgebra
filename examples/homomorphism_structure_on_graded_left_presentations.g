LoadPackage( "HomotopyCategories" );
LoadPackage( "FreydCategories" );
LoadPackage( "4ti2Interface" ); # or NConvex
LoadPackage( "LinearAlgebra" );
LoadPackage( "GradedModulePresentations" );
LoadPackage( "Bialgebroid" );
ReadPackage( "HomotopyCategories", "/examples/random_methods_for_categories_of_graded_rows.g" );

Q := HomalgFieldOfRationalsInSingular( );;
S := GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" );;
#SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ] );
#S := KoszulDualRing( GradedRing( Q * "x_0, x_1, x_2, y_0, y_1" ) );


graded_rows := CategoryOfGradedRows( S: FinalizeCategory := false );;

## Adding the random methods
AddRandomMethodsToGradedRows( graded_rows );;

## Adding the external hom methods
AddBasisOfExternalHom( graded_rows, BasisOfExternalHomBetweenGradedRows );;
AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( graded_rows, CoefficientsOfMorphismOfGradedRowsWRTBasisOfExternalHom );;

## Defining graded_rows as linear category
SetIsLinearCategoryOverCommutativeRing( graded_rows, true );;
SetCommutativeRingOfLinearCategory( graded_rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );;
AddMultiplyWithElementOfCommutativeRingForMorphisms( graded_rows, 
  {r,phi} -> GradedRowOrColumnMorphism( Source( phi ), r*UnderlyingHomalgMatrix( phi ), Range( phi ) ) );;
Finalize( graded_rows );;

SetIsProjective( DistinguishedObjectOfHomomorphismStructure( graded_rows ), true );;

homotopy_of_graded_rows := HomotopyCategory( graded_rows );

lp_cat := GradedLeftPresentations( S );

graded_rows_in_lp_cat :=  FullSubcategory( lp_cat, "A full subcategory of twists of the ring in " );


name := "Equivalence from full subcategory of graded rows in graded left presentations to the abstract graded rows category";
F := CapFunctor( name, graded_rows_in_lp_cat, graded_rows );

AddObjectFunction( F,
  function( a )
    local cell, degrees;
    cell := UnderlyingCell( a );
    degrees := GeneratorDegrees( cell );
    degrees := List( degrees, d -> [ -d, 1 ] );
    return GradedRow( degrees, UnderlyingHomalgRing( cell ) );
end );

AddMorphismFunction( F,
  function( s, phi, r )
    return GradedRowOrColumnMorphism( s, UnderlyingMatrix( UnderlyingCell( phi ) ), r );
end );

name := "Equivalence from the abstract graded rows category to the full subcategory of graded rows in graded left presentations";
G := CapFunctor( name, graded_rows, graded_rows_in_lp_cat );

AddObjectFunction( G,
  function( a )
    local degrees;
    
    degrees := DegreeList( a );
    
    degrees := Concatenation( List( degrees, d -> ListWithIdenticalEntries( d[ 2 ], -d[ 1 ] ) ) );
    
    return AsFullSubcategoryCell( graded_rows_in_lp_cat,
              GradedFreeLeftPresentation( RankOfObject( a ), UnderlyingHomalgGradedRing( a ), degrees ) );
    
end );

AddMorphismFunction( G,
  function( s, phi, r )
    local ss, rr;
    
    ss := UnderlyingCell( s );
    
    rr := UnderlyingCell( r );
    
    return  AsFullSubcategoryCell( graded_rows_in_lp_cat,
              GradedPresentationMorphism( ss, UnderlyingHomalgMatrix( phi ), rr ) );
end );


