
##
InstallGlobalFunction( PREPARE_CATEGORIES_OF_HOMALG_GRADED_POLYNOMIAL_RING, 
function( S )
	local graded_lp_cat_sym, chains_graded_lp_cat_sym, 
	homotopy_chains_graded_lp_cat_sym, ext_S, graded_lp_cat_ext, with_commutative_squares, cochains_graded_lp_cat_sym,
	cochains_cochains_graded_lp_cat_sym, bicomplexes_of_graded_lp_cat_sym, stable_lp_cat_ext;

	graded_lp_cat_sym := GradedLeftPresentations( S : FinalizeCategory := false );

	if not HasIsFinalized( graded_lp_cat_sym ) then 
	
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

	# constructing the chain complex category of graded left presentations over S
	chains_graded_lp_cat_sym := ChainComplexCategory( graded_lp_cat_sym : FinalizeCategory := false );
	ModelStructureOnChainComplexes( chains_graded_lp_cat_sym );
	AddAreLeftHomotopic( chains_graded_lp_cat_sym, 
    	function( phi, psi )
    	    return IsNullHomotopic( phi - psi );
        end );

	AddGeneratorsOfExternalHom( chains_graded_lp_cat_sym,
	GENERATORS_OF_EXTERNAL_HOM_IN_CHAINS_OF_GRADED_LEFT_PRESENTATIONS );
	Finalize( chains_graded_lp_cat_sym );

	homotopy_chains_graded_lp_cat_sym := HomotopyCategory( chains_graded_lp_cat_sym );
	AddTriangulatedStructure( homotopy_chains_graded_lp_cat_sym );
	Finalize( homotopy_chains_graded_lp_cat_sym );

	# constructing the cochain complex category of graded left presentations over S
	cochains_graded_lp_cat_sym := CochainComplexCategory( graded_lp_cat_sym );

	# constructing the category Ch( ch( graded_lp_Cat_sym ) ) and the it associated bicomplex category
	cochains_cochains_graded_lp_cat_sym := CochainComplexCategory( cochains_graded_lp_cat_sym );
	with_commutative_squares := false;
	bicomplexes_of_graded_lp_cat_sym := AsCategoryOfBicomplexes( cochains_cochains_graded_lp_cat_sym );
	SetIsBicomplexCategoryWithCommutativeSquares( bicomplexes_of_graded_lp_cat_sym, with_commutative_squares );

	# constructing the category of graded left presentations over exterior algebra A
	
	ext_S := KoszulDualRing( S );
	graded_lp_cat_ext := GradedLeftPresentations( ext_S: FinalizeCategory := false );
	SetIsFrobeniusCategory( graded_lp_cat_ext, true );

	AddLiftAlongMonomorphism( graded_lp_cat_ext,
	    function( iota, tau )
	    local l;
	    if not IsMonomorphism( iota ) then
	        Error( "very serious error!, you think that some morphism is monomorphism, but it is not!" );
		fi;

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
	                GradedFreeLeftPresentation( Length( current_degrees), ext_S, current_degrees ),
	                TransitionMatrix( U, PositionOfTheDefaultPresentation(U), 1 )*ext_S,
	                M );
	end, -1 );

	AddGeneratorsOfExternalHom( graded_lp_cat_ext,
	    function( M, N )
	    return BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_LEFT_PRES_OVER_EXTERIOR_ALGEBRA( M, N );
	end );

	ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( graded_lp_cat_ext );
	TurnAbelianCategoryToExactCategory( graded_lp_cat_ext );
	
	SetTestFunctionForStableCategories(graded_lp_cat_ext, CanBeFactoredThroughExactProjective );
	
	Finalize( graded_lp_cat_ext );

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


	fi;
end );


