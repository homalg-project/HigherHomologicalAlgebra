LoadPackage( "GradedModulePresentations" );
LoadPackage( "ModelCategories" );
LoadPackage( "TriangulatedCategoriesForCAP" );
LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/glp_over_g_exterior_algebra.g" );
ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/complexes_of_graded_left_presentations_over_graded_polynomial_ring.g" );


DeclareOperation( "BasisOfExternalHom", [ IsCapCategoryObject, IsCapCategoryObject ] );

BindGlobal( "ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA",

function( category )

##
AddLiftColift( category,
    function( alpha, beta, gamma, delta )
    local lift;
    lift := graded_colift_lift_in_stable_category(
            UnderlyingUnstableMorphism( alpha ),
            UnderlyingUnstableMorphism( beta ),
            UnderlyingUnstableMorphism( gamma ),
            UnderlyingUnstableMorphism( delta )
            );
    if lift = fail then
        return fail;
    else
        return AsStableMorphism( lift );
    fi;

    end );

## Since we have LiftColift, we automatically have Lifts & Colifts (see Derivations in Triangulated categories).
##
AddIsSplitMonomorphism( category,
    function( mor )
    local l;
    l := Colift( mor, IdentityMorphism( Source( mor ) ) );

    if l = fail then
        AddToReasons( "IsSplitMonomorphism: because the morphism can not be colifted to the identity morphism of the source" );
        return false;
    else
        return true;
    fi;

end );

AddIsSplitEpimorphism( category,
    function( mor )
    local l;
    l := Lift( IdentityMorphism( Range( mor ) ), mor );

    if l = fail then
        AddToReasons( "IsSplitMonomorphism: because the morphism can not be lifted to the identity morphism of the Range" );
        return false;
    else
        return true;
    fi;

end );

AddInverseImmutable( category,
    function( mor )
    return Lift( IdentityMorphism( Range( mor ) ), mor );
end );

end );

##
InstallMethodWithCache( GeneratorsOfExternalHom,
    [ IsCapCategoryObject, IsCapCategoryObject ],
    function( M, N )
    local basis;
    if IsStableCategoryObject( M ) and IsStableCategoryObject( N ) then
            basis := GeneratorsOfExternalHom( UnderlyingUnstableObject(M), UnderlyingUnstableObject(N));
            basis := List( basis, AsStableMorphism );
            basis := DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms( b ) ) );
            return basis;
    else
        TryNextMethod( );
    fi;
end );

graded_compute_coefficients_for_stable_morphisms := function( b, f )
    local R, basis_indices, Q, a, A, B, C, vec, main_list, matrix, constant, M, N, sol, F;

    M := Source( f );
    N := Range( f );

    if not IsWellDefined( f ) then
        return fail;
    fi;

    R := HomalgRing( UnderlyingMatrix( M ) );
    basis_indices := standard_list_of_basis_indices( R );
    Q := CoefficientsRing( R );

    F := List( b, UnderlyingMatrix );
    a := MonomorphismIntoSomeInjectiveObject( UnderlyingUnstableObject( M ) );
    A := UnderlyingMatrix( a );
    B := UnderlyingMatrix( N );
    C := UnderlyingMatrix( f );

    vec := function( H ) return Iterated( List( [ 1 .. NrColumns( H ) ], i -> CertainColumns( H, [ i ] ) ), UnionOfRows ); end;

    main_list :=
        List( [ 1 .. Length( basis_indices) ],
        function( i )
        local current_F, current_C, main;
        current_F := List( F, g -> DecompositionOfHomalgMat( g )[i][2]*Q );
        current_C := DecompositionOfHomalgMat(C)[ i ][2]*Q;
        main := UnionOfColumns( Iterated( List( current_F, vec ), UnionOfColumns ), FF2( basis_indices[i], A, B )*Q );
        return [ main, vec( current_C) ];
        end );

    matrix :=   Iterated( List( main_list, m -> m[ 1 ] ), UnionOfRows );
    constant := Iterated( List( main_list, m -> m[ 2 ] ), UnionOfRows );
    sol := LeftDivide( matrix, constant );
    if sol = fail then
        return fail;
    else
        return EntriesOfHomalgMatrix( CertainRows( sol, [ 1..Length( b ) ] ) );
    fi;
end;

InstallMethodWithCache( BasisOfExternalHom, 
    [ IsCapCategoryObject, IsCapCategoryObject ],
    function( M, N )
    local generators, i, basis;
    if IsStableCategoryObject( M ) and IsStableCategoryObject( N ) then

        generators := GeneratorsOfExternalHom( M, N );
        if generators = [ ] then
            return [ ];
        fi;
        basis := [ generators[ 1 ] ];
        for i in [ 2 .. Length( generators ) ] do
            if WithComments = true then
                Print( "Testing the redundancy of the ", i, "'th morphism out of ", Length( generators ), "morphisms!." );
            fi;
            if graded_compute_coefficients_for_stable_morphisms( basis, generators[ i ] ) = fail then
                Add( basis, generators[ i ] );
            fi;
        od;
        return basis;
    else
        TryNextMethod( );
    fi;
end );

InstallMethodWithCache( BasisOfExternalHom, [ IsCapCategoryObject, IsCapCategoryObject ],
    function( M, N )
    if HasUnderlyingHomalgRing( M ) and IsExteriorRing( UnderlyingHomalgRing( M ) ) then
        graded_basis_of_external_hom( M, N );
    else
        TryNextMethod( );
    fi;
end );

DeclareAttribute( "iso_to_reduced_stable_module", IsStableCategoryObject );
DeclareAttribute( "iso_from_reduced_stable_module", IsStableCategoryObject );

InstallMethod( iso_to_reduced_stable_module,
            [ IsStableCategoryObject ],
    function( M )
    local m, hM, s, rM, cM, iso;
    cM := UnderlyingUnstableObject( M );
    m := is_reduced_graded_module( cM );
    if m = true then
        hM := AsPresentationInHomalg( cM );
        ByASmallerPresentation( hM );
        s := PositionOfTheDefaultPresentation( hM );
        rM := AsGradedLeftPresentation( MatrixOfRelations( hM ), DegreesOfGenerators( hM ) );
        return AsStableMorphism( GradedPresentationMorphism( cM, TransitionMatrix( hM, 1, s ), rM ) );
    else
        iso := PreCompose( AsStableMorphism( CokernelProjection( m[ 2 ] ) ), iso_to_reduced_stable_module( AsStableObject( CokernelObject( m[ 2 ] ) ) ) );
        Assert( 3, IsIsomorphism( iso ) );
        SetIsIsomorphism( iso, true );
        return iso;
    fi;
end );

InstallMethod( iso_from_reduced_stable_module,
            [ IsStableCategoryObject ],
    function( M )
    return Inverse( iso_to_reduced_stable_module( M ) );
end );

# for a morphism between two free modules of rank 1 and with degrees 1, ..., n
# o(-1) <-> p_1, ..., o(-n) <-> p_n

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
    return graded_basis_of_external_hom( M, N );
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
IsFiniteDimensionalGradedLeftPresentation := function(M)
                                            return IsZero(HilbertPolynomial(AsPresentationInHomalg(M)));
                                            end;
C := FullSubcategoryByMembershipFunction(graded_lp_cat_sym, IsFiniteDimensionalGradedLeftPresentation );
coh := graded_lp_cat_sym / C;
cochains_coh := CochainComplexCategory( coh );
cochains_cochains_coh := CochainComplexCategory( cochains_coh );
bicomplexes_of_coh := AsCategoryOfBicomplexes( cochains_cochains_coh );
SetIsBicomplexCategoryWithCommutativeSquares( bicomplexes_of_coh, with_commutative_squares );

# The sheafification functor
Sh := CanonicalProjection( coh );
ChSh := ExtendFunctorToCochainComplexCategoryFunctor(Sh);
BiSh := ExtendFunctorToCohomologicalBicomplexCategoryFunctor(Sh);


##
St := CapFunctor( "modules to stable modules", graded_lp_cat_sym, stable_lp_cat_ext );
AddObjectFunction( St,
	function( M )
	local tM;
	tM := TateResolution( M );
	return AsStableObject( Source( CyclesAt( tM, 0 ) ) );
end );

AddMorphismFunction( St,
	function( s, f, r )
	local tf;
	tf := TateResolution( f );
	return AsStableMorphism( KernelLift( Range( tf )^0, PreCompose( CyclesAt( Source( tf ), 0 ), tf[ 0 ] ) ) );
end );

##
AsStable := CapFunctor( "as stable functor", graded_lp_cat_ext, stable_lp_cat_ext );
AddObjectFunction( AsStable, AsStableObject );
AddMorphismFunction( AsStable,
	function( s, f, r )
	return AsStableMorphism( f );
end );

w_A := function(k)
	return ApplyFunctor( TwistFunctor( A, k ),
			     GradedFreeLeftPresentation( 1, A, [ Length( IndeterminatesOfExteriorRing( A ) ) ] ) );
end;

RR := RFunctor( S );
ChRR := ExtendFunctorToCochainComplexCategoryFunctor( RR );
LL := LFunctor( S );
ChLL := ExtendFunctorToCochainComplexCategoryFunctor( LL );
TT := TateFunctor( S );

Trunc_leq_m1 := BrutalTruncationAboveFunctor( cochains_graded_lp_cat_sym, -1 );;

KeyDependentOperation( "_Trunc_leq_rm1", IsHomalgGradedRing, IsInt, ReturnTrue );
InstallMethod( _Trunc_leq_rm1Op,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return BrutalTruncationAboveFunctor( cochains_graded_lp_cat_ext, r - 1 );
end );


KeyDependentOperation( "_Trunc_g_rm1", IsHomalgGradedRing, IsInt, ReturnTrue );
InstallMethod( _Trunc_g_rm1Op,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return BrutalTruncationBelowFunctor( cochains_graded_lp_cat_ext, r - 1 );
end );

ChTrunc_leq_m1 := ExtendFunctorToCochainComplexCategoryFunctor( Trunc_leq_m1 );;

# the functor from the category of bicomplexes to cochains that returns the cochain of vertical cohomologies
# at row -1

Cochain_of_ver_coho_sym := ComplexOfVerticalCohomologiesFunctorAt( bicomplexes_of_graded_lp_cat_sym, -1 );
Cochain_of_ver_coho_coh := ComplexOfVerticalCohomologiesFunctorAt( bicomplexes_of_coh, -1 );

Coh0_sym := CohomologyFunctorAt( cochains_graded_lp_cat_sym, graded_lp_cat_sym, 0 );
Coh0_coh := CohomologyFunctorAt( cochains_coh, coh, 0 );

KeyDependentOperation( "_Cochain_of_hor_coho_sym_rm1", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "_Cochain_of_hor_coho_coh_rm1", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "_Coh_mr_sym", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "_Coh_mr_coh", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "_Coh_r_ext", IsHomalgGradedRing, IsInt, ReturnTrue );

##
InstallMethod( _Coh_r_extOp,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return CohomologyFunctorAt( cochains_graded_lp_cat_ext, graded_lp_cat_ext, r );
end );

##
InstallMethod( _Cochain_of_hor_coho_sym_rm1Op,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return ComplexOfHorizontalCohomologiesFunctorAt( bicomplexes_of_graded_lp_cat_sym, r - 1 );
end );

##
InstallMethod( _Cochain_of_hor_coho_coh_rm1Op,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return ComplexOfHorizontalCohomologiesFunctorAt( bicomplexes_of_coh, r - 1 );
end );

##
InstallMethod( _Coh_mr_symOp,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return CohomologyFunctorAt( cochains_graded_lp_cat_sym, graded_lp_cat_sym, -r );
end );

##
InstallMethod( _Coh_mr_cohOp,
            [ IsHomalgGradedRing, IsInt ],
    function( S, r )
    return CohomologyFunctorAt( cochains_coh, coh, -r );
end );


# Ch(Ch( graded_lp_cat_sym )) -> Bicomplex( graded__lp_cat_sym)

ChCh_to_Bi_sym := ComplexOfComplexesToBicomplexFunctor(cochains_cochains_graded_lp_cat_sym, bicomplexes_of_graded_lp_cat_sym );;

## This functor gives back the beilinson complex as a complex of S-modules.
## It is quick and one can see how its objects are direct sums of twisted cotangent bundles.
Beilinson_complex_sym := CapFunctor( "Beilinson Complex functor (Output is cochains of S-modules)",
                        graded_lp_cat_sym, cochains_graded_lp_cat_sym );
AddObjectFunction( Beilinson_complex_sym,
    function( M )
    local C, n;
    n := Length( IndeterminatesOfPolynomialRing( UnderlyingHomalgRing( M ) ) );
    C := ApplyFunctor(
        PreCompose( [ TT, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, Cochain_of_ver_coho_sym ] ), M );;
    SetLowerBound( C, -n );
    SetUpperBound( C, n );
    return C;
end );

AddMorphismFunction( Beilinson_complex_sym,
    function( new_source, f, new_range )
    return ApplyFunctor(
        PreCompose( [ TT, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, Cochain_of_ver_coho_sym ] ), f );;
end );

## This method is very very expensive since the bicomplex is in the category of 
## bicomplexes of Serre quotient category.
Beilinson_complex_Serre_v1 := CapFunctor( "Beilinson Complex functor (Output is cochain of sheaves)",
                            graded_lp_cat_sym, cochains_coh );
AddObjectFunction( Beilinson_complex_Serre_v1,
    function( M )
    return ApplyFunctor(
        PreCompose( [ TT, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, BiSh, Cochain_of_ver_coho_coh ] ), M );;
end );

AddMorphismFunction( Beilinson_complex_Serre_v1,
    function( new_source, f, new_range )
    return ApplyFunctor(
        PreCompose( [ TT, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, BiSh, Cochain_of_ver_coho_coh ] ), f );;
end );

## This method is better, it computes the complex as a complex of modules then applies 
## the sheafification functor.
Beilinson_complex_Serre_v2 := CapFunctor( "Beilinson Complex functor (Output is cochain of sheaves)",
                            graded_lp_cat_sym, cochains_coh );
AddObjectFunction( Beilinson_complex_Serre_v2,
    function( M )
    return ApplyFunctor( PreCompose( [ Beilinson_complex_sym, ChSh ] ), M );;
end );

AddMorphismFunction( Beilinson_complex_Serre_v2,
    function( new_source, f, new_range )
    return ApplyFunctor( PreCompose( [ Beilinson_complex_sym, ChSh ] ), f );;
end );

# This should be later changed to use the homalg command: TruncatedModule, etc...
# 
KeyDependentOperation( "GeneratedByHomogeneousPart_sym", IsHomalgRing, IsInt, ReturnTrue );

InstallMethod( GeneratedByHomogeneousPart_symOp,
        [ IsHomalgRing, IsInt ],
  function( S, r )
    local F;
    
    if r < 2 then
        Error( "please choose the second argument to be greater than 2; received ", r, "\n" );
    fi;
    
    F := CapFunctor( "GeneratedByHomogeneousPart_sym", graded_lp_cat_sym, graded_lp_cat_sym );
    
    AddObjectFunction( F,
      function( M )
        return GradedLeftPresentationGeneratedByHomogeneousPart( M, r );
    end );
    
    AddMorphismFunction( F,
      function( source, f, range )
        local M1, M2, emb1, emb2;
        
        M1 := Source( f );
        M2 := Range( f );
        
        M1 := GradedLeftPresentationGeneratedByHomogeneousPart( M1, r );
        M2 := GradedLeftPresentationGeneratedByHomogeneousPart( M2, r );
        
        emb1 := EmbeddingInSuperObject( M1 );
        emb2 := EmbeddingInSuperObject( M2 );
        
        return LiftAlongMonomorphism( emb2, PreCompose( emb1, f ) );
        
    end );
    
    return F;
    
end );

KeyDependentOperation( "Nat_3", IsHomalgRing, IsInt, ReturnTrue );

InstallMethod( Nat_3Op,
        [ IsHomalgRing, IsInt ],
        
  function( S, r )
    local nat;
    
    nat := NaturalTransformation( "from GeneratedByHomogeneousPart-functor to identity functor",
                     GeneratedByHomogeneousPart_sym( S, r ), IdentityFunctor( graded_lp_cat_sym ) );
    AddNaturalTransformationFunction( nat,
      function( source, M, range )
        
        return EmbeddingInSuperObject( GradedLeftPresentationGeneratedByHomogeneousPart( M, r ) );
        
    end );
    
    return nat;
    
end );


# KeyDependentOperation methods to construct the natural isomorphism.

# Beilinson of M means  Sh( H0( Beilinson_complex_sym( M ) ) )
# This is the fastest way, i.e., we we can define the Beilinson of M to be 
# H0( Beilinson_complex_Serre_v1,2( M ) ) but that would be too expensive.

KeyDependentOperation( "TruncationToBeilinson", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( TruncationToBeilinsonOp,
                [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    local a, CV, CH, i1, i2, p1, p2, L, iso, Trunc_leq_rm1,
        indices, Cochain_of_hor_coho_sym_rm1, mono;
    if r < Maximum( 2, CastelnuovoMumfordRegularity( M ) ) then
        Error( "r should be >= maximim(2, reg(M))" );
    fi;
    Trunc_leq_rm1 := _Trunc_leq_rm1(S,r);
    Cochain_of_hor_coho_sym_rm1 := _Cochain_of_hor_coho_sym_rm1(S,r);

    a := ApplyFunctor( PreCompose( [ TT, Trunc_leq_rm1, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M );
    CV := ApplyFunctor( Cochain_of_ver_coho_sym, a );;
    CH := ApplyFunctor( Cochain_of_hor_coho_sym_rm1, a );;
    i1 := GeneralizedEmbeddingOfCohomologyAt( CH, -r );;
    i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt( a, r-1, -r );;
    p1 := GeneralizedProjectionOntoVerticalCohomologyAt( a, 0, -1 );;
    p2 := GeneralizedProjectionOntoCohomologyAt( CV, 0 );
    indices := Reversed( List( [ 1 .. r-1 ], i -> [ i, -i ] ) );;
    L := List( indices,i -> GeneralizedMorphismByCospan(
            VerticalDifferentialAt( a, i[1], i[2]-1 ),
            HorizontalDifferentialAt( a, i[1]-1, i[2] ) ) );;
    cospan_to_span := FunctorFromCospansToSpans( graded_lp_cat_sym );;
    L := List( L, l -> ApplyFunctor( cospan_to_span, l ) );;
    mono := PreCompose( Concatenation( [ i1, i2 ], L, [ p1, p2 ] ) );
    iso := SerreQuotientCategoryMorphism( coh, ApplyFunctor( span_to_three_arrows, mono ) );
    return iso;
end );

KeyDependentOperation( "TruncToTrunc1", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( TruncToTrunc1Op,
                [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    local tM, lift, P, phi;
    if r < Maximum( 2, CastelnuovoMumfordRegularity( M ) ) then
        Error( "r should be >= maximum(2, reg(M))" );
    fi;
    tM := ApplyFunctor( PreCompose( [ TT ] ), M );
    lift := KernelLift( tM^r, tM^(r-1) );
    P := Range( lift );
    phi := CochainMorphism(
        ApplyFunctor( _Trunc_leq_rm1(S,r), tM ),
        StalkCochainComplex( P, r - 1 ),
        [ lift ], r - 1 );
    phi := ApplyFunctor(
        PreCompose( [ ChLL, ChCh_to_Bi_sym, _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh ] ),
         phi );
    return phi;
end );

KeyDependentOperation( "TruncToTrunc2", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( TruncToTrunc2Op,
    [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    local tM, M_geq_r,f,P,Mr,Pr,emb_Mr_in_P, emb_Pr_in_P,lift, LP,mat,mor;
    if r < Maximum( 2, CastelnuovoMumfordRegularity( M ) ) then
        Error( "r should be >= maximum(2, reg(M))" );
    fi;
    tM := ApplyFunctor( TT, M );
    M_geq_r := ApplyFunctor( GeneratedByHomogeneousPart_sym(S,r), M );
    f := tM^r;
    P := KernelObject( f );
    Mr := GradedLeftPresentationGeneratedByHomogeneousPart( tM[r], r );
    emb_Mr_in_P := KernelLift( f, EmbeddingInSuperObject( Mr ) );

    Pr := GradedLeftPresentationGeneratedByHomogeneousPart( P, r );
    emb_Pr_in_P := EmbeddingInSuperObject( Pr );
    lift := LiftAlongMonomorphism( emb_Mr_in_P, emb_Pr_in_P );

    LP := ApplyFunctor( LL, P );
    mat := UnderlyingMatrix( lift )*S;
    mor := GradedPresentationMorphism( LP[ -r ], mat, M_geq_r );
    
    if IsBicomplexCategoryWithCommutativeSquares( bicomplexes_of_graded_lp_cat_sym ) then
        return ApplyFunctor( Sh, CokernelColift( LP^(-r-1), mor ) );
    else
        if r mod 2 = 0 then
            return ApplyFunctor( Sh, CokernelColift( AdditiveInverseForMorphisms( LP^(-r-1) ), mor ) );
        else
            return ApplyFunctor( Sh, CokernelColift( LP^(-r-1), mor ) );
        fi;
    fi;
end );

KeyDependentOperation( "TruncToSheaf", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( TruncToSheafOp,
    [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    if r < Maximum( 2, CastelnuovoMumfordRegularity( M ) ) then
        Error( "r should be >= maximum(2, reg(M))" );
    fi;
    return ApplyFunctor( Sh, 
    EmbeddingInSuperObject( GradedLeftPresentationGeneratedByHomogeneousPart( M, r ) ) );
end );

KeyDependentOperation( "BeilinsonToSheaf", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( BeilinsonToSheafOp,
    [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    local l, s, r1, r2, r3;
    if r < Maximum( 2, CastelnuovoMumfordRegularity( M ) ) then
        Error( "r should be >= maximum(2, reg(M))" );
    fi;

    # This is because the bicomplex is with anti-commutative squares
    if r mod 4 = 0 or r mod 4 = 3 then
        s := r;
    elif r mod 4 = 1 then
        s := r + 2;
    else
        s := r + 1;
    fi;

    # if the bicomplexes are with commutative squars then:
    # if r mod 2 = 0 then
    # s := r;
    # else
    #     s := r+1;
    # fi;
    l := TruncationToBeilinson( M, s );
    r1 := TruncToTrunc1( M, s );
    r2 := TruncToTrunc2( M, s );
    r3 := TruncToSheaf( M, s );
    return PreCompose( [ Inverse( l ), r1, r2, r3 ] );
end );


CohomologyOfBeilinsonComplexToSheafification := 
    NaturalTransformation( 
        "Natural isomorphism from Sh(H^0(Beilinson_complex_sym(*))) -> Sh(*)",
        PreCompose( [ Beilinson_complex_sym, Coh0_sym, Sh ] ),
        Sh );
AddNaturalTransformationFunction( CohomologyOfBeilinsonComplexToSheafification,
    function( source, M, range )
    return BeilinsonToSheaf( M, Maximum( 2, CastelnuovoMumfordRegularity( M ) ) );
end );

create_complex := function( n )
local degrees, new_degrees, L, i, matrices, objects, morphisms;

degrees := [ Random( [ -n .. 0 ] ), Random( [ 1 .. n ] ) ];

L := [ degrees ];

for i in [ 2 .. n ] do
new_degrees :=  [ Random( [ degrees[1]+1 .. degrees[2] ] ), degrees[2] + Random([1..3]) ];
Add( L, new_degrees );
degrees := new_degrees;
od;

matrices := List( [ 1 .. n - 1 ], i -> RandomMatrixBetweenGradedFreeLeftModules( L[i], L[i+1], S) );
objects := List( [ 1 .. n ], i -> GradedFreeLeftPresentation(2,S,L[i] ) );
morphisms := List( [ 1 .. n - 1 ], i -> GradedPresentationMorphism( objects[i], matrices[i], objects[i+1]));

return CochainComplex( morphisms, -Int(n/2) );
end;

# Beilinson "functor" of a complex

Beilinson_complex_of_complex_sym := 
    PreCompose( [ TateFunctorForCochains(S), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, Cochain_of_ver_coho_sym ] );

DeclareAttribute( "kamal", IsHomalgGradedRing );
InstallMethod( kamal, [ IsHomalgGradedRing ],
function( S )
local omegas, morphisms, n, k, l, j, current;
n := Length( IndeterminatesOfPolynomialRing( S ) );

omegas := List( [ 1 .. n ], i -> KoszulSyzygyModule( S, i - 1)[ i - 1 ] );
morphisms := Reversed( List( [ 1 .. n -1 ], i -> GeneratorsOfExternalHom( omegas[i+1], omegas[i]) ) );

for j in [ 2 .. n-1] do
    current := [ ];
    for k in [ 1 .. n ] do
    for l in [ 1 .. n ] do
        if IsZeroForMorphisms( PreCompose( morphisms[j-1][k], morphisms[j][l] ) ) then
            current[k] := morphisms[j][l];
        fi;
    od;
    od;
    morphisms[ j ] := current;
od;

for j in [ 2 .. n-1] do
    for k in [ 1 .. n ] do
    for l in [ 1 .. n ] do
        if k <> l and IsEqualForMorphisms( PreCompose( morphisms[j-1][k], morphisms[j][l] ),
             PreCompose( morphisms[j-1][l], morphisms[j][k] ) ) then
            morphisms[ j ][ l ] := -morphisms[ j ][ l ];
        elif k <> l and not IsEqualForMorphisms( PreCompose( morphisms[j-1][k], morphisms[j][l] ),
             -PreCompose( morphisms[j-1][l], morphisms[j][k] ) ) then
            Print( "unexpected!");
        fi;
    od;
    od;
od;

return morphisms;
end );

DeclareAttribute( "saleh", IsHomalgGradedRing );
InstallMethod( saleh, [ IsHomalgGradedRing ],
function( S )
local o_s, morphisms, o, matrices, n;
n := Length( IndeterminatesOfPolynomialRing( S ) );

matrices := List( Indeterminates( S ), x -> HomalgMatrix( [[x]],1,1,S) );

o := GradedFreeLeftPresentation( 1, S, [ 0 ] );
o_s := Reversed( List( [ 1 .. n ], i -> o[ -i ] ) );

morphisms := List( [ 1 .. n - 1 ], 
                i -> List( [ 1 .. n ], 
                    j -> GradedPresentationMorphism( o_s[ i ], matrices[j], o_s[ i + 1 ] ) ) );
return morphisms;
end );

DeclareAttribute( "MorphismFromCanonicalKoszulSyzygyModule", IsGradedLeftPresentation );

DeclareAttribute( "MorphismIntoCanonicalKoszulSyzygyModule", IsGradedLeftPresentation );
InstallMethod( MorphismIntoCanonicalKoszulSyzygyModule,
    [ IsGradedLeftPresentation ],
function( some_omega )
local mat, S, n, L, index, G;

mat := UnderlyingMatrix( some_omega );
S := UnderlyingHomalgRing( some_omega );
n := Length( IndeterminatesOfPolynomialRing( S ) );
if NrColumns( mat ) = 1 and NrRows( mat ) = n then
    SetMorphismFromCanonicalKoszulSyzygyModule( some_omega, UniversalMorphismFromZeroObject( some_omega ) );
    return UniversalMorphismIntoZeroObject( some_omega );
fi;
if NrRows( mat ) = 0 then
    SetMorphismFromCanonicalKoszulSyzygyModule( some_omega, IdentityMorphism( some_omega ) );
    return IdentityMorphism( some_omega );
fi;
L := List( [ 0 .. n - 1 ], i-> [ Binomial( n, i-1 ), Binomial( n, i ) ] );
index := n - Position( L, [ NrRows(mat), NrColumns(mat) ] );
G := GeneratorsOfExternalHom(some_omega, KoszulSyzygyModule(S,index)[index] );
if Length( G ) <> 1 then
    Error( "unexpected thing happend" );
fi;
SetMorphismFromCanonicalKoszulSyzygyModule( some_omega, Inverse( G[1] ) );
return G[1];
end );


DeclareAttribute( "CanonicalizeOmegaModule", IsGradedLeftPresentation );
InstallMethod( CanonicalizeOmegaModule, [ IsGradedLeftPresentation ],
function( some_omega )
local mat, S, n, L, index, K;

mat := UnderlyingMatrix( some_omega );
S := UnderlyingHomalgRing( some_omega );
n := Length( IndeterminatesOfPolynomialRing( S ) );
if NrColumns( mat ) = 1 and NrRows( mat ) = n then
    ZeroObject( CapCategory( some_omega ) )!.index := -1;
    return ZeroObject( CapCategory( some_omega ) );
fi;
if NrRows( mat ) = 0 then
    some_omega!.index := n - 1;
    return some_omega;
fi;

L := List( [ 0 .. n - 1 ], i-> [ Binomial( n, i-1 ), Binomial( n, i ) ] );
index := n - Position( L, [ NrRows(mat), NrColumns(mat) ] );
K := KoszulSyzygyModule( S, index )[ index ];
K!.index := index;
return K;
end );

DeclareAttribute( "CanonicalizeOmegaModule", IsGradedLeftPresentationMorphism );
InstallMethod( CanonicalizeOmegaModule, [ IsGradedLeftPresentationMorphism ],
function( phi )
MorphismIntoCanonicalKoszulSyzygyModule( Source( phi ) );
return PreCompose( [ 
    MorphismFromCanonicalKoszulSyzygyModule( Source( phi ) ),
    phi,
    MorphismIntoCanonicalKoszulSyzygyModule( Range( phi ) )
] );
end );

DeclareAttribute( "CanonicalizeDirectSumOfOmegaModules", IsGradedLeftPresentation );
InstallMethod( CanonicalizeDirectSumOfOmegaModules, [ IsGradedLeftPresentation ],
function( M )
local mat, S, n, L, non_zeros, length_non_zeros, degrees, current_degrees, current_mat, p, omega, N, irrelevant_module;

S := UnderlyingHomalgRing( M );
n := Length( IndeterminatesOfPolynomialRing( S ) );
L := List( [ 0 .. n - 1 ], i-> [ Binomial( n, i-1 ), Binomial( n, i ) ] );
mat := UnderlyingMatrix( M );

if NrRows(mat) = 0 and NrColumns(mat) <> 0 then
    return List( [ 1 .. NrColumns(mat) ], i -> GradedFreeLeftPresentation(1,S,[ GeneratorDegrees(M)[i] ] ) );
fi;

if NrRows(mat) = 0 and NrColumns(mat) = 0 then
    return [ZeroObject( M ) ];
fi;

non_zeros := Filtered( EntriesOfHomalgMatrix( CertainColumns( mat, [1] ) ), e -> IsZero(e)<> true );
length_non_zeros := Length( non_zeros );
if length_non_zeros = n then
    non_zeros := HomalgMatrix( non_zeros, n, 1, S );
    irrelevant_module := AsGradedLeftPresentation( non_zeros, GeneratorDegrees(M){[1]} );

    degrees := GeneratorDegrees(M){[2..NrColumns(mat)]};
    mat := CertainColumns( CertainRows( mat, [ n + 1 .. NrRows( mat ) ] ), [ 2 .. NrColumns( mat ) ] );
    N := AsGradedLeftPresentation( mat, degrees );
    return Concatenation( [irrelevant_module ], CanonicalizeDirectSumOfOmegaModules( N ) );
else
    p := length_non_zeros + 1;
    current_degrees := GeneratorDegrees(M){[ 1 .. L[p][2] ] };
    current_mat := CertainColumns( CertainRows( mat, [ 1 .. L[p][1] ] ), [ 1 .. L[p][2] ] );

    omega := AsGradedLeftPresentation( current_mat, current_degrees );

    current_degrees := GeneratorDegrees(M){[ L[p][2]+1 .. NrColumns(mat) ] };
    current_mat := CertainColumns( CertainRows( mat, [ L[p][1]+1 .. NrRows( mat ) ] ), [ L[p][2]+1 .. NrColumns( mat ) ] );

    N := AsGradedLeftPresentation( current_mat, current_degrees );
    
    return Concatenation( [ omega ], CanonicalizeDirectSumOfOmegaModules( N ) );

fi;

end );

DeclareAttribute( "CanonicalizeMorphismOfDirectSumsOfOmegaModules", IsGradedLeftPresentationMorphism );
InstallMethod( CanonicalizeMorphismOfDirectSumsOfOmegaModules, [ IsGradedLeftPresentationMorphism ],
    function( phi )
    local direct_summand_of_range, direct_summand_of_source, L;
    direct_summand_of_source := CanonicalizeDirectSumOfOmegaModules( Source( phi ) );
    direct_summand_of_range := CanonicalizeDirectSumOfOmegaModules( Range( phi ) );
    L := List( [ 1 .. Length( direct_summand_of_source ) ], 
        i -> List( [ 1 .. Length( direct_summand_of_range ) ],
            j -> PreCompose(
                [
                    InjectionOfCofactorOfDirectSum(direct_summand_of_source, i),
                    phi,
                    ProjectionInFactorOfDirectSum(direct_summand_of_range, j )
                ]
            )));
    return L;
end );

DeclareAttribute( "CanonicalizeMorphismOfDirectSumsOfOModules", IsGradedLeftPresentationMorphism );
InstallMethod( CanonicalizeMorphismOfDirectSumsOfOModules, [ IsGradedLeftPresentationMorphism ],
    function( phi )
    local direct_summand_of_range, direct_summand_of_source, L;
    direct_summand_of_source := List( GeneratorDegrees( Source( phi ) ), 
            d -> GradedFreeLeftPresentation( 1, S, [ d ] ) ); 
    direct_summand_of_range := List( GeneratorDegrees( Range( phi ) ), 
            d -> GradedFreeLeftPresentation( 1, S, [ d ] ) ); 
    if direct_summand_of_source = [ ] then
        direct_summand_of_source := [ ZeroObject( phi ) ];
    fi;

    if direct_summand_of_range = [ ] then
        direct_summand_of_range := [ ZeroObject( phi ) ];
    fi;

    L := List( [ 1 .. Length( direct_summand_of_source ) ], 
        i -> List( [ 1 .. Length( direct_summand_of_range ) ],
            j -> PreCompose(
                [
                    InjectionOfCofactorOfDirectSum(direct_summand_of_source, i),
                    phi,
                    ProjectionInFactorOfDirectSum(direct_summand_of_range, j )
                ]
            )));
    return L;
end );

Canonicalize := CapFunctor( "canonicalize functor", graded_lp_cat_sym, graded_lp_cat_sym );
AddObjectFunction( Canonicalize,
function( M )
local L;
L := CanonicalizeDirectSumOfOmegaModules( M );
L := List( L, CanonicalizeOmegaModule );
if L = [] then
    return ZeroObject( CapCategory( M ) );
fi;
return DirectSum( L );
end );

AddMorphismFunction( Canonicalize,
function( source, phi, range )
local L;
if IsZero( phi ) then 
    return ZeroMorphism( source, range );
fi;
L := CanonicalizeMorphismOfDirectSumsOfOmegaModules( phi );
L := List( L, l -> List( l, CanonicalizeOmegaModule ) );
L := MorphismBetweenDirectSums( L );
return L;
end );

Canonicalize := ExtendFunctorToCochainComplexCategoryFunctor( Canonicalize );

DeclareOperation( "BasisBetweenCotangentBundles", [ IsHomalgGradedRing, IsInt, IsInt ] );
InstallMethodWithCache( BasisBetweenCotangentBundles, 
        "this should return the basis of Hom( omega^i(i),omega^j(j) )",
        [ IsHomalgGradedRing, IsInt, IsInt ],
    function( S, i, j )
    local G, n, index, combinations, L;
    if i<j then
        return [];
    fi;

    if i = j then
        return [ IdentityMorphism( KoszulSyzygyModule( S, i)[i] ) ];
    fi;

    G := kamal( S );
    
    n := Length( IndeterminatesOfPolynomialRing( S ) );

    index := n - i;
    combinations := Combinations( [ 1 .. n ], i - j );
    combinations := List( combinations, comb -> Reversed( comb ) );

    L := List( combinations, comb -> List( [ 1 .. i - j ], k-> G[index+k-1][comb[k]] ) );
    return List( L, l -> PreCompose(l) );
end );


DeclareOperation( "BasisBetweenVectorBundles", [ IsHomalgGradedRing, IsInt, IsInt ] );
InstallMethodWithCache( BasisBetweenVectorBundles, 
    [ IsHomalgGradedRing, IsInt, IsInt ],
    function( S, i, j )
    local n, L, source_index, range_index, d, indices, index;

    n := Length( IndeterminatesOfPolynomialRing( S ) );
    
    if i >= 0 or j >= 0 or i < -n or j < -n then
        Error( "wrong input\n");
    fi;

    if i > j then
        return [ ];
    fi;

    if i = j then
        return [ IdentityMorphism( GradedFreeLeftPresentation( 1, S, [ -i ] ) ) ];
    fi;

    L := saleh( S );

    source_index := Position( [ -n .. -1 ], i );
    range_index := Position( [ -n .. -1 ], j );

    d := range_index - source_index;

    indices := Cartesian( List( [ 1 .. d ], i -> [ 1 .. n ] ) );;
    for index in indices do
        Sort( index );
    od;
    indices := Set( indices );;

    return List( indices, index -> 
        PreCompose( List( [ 1 .. d ], i -> L[i+source_index-1][index[i]]) ) );

end );

DeclareAttribute( "MorphismToListOfRecords_Cotangents", IsGradedLeftPresentationMorphism );
InstallMethod( MorphismToListOfRecords_Cotangents, 
    [ IsGradedLeftPresentationMorphism ],
function( phi)
local source, range, G, mat, n, L, i, j, zero_obj;
source := Source( phi );
range := Range( phi );

S := UnderlyingHomalgRing( phi );
n := Length( IndeterminatesOfPolynomialRing( S ) );

L := List( [ 1 .. n ], k -> KoszulSyzygyModule(S,k-1)[k-1] );
zero_obj := ZeroObject( CapCategory( phi ) );
L := Concatenation( [ zero_obj ], L );

if Position( L, source ) = fail or Position( L, range ) = fail then
    L := CanonicalizeMorphismOfDirectSumsOfOmegaModules( phi );
    return List( L, l -> List( l, f -> MorphismToListOfRecords_Cotangents( f )[1][1] ) );
fi;

i := Position( L, source )-2;
j := Position( L, range )-2;

if i = -1 or j = -1 then
    return [ [ rec( indices := [i, j], coefficients := [] ) ] ];
fi;

if i<j then
    return [ [ rec( indices := [i,j], coefficients := [] ) ] ];
fi;

G := ShallowCopy( BasisBetweenCotangentBundles( S, i, j ) );
#G := GeneratorsOfExternalHom( source, range );
G := List( G, UnderlyingMatrix );
G := UnionOfRows( List( G, 
    g -> UnionOfColumns( List( [ 1 .. NrRows( g ) ], i -> CertainRows( g, [i] ) ) ) ) );
mat := UnderlyingMatrix( phi );
mat := UnionOfColumns( List( [ 1 .. NrRows( mat ) ], i -> CertainRows( mat, [i] ) ) );
return [ [ rec( indices := [i,j], coefficients := EntriesOfHomalgMatrix( RightDivide( mat, G) ) ) ] ];
end );

DeclareAttribute( "MorphismToListOfRecords_VectorBundles", IsGradedLeftPresentationMorphism );
InstallMethod( MorphismToListOfRecords_VectorBundles, 
    [ IsGradedLeftPresentationMorphism ],
function( phi)
local source, range, G, mat, n, L, i, j, zero_obj, o;
source := Source( phi );
range := Range( phi );

S := UnderlyingHomalgRing( phi );
n := Length( IndeterminatesOfPolynomialRing( S ) );

L := List( [ 1 .. n ], k -> GradedFreeLeftPresentation( 1, S, [ k ] ) );

zero_obj := ZeroObject( CapCategory( phi ) );
L := Concatenation( L, [ zero_obj ] );

if Position( L, source ) = fail or Position( L, range ) = fail then
    L := CanonicalizeMorphismOfDirectSumsOfOModules( phi );
    return List( L, l -> List( l, f -> MorphismToListOfRecords_VectorBundles( f )[1][1] ) );
fi;

i := Position( L, source );
j := Position( L, range );

if i = n+1 or j = n+1 then
    return [ [ rec( indices := [-i, -j], coefficients := [] ) ] ];
fi;

if i<j then
    return [ [ rec( indices := [-i,-j], coefficients := [] ) ] ];
fi;

G := ShallowCopy( BasisBetweenVectorBundles( S, -i, -j ) );
G := List( G, UnderlyingMatrix );
G := UnionOfRows( G );
mat := UnderlyingMatrix( phi );
return [ [ rec( indices := [-i,-j], coefficients := EntriesOfHomalgMatrix( RightDivide( mat, G) ) ) ] ];
end );


morphism_between_cotangent_bundles := function( S, r )
local cat, coefficients, indices;
cat := GradedLeftPresentations( S );
indices := r!.indices;
coefficients := List( r.coefficients, c -> String(c)/S );
if indices = [ -1, -1 ] then
    return ZeroMorphism( ZeroObject(cat), ZeroObject( cat ) );
elif indices[ 1 ] = -1 then
    return UniversalMorphismFromZeroObject( KoszulSyzygyModule( S, indices[2] )[ indices[2] ] );
elif indices[ 2 ] = -1 then
    return UniversalMorphismIntoZeroObject( KoszulSyzygyModule( S, indices[1] )[ indices[1] ] );
else
    return coefficients*BasisBetweenCotangentBundles( S, indices[1], indices[2] );
fi;
end;

morphism_between_vector_bundles := function( S, r )
local cat, coefficients, indices, n;
cat := GradedLeftPresentations( S );
n := Length( IndeterminatesOfPolynomialRing( S ) );
indices := r!.indices;
coefficients := List( r.coefficients, c -> String(c)/S );
if indices = [ -n-1, -n-1 ] then
    return ZeroMorphism( ZeroObject(cat), ZeroObject( cat ) );
elif indices[ 1 ] = -n-1 then
    return UniversalMorphismFromZeroObject( GradedFreeLeftPresentation( 1, S, [ -indices[ 2 ] ] ) );
elif indices[ 2 ] = -n-1 then
    return UniversalMorphismIntoZeroObject( GradedFreeLeftPresentation( 1, S, [ -indices[ 1 ] ] ) );
else
    return coefficients*BasisBetweenVectorBundles( S, indices[1], indices[2] );
fi;
end;



DeclareOperation( "ListOfRecordsToMorphism_Cotangents", [ IsHomalgGradedRing, IsList ] );
InstallMethod( ListOfRecordsToMorphism_Cotangents, [ IsHomalgGradedRing, IsList ],
function( S, L )
return MorphismBetweenDirectSums( List( L, l -> List( l, r -> morphism_between_cotangent_bundles( S, r ) ) ) ); 
end );

DeclareOperation( "ListOfRecordsToMorphism_VectorBundles", [ IsHomalgGradedRing, IsList ] );
InstallMethod( ListOfRecordsToMorphism_VectorBundles, [ IsHomalgGradedRing, IsList ],
function( S, L )
return MorphismBetweenDirectSums( List( L, l -> List( l, r -> morphism_between_vector_bundles( S, r ) ) ) ); 
end );

set_bounds := function( f, a, b )
SetLowerBound( f, a );
SetLowerBound( Source(f), a );
SetLowerBound( Range(f), a );
SetUpperBound( f, b );
SetUpperBound( Source(f), b );
SetUpperBound( Range(f), b );
end;


# To compute Beilinson complex there is three functors 
#    *Beilinson_complex_sym
#    *Beilinson_complex_Serre_v1
#    *Beilinson_complex_Serre_v2
# In the first one, we get a complex of graded S-modules.
# In the second and third, we get a complex of coherent sheaves 
# (i.e., a complex in Serre Quotient category)
# Serre_v1: it is complex of vertical cohomologies of a bicomplex in Serre quotient (very slow)
# Serre_v2: it is nothing but the sheafification of Beilinson_complex_sym (quicker than v1)

# I would recommend testing this example with S=Q[x0,x1], because over bigger rings computing 
# G will take more time.

# m := RandomMatrixBetweenGradedFreeLeftModules([4],[1,2,1,2,3],S);
# M := AsGradedLeftPresentation(m,[1,2,1,2,3]);
# n := RandomMatrixBetweenGradedFreeLeftModules([4,5],[1,2,1,2],S);
# N := AsGradedLeftPresentation(n,[1,2,1,2]);
# G := GeneratorsOfExternalHom(M,N);
# f := Random(G);
# 
# CohomologyOfBeilinsonComplexToSheafification;
# 
# FF := Source( CohomologyOfBeilinsonComplexToSheafification );
# GG := Range( CohomologyOfBeilinsonComplexToSheafification );
# 
# FF_f := ApplyFunctor( FF, f );
# GG_f := ApplyFunctor( GG, f );
# 
# mu_M := ApplyNaturalTransformation( CohomologyOfBeilinsonComplexToSheafification, M );
# mu_N := ApplyNaturalTransformation( CohomologyOfBeilinsonComplexToSheafification, N );
# 
# IsWellDefined( mu_M );
# IsWellDefined( mu_N );
# 
# IsIsomorphism( mu_M );
# IsIsomorphism( mu_N );
# 
# p1 := PreCompose( mu_M, GG_f );
# p2 := PreCompose( FF_f, mu_N );
# 
# IsCongruentForMorphisms(p1,p2);
# Beilinson_sym := ApplyFunctor( Beilinson_complex_sym, M );
# IsWellDefined( Beilinson_sym, -3, 3 );
# Display( Beilinson_sym, -3, 3 );
# 
# Beilinson_Serre_v2 := ApplyFunctor( Beilinson_complex_Serre_v2, M );
# 
# 