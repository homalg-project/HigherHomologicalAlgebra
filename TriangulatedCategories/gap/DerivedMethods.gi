# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

################################################
##
## Derived Methods for Triangulated Categories
##
################################################

##
AddDerivationToCAP( ShiftOfMorphismByInteger,
                    "ShiftOfMorphismByInteger by ShiftOfObjectByInteger & ShiftOfMorphismByIntegerWithGivenObjects",
                [ [ ShiftOfObjectByInteger, 2 ],
                  [ ShiftOfMorphismByIntegerWithGivenObjects, 1 ] ],
  
  function ( homotopy_cat, alpha, n )
    local s, r;
    
    s := ShiftOfObjectByInteger( Source( alpha ), n );
    r := ShiftOfObjectByInteger( Range ( alpha ), n );
    
    return ShiftOfMorphismByIntegerWithGivenObjects( homotopy_cat, s, alpha, n, r );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( ShiftOfObject,
                    "ShiftOfObject by ShiftOfObjectByInteger",
              [ [ ShiftOfObjectByInteger, 1 ] ],
  
  function ( homotopy_cat, C )
    
    return ShiftOfObjectByInteger( homotopy_cat, C, 1 );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( InverseShiftOfObject,
                    "InverseShiftOfObject by ShiftOfObjectByInteger",
              [ [ ShiftOfObjectByInteger, 1 ] ],
  
  function ( homotopy_cat, C )
    
    return ShiftOfObjectByInteger( homotopy_cat, C, -1 );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( ShiftOfMorphismWithGivenObjects,
                    "ShiftOfMorphismWithGivenObjects by ShiftOfMorphismByIntegerWithGivenObjects",
              [ [ ShiftOfMorphismByIntegerWithGivenObjects, 1 ] ],
  
  function ( homotopy_cat, s, C, r )
    
    return ShiftOfMorphismByIntegerWithGivenObjects( homotopy_cat, s, C, 1, r );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( InverseShiftOfMorphismWithGivenObjects,
                    "InverseShiftOfMorphismWithGivenObjects by ShiftOfMorphismByIntegerWithGivenObjects",
              [ [ ShiftOfMorphismByIntegerWithGivenObjects, 1 ] ],
  
  function ( homotopy_cat, s, C, r )
    
    return ShiftOfMorphismByIntegerWithGivenObjects( homotopy_cat, s, C, -1, r );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( IsExactTriangle,
                    "IsExactTriangle by WitnessIsomorphismIntoStandardConeObject",
                [
                  [ WitnessIsomorphismIntoStandardConeObject, 1 ],
                ],
  function( cat, alpha, iota, pi )
    
    return WitnessIsomorphismIntoStandardConeObject( alpha, iota, pi ) <> fail;
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddFinalDerivationBundle( "Adding witnesses for beeing exact by using SolveLinearSystemInAbCategoryOrFail",
                [
                  [ IsEqualForObjects, 1 ],
                  [ ShiftOfObject, 1 ],
                  [ MorphismIntoStandardConeObject, 1 ],
                  [ MorphismFromStandardConeObject, 1 ],
                  [ IdentityMorphism, 2 ],
                  [ SolveLinearSystemInAbCategoryOrFail, 1 ],
                  [ InverseForMorphisms, 1 ],
                ],
                [
                  WitnessIsomorphismIntoStandardConeObject,
                  WitnessIsomorphismFromStandardConeObject
                ],
[
  WitnessIsomorphismIntoStandardConeObject,
  [
    [ IsEqualForObjects, 1 ],
    [ ShiftOfObject, 1 ],
    [ MorphismIntoStandardConeObject, 1 ],
    [ MorphismFromStandardConeObject, 1 ],
    [ IdentityMorphism, 2 ],
    [ SolveLinearSystemInAbCategoryOrFail, 1 ],
  ],
  function( cat, alpha, iota, pi )
    local iota_alpha, pi_alpha, left_coeffs, right_coeffs, right_side, sol;
    
    if not IsEqualForObjects( ShiftOfObject( Source( alpha ) ), Range( pi ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    iota_alpha := MorphismIntoStandardConeObject( alpha );
    
    pi_alpha := MorphismFromStandardConeObject( alpha );
    
    left_coeffs := [ [ iota ], [ IdentityMorphism( Range( iota )  ) ] ];
    
    right_coeffs := [ [ IdentityMorphism( Range( iota_alpha ) ) ], [ pi_alpha ] ];
    
    right_side := [ iota_alpha, pi ];
    
    sol := SolveLinearSystemInAbCategoryOrFail( left_coeffs, right_coeffs, right_side );
    
    if sol = fail then
      
      return fail;
      
    else
      
      return sol[ 1 ];
      
    fi;
  
  end
],
[
  WitnessIsomorphismFromStandardConeObject,
  [
    [ WitnessIsomorphismIntoStandardConeObject, 1 ],
    [ InverseForMorphisms, 1 ],
  ],
  function( cat, alpha, iota, pi )
    local w;
    
    w := WitnessIsomorphismIntoStandardConeObject( alpha, iota, pi );
    
    if w = fail then
      
      return w;
      
    else
      
      return Inverse( w );
      
    fi;
    
  end
] : CategoryFilter := IsTriangulatedCategory );

# See categories and homological algebra (schapira)
AddFinalDerivation( IsIsomorphism,
                    "IsIsomorphism by deciding if the cone object is zero",
                [
                    [ StandardConeObject, 1 ],
                    [ IsZeroForObjects,  1 ]
                ],
                [
                    IsIsomorphism
                ],
  function( cat, alpha )
  
    return IsZeroForObjects( StandardConeObject( alpha ) );
    
end : CategoryFilter := IsTriangulatedCategory );


AddDerivationToCAP( DomainMorphismByOctahedralAxiomWithGivenObjects,
                    "",
                [
                    [ IdentityMorphism, 1 ],
                    [ MorphismBetweenStandardConeObjectsWithGivenObjects,  1 ]
                ],
  function( cat, s, alpha, beta, gamma, r )
    local A, id_A;
    
    A := Source( alpha );
    
    id_A := IdentityMorphism( A );
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects( s, [ alpha, id_A, beta, gamma ], r );
    
end );

AddDerivationToCAP( MorphismFromConeObjectByOctahedralAxiomWithGivenObjects,
                    "",
                [
                  [ StandardConeObject, 1 ],
                  [ MorphismFromStandardConeObjectWithGivenObjects, 1 ],
                  [ MorphismIntoStandardConeObjectWithGivenStandardConeObject, 1 ],
                  [ ShiftOfObject, 2 ],
                  [ ShiftOfMorphismWithGivenObjects, 1 ],
                  [ PreCompose, 1 ]
                ],
  function( cat, s, alpha, beta, gamma, r )
    local B, pi_beta, cone_alpha, iota_alpha;
    
    B := Range( alpha );
     
    pi_beta := MorphismFromStandardConeObjectWithGivenObjects(
                          s,
                          beta,
                          ShiftOfObject( B )
                      );
    
    cone_alpha := StandardConeObject( alpha );
    
    iota_alpha := MorphismIntoStandardConeObjectWithGivenStandardConeObject(
                          alpha,
                          cone_alpha
                      );
    
    iota_alpha := ShiftOfMorphismWithGivenObjects(
                      ShiftOfObject( B ),
                      iota_alpha,
                      r
                    );
    
    return PreCompose( pi_beta, iota_alpha );
    
end );

##
AddDerivationToCAP( IsSplitEpimorphism,
                    "a morphism is triangulated categories is epi iff it is split epi",
                [
                    [ IsEpimorphism, 1 ]
                ],
  function( cat, alpha )
    return IsEpimorphism( alpha );
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( IsSplitMonomorphism,
                    "a morphism is triangulated categories is mono iff it is split mono",
                [
                    [ IsMonomorphism, 1 ]
                ],
  function( cat, alpha )
    return IsMonomorphism( alpha );
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( ShiftFactoringIsomorphismWithGivenObjects,
                    "ShiftFactoringIsomorphismWithGivenObjects using InjectionOfCofactorOfDirectSum and ShiftOfMorphism",
                [
                    [ InjectionOfCofactorOfDirectSum, 2 ],
                    [ ShiftOfMorphismWithGivenObjects, 2 ],
                    [ ShiftOfObject, 4 ],
                    [ MorphismBetweenDirectSums, 1 ],
                ],
  function( cat, s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ ShiftOfMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
end : CategoryFilter := IsTriangulatedCategory );

AddDerivationToCAP( ShiftExpandingIsomorphismWithGivenObjects,
                    "ShiftExpandingIsomorphismWithGivenObjects using ProjectionInFactorOfDirectSum and ShiftOfMorphism",
                [
                    [ ProjectionInFactorOfDirectSum, 2 ],
                    [ ShiftOfMorphismWithGivenObjects, 2 ],
                    [ ShiftOfObject, 4 ],
                    [ MorphismBetweenDirectSums, 1 ],
                ],
  function( cat, s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> ShiftOfMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
    
end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( InverseShiftFactoringIsomorphismWithGivenObjects,
                    "InverseShiftFactoringIsomorphismWithGivenObjects using InjectionOfCofactorOfDirectSum and InverseShiftOfMorphism",
                [
                    [ InjectionOfCofactorOfDirectSum, 2 ],
                    [ InverseShiftOfMorphismWithGivenObjects, 2 ],
                    [ InverseShiftOfObject, 4 ],
                    [ MorphismBetweenDirectSums, 1 ],
                ],
  function( cat, s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ InverseShiftOfMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
 end : CategoryFilter := IsTriangulatedCategory );

##
AddDerivationToCAP( InverseShiftExpandingIsomorphismWithGivenObjects,
                    "InverseShiftExpandingIsomorphismWithGivenObjects using ProjectionInFactorOfDirectSum and InverseShiftOfMorphism",
                [
                    [ ProjectionInFactorOfDirectSum, 2 ],
                    [ InverseShiftOfMorphismWithGivenObjects, 2 ],
                    [ InverseShiftOfObject, 4 ],
                    [ MorphismBetweenDirectSums, 1 ],
                ],
  function( cat, s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> InverseShiftOfMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
       
 end : CategoryFilter := IsTriangulatedCategory );

##


