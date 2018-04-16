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


R := GradedRing( KoszulDualRing( HomalgFieldOfRationalsInSingular( )*"x,y" ) );
SetWeightsOfIndeterminates( R, [ -1,-1 ] );
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

