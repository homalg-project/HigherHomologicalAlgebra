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

##
AddFinalDerivation( IsColiftingObject,
            [
              [ IdentityMorphism, 1 ],
              [ IsNullHomotopic, 1 ],
              [ Colift, 1 ]
            ],
            [
              IsColiftingObject,
              ColiftingObject,
              MorphismToColiftingObjectWithGivenColiftingObject,
              ColiftingMorphismWithGivenColiftingObjects,
              IsColiftableAlongMorphismToColiftingObject,
              WitnessForBeingColiftableAlongMorphismToColiftingObject
            ],
            
  function( category, A )
    local id_A;
    
    id_A := IdentityMorphism( A );
    
    return IsNullHomotopic( id_A );
    
  end,
[
  ColiftingObject,
  function( category, A )
    local id_A;
    
    id_A := IdentityMorphism( A );
    
    return MappingCone( id_A );
    
  end
],
[
  MorphismToColiftingObjectWithGivenColiftingObject,
  function( category, A, Q_A )
    local id_A;
    
    id_A := IdentityMorphism( A );
    
    return NaturalInjectionInMappingCone( id_A );
    
  end
],
[
  RetractionOfMorphismToColiftingObjectWithGivenColiftingObject,
  function( category, A, Q_A )
    local id_A, lambda, r_A;
    
    id_A := IdentityMorphism( A );
    
    lambda := HomotopyMorphisms( id_A );
    
    r_A := AsZFunction( i -> MorphismBetweenDirectSums( [ [ lambda[ i +1 ] ], [ id_A[ i ] ] ] ) );
    
    return CochainMorphism( Q_A, A, r_A );
    
  end
],
[
  ColiftingMorphismWithGivenColiftingObjects,
  function( category, Q_A, phi, Q_B )
    local A, id_A, B, id_B;
    
    A := Source( phi );
    
    id_A := IdentityMorphism( A );
    
    B := Range( phi );
    
    id_B := IdentityMorphism( B );
    
    return MappingConeFunctorial( Q_A, id_A, phi, phi, id_B, Q_B );
    
end
] : ConditionsListComplete := true,
  FunctionCalledBeforeInstallation :=
    function( cat )
      return;
    end,
  CategoryFilter := IsChainOrCochainComplexCategory,
  Description := "Adding system of colifting objects to complexes categories"
);
