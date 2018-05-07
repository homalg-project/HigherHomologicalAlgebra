LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "BBGG", "/examples/glp_over_g_exterior_algebra/glp_over_g_exterior_algebra.g" );

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

LoadPackage( "BBGG" );
S := GradedRing( HomalgFieldOfRationalsInSingular( )*"x,y" );
SetWeightsOfIndeterminates( S, [ 1, 1 ] );
R := KoszulDualRing( S );
lp_sym := GradedLeftPresentations( S: FinalizeCategory := false );

##
AddEpimorphismFromSomeProjectiveObject( lp_sym, 
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
AddIsProjective( lp_sym,
    function( M )
    local l;
    l := Lift( IdentityMorphism( M ), EpimorphismFromSomeProjectiveObject( M ) );
    if l = fail then
	return false;
    else
	return true;
    fi;
end );

Finalize( lp_sym );

lp_ext := GradedLeftPresentations( R: FinalizeCategory := false );
AddEpimorphismFromSomeProjectiveObject( lp_ext, 
    function( M )
    local hM, U, current_degrees;
    hM := AsPresentationInHomalg( M );
    ByASmallerPresentation( hM );
    U := UnderlyingModule( hM );
    current_degrees := DegreesOfGenerators( hM );
    return GradedPresentationMorphism( 
                GradedFreeLeftPresentation( Length( current_degrees), R, current_degrees ),
                TransitionMatrix( U, PositionOfTheDefaultPresentation(U), 1 )*R,
                M );
end, -1 );  
SetIsFrobeniusCategory( lp_ext, true );
ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( lp_ext );
TurnAbelianCategoryToExactCategory( lp_ext );
SetTestFunctionForStableCategories(lp_ext, CanBeFactoredThroughExactProjective );
Finalize( lp_ext );

stable_lp_ext := StableCategory( lp_ext );
SetIsTriangulatedCategory( stable_lp_ext, true );
ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_lp_ext );
AsTriangulatedCategory( stable_lp_ext );
Finalize( stable_lp_ext );

# Gamma
m := RandomMatrixBetweenGradedFreeLeftModules( [ 2,3,4 ], [ 3,5,4,5 ], R );
n := RandomMatrixBetweenGradedFreeLeftModules( [ 3,2,4 ], [ 5,3,5,4 ], R );
M := AsGradedLeftPresentation( m, [ 3,5,4,5 ] );
N := AsGradedLeftPresentation( n, [ 5,3,5,4 ] );
#b := graded_basis_of_external_hom(M,N);
LL := LFunctor( S );
#Lb1 := ApplyFunctor( L, b[1] );
#Display( Lb1, -6, 2 );

p := RandomMatrixBetweenGradedFreeLeftModules( [ 3, 4 ], [ 2, 2, 1, 5, 6 ], S );
P := AsGradedLeftPresentation( p, [2,2,1, 5, 6] );
RR := RFunctor( S );
#RP := ApplyFunctor( R, P );
#Display( Lb1, 0, 5 );

##
modules_to_stable_module := CapFunctor( "modules to stable modules", lp_sym, stable_lp_ext );
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

