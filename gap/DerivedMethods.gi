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
AddFinalDerivation( WitnessIsomorphismIntoStandardConeObjectByExactTriangle,
                [
                  [ SolveLinearSystemInAbCategory, 1 ],
                  [ Inverse, 1 ]
                ],
                [
                  WitnessIsomorphismIntoStandardConeObjectByExactTriangle,
                  WitnessIsomorphismFromStandardConeObjectByExactTriangle
                ],
  function( alpha, iota, pi )
    local iota_alpha, pi_alpha, left_coeffs, right_coeffs, right_side, sol;
    
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
  WitnessIsomorphismFromStandardConeObjectByExactTriangle,
    function( alpha, iota, pi )
      local w;
      
      w := WitnessIsomorphismIntoStandardConeObjectByExactTriangle( alpha, iota, pi );
      
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
