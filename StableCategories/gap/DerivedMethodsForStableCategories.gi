# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#

##
AddDerivationToCAP( IsLiftableAlongMorphismFromLiftingObject,
                [
                    [ Lift, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return Lift( alpha, P_b ) <> fail;
    
end: Description:= "IsLiftableAlongMorphismFromLiftingObject using Lift & MorphismFromLiftingObject" );


##
AddDerivationToCAP( IsLiftableAlongMorphismFromLiftingObject,
                [
                    [ IsLiftable, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return IsLiftable( alpha, P_b );
    
end: Description:= "IsLiftableAlongMorphismFromLiftingObject using IsLiftable & MorphismFromLiftingObject methods" );

##
AddDerivationToCAP( WitnessForBeingLiftableAlongMorphismFromLiftingObject,
                [
                    [ Lift, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return Lift( alpha, P_b );
 
   
end: Description:= "WitnessForBeingLiftableAlongMorphismFromLiftingObject using Lift & MorphismFromLiftingObject methods" );


##
AddDerivationToCAP( IsColiftableAlongMorphismToColiftingObject,
                [
                    [ Colift, 1 ],
                    [ MorphismToColiftingObject,  1 ]
                ],
  
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismToColiftingObject( a );
    
    return Colift( I_a, alpha ) <> fail;
    
end: Description:= "IsColiftableAlongMorphismToColiftingObject using Colift & MorphismToColiftingObject" );


##
AddDerivationToCAP( IsColiftableAlongMorphismToColiftingObject,
                [
                    [ IsColiftable, 1 ],
                    [ MorphismToColiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismToColiftingObject( a );
    
    return IsColiftable( I_a, alpha );
   
end: Description:= "IsColiftableAlongMorphismToColiftingObject using IsColiftable & MorphismToColiftingObject methods" );

##
AddDerivationToCAP( WitnessForBeingColiftableAlongMorphismToColiftingObject,
                [
                    [ Colift, 1 ],
                    [ MorphismToColiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismToColiftingObject( a );
    
    return Colift( I_a, alpha );
   
end: Description:= "WitnessForBeingColiftableAlongMorphismToColiftingObject using Colift & MorphismToColiftingObject methods" );
