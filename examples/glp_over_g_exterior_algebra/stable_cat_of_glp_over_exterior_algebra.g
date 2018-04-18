LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/glp_over_g_exterior_algebra/glp_over_g_exterior_algebra.g" );

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

basis := [ generators[ 1 ] ];

for i in [ 2 .. Length( generators ) ] do 
    if graded_compute_coefficients_for_stable_morphisms( basis, generators[ i ] ) = fail then
        Add( basis, generators[ i ] );
    fi;
od;

return basis;
end;


R := GradedRing( KoszulDualRing( HomalgFieldOfRationalsInSingular( )*"x,y,z" ) );
SetWeightsOfIndeterminates( R, [ -1,-1, -1 ] );
cat := GradedLeftPresentations( R: FinalizeCategory := false );
SetIsFrobeniusCategory( cat, true );
ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( cat );
TurnAbelianCategoryToExactCategory( cat );
SetTestFunctionForStableCategories(cat, CanBeFactoredThroughExactProjective );
Finalize( cat );

stable_cat := StableCategory( cat );
SetIsTriangulatedCategory( stable_cat, true );
ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_cat );
AsTriangulatedCategory( stable_cat );
Finalize( stable_cat );

