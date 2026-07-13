gap> START_TEST("test_random_methods_category_of_rows.tst");

gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "ComplexesCategories", false );
true
gap> ring := HomalgRingOfIntegers( );;
gap> rows := CategoryOfRows( ring );;
gap> ch_rows := ComplexesCategoryByChains( rows );;
gap> A := RandomObject( ch_rows, 5 );;
gap> B := RandomObject( ch_rows, 5 );;
gap> f := RandomMorphismWithFixedSource( A, 5 );;
gap> g := RandomMorphismWithFixedRange( A, 5 );;
gap> t := RandomMorphismWithFixedSourceAndRange( A, B, 5 );;
gap> s := RandomMorphism( ch_rows, 5 );;
gap> Assert( 0, ForAll( [ f, g, t, s ], IsWellDefined ) );
gap> Assert( 0, IsWellDefined( HomStructure( f, g ) ) );
gap> A := RandomObject( ch_rows, [ -4, 4, [ [ 1 .. 5 ], [ 1 ] ] ] );;
gap> B := RandomObject( ch_rows, [ -4, 4, [ [ 1 .. 5 ], [ 1 ] ] ] );;
gap> f := RandomMorphismWithFixedSource( A, 5 );;
gap> g := RandomMorphismWithFixedRange( A, 5 );;
gap> t := RandomMorphismWithFixedSourceAndRange( A, B, 5 );;
gap> s := RandomMorphism( ch_rows, 5 );;
gap> Assert( 0, ForAll( [ f, g, t, s ], IsWellDefined ) );
gap> id_A := IdentityMorphism( A );;
gap> Assert( 0, IsEqualForMorphisms( 2 * id_A, AdditionForMorphisms( id_A, id_A ) ) );
gap> i := IdentityFunctor( rows );;
gap> I := ExtendFunctorToComplexesCategoriesByChains( i );;
gap> Assert( 0, IsEqualForMorphisms( ApplyFunctor( I, s ), s ) );
gap> I := ExtendFunctorToComplexesCategoriesByCochains( i );;
gap> s := AsCochainComplexMorphism( s );;
gap> Assert( 0, IsEqualForMorphisms( ApplyFunctor( I, s ), s ) );
gap> I := InclusionFunctorIntoComplexesCategoryByChains( rows );;
gap> Assert( 0, ApplyFunctor( I, f[0] )[0] = f[0] );
gap> I := InclusionFunctorIntoComplexesCategoryByCochains( rows );;
gap> Assert( 0, ApplyFunctor( I, f[0] )[0] = f[0] );
gap> ring := HomalgFieldOfRationals( );;
gap> rows := CategoryOfRows( ring );;
gap> f := RandomMorphism( rows, 30 );;
gap> Assert( 0, LowerBound( MorphismBetweenProjectiveResolutions(f, true) ) = 0 );
gap> Assert( 0, UpperBound( MorphismBetweenInjectiveResolutions(f, true) ) = 0 );

#
gap> STOP_TEST("test_random_methods_category_of_rows.tst", 1);
