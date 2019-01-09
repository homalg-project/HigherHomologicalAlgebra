LoadPackage( "GradedModulePresentations" );
LoadPackage( "ModelCategories" );
LoadPackage( "TriangulatedCategoriesForCAP" );
LoadPackage( "StableCategoriesForCAP" );
LoadPackage( "BBGG" );

ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/tools_for_complexes.g" );

if not IsBound( dimension_of_projective_space ) then
nr_indeterminates := InputFromUser( "Please enter n to define the polynomial ring Q[x_0,...,x_n],  n = " );
else
nr_indeterminates := ValueGlobal( "dimension_of_projective_space" );
fi;
with_commutative_squares := false;
vars := Concatenation( Concatenation( [ "x0" ] , List( [ 1 .. nr_indeterminates ], i -> Concatenation( ",x", String( i ) ) ) ) );
R := HomalgFieldOfRationalsInSingular( )*vars;
S := GradedRing( R );
A := KoszulDualRing( S );

lp_cat_sym := LeftPresentations( R );

graded_lp_cat_sym := GradedLeftPresentations( S : FinalizeCategory := false );

AddEvaluationMorphismWithGivenSource( graded_lp_cat_sym,
    function( a, b, s )
    local mor;
    mor := EvaluationMorphismWithGivenSource( UnderlyingPresentationObject( a ), UnderlyingPresentationObject( b ), UnderlyingPresentationObject( s ) );
    return GradedPresentationMorphism( s, UnderlyingMatrix( mor )*S, b );
end );

AddCoevaluationMorphismWithGivenRange( graded_lp_cat_sym,
    function( a, b, r )
    local mor;
    mor := CoevaluationMorphismWithGivenRange( UnderlyingPresentationObject( a ), UnderlyingPresentationObject( b ), UnderlyingPresentationObject( r ) );
    return GradedPresentationMorphism( a, UnderlyingMatrix( mor )*S, r );
end );

AddEpimorphismFromSomeProjectiveObject( graded_lp_cat_sym,
    function( M )
    local hM, U, current_degrees;
    hM := AsPresentationInHomalg( M );
    ByASmallerPresentation( hM );
    U := UnderlyingModule( hM );
    current_degrees := DegreesOfGenerators( hM );
    return GradedPresentationMorphism(
                GradedFreeLeftPresentation( Length( current_degrees), S, current_degrees ),
                TransitionMatrix( U, PositionOfTheDefaultPresentation(U), 1 )*S,
                M );
end, -1 );

##
AddIsProjective( graded_lp_cat_sym,
    function( M )
    local l;
    l := Lift( IdentityMorphism( M ), EpimorphismFromSomeProjectiveObject( M ) );
    if l = fail then
	return false;
    else
	return true;
    fi;
end );

AddGeneratorsOfExternalHom( graded_lp_cat_sym,
   function( M, N )
    local hM, hN, G;
    hM := AsPresentationInHomalg( M );
    hN := AsPresentationInHomalg( N );
    G := GetGenerators( Hom( hM, hN ) );
    return List( G, AsPresentationMorphismInCAP );
end );

Finalize( graded_lp_cat_sym );

cospan_to_span := FunctorFromCospansToSpans( graded_lp_cat_sym );;
cospan_to_three_arrows := FunctorFromCospansToThreeArrows( graded_lp_cat_sym );;
span_to_three_arrows := FunctorFromSpansToThreeArrows( graded_lp_cat_sym );;
span_to_cospan := FunctorFromSpansToCospans( graded_lp_cat_sym );;

# constructing the chain complex category of left presentations over R
chains_lp_cat_sym := ChainComplexCategory( lp_cat_sym : FinalizeCategory := false );
ModelStructureOnChainComplexes( chains_lp_cat_sym );
Finalize( chains_lp_cat_sym );

# constructing the cochain complex category of left presentations over R
cochains_lp_cat_sym := CochainComplexCategory( lp_cat_sym );

# constructing the chain complex category of graded left presentations over S
chains_graded_lp_cat_sym := ChainComplexCategory( graded_lp_cat_sym : FinalizeCategory := false );
ModelStructureOnChainComplexes( chains_graded_lp_cat_sym );
AddAreLeftHomotopic( chains_graded_lp_cat_sym, 
    function( phi, psi )
        return IsNullHomotopic( phi - psi );
        #return is_left_homotopic_to_null( phi - psi );
    end );
AddGeneratorsOfExternalHom( chains_graded_lp_cat_sym,
    function( C, D )
    return graded_generators_of_hom_for_chains( C, D );
end );

Finalize( chains_graded_lp_cat_sym );

# constructing the cochain complex category of graded left presentations over S
cochains_graded_lp_cat_sym := CochainComplexCategory( graded_lp_cat_sym );

cochain_to_chain_functor := CochainToChainComplexFunctor( cochains_graded_lp_cat_sym, chains_graded_lp_cat_sym );

# constructing the category Ch( ch( graded_lp_Cat_sym ) ) and the it associated bicomplex category
cochains_cochains_graded_lp_cat_sym := CochainComplexCategory( cochains_graded_lp_cat_sym );
bicomplexes_of_graded_lp_cat_sym := AsCategoryOfBicomplexes( cochains_cochains_graded_lp_cat_sym );
SetIsBicomplexCategoryWithCommutativeSquares( bicomplexes_of_graded_lp_cat_sym, with_commutative_squares );

# constructing the category of graded left presentations over exterior algebra A
graded_lp_cat_ext := GradedLeftPresentations( A: FinalizeCategory := false );
AddLiftAlongMonomorphism( graded_lp_cat_ext,
    function( iota, tau )
    local l;
    l := LiftAlongMonomorphism( UnderlyingPresentationMorphism( iota ),
            UnderlyingPresentationMorphism( tau ) );
    return GradedPresentationMorphism( Source( tau ), l, Source( iota ) );
end );

AddEpimorphismFromSomeProjectiveObject( graded_lp_cat_ext,
    function( M )
    local hM, U, current_degrees;
    hM := AsPresentationInHomalg( M );
    ByASmallerPresentation( hM );
    U := UnderlyingModule( hM );
    current_degrees := DegreesOfGenerators( hM );
    return GradedPresentationMorphism(
                GradedFreeLeftPresentation( Length( current_degrees), A, current_degrees ),
                TransitionMatrix( U, PositionOfTheDefaultPresentation(U), 1 )*A,
                M );
end, -1 );

AddGeneratorsOfExternalHom( graded_lp_cat_ext,
    function( M, N )
    return BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_LEFT_PRES_OVER_EXTERIOR_ALGEBRA( M, N );
end );

SetIsFrobeniusCategory( graded_lp_cat_ext, true );
ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( graded_lp_cat_ext );
TurnAbelianCategoryToExactCategory( graded_lp_cat_ext );
SetTestFunctionForStableCategories(graded_lp_cat_ext, CanBeFactoredThroughExactProjective );
Finalize( graded_lp_cat_ext );

cochains_graded_lp_cat_ext := CochainComplexCategory( graded_lp_cat_ext );

# constructing the stable category of graded left presentations over A and giving it the
# triangulated structure
stable_lp_cat_ext := StableCategory( graded_lp_cat_ext );

AddGeneratorsOfExternalHom( stable_lp_cat_ext,
    function( M, N )
    local basis;
    basis := GeneratorsOfExternalHom( UnderlyingUnstableObject(M), UnderlyingUnstableObject(N));
    basis := List( basis, AsStableMorphism );
    basis := DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms( b ) ) );
    return basis;
end );

SetIsTriangulatedCategory( stable_lp_cat_ext, true );
ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_lp_cat_ext );
AsTriangulatedCategory( stable_lp_cat_ext );
Finalize( stable_lp_cat_ext );

# constructing the category of coherent sheaves over P^n = Proj(S)
IsFiniteDimensionalGradedLeftPresentation := 
    function( M )
    return IsZero( HilbertPolynomial( AsPresentationInHomalg( M ) ) );
    end;

C := FullSubcategoryByMembershipFunction(graded_lp_cat_sym, IsFiniteDimensionalGradedLeftPresentation );
coh := graded_lp_cat_sym / C;

