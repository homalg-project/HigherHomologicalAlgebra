#############################################################################
##
##  ComplexesForCAP.gi             ComplexesForCAP package
##
##  Copyright 2018,                Kamal Saleh, Siegen University, Germany
##
#############################################################################

################################################
##
## Derived Methods for chain complexes categories
##
################################################

AddDerivationToCAP( IsNullHomotopic,
                [
                    [ Colift, 1 ],
                    [ IsZeroForMorphisms, 1 ]
                ],
    function( phi )
    return  IsZeroForMorphisms( phi ) or
            Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) <> fail;
    end: CategoryFilter := IsChainOrCochainComplexCategory, 
         Description := "compute if a morphism is homotopic to zero using colifts" );

AddDerivationToCAP( HomotopyMorphisms,
                [
                    [ IsNullHomotopic, 1 ],
                    [ Colift, 1 ]
                ],
    function( phi )
    local C, D, colift;
    if not IsNullHomotopic( phi ) then
        return fail;
    fi;
    C := Source( phi );
    D := Range( phi );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    if colift = fail then 
      return fail;
    else
      return MapLazy( IntegersList, 
      		n -> PreCompose( 
		MorphismBetweenDirectSums( [ [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n + 1 ] ) ] ] ),
		colift[ n + 1 ] ), 1 );
    fi;
end: CategoryFilter := IsChainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

AddDerivationToCAP( HomotopyMorphisms,
                [
                    [ IsNullHomotopic, 1 ],
                    [ Colift, 1 ]
                ],
    function( phi )
    local C, D, colift;
    if not IsNullHomotopic( phi ) then
        return fail;
    fi;
    C := Source( phi );
    D := Range( phi );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    if colift = fail then 
      return fail;
    else
      return MapLazy( IntegersList, 
      		n -> PreCompose( 
		MorphismBetweenDirectSums( [ [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n - 1 ] ) ] ] ),
		colift[ n - 1 ] ), 1 );
    fi;
end: CategoryFilter := IsCochainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

AddDerivationToCAP( Lift,
            [
              [ DistinguishedObjectOfHomomorphismStructure, 1 ],
              [ InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphismsWithGivenObjects, 1 ],
              [ InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism, 1 ]
            ],
  function( alpha, beta )
    local cat, P, N, M, D, D_to_hom_PN, PM_to_PN, m1, m2, lift;
  
    cat := CapCategory( alpha );
    
    P := Source( alpha );
    
    N := Range( alpha );
    
    M := Source( beta );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    D_to_hom_PN := InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha );
    
    PM_to_PN := HomomorphismStructureOnMorphisms( IdentityMorphism( P ), beta );
    
    m1 := [ [ D_to_hom_PN[ 0 ], ZeroMorphism( D[0], Source( PM_to_PN )[ -1 ] ) ] ];
    
    m1 := MorphismBetweenDirectSums( m1 );
    
    m2 := [ [ PM_to_PN[ 0 ], Source( PM_to_PN )^0 ] ];
    
    m2 := MorphismBetweenDirectSums( m2 );
    
    lift := Lift( m1, m2 );
    
    if lift = fail then
      
      return fail;
      
    else
      
      lift := ChainMorphism( D, Source( PM_to_PN ), [ lift ], 0 );
      
      return InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( P, M, lift );
    
    fi;

    
end: ConditionsListComplete := true,
CategoryFilter := function( chains )
  local cat, range_cat, range_chains, conditions;
  
  if not IsChainComplexCategory( chains ) then
    
    return false;
  
  fi;
  
  cat := UnderlyingCategory( chains );
  
  if not  ( HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat ) ) then
    
    return false;
    
  fi;
  
  range_cat := RangeCategoryOfHomomorphismStructure( cat );
  
  if HasIsAbCategory( chains ) and IsAbCategory( chains ) and HasRangeCategoryOfHomomorphismStructure( chains ) then

      range_chains := RangeCategoryOfHomomorphismStructure( chains );
      
      if not HasUnderlyingCategory( range_chains ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( range_chains ), range_cat ) then
        
        return false;
        
      fi;
      
      conditions := [
        "MorphismBetweenDirectSums",
        "Lift",
      ];

      if ForAll( conditions, c -> CanCompute( range_cat, c ) ) then
         
          return true;

      fi;

  fi;

  return false;

end,
Description := "Lift in chain complexes using the homomorphism structure"
);
   
AddDerivationToCAP( Colift,
            [
              [ DistinguishedObjectOfHomomorphismStructure, 1 ],
              [ InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphismsWithGivenObjects, 1 ],
              [ InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism, 1 ]
            ],
  function( alpha, beta )
    local cat, M, N, I, D, D_to_hom_MI, NI_to_MI, m1, m2, lift;
  
    cat := CapCategory( alpha );
    
    M := Source( alpha );
    
    N := Range( alpha );
    
    I := Range( beta );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    D_to_hom_MI := InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( beta );
    
    NI_to_MI := HomomorphismStructureOnMorphisms( alpha, IdentityMorphism( I ) );
    
    m1 := [ [ D_to_hom_MI[ 0 ], ZeroMorphism( D[0], Source( NI_to_MI )[ -1 ] ) ] ];
    
    m1 := MorphismBetweenDirectSums( m1 );
    
    m2 := [ [ NI_to_MI[ 0 ], Source( NI_to_MI )^0 ] ];
    
    m2 := MorphismBetweenDirectSums( m2 );
    
    lift := Lift( m1, m2 );
    
    if lift = fail then
      
      return fail;
      
    else
      
      lift := ChainMorphism( D, Source( NI_to_MI ), [ lift ], 0 );
      
      return InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( N, I, lift );
    
    fi;

    
end: ConditionsListComplete := true,
CategoryFilter := function( chains )
  local cat, range_cat, range_chains, conditions;
  
  if not IsChainComplexCategory( chains ) then
    
    return false;
  
  fi;
  
  cat := UnderlyingCategory( chains );
  
  if not  ( HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat ) ) then
    
    return false;
    
  fi;
  
  range_cat := RangeCategoryOfHomomorphismStructure( cat );
  
  if HasIsAbCategory( chains ) and IsAbCategory( chains ) and HasRangeCategoryOfHomomorphismStructure( chains ) then

      range_chains := RangeCategoryOfHomomorphismStructure( chains );
      
      if not HasUnderlyingCategory( range_chains ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( range_chains ), range_cat ) then
        
        return false;
        
      fi;
      
      conditions := [
        "MorphismBetweenDirectSums",
        "Lift",
      ];

      if ForAll( conditions, c -> CanCompute( range_cat, c ) ) then
         
          return true;

      fi;

  fi;

  return false;

end,
Description := "Colift in chain complexes using the homomorphism structure"
);

