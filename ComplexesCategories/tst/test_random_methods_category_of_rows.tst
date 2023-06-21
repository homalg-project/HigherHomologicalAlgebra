gap> ring := HomalgRingOfIntegers( );;
gap> rows := CategoryOfRows( ring );;
gap> ch_rows := ComplexesCategoryByChains( rows );;
gap> A := RandomObject( ch_rows, 10 );;
gap> B := RandomObject( ch_rows, 10 );;
gap> f := RandomMorphismWithFixedSource( A, 10 );;
gap> g := RandomMorphismWithFixedRange( A, 10 );;
gap> t := RandomMorphismWithFixedSourceAndRange( A, B, 10 );;
gap> s := RandomMorphism( ch_rows, 10 );;
gap> ForAll( [ f, g, t, s ], IsWellDefined );
true
gap> IsWellDefined( HomStructure( f, g ) );
true
gap> A := RandomObject( ch_rows, [ -4, 4, [[1 .. 10],[1]] ] );;
gap> B := RandomObject( ch_rows, [ -4, 4, [[1 .. 10],[1]] ] );;
gap> f := RandomMorphismWithFixedSource( A, 10 );;
gap> g := RandomMorphismWithFixedRange( A, 10 );;
gap> t := RandomMorphismWithFixedSourceAndRange( A, B, 10 );;
gap> s := RandomMorphism( ch_rows, 10 );;
gap> ForAll( [ f, g, t, s ], IsWellDefined );
true
gap> id_A := IdentityMorphism( A );;
gap> IsEqualForMorphisms( 2 * id_A, AdditionForMorphisms( id_A, id_A ) );
true
gap> i := IdentityFunctor( rows );;
gap> I := ExtendFunctorToComplexesCategoriesByChains( i );;
gap> IsEqualForMorphisms( ApplyFunctor( I, s ), s );
true
gap> I := ExtendFunctorToComplexesCategoriesByCochains( i );;
gap> s := AsCochainComplexMorphism( s );;
gap> IsEqualForMorphisms( ApplyFunctor( I, s ), s );
true
gap> I := InclusionFunctorIntoComplexesCategoryByChains( rows );;
gap> ApplyFunctor( I, f[0] )[0] = f[0];
true
gap> I := InclusionFunctorIntoComplexesCategoryByCochains( rows );;
gap> ApplyFunctor( I, f[0] )[0] = f[0];
true
gap> ring := HomalgFieldOfRationals( );;
gap> rows := CategoryOfRows( ring );;
gap> f := RandomMorphism( rows, 30 );;
gap> LowerBound( MorphismBetweenProjectiveResolutions(f, true) ) = 0;
true
gap> UpperBound( MorphismBetweenInjectiveResolutions(f, true) ) = 0;
true
