# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#

##
AddDerivationToCAP( IsLiftableAlongMorphismFromLiftingObject,
                    "IsLiftableAlongMorphismFromLiftingObject using IsLiftable & MorphismFromLiftingObject methods",
                [
                    [ IsLiftable, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return IsLiftable( alpha, P_b );
    
end );

##
AddDerivationToCAP( WitnessForBeingLiftableAlongMorphismFromLiftingObject,
                    "WitnessForBeingLiftableAlongMorphismFromLiftingObject using Lift & MorphismFromLiftingObject methods",
                [
                    [ Lift, 1 ],
                    [ MorphismFromLiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local b, P_b;
    
    b := Range( alpha );
    
    P_b := MorphismFromLiftingObject( b );
    
    return Lift( alpha, P_b );
 
   
end );


##
AddDerivationToCAP( IsColiftableAlongMorphismToColiftingObject,
                    "IsColiftableAlongMorphismToColiftingObject using IsColiftable & MorphismToColiftingObject methods",
                [
                    [ IsColiftable, 1 ],
                    [ MorphismToColiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismToColiftingObject( a );
    
    return IsColiftable( I_a, alpha );
   
end );

##
AddDerivationToCAP( WitnessForBeingColiftableAlongMorphismToColiftingObject,
                    "WitnessForBeingColiftableAlongMorphismToColiftingObject using Colift & MorphismToColiftingObject methods",
                [
                    [ Colift, 1 ],
                    [ MorphismToColiftingObject,  1 ]
                ],
    
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );
    
    I_a := MorphismToColiftingObject( a );
    
    return Colift( I_a, alpha );
   
end );

##
AddFinalDerivationBundle( "Adding system of colifting objects to cochain complexes categories",
            [
              [ IdentityMorphism, 2 ],
              [ MorphismBetweenDirectSums, 1 ],
            ],
            [
              IsColiftingObject,
              ColiftingObject,
              MorphismToColiftingObjectWithGivenColiftingObject,
              RetractionOfMorphismToColiftingObjectWithGivenColiftingObject,
              ColiftingMorphismWithGivenColiftingObjects,
              IsColiftableAlongMorphismToColiftingObject,
              WitnessForBeingColiftableAlongMorphismToColiftingObject
            ],
[
  IsColiftingObject,
  function( category, A )
    local id_A;
    
    id_A := IdentityMorphism( A );
    
    return ValueGlobal( "IsNullHomotopic" )( id_A ); # it need to be fixed
    
  end
],
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
    
    lambda := ValueGlobal( "HomotopyMorphisms" )( id_A );
    
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
] :
  CategoryFilter := IsCochainComplexCategory
);
