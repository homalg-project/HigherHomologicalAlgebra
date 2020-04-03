#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2020,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################

################################################
##
## Derived Methods for Triangulated Categories
##
################################################

##
AddDerivationToCAP( IsExactTriangle,
                [
                  [ WitnessIsomorphismIntoStandardConeObject, 1 ],
                ],
  function( alpha, iota, pi )
    
    return WitnessIsomorphismIntoStandardConeObject( alpha, iota, pi ) <> fail;
    
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "IsExactTriangle by WitnessIsomorphismIntoStandardConeObject"
);

##
AddFinalDerivation( WitnessIsomorphismIntoStandardConeObject,
                [
                  [ SolveLinearSystemInAbCategory, 1 ],
                  [ ShiftOnObject, 1 ]
                ],
                [
                  WitnessIsomorphismIntoStandardConeObject,
                  WitnessIsomorphismFromStandardConeObject
                ],
  function( alpha, iota, pi )
    local iota_alpha, pi_alpha, left_coeffs, right_coeffs, right_side, sol;
    
    if not IsEqualForObjects( ShiftOnObject( Source( alpha ) ), Range( pi ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    iota_alpha := MorphismIntoStandardConeObject( alpha );
    
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
    function( alpha, iota, pi )
      local w;
      
      w := WitnessIsomorphismIntoStandardConeObject( alpha, iota, pi );
      
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
  function( alpha )
  
    return IsZeroForObjects( StandardConeObject( alpha ) );
    
end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "IsIsomorphism by deciding if the cone object is zero"
);

##
AddDerivationToCAP( IsSplitEpimorphism,
                [
                    [ IsEpimorphism, 1 ]
                ],
  function( alpha )
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
  function( alpha )
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
  function( alpha )
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
  function( alpha )
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
  function( s, L, r  )
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
  function( s, L, r  )
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
  function( s, L, r )
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
  function( s, L, r )
    local l, Tl;

    l := List( [ 1..Length( L ) ], i -> ProjectionInFactorOfDirectSum( L , i ) );
    Tl := List( l, m -> InverseShiftOnMorphism( m ) );
    return MorphismBetweenDirectSums( [ Tl ] );
       
 end:
  CategoryFilter := IsTriangulatedCategory,
  Description:= "InverseShiftExpandingIsomorphismWithGivenObjects using ProjectionInFactorOfDirectSum and InverseShiftOnMorphism"
 );

##

