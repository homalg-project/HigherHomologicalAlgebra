LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/lp_over_exterior_algebra/lp_over_exterior_algebra.g" );

BindGlobal( "ADD_METHODS_TO_STABLE_CAT_OF_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA",

function( category )

##
AddLiftColift( category,
    function( alpha, beta, gamma, delta )
    local lift;
    lift := colift_lift_in_stable_category( 
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
        AddToReasons( "IsSplitMonomorphism: because the morphism can not be coliftet to the identity morphism of the source" ); 
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
        AddToReasons( "IsSplitMonomorphism: because the morphism can not be coliftet to the identity morphism of the source" );
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

R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y" );
cat := LeftPresentations( R: FinalizeCategory := false );
ADD_METHODS_TO_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( cat );
TurnAbelianCategoryToExactCategory( cat );
SetIsFrobeniusCategory( cat, true );
Finalize( cat );

SetTestFunctionForStableCategories(cat, CanBeFactoredThroughExactProjective );
stable_cat := StableCategory( cat );
SetIsTriangulatedCategory( stable_cat, true );
ADD_METHODS_TO_STABLE_CAT_OF_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_cat );
AsTriangulatedCategory( stable_cat );
Finalize( stable_cat );

m := HomalgMatrix( "[ [ e1, e0, e1, e1*e0, e0-e1 ], [ 0, 1, e1*e0, 0, -4*e1 ], [ e1+e0, 0, 1, e1*e0-e1, 0 ] ]", 3, 5, R);
m := AsLeftPresentation( m );
M := AsStableObject( m );
n := HomalgMatrix( "[ [ e1*e0, e0-e1 ], [ 1, e0 ], [ e1*e0, e1*e0-e0 ] ]", 3, 2, R);
n := AsLeftPresentation( n );
N := AsStableObject( n );
