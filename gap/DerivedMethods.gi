#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################

################################################
##
## Derived Methods for Triangulated Categories
##
################################################

AddDerivationToCAP( IsExactTriangle,
                [
                    [ LiftColift, 1 ],
                    [ CompleteMorphismToStandardExactTriangle, 1 ]
                ],
    function( T )
    local sT, m;
    
    sT := CompleteMorphismToStandardExactTriangle( T^0 );
    m := LiftColift( T^1, sT^1, T^2, sT^2 );

    if m = fail then
        AddToReasons( "IsExactTriangle: because there is no lift/colift that makes the required diagram commutative." );
        return false;
    else
        return true;
    fi;

    end: CategoryFilter := IsTriangulatedCategory, Description := "compute if a triangles exact or not using LiftColift method" );

AddDerivationToCAP( CompleteToMorphismOfExactTriangles,
                [
                    [ LiftColift, 1 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( T1, T2, m0, m1 )
    local l;

    l := LiftColift( T1^1, PreCompose( m1, T2^1 ), PreCompose( T1^2, ShiftOfMorphism( m0 ) ), T2^2 );
    if l = fail then
        return fail;
    else
        return CreateTrianglesMorphism( T1, T2, m0, m1, l );
    fi;
    end: CategoryFilter := IsTriangulatedCategory, Description := "complete to morphism of exact triangles using LiftColift method" );
##
AddDerivationToCAP( CompleteToMorphismOfExactTriangles,
                [   [ IsomorphismIntoStandardExactTriangle, 2 ],
                    [ IsomorphismFromStandardExactTriangle, 2 ], 
                    [ CompleteToMorphismOfStandardExactTriangles, 2 ],
                    [ CompleteMorphismToStandardExactTriangle, 2 ]
                ], 
    function( T1, T2, m0, m1 )
    local can_T1, can_T2, T1_to_can_T1, T2_to_can_T2, can_T1_to_T1, can_T2_to_T2, can_T1_to_can_T2,
        can_T1_to_can_T2_0, can_T1_to_can_T2_1;
    
    if IsCapCategoryStandardExactTriangle( T1 ) and IsCapCategoryStandardExactTriangle( T2 ) then
        return CompleteToMorphismOfStandardExactTriangles( T1, T2, m0, m1 );
    fi;

    can_T1 := UnderlyingStandardExactTriangle( T1 );
    can_T2 := UnderlyingStandardExactTriangle( T2 );
    
    T1_to_can_T1 := IsomorphismIntoStandardExactTriangle( T1 );
    can_T1_to_T1 := IsomorphismFromStandardExactTriangle( T1 );

    T2_to_can_T2 := IsomorphismIntoStandardExactTriangle( T2 );
    can_T2_to_T2 := IsomorphismFromStandardExactTriangle( T2 );

    can_T1_to_can_T2_0 := PreCompose( [ MorphismAt( can_T1_to_T1, 0 ), m0, MorphismAt( T2_to_can_T2, 0 ) ] );
    can_T1_to_can_T2_1 := PreCompose( [ MorphismAt( can_T1_to_T1, 1 ), m1, MorphismAt( T2_to_can_T2, 1 ) ] );
    can_T1_to_can_T2 := CompleteToMorphismOfStandardExactTriangles( can_T1, can_T2, can_T1_to_can_T2_0, can_T1_to_can_T2_1 );
    return PreCompose( [ T1_to_can_T1, can_T1_to_can_T2, can_T2_to_T2 ] );
    
end:CategoryFilter := IsTriangulatedCategory, Description := "complete to morphism of exact triangles" );

##
AddDerivationToCAP( CompleteToMorphismOfStandardExactTriangles,
                [
                    [ CompleteToMorphismOfExactTriangles, 1 ]
                ],
    function( T1, T2, m0, m1 )
    return CompleteToMorphismOfExactTriangles( T1, T2, m0, m1 );
    end: CategoryFilter := IsTriangulatedCategory, Description := "complete to morphism of standard exact triangles if we can complete to morphism of exact triangles" );

## In the following 4 derivations we need iso's methods because we want the (reverse) rotation 
## and isomorphisms (to,from) its canonical representative, otherwise we can not do anything with this (reverse) rotation.

AddDerivationToCAP( RotationOfExactTriangle,
                [   [ IsomorphismFromStandardExactTriangle, 0 ],
                    [ IsomorphismIntoStandardExactTriangle, 0 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( T )

    return CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );     

end:CategoryFilter := IsTriangulatedCategory, Description := "creates a rotation of an exact triangle");

##
AddDerivationToCAP( RotationOfStandardExactTriangle,
                [   [ IsomorphismFromStandardExactTriangle, 0 ],
                    [ IsomorphismIntoStandardExactTriangle, 0 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( T )
    local rT;

    rT := CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );

    return rT;

end:CategoryFilter := IsTriangulatedCategory, Description := "creates a rotation of a canonical exact triangle");

##
AddDerivationToCAP( ReverseRotationOfExactTriangle,
                [   [ IsomorphismFromStandardExactTriangle, 1 ],
                    [ IsomorphismIntoStandardExactTriangle, 1 ],
                    [ ReverseShiftOfMorphism, 1 ]
                ],
    function( T )
    local rT;

    if not HasIsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "Its not known wether the shift functor is automorphism!" );
    fi;
     
    if not IsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "The shift-functor that defines the triangulated struture must be automorphism!" );
    fi;

    rT := CreateExactTriangle( AdditiveInverse(ReverseShiftOfMorphism( MorphismAt( T, 2 ) ) ), MorphismAt( T, 0), MorphismAt( T, 1 ) );

    IsomorphismFromStandardExactTriangle( rT );
    
    IsomorphismIntoStandardExactTriangle( rT );

    return rT;

end:CategoryFilter := IsTriangulatedCategory, Description := "creates the reverse rotation of an exact triangle");

##
AddDerivationToCAP( ReverseRotationOfStandardExactTriangle,
                [   [ IsomorphismFromStandardExactTriangle, 1 ],
                    [ IsomorphismIntoStandardExactTriangle, 1 ],
                    [ ReverseShiftOfMorphism, 1 ]
                ],
    function( T )

    if not HasIsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "Its not known wether the shift functor is automorphism!" );
    fi;
     
    if not IsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "The shift-functor that defines the triangulated struture must be automorphism!" );
    fi;

    return CreateExactTriangle( AdditiveInverse( ReverseShiftOfMorphism( MorphismAt( T, 2 ) ) ), MorphismAt( T, 0), MorphismAt( T, 1 ) );

end:CategoryFilter := IsTriangulatedCategory, Description := "creates the reverse rotation of a canonical exact triangle");

##
AddDerivationToCAP( IsomorphismFromStandardExactTriangle,
                [   [ CompleteToMorphismOfExactTriangles, 1 ],
                    [ CompleteMorphismToStandardExactTriangle, 1 ]
                ],
    function( T )
    local can_T;

    can_T := UnderlyingStandardExactTriangle( T );

    return CompleteToMorphismOfExactTriangles( can_T, T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T,1 ) ) );

end:CategoryFilter := IsTriangulatedCategory, Description := "creates isomorphism from the underlying canonical exact triangle");

##
AddDerivationToCAP( IsomorphismIntoStandardExactTriangle,
                [   [ CompleteToMorphismOfExactTriangles, 1 ],
                    [ CompleteMorphismToStandardExactTriangle, 1 ]
                ],
    function( T )
    local can_T;

    can_T := UnderlyingStandardExactTriangle( T );

    return CompleteToMorphismOfExactTriangles( T, can_T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T,1 ) ) );

end:CategoryFilter := IsTriangulatedCategory, Description := "creates isomorphism to the underlying canonical exact triangle");

##
AddDerivationToCAP( IsStandardExactTriangle,
                [
                    [ CompleteMorphismToStandardExactTriangle, 1 ]
                ],
    function( T )
    local can_T;
    
    can_T := CompleteMorphismToStandardExactTriangle( MorphismAt( T, 0 ) );
    
    return  ForAll( [ 0..3 ], i -> IsEqualForObjects( ObjectAt( T, i ), ObjectAt( can_T, i ) ) ) and 
            ForAll( [ 0..2 ], i -> IsEqualForMorphisms( MorphismAt( T, i ), MorphismAt( can_T, i ) ) );

end:CategoryFilter := IsTriangulatedCategory, Description := "checks if the given exact triangle is canonical" );

##
AddDerivationToCAP( IsomorphismFromStandardExactTriangle,
                [
                    [ IsomorphismIntoStandardExactTriangle, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( T )
    local i;
    i := IsomorphismIntoStandardExactTriangle( T );
    return CreateTrianglesMorphism( Range( i ), Source( i ), MorphismAt(i,0), MorphismAt(i,1), Inverse( MorphismAt( i, 2 ) ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes the iso from canonical exact triangle");

##
AddDerivationToCAP( IsomorphismIntoStandardExactTriangle,
                [
                    [ IsomorphismFromStandardExactTriangle, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( T )
    local i;
    i := IsomorphismFromStandardExactTriangle( T );
    return CreateTrianglesMorphism( Range( i ), Source( i ), MorphismAt(i,0), MorphismAt(i,1), Inverse( MorphismAt( i, 2 ) ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes the iso to canonical exact triangle");

##
AddDerivationToCAP( IsomorphismFromShiftOfReverseShift,
                [
                    [ IsomorphismIntoShiftOfReverseShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismIntoShiftOfReverseShift( obj ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes iso from shift of reverse shift using the iso to shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismIntoShiftOfReverseShift,
                [
                    [ IsomorphismFromShiftOfReverseShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismFromShiftOfReverseShift( obj ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes iso to shift of reverse shift using the iso from shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismFromReverseShiftOfShift,
                [
                    [ IsomorphismIntoReverseShiftOfShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismIntoReverseShiftOfShift( obj ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes iso from shift of reverse shift using the iso to shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismIntoReverseShiftOfShift,
                [
                    [ IsomorphismFromReverseShiftOfShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismFromReverseShiftOfShift( obj ) );
end:CategoryFilter := IsTriangulatedCategory, Description := "computes iso to shift of reverse shift using the iso from shift of reverse shift" );

##
AddDerivationToCAP( ShiftFactoringIsomorphismWithGivenObjects,
                [
                    [ InjectionOfCofactorOfDirectSum, 1 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ ShiftOfMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
end );

AddDerivationToCAP( ShiftExpandingIsomorphismWithGivenObjects,
                [
                    [ ProjectionInFactorOfDirectSum, 1 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> ShiftOfMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
    
end );

##
AddDerivationToCAP( ReverseShiftFactoringIsomorphismWithGivenObjects,
                [
                    [ InjectionOfCofactorOfDirectSum, 1 ],
                    [ ReverseShiftOfMorphism, 1 ]
                ],
    function( s, L, r )
     local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ ReverseShiftOfMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
 end );

##
AddDerivationToCAP( ReverseShiftExpandingIsomorphismWithGivenObjects,
                [
                    [ ProjectionInFactorOfDirectSum, 1 ],
                    [ ReverseShiftOfMorphism, 1 ]
                ],
    function( s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> ReverseShiftOfMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
       
 end );

##

# See categories and homological algebra (schapira)
AddFinalDerivation( IsIsomorphism,
                [
                    [ ConeObject, 1 ],
                    [ IsZeroForObjects,  1 ]
                ],
                [
                    IsIsomorphism
                ],
    function( mor )
    return IsZeroForObjects( ConeObject( mor ) );
end: CategoryFilter := IsTriangulatedCategory, Description:= "Is isomorphism by deciding if the cone object is zero" );

##
AddDerivationToCAP( IsomorphismIntoStandardExactTriangle,
                [
                    [ LiftColift, 1 ],
                    [ CompleteMorphismToStandardExactTriangle,  1 ]
                ],
    function( tr )
    local str, l;
    str := UnderlyingStandardExactTriangle( tr );
    
    l := LiftColift( tr^2, str^2, tr^1, str^1 );

    if l = fail then
        return fail;
    else
        return CreateTrianglesMorphism( tr, str, IdentityMorphism( tr[ 0 ] ), IdentityMorphism( tr[ 1 ] ), l );
    fi;

end:CategoryFilter := IsTriangulatedCategory, CategoryFilter := IsTriangulatedCategory, Description:= "Computing the isomorphism into the standard exact triangle using LiftColift" );

##
AddDerivationToCAP( IsomorphismFromStandardExactTriangle,
                [
                    [ LiftColift, 1 ],
                    [ CompleteMorphismToStandardExactTriangle,  1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( tr )
    local str, l;
    str := UnderlyingStandardExactTriangle( tr );
    
    l := LiftColift( tr^2, str^2, tr^1, str^1 );

    if l = fail then
        return fail;
    else
        return CreateTrianglesMorphism( str, tr, IdentityMorphism( tr[ 0 ] ), IdentityMorphism( tr[ 1 ] ), Inverse( l ) );
    fi;

end: CategoryFilter := IsTriangulatedCategory, Description:= "computing the isomorphism from the standard exact triangle using LiftColift" );

##
AddDerivationToCAP( IsomorphismFromStandardExactTriangle,
                [
                    [ IsomorphismIntoStandardExactTriangle,  1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( tr )
    local i;
    i := IsomorphismIntoStandardExactTriangle( tr );
    return CreateTrianglesMorphism( Range( i ), Source( i ), i[ 0 ], i[ 1 ], Inverse( i[ 2 ] ) );

end: CategoryFilter := IsTriangulatedCategory, Description:= "computing the isomorphism from the standard exact triangle using the isomorphism into standard exact triangle" );

##
AddDerivationToCAP( IsomorphismIntoStandardExactTriangle,
                [
                    [ IsomorphismFromStandardExactTriangle,  1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( tr )
    local i;
    i := IsomorphismFromStandardExactTriangle( tr );
    return CreateTrianglesMorphism( Range( i ), Source( i ), i[ 0 ], i[ 1 ], Inverse( i[ 2 ] ) );

end: CategoryFilter := IsTriangulatedCategory, Description:= "computing the isomorphism into the standard exact triangle using the isomorphism from standard exact triangle" );

##
AddDerivationToCAP( Lift, 
                [
                    [ LiftColift, 1 ],
                    [ UniversalMorphismFromZeroObject, 1 ]
                ],
    function( alpha, beta )
    
      return LiftColift( alpha, beta, UniversalMorphismFromZeroObject( Source( alpha ) ), UniversalMorphismFromZeroObject( Source( beta ) ) );
      
end );

##
AddDerivationToCAP( Colift,
                [
                    [ LiftColift, 1 ],
                    [ UniversalMorphismIntoZeroObject, 1 ]
                ],
    function( alpha, beta )
    
      return LiftColift( UniversalMorphismIntoZeroObject( Range( alpha ) ), UniversalMorphismIntoZeroObject( Range( beta ) ), alpha, beta );
      
end );

#                 Y
#        << alpha    << gamma
#     X                         Z
#        << beta     << delta
#                 W
##
AddDerivationToCAP( LiftColift,
                [
                  [ SolveLinearSystemInAbCategory, 1 ],
                  [ IdentityMorphism, 2 ]
                ],
  function( alpha, beta, gamma, delta )
    local left_coeffs, right_coeffs, cons, sol;
    
    left_coeffs := [ [ gamma ], [ IdentityMorphism( Source( alpha )  ) ] ];
    
    right_coeffs := [ [ IdentityMorphism( Range( delta ) ) ], [ beta ] ];
    
    cons := [ delta ,alpha ];
    
    sol := SolveLinearSystemInAbCategory( left_coeffs, right_coeffs, cons );
    
    if sol = fail then
      
      return fail;
      
    else
      
      return sol[1];
      
    fi;
    
end: CategoryFilter := IsAbCategory, Description:= "LiftColift using SolveLinearSystemInAbCategory" );

##
AddDerivationToCAP( IsSplitEpimorphism,
                [
                    [ IsEpimorphism, 1 ]
                ],
    function( alpha )
    return IsEpimorphism( alpha );
end:  CategoryFilter := IsTriangulatedCategory, Description:= "a morphism is triangulated categories is epi iff it is split epi" );

##
AddDerivationToCAP( IsSplitMonomorphism,
                [
                    [ IsMonomorphism, 1 ]
                ],
    function( alpha )
    return IsMonomorphism( alpha );
end:  CategoryFilter := IsTriangulatedCategory, Description:= "a morphism is triangulated categories is mono iff it is split mono" );

##
AddDerivationToCAP( IsEpimorphism,
                [
                    [ IsSplitEpimorphism, 1 ]
                ],
    function( alpha )
      return IsSplitEpimorphism( alpha );
end:  CategoryFilter := IsTriangulatedCategory, Description:= "a morphism is triangulated categories is epi iff it is split epi" );

##
AddDerivationToCAP( IsMonomorphism,
                [
                    [ IsSplitMonomorphism, 1 ]
                ],
    function( alpha )
    return IsSplitMonomorphism( alpha );
end: CategoryFilter := IsTriangulatedCategory, Description:= "a morphism is triangulated categories is mono iff it is split mono" );

