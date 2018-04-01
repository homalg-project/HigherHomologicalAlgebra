LoadPackage( "StableCategoriesForCAP" );
ReadPackage( "StableCategoriesForCAP", "/examples/lp_over_exterior_algebra/lp_over_exterior_algebra.g" );

BindGlobal( "ADD_METHODS_TO_STABLE_CAT_OF_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA",

function( category )
    
AddLift( category,
    function( alpha, beta )
    local lift;
    
    lift := colift_lift_in_stable_category( 
            UniversalMorphismFromZeroObject( Source( UnderlyingUnstableMorphism( alpha ) ) ),
            UniversalMorphismFromZeroObject( Source( UnderlyingUnstableMorphism( beta ) ) ),
            UnderlyingUnstableMorphism( alpha ),
            UnderlyingUnstableMorphism( beta ) );
    if lift = fail then
        return fail;
    else
        return AsStableMorphism( lift );
    fi;
    
end );



AddColift( category,
    function( alpha, beta )
    local col;
    
    col :=  colift_lift_in_stable_category( 
            UnderlyingUnstableMorphism( alpha ),
            UnderlyingUnstableMorphism( beta ),
            UniversalMorphismIntoZeroObject( Range( UnderlyingUnstableMorphism( alpha ) ) ),
            UniversalMorphismIntoZeroObject( Range( UnderlyingUnstableMorphism( beta ) ) ) );
    
    if col = fail then
        return fail;
    else
        return AsStableMorphism( col );
    fi;
    
end );


AddIsSplitMonomorphism( category, 
    function( mor )
    local l;
    l := Colift( mor, IdentityMorphism( Source( mor ) ) );

    if l = fail then 
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
ADD_METHODS_TO_STABLE_CAT_OF_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_cat );
Finalize( stable_cat );

m := HomalgMatrix( "[ [ e1, e0, e1, e1*e0, e0-e1 ], [ 0, 1, e1*e0, 0, -4*e1 ], [ e1+e0, 0, 1, e1*e0-e1, 0 ] ]", 3, 5, R);
M := AsLeftPresentation( m );
n := HomalgMatrix( "[ [ e0, e1, e1, e1*e0, e0-e1 ], [ 1, 0, e1*e0, e0, e0 ], [ e1*e0, 0, 1, e1*e0-e0, 0 ] ]", 3, 5, R);
N := AsLeftPresentation( n );
quit;

hom_basis := basis_of_external_hom( M, N );
random := List( [ 1..Length( hom_basis ) ], i-> Random( [ -i..i ] ) );;
f := Sum( [ 1..Length( hom_basis ) ], i -> random[ i ] * hom_basis[ i ] );
compute_coefficients( hom_basis, f );

