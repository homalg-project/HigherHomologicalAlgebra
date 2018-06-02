LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/glp_over_g_exterior_algebra.g" );
ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/complexes_of_graded_left_presentations_over_graded_polynomial_ring.g" );

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

generators_of_stable_hom := function( M, N )
    local basis;
    basis := graded_generators_of_external_hom( UnderlyingUnstableObject(M), UnderlyingUnstableObject(N));
    Apply( basis, AsStableMorphism );
    basis := DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms( b ) ) );
    return basis;
end;

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

basis_of_stable_hom := function( M, N )
local generators, i, basis;

generators := generators_of_stable_hom( M, N );

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
end;

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

# this function can be implemented using the monoidal structure of lp over the polynomial ring
graded_generators_of_external_hom := function( M, N )
	local hM, hN, G;
	hM := AsPresentationInHomalg( M );
	hN := AsPresentationInHomalg( N );
	G := GetGenerators( Hom( hM, hN ) );
	return List( G, AsPresentationMorphismInCAP );
end;

l := InputFromUser( "Please enter l to define the polynomial ring Q[x_0,...,x_l],  l = " );
vars := Concatenation( Concatenation( [ "x0" ] , List( [ 1 .. l ], i -> Concatenation( ",x", String( i ) ) ) ) );
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

Finalize( graded_lp_cat_sym );

# constructing the chain complex category of left presentations over R
chains_lp_cat_sym := ChainComplexCategory( lp_cat_sym : FinalizeCategory := false );
AddLift( chains_lp_cat_sym, compute_lifts_in_chains );
AddColift( chains_lp_cat_sym, compute_colifts_in_chains );
AddIsNullHomotopic( chains_lp_cat_sym, phi -> not Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) = fail );
AddHomotopyMorphisms( chains_lp_cat_sym, compute_homotopy_chain_morphisms_for_null_homotopic_morphism );
Finalize( chains_lp_cat_sym );

# constructing the cochain complex category of left presentations over R
cochains_lp_cat_sym := CochainComplexCategory( lp_cat_sym : FinalizeCategory := false );
AddLift( cochains_lp_cat_sym, compute_lifts_in_cochains );
AddColift( cochains_lp_cat_sym, compute_colifts_in_cochains );
AddIsNullHomotopic( cochains_lp_cat_sym, phi -> not Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) = fail );
AddHomotopyMorphisms( cochains_lp_cat_sym, compute_homotopy_cochain_morphisms_for_null_homotopic_morphism );
Finalize( cochains_lp_cat_sym );

# constructing the chain complex category of graded left presentations over R
chains_graded_lp_cat_sym := ChainComplexCategory( graded_lp_cat_sym : FinalizeCategory := false );
AddLift( chains_graded_lp_cat_sym, compute_lifts_in_chains );
AddColift( chains_graded_lp_cat_sym, compute_colifts_in_chains );
AddIsNullHomotopic( chains_graded_lp_cat_sym, phi -> not Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) = fail );
AddHomotopyMorphisms( chains_graded_lp_cat_sym, compute_homotopy_chain_morphisms_for_null_homotopic_morphism );
Finalize( chains_graded_lp_cat_sym );

# constructing the cochain complex category of graded left presentations over R
cochains_graded_lp_cat_sym := CochainComplexCategory( graded_lp_cat_sym : FinalizeCategory := false );
AddLift( cochains_graded_lp_cat_sym, compute_lifts_in_cochains );
AddColift( cochains_graded_lp_cat_sym, compute_colifts_in_cochains );
AddIsNullHomotopic( cochains_graded_lp_cat_sym, phi -> not Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) = fail );
AddHomotopyMorphisms( cochains_graded_lp_cat_sym, compute_homotopy_cochain_morphisms_for_null_homotopic_morphism );
Finalize( cochains_graded_lp_cat_sym );

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

SetIsFrobeniusCategory( graded_lp_cat_ext, true );
ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( graded_lp_cat_ext );
TurnAbelianCategoryToExactCategory( graded_lp_cat_ext );
SetTestFunctionForStableCategories(graded_lp_cat_ext, CanBeFactoredThroughExactProjective );
Finalize( graded_lp_cat_ext );

cochains_graded_lp_cat_ext := CochainComplexCategory( graded_lp_cat_ext );

stable_lp_cat_ext := StableCategory( graded_lp_cat_ext );
SetIsTriangulatedCategory( stable_lp_cat_ext, true );
ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_lp_cat_ext );
AsTriangulatedCategory( stable_lp_cat_ext );
Finalize( stable_lp_cat_ext );

##
modules_to_stable_module := CapFunctor( "modules to stable modules", graded_lp_cat_sym, stable_lp_cat_ext );
AddObjectFunction( modules_to_stable_module, 
	function( M )
	local tM;
	tM := TateResolution( M );
	return AsStableObject( Source( CyclesAt( tM, 0 ) ) );
	end );
AddMorphismFunction( modules_to_stable_module,
	function( s, f, r )
	local tf;
	tf := TateResolution( f );
	return AsStableMorphism( KernelLift( Range( tf )^0, PreCompose( CyclesAt( Source( tf ), 0 ), tf[ 0 ] ) ) );
	end );

##
as_stable_functor := CapFunctor( "as stable functor", graded_lp_cat_ext, stable_lp_cat_ext );
AddObjectFunction( as_stable_functor, AsStableObject );
AddMorphismFunction( as_stable_functor,
	function( s, f, r )
	return AsStableMorphism( f );
end );

##
#LL := LFunctor( S );
#Lb1 := ApplyFunctor( L, b[1] );
#Display( Lb1, -6, 2 );

p := RandomMatrixBetweenGradedFreeLeftModules( [ 3, 4 ], [ 1, 3, 5 ], S );
P := AsGradedLeftPresentation( p, [ 1, 3, 5 ] );
RR := RFunctor( S );
#RP := ApplyFunctor( R, P );
#Display( Lb1, 0, 5 );

# The output here is stable module that correspondes to O(k) [ the sheafification of S(k) ]
KeyDependentOperation( "TwistedStructureBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
InstallMethod( TwistedStructureBundleOp,
	[ IsHomalgGradedRing, IsInt ],
	function( Sym, k )
	local F;
    	F := GradedFreeLeftPresentation( 1, Sym, [ -k ] );
    	return Source( CyclesAt( TateResolution( F ), 0 ) );
end );

# See Appendix of Vector Bundels over complex projective spaces
KeyDependentOperation( "TwistedCotangentBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
InstallMethod( TwistedCotangentBundleOp,
	[ IsHomalgGradedRing, IsInt ],
	function( A, k )
	local n, F, hF, hM, cM, id, i, mat;
	n := Length( IndeterminatesOfExteriorRing( A ) );
    if k < 0 or k > n - 1 then
        Error( Concatenation( "Cotangent bundels are defined only for 0,1,...,", String( n - 1 ) ) );
    fi;
	F := GradedFreeLeftPresentation( 1, A, [ n - k ] );
	hF := AsPresentationInHomalg( F );
	hM := SubmoduleGeneratedByHomogeneousPart( 0, hF );
	hM := UnderlyingObject( hM );
	cM := AsPresentationInCAP( hM );
	mat := UnderlyingMatrix( cM );
	id := HomalgInitialMatrix( NrColumns( mat ), NrColumns( mat ), A );
	for i in [ 1 .. NrColumns( mat ) ] do
		SetMatElm( id, i, NrColumns( mat )-i+1, One(A) );
	od;
	return AsGradedLeftPresentation( mat*id, Reversed( GeneratorDegrees( cM ) ) );
end );

# See chapter 5, Sheaf cohomology and free resolutions over exterior algebra
KeyDependentOperation( "KoszulSyzygyModule", IsHomalgGradedRing, IsInt, ReturnTrue );
InstallMethod( KoszulSyzygyModuleOp,
	[ IsHomalgGradedRing, IsInt ],
       	function( S, k )
       	local ind, K, koszul_resolution, n;
       	ind := IndeterminatesOfPolynomialRing( S );
       	K := AsGradedLeftPresentation( HomalgMatrix( ind, S ), [ 0 ] );
       	koszul_resolution := ProjectiveResolution( K );
      	return CokernelObject( koszul_resolution^( -k - 2 ) );
end );

w_A := function(k) 
	return ApplyFunctor( TwistFunctor( A, k ), 
			     GradedFreeLeftPresentation( 1, A, [ Length( IndeterminatesOfExteriorRing( A ) ) ] ) ); 
end;

DeclareAttribute( "ToMorphismBetweenCotangentBundles", IsCapCategoryMorphism );
InstallMethod( ToMorphismBetweenCotangentBundles,
    [ IsCapCategoryMorphism ],
    function( phi )
    local A, n, F1, d1, k1, F2, d2, k2, i1, i2, Cotangent_bundle_1, Cotangent_bundle_2, is_zero_obj_1, is_zero_obj_2, l;

    # Omega^i(i) correspondes to E( -n + i ) = E( -n )( i ) = w_i
    # degree of E( -n + i ) is n - i
    # hence i = n  - degree of w_i

    A := UnderlyingHomalgRing( phi );
    n := Length( IndeterminatesOfExteriorRing( A ) );

    F1 := Source( phi );
    if Length( GeneratorDegrees( F1 ) ) <> 1 then 
        Error( "The source must be free of rank 1" );
    fi;

    d1 := GeneratorDegrees( F1 )[ 1 ];
    
    k1 := n - Int( String( d1 ) );

    F2 := Range( phi );
    if Length( GeneratorDegrees( F2 ) ) <> 1 then 
        Error( "The range must be free of rank 1" );
    fi;
     
    d2 := GeneratorDegrees( F2 )[ 1 ];
    k2 := n - Int( String( d2 ) );
    
    is_zero_obj_1 := false;
    if -1 < k1 and k1 < n then
       	Cotangent_bundle_1 := TwistedCotangentBundle( A, k1 );
    else
	    Cotangent_bundle_1 := ZeroObject( CapCategory( phi ) );
	    is_zero_obj_1 := true;
    fi;

    is_zero_obj_2 := false;
    if -1 < k2 and k2 < n then
       	Cotangent_bundle_2 := TwistedCotangentBundle( A, k2 );
    else
	    Cotangent_bundle_2 := ZeroObject( CapCategory( phi ) );
	    is_zero_obj_2 := true;
    fi;
	
    if is_zero_obj_1 or is_zero_obj_2 then
	    return ZeroMorphism( Cotangent_bundle_1, Cotangent_bundle_2 );
    fi;
    
    if IsZeroForMorphisms( phi ) then
	    return ZeroMorphism(  Cotangent_bundle_1, Cotangent_bundle_2 );
    fi;
    # The embedding of a submodule of a graded ring in a free module of rank 1 is unique up to 
    # multiplication by a scalar.
    i1 := MonomorphismIntoSomeInjectiveObject( Cotangent_bundle_1 );
    i2 := MonomorphismIntoSomeInjectiveObject( Cotangent_bundle_2 );
    
    #return Lift( PreCompose( i1, phi ), i2 );
    return LiftAlongMonomorphism( i2, PreCompose( i1, phi ) );
end );

name := Concatenation( "ω_A(i)->ω_A(j) to Ω^i_A(i)->Ω^j_A(j) endofunctor in ", Name( graded_lp_cat_ext ) );
ToMorphismBetweenCotangentBundlesFunctor := CapFunctor( name, graded_lp_cat_ext, graded_lp_cat_ext );
AddObjectFunction( ToMorphismBetweenCotangentBundlesFunctor,
function( M )
local mat, degrees_M, summands_M, list, d, k, n, F;
n := Length( IndeterminatesOfExteriorRing( A ) );
degrees_M := GeneratorDegrees( M );
degrees_M := List( degrees_M, i -> Int( String( i ) ) );
summands_M := List( degrees_M, d -> GradedFreeLeftPresentation(1,A,[d]) );

if summands_M = [ ] then
    return ZeroObject( graded_lp_cat_ext );
fi;

list := [ ];
for F in summands_M do 
    d := GeneratorDegrees( F )[ 1 ];
    
    k := n - Int( String( d ) );
    
    if -1 < k and k < n then
       	Add( list, TwistedCotangentBundle( A, k ) );
    else
	    Add( list, ZeroObject( CapCategory( M ) ) );
    fi;
od;
return DirectSum( list );
end ); 

AddMorphismFunction( ToMorphismBetweenCotangentBundlesFunctor,
function( new_source, t, new_range )
local mat, M, N, degrees_N, degrees_M, summands_N, summands_M, L;
mat := UnderlyingMatrix( t );
M := Source( t );
N := Range( t );
degrees_M := GeneratorDegrees( M );
degrees_N := GeneratorDegrees( N );
degrees_M := List( degrees_M, i -> Int( String( i ) ) );
degrees_N := List( degrees_N, i -> Int( String( i ) ) );
summands_M := List( degrees_M, d -> GradedFreeLeftPresentation(1,A,[d]) );;
summands_N := List( degrees_N, d -> GradedFreeLeftPresentation(1,A,[d]) );;
L := List( [ 1 .. Length( degrees_M ) ], i -> List( [ 1 .. Length( degrees_N ) ], 
        j -> ToMorphismBetweenCotangentBundles( GradedPresentationMorphism( summands_M[i],HomalgMatrix([ MatElm(mat,i,j)],1,1,A), summands_N[j]) ) ) );;
if Concatenation( L ) = [ ] then
    return ZeroMorphism( new_source, new_range );
else
    return MorphismBetweenDirectSums( L );
fi;
end );

