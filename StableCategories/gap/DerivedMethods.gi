
##
AddDerivationToCAP( IsLiftableThroughLiftingObject,
                [
                    [ Lift, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return Lift( alpha, P_b ) <> fail;
    
end: Description:= "IsLiftableThroughLiftingObject using Lift & MorphismFromLiftingObject" );


##
AddDerivationToCAP( IsLiftableThroughLiftingObject,
                [
                    [ IsLiftable, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return IsLiftable( alpha, P_b );
    
end: Description:= "IsLiftableThroughLiftingObject using IsLiftable & MorphismFromLiftingObject methods" );

##
AddDerivationToCAP( WitnessForBeingLiftableThroughLiftingObject,
                [
                    [ Lift, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return Lift( alpha, P_b );
 
   
end: Description:= "WitnessForBeingLiftableThroughLiftingObject using Lift & MorphismFromLiftingObject methods" );


##
AddDerivationToCAP( IsColiftableThroughColiftingObject,
                [
                    [ Colift, 1 ],
                    [ MorphismIntoColiftingObject,  1 ]
                ],
  
  function( alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismIntoColiftingObject( a );
    
    return Colift( I_a, alpha ) <> fail;
    
end: Description:= "IsColiftableThroughColiftingObject using Colift & MorphismIntoColiftingObject" );


##
AddDerivationToCAP( IsColiftableThroughColiftingObject,
                [
                    [ IsColiftable, 1 ],
                    [ MorphismIntoColiftingObject,  1 ]
                ],
    
  function( alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismIntoColiftingObject( a );
    
    return IsColiftable( I_a, alpha );
   
end: Description:= "IsColiftableThroughColiftingObject using IsColiftable & MorphismIntoColiftingObject methods" );

##
AddDerivationToCAP( WitnessForBeingColiftableThroughColiftingObject,
                [
                    [ Colift, 1 ],
                    [ MorphismIntoColiftingObject,  1 ]
                ],
    
  function( alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismIntoColiftingObject( a );
    
    return Colift( I_a, alpha );
   
end: Description:= "WitnessForBeingColiftableThroughColiftingObject using Colift & MorphismIntoColiftingObject methods" );

