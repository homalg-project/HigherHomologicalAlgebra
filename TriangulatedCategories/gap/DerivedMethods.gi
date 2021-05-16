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
AddDerivationToCAP( IsExactTriangle,
                [
                  [ WitnessIsomorphismOntoStandardConeObject, 1 ],
                ],
  function( cat, alpha, iota, pi )
    
    return WitnessIsomorphismOntoStandardConeObject( alpha, iota, pi ) <> fail;
    
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "IsExactTriangle by WitnessIsomorphismOntoStandardConeObject"
);

##
AddFinalDerivation( WitnessIsomorphismOntoStandardConeObject,
                [
                  [ SolveLinearSystemInAbCategory, 1 ],
                  [ ShiftOnObject, 1 ]
                ],
                [
                  WitnessIsomorphismOntoStandardConeObject,
                  WitnessIsomorphismFromStandardConeObject
                ],
  function( cat, alpha, iota, pi )
    local iota_alpha, pi_alpha, left_coeffs, right_coeffs, right_side, sol;
    
    if not IsEqualForObjects( ShiftOnObject( Source( alpha ) ), Range( pi ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    iota_alpha := MorphismToStandardConeObject( alpha );
    
    pi_alpha := MorphismFromStandardConeObject( alpha );
    
    left_coeffs := [ [ iota ], [ IdentityMorphism( Range( iota )  ) ] ];
    
    right_coeffs := [ [ IdentityMorphism( Range( iota_alpha ) ) ], [ pi_alpha ] ];
    
    right_side := [ iota_alpha, pi ];
    
    sol := SolveLinearSystemInAbCategory( left_coeffs, right_coeffs, right_side );
    
    if sol = fail then
      
      return fail;
      
    else
      
      return sol[ 1 ];
      
    fi;
  
  end,
[
  WitnessIsomorphismFromStandardConeObject,
    function( cat, alpha, iota, pi )
      local w;
      
      w := WitnessIsomorphismOntoStandardConeObject( alpha, iota, pi );
      
      if w = fail then
        
        return w;
        
      else
        
        return Inverse( w );
        
      fi;
      
    end
]:
  CategoryFilter := IsTriangulatedCategory,
  Description := "Adding witnesses for beeing exact by using SolveLinearSystemInAbCategory"
);

# See categories and homological algebra (schapira)
AddFinalDerivation( IsIsomorphism,
                [
                    [ StandardConeObject, 1 ],
                    [ IsZeroForObjects,  1 ]
                ],
                [
                    IsIsomorphism
                ],
  function( cat, alpha )
  
    return IsZeroForObjects( StandardConeObject( alpha ) );
    
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "IsIsomorphism by deciding if the cone object is zero"
);


AddDerivationToCAP( DomainMorphismByOctahedralAxiomWithGivenObjects,
                [
                    [ IdentityMorphism, 1 ],
                    [ MorphismBetweenStandardConeObjectsWithGivenObjects,  1 ]
                ],
  function( cat, s, alpha, beta, gamma, r )
    local A, id_A;
    
    A := Source( alpha );
    
    id_A := IdentityMorphism( A );
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects( s, alpha, id_A, beta, gamma, r );
    
end );

AddDerivationToCAP( MorphismFromConeObjectByOctahedralAxiomWithGivenObjects,
                [
                  [ StandardConeObject, 2 ],
                  [ MorphismFromStandardConeObjectWithGivenStandardConeObject, 1 ],
                  [ MorphismToStandardConeObjectWithGivenStandardConeObject, 1 ],
                  [ ShiftOnObject, 1 ],
                  [ ShiftOnMorphismWithGivenObjects, 1 ]
                ],
  function( cat, s, alpha, beta, gamma, r )
    local B, pi_beta, cone_alpha, iota_alpha;
    
    B := Range( alpha );
     
    pi_beta := MorphismFromStandardConeObjectWithGivenStandardConeObject(
                          beta,
                          s
                      );
    
    cone_alpha := StandardConeObject( alpha );
    
    iota_alpha := MorphismToStandardConeObjectWithGivenStandardConeObject(
                          alpha,
                          cone_alpha
                      );
    
    iota_alpha := ShiftOnMorphismWithGivenObjects(
                      ShiftOnObject( B ),
                      iota_alpha,
                      r
                    );
    
    return PreCompose( pi_beta, iota_alpha );
    
end );

##
AddDerivationToCAP( IsSplitEpimorphism,
                [
                    [ IsEpimorphism, 1 ]
                ],
  function( cat, alpha )
    return IsEpimorphism( alpha );
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "a morphism is triangulated categories is epi iff it is split epi"
);

##
AddDerivationToCAP( IsSplitMonomorphism,
                [
                    [ IsMonomorphism, 1 ]
                ],
  function( cat, alpha )
    return IsMonomorphism( alpha );
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "a morphism is triangulated categories is mono iff it is split mono"
);

##
AddDerivationToCAP( IsEpimorphism,
                [
                    [ IsSplitEpimorphism, 1 ]
                ],
  function( cat, alpha )
    return IsSplitEpimorphism( alpha );
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "a morphism is triangulated categories is epi iff it is split epi"
);

##
AddDerivationToCAP( IsMonomorphism,
                [
                    [ IsSplitMonomorphism, 1 ]
                ],
  function( cat, alpha )
    return IsSplitMonomorphism( alpha );
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "a morphism is triangulated categories is mono iff it is split mono"
);

##
AddDerivationToCAP( ShiftFactoringIsomorphismWithGivenObjects,
                [
                    [ InjectionOfCofactorOfDirectSum, 1 ],
                    [ ShiftOnMorphismWithGivenObjects, 1 ]
                ],
  function( cat, s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ ShiftOnMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
end:
  ategoryFilter := IsTriangulatedCategory,
  Description:= "ShiftFactoringIsomorphismWithGivenObjects using InjectionOfCofactorOfDirectSum and ShiftOnMorphism"
);

AddDerivationToCAP( ShiftExpandingIsomorphismWithGivenObjects,
                [
                    [ ProjectionInFactorOfDirectSum, 1 ],
                    [ ShiftOnMorphismWithGivenObjects, 1 ]
                ],
  function( cat, s, L, r  )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> ShiftOnMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
    
end:
 CategoryFilter := IsTriangulatedCategory,
  Description:= "ShiftExpandingIsomorphismWithGivenObjects using ProjectionInFactorOfDirectSum and ShiftOnMorphism"

);

##
AddDerivationToCAP( InverseShiftFactoringIsomorphismWithGivenObjects,
                [
                    [ InjectionOfCofactorOfDirectSum, 1 ],
                    [ InverseShiftOnMorphismWithGivenObjects, 1 ]
                ],
  function( cat, s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> InjectionOfCofactorOfDirectSum( L , i ) );
    Tl := List( l, m -> [ InverseShiftOnMorphism( m ) ] );
    return MorphismBetweenDirectSums( Tl );
    
 end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "InverseShiftFactoringIsomorphismWithGivenObjects using InjectionOfCofactorOfDirectSum and InverseShiftOnMorphism"
 );

##
AddDerivationToCAP( InverseShiftExpandingIsomorphismWithGivenObjects,
                [
                    [ ProjectionInFactorOfDirectSum, 1 ],
                    [ InverseShiftOnMorphismWithGivenObjects, 1 ]
                ],
  function( cat, s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> InverseShiftOnMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
       
 end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "InverseShiftExpandingIsomorphismWithGivenObjects using ProjectionInFactorOfDirectSum and InverseShiftOnMorphism"
 );

##


