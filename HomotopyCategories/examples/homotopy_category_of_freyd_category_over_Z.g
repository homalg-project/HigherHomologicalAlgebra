LoadPackage( "HomotopyCategories" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "FreydCategories" );
ReadPackage( "HomotopyCategories", "/examples/temp_dir/random_methods_for_categories_of_rows.g" );

R := HomalgRingOfIntegers( );

rows := CategoryOfRows( R : FinalizeCategory := false );
AddRandomMethodsToRows( rows );
Finalize( rows );

freyd_cat := FreydCategory( rows );
chains_freyd_cat := ChainComplexCategory( freyd_cat );
homotopy_freyd_cat := HomotopyCategory( freyd_cat );

# Create two objects in the homotopy category
M := ProjectiveChainResolution( FreydCategoryObject( RandomMorphism( rows, [ 1 .. 9 ] ) ), true ) / homotopy_freyd_cat;
N := ProjectiveChainResolution( FreydCategoryObject( RandomMorphism( rows, [ 1 .. 8 ] ) ), true ) / homotopy_freyd_cat;

H := HomStructure( M, N );

# or in this case: HomStructure( HomologyAt( M, 0 ), HomologyAt( N, 0 ) );


# Localisation functor in the derived category
LoadPackage( "DerivedCategories" );
LL := LocalizationFunctorByProjectiveObjects( homotopy_freyd_cat );
Display( LL );
LL( M );
LL( N );

