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

##
AddDerivationToCAP( CompleteToMorphismOfExactTriangles,
                [   [ IsomorphismToCanonicalExactTriangle, 1 ],
                    [ IsomorphismFromCanonicalExactTriangle, 1 ], 
                    [ CompleteToMorphismOfCanonicalExactTriangles, 1 ],
                    [ CompleteMorphismToCanonicalExactTriangle, 1 ]
                ], 
    function( T1, T2, m0, m1 )
    local can_T1, can_T2, T1_to_can_T1, T2_to_can_T2, can_T1_to_T1, can_T2_to_T2, can_T1_to_can_T2,
        can_T1_to_can_T2_0, can_T1_to_can_T2_1;
    
    if IsCapCategoryCanonicalExactTriangle( T1 ) and IsCapCategoryCanonicalExactTriangle( T2 ) then
        return CompleteToMorphismOfCanonicalExactTriangles( T1, T2, m0, m1 );
    fi;

    can_T1 := UnderlyingCanonicalExactTriangle( T1 );
    can_T2 := UnderlyingCanonicalExactTriangle( T2 );
    
    T1_to_can_T1 := IsomorphismToCanonicalExactTriangle( T1 );
    can_T1_to_T1 := IsomorphismFromCanonicalExactTriangle( T1 );

    T2_to_can_T2 := IsomorphismToCanonicalExactTriangle( T2 );
    can_T2_to_T2 := IsomorphismFromCanonicalExactTriangle( T2 );

    can_T1_to_can_T2_0 := PreCompose( [ MorphismAt( can_T1_to_T1, 0 ), m0, MorphismAt( T2_to_can_T2, 0 ) ] );
    can_T1_to_can_T2_1 := PreCompose( [ MorphismAt( can_T1_to_T1, 1 ), m1, MorphismAt( T2_to_can_T2, 1 ) ] );
    can_T1_to_can_T2 := CompleteToMorphismOfCanonicalExactTriangles( can_T1, can_T2, can_T1_to_can_T2_0, can_T1_to_can_T2_1 );
    return PreCompose( [ T1_to_can_T1, can_T1_to_can_T2, can_T2_to_T2 ] );
    
end: Description := "complete to morphism of exact triangles" );

## In the following 4 derivations we need iso's methods because we want the (reverse) rotation 
## and isomorphisms (to,from) its canonical representative, otherwise we can not do anything with this (reverse) rotation.

AddDerivationToCAP( RotationOfExactTriangle,
                [   [ IsomorphismFromCanonicalExactTriangle, 1 ],
                    [ IsomorphismToCanonicalExactTriangle, 1 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( T )

    return CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );     

end: Description := "creates a rotation of an exact triangle");

##
AddDerivationToCAP( RotationOfCanonicalExactTriangle,
                [   [ IsomorphismFromCanonicalExactTriangle, 1 ],
                    [ IsomorphismToCanonicalExactTriangle, 1 ],
                    [ ShiftOfMorphism, 1 ]
                ],
    function( T )
    local rT;

    rT := CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );     
    
    IsomorphismFromCanonicalExactTriangle( rT );
    
    IsomorphismToCanonicalExactTriangle( rT );

    return rT;

end: Description := "creates a rotation of a canonical exact triangle");

##
AddDerivationToCAP( ReverseRotationOfExactTriangle,
                [   [ IsomorphismFromCanonicalExactTriangle, 1 ],
                    [ IsomorphismToCanonicalExactTriangle, 1 ],
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

    IsomorphismFromCanonicalExactTriangle( rT );
    
    IsomorphismToCanonicalExactTriangle( rT );

    return rT;

end: Description := "creates the reverse rotation of an exact triangle");

##
AddDerivationToCAP( ReverseRotationOfCanonicalExactTriangle,
                [   [ IsomorphismFromCanonicalExactTriangle, 1 ],
                    [ IsomorphismToCanonicalExactTriangle, 1 ],
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

end: Description := "creates the reverse rotation of a canonical exact triangle");

##
AddDerivationToCAP( IsomorphismFromCanonicalExactTriangle,
                [   [ CompleteToMorphismOfExactTriangles, 1 ],
                    [ CompleteMorphismToCanonicalExactTriangle, 1 ]
                ],
    function( T )
    local can_T;

    can_T := UnderlyingCanonicalExactTriangle( T );

    return CompleteToMorphismOfExactTriangles( can_T, T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T,1 ) ) );

end: Description := "creates isomorphism from the underlying canonical exact triangle");

##
AddDerivationToCAP( IsomorphismToCanonicalExactTriangle,
                [   [ CompleteToMorphismOfExactTriangles, 1 ],
                    [ CompleteMorphismToCanonicalExactTriangle, 1 ]
                ],
    function( T )
    local can_T;

    can_T := UnderlyingCanonicalExactTriangle( T );

    return CompleteToMorphismOfExactTriangles( T, can_T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T,1 ) ) );

end: Description := "creates isomorphism to the underlying canonical exact triangle");

##
AddDerivationToCAP( IsCanonicalExactTriangle,
                [
                    [ CompleteMorphismToCanonicalExactTriangle, 1 ]
                ],
    function( T )
    local can_T;
    
    can_T := CompleteMorphismToCanonicalExactTriangle( MorphismAt( T, 0 ) );
    
    return  ForAll( [ 0..3 ], i -> IsEqualForObjects( ObjectAt( T, i ), ObjectAt( can_T, i ) ) ) and 
            ForAll( [ 0..2 ], i -> IsEqualForMorphisms( MorphismAt( T, i ), MorphismAt( can_T, i ) ) );

end: Description := "checks if the given exact triangle is canonical");

##
AddDerivationToCAP( IsomorphismFromCanonicalExactTriangle,
                [
                    [ IsomorphismToCanonicalExactTriangle, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( T )
    local i;
    i := IsomorphismToCanonicalExactTriangle( T );
    return CreateTrianglesMorphism( Range( i ), Source( i ), MorphismAt(i,0), MorphismAt(i,1), Inverse( MorphismAt( i, 2 ) ) );
end: Description := "computes the iso from canonical exact triangle");

##
AddDerivationToCAP( IsomorphismToCanonicalExactTriangle,
                [
                    [ IsomorphismFromCanonicalExactTriangle, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( T )
    local i;
    i := IsomorphismFromCanonicalExactTriangle( T );
    return CreateTrianglesMorphism( Range( i ), Source( i ), MorphismAt(i,0), MorphismAt(i,1), Inverse( MorphismAt( i, 2 ) ) );
end: Description := "computes the iso to canonical exact triangle");

##
AddDerivationToCAP( IsomorphismFromShiftOfReverseShift,
                [
                    [ IsomorphismIntoShiftOfReverseShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismIntoShiftOfReverseShift( obj ) );
end: Description := "computes iso from shift of reverse shift using the iso to shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismIntoShiftOfReverseShift,
                [
                    [ IsomorphismFromShiftOfReverseShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismFromShiftOfReverseShift( obj ) );
end: Description := "computes iso to shift of reverse shift using the iso from shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismFromReverseShiftOfShift,
                [
                    [ IsomorphismIntoReverseShiftOfShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismIntoReverseShiftOfShift( obj ) );
end: Description := "computes iso from shift of reverse shift using the iso to shift of reverse shift" );

##
AddDerivationToCAP( IsomorphismIntoReverseShiftOfShift,
                [
                    [ IsomorphismFromReverseShiftOfShift, 1 ],
                    [ InverseImmutable, 1 ]
                ],
    function( obj )
    return Inverse( IsomorphismFromReverseShiftOfShift( obj ) );
end: Description := "computes iso to shift of reverse shift using the iso from shift of reverse shift" );
