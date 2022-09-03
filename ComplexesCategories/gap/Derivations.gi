# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##
#############################################################################

################################################
##
## Derived Methods for chain complexes categories
##
################################################

## Homotopy methods

##
AddDerivationToCAP( IsNullHomotopic,
                [
                    [ HomotopyMorphisms, 1 ],
                ],
    function( cat, phi )
    
      return HomotopyMorphisms( phi ) <> fail;
      
   end: CategoryFilter := IsChainOrCochainComplexCategory, 
         Description := "compute if a morphism is homotopic to zero using colifts" );

##
AddDerivationToCAP( HomotopyMorphisms,
                [
                    #[ IdentityMorphism, 1 ] # this should be modified!
                ],
  function( cat, phi )
    local A, B, m, n, L, K, b, sol, H;
    
    A := Source( phi );
    
    B := Range( phi );
    
    m := Minimum( ActiveLowerBound( A ), ActiveLowerBound( B ) );
    
    n := Maximum( ActiveUpperBound( A ), ActiveUpperBound( B ) );
    
    if IsEqualToZeroMorphism( phi ) or m > n then
      Info( InfoComplexesCategories, 2, "Computing witness of being null-homotopic the easy way ..." );
      return AsZFunction( n -> ZeroMorphism( A[ n ], B[ n - 1 ] ) );
      Info( InfoComplexesCategories, 2, "Done!" );
    fi;
   
    L := Concatenation( 
           
          List( [ 1 .. n - m ],
            i -> Concatenation(
              ##
              List( [ 1 .. i - 1 ],
                j -> ZeroMorphism( A[ i + m - 1 ],A[ j + m - 1 ] ) ),
              ##
              [ IdentityMorphism( A[ i + m - 1 ] ), A^( i + m - 1 ) ],
              ##
              List( [ i + 2 ..n - m + 1 ], 
                j -> ZeroMorphism( A[ i + m - 1 ] , A[ j + m - 1 ] ) )
                              )
            ),
            
            [ Concatenation(
                List( [ 1 .. n - m ], 
                  j -> ZeroMorphism( A[ n ], A[ j + m - 1 ] ) ), 
              
                [ IdentityMorphism( A[ n ] ) ] ) ] 
                
          );
          
    K := Concatenation(
          
          List( [ 1 .. n - m ],
            i -> Concatenation( 
              
              List( [ 1 .. i - 1 ], 
                j -> ZeroMorphism( B[ j + m - 2 ],B[ i + m - 1 ] ) ),
              
              [ B^( i + m - 2 ), IdentityMorphism( B[ i + m - 1 ] ) ],
              
              
              List( [ i + 2 ..n - m + 1 ],
                j -> ZeroMorphism( B[ j + m - 2 ], B[ i + m - 1 ]) ) 
                              ) 
            ),
              
          [ Concatenation(
              
              List([ 1 .. n - m ], 
                j -> ZeroMorphism( B[ j + m - 2 ], B[ n ] ) ),
                
              [ B^(n - 1) ] ) ] 
            
          );
    
    b := List( [ m .. n ], i -> phi[ i ] );
    
    Info( InfoComplexesCategories, 2, "\033[5mComputing\033[0m witness of being null-homotopic the hard way: SolveLinearSystemInAbCategoryOrFail ..." );
    sol := SolveLinearSystemInAbCategoryOrFail( L, K, b );
    Info( InfoComplexesCategories, 2, "Done!" );
    
    if sol = fail then
      
      SetIsNullHomotopic( phi, false );
      
      return fail;
      
    else
      
      # This H is not well-defined, we only need the Z function
      
      SetIsNullHomotopic( phi, true );
      
      H := CochainMorphism( A, ShiftLazy( B, -1 ), sol, m );
      
      return Morphisms( H );
      
    fi;
    
end:
CategoryFilter := function( cochains )
  local cat;
  
  if not IsCochainComplexCategory( cochains ) then
    
    return false;
  
  fi;
  
  cat := UnderlyingCategory( cochains );
  
  if CanCompute( cat, "SolveLinearSystemInAbCategoryOrFail" ) then
    
    return true;
    
  fi;
  
  return false;

end,
Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

##
AddDerivationToCAP( HomotopyMorphisms,
                [
                    #[ IdentityMorphism, 1 ]
                ],
  function( cat, phi )
    local A, B, m, n, L, K, b, sol, H;
    
    A := Source( phi );
    
    B := Range( phi );
    
    m := Minimum( ActiveLowerBound( A ), ActiveLowerBound( B ) );
    
    n := Maximum( ActiveUpperBound( A ), ActiveUpperBound( B ) );
    
    if IsEqualToZeroMorphism( phi ) or m > n then
      Info( InfoComplexesCategories, 2, "Computing witness of being null-homotopic the easy way ..." );
      return AsZFunction( n -> ZeroMorphism( A[ n ], B[ n + 1 ] ) );
      Info( InfoComplexesCategories, 2, "Done!" );
    fi;
     
    L := Concatenation( 
          
          List( [ 1 .. n - m ],
            i -> Concatenation(
              
              List( [ 1 .. i - 1 ], 
                j -> ZeroMorphism( A[ -i + n + 1 ], A[ -j + n + 1 ] ) ),
              
              [ IdentityMorphism( A[ -i + n + 1 ] ), A^( -i + n + 1 ) ],
                List( [ i + 2 ..-m + n + 1 ],
                  j -> ZeroMorphism( A[ -i + n + 1 ] , A[ -j + n + 1 ] ) ) 
                  
                              )
                              
              ),
              
          [ Concatenation( 
              
              List([ 1 .. n - m ],
                j -> ZeroMorphism( A[ m ], A[ -j + n + 1 ] ) ),
                
              [ IdentityMorphism( A[ m ] ) ] 
              
              ) ] 
              
          );
          
    K := Concatenation(
          
          List( [ 1 .. n - m ],
            i -> Concatenation(
              
              List( [ 1 .. i - 1 ],
                  j -> ZeroMorphism( B[ -j + n + 2 ], B[ -i + n + 1 ] ) ), 
                  
              [ B^( -i + n + 2 ), IdentityMorphism( B[ -i + n + 1 ] ) ],
              
              List( [ i + 2 ..n - m + 1 ],
                
                j -> ZeroMorphism( B[ -j + n + 2 ], B[ -i + n + 1 ] ) ) ) 
                
              ),
              
          [ Concatenation(
              
              List([ 1 .. n - m ], j -> ZeroMorphism( B[ -j + n + 2 ], B[ m ] ) ),
              
              [ B^( m + 1 ) ] ) ] 
              
          );
          
    b := List( Reversed( [ m .. n ] ), i -> phi[ i ] );
    
    Info( InfoComplexesCategories, 2, "\033[5mComputing\033[0m witness of being null-homotopic the hard way: SolveLinearSystemInAbCategoryOrFail ..." );
    sol := SolveLinearSystemInAbCategoryOrFail( L, K, b );
    Info( InfoComplexesCategories, 2, "Done!" );
    
    if sol = fail then
      
      SetIsNullHomotopic( phi, false );
      
      return fail;
      
    else
      
      SetIsNullHomotopic( phi, true );
      
      H := ChainMorphism( A, ShiftLazy( B, 1 ), Reversed( sol ), m );
      
      return Morphisms( H );
      
    fi;
    
end:
CategoryFilter := function( chains )
  local cat;
  
  if not IsChainComplexCategory( chains ) then
    
    return false;
    
  fi;
  
  cat := UnderlyingCategory( chains );
  
  if CanCompute( cat, "SolveLinearSystemInAbCategoryOrFail" ) then
    
    return true;
    
  fi;
  
  return false;
  
end,
Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

##
AddFinalDerivation( HomotopyMorphisms,
                [
                  [ IsEqualToZeroMorphism, 1 ],
                  [ ZeroMorphism, 2 ],
                  [ IdentityMorphism, 2 ],
                  [ Colift, 1 ],
                  [ MorphismBetweenDirectSums, 1 ],
                  [ PreCompose, 1 ],
                ],
                [
                  HomotopyMorphisms
                ],
  function( cat, phi )
    local C, D, colift;
    
    C := Source( phi );
    
    D := Range( phi );
    
    if IsEqualToZeroMorphism( phi ) then
      Info( InfoComplexesCategories, 2, "Computing witness of being null-homotopic the easy way ..." );
      return AsZFunction( n -> ZeroMorphism( C[ n ], D[ n + 1 ] ) );
      Info( InfoComplexesCategories, 2, "Done!" );
    fi;
    
    Info( InfoComplexesCategories, 2, "\033[5mComputing\033[0m witness of being null-homotopic the hard way via colift ..." );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    Info( InfoComplexesCategories, 2, "Done!" );
    
    if colift = fail then
      SetIsNullHomotopic( phi, false );
      return fail;
    else
      SetIsNullHomotopic( phi, true );
      return AsZFunction( n ->
                PreCompose(
                  MorphismBetweenDirectSums(
                    [
                      [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n + 1 ] ) ]
                    ]
                  ),
                  colift[ n + 1 ] )
                );
    fi;
    
end: CategoryFilter := IsChainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

##
AddFinalDerivation( HomotopyMorphisms,
                [
                  [ IsEqualToZeroMorphism, 1 ],
                  [ ZeroMorphism, 2 ],
                  [ IdentityMorphism, 2 ],
                  [ Colift, 1 ],
                  [ MorphismBetweenDirectSums, 1 ],
                  [ PreCompose, 1 ],
                ],
                [
                  HomotopyMorphisms
                ],
  function( cat, phi )
    local C, D, colift;
    
    C := Source( phi );
    
    D := Range( phi );
    
    if IsEqualToZeroMorphism( phi ) then
      Info( InfoComplexesCategories, 2, "Computing witness of being null-homotopic the easy way ..." );
      return AsZFunction( n -> ZeroMorphism( C[ n ], D[ n - 1 ] ) );
      Info( InfoComplexesCategories, 2, "Done!" );
    fi;
    
    Info( InfoComplexesCategories, 2, "\033[5mComputing\033[0m witness of being null-homotopic the hard way ..." );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    Info( InfoComplexesCategories, 2, "Done!" );
    
    if colift = fail then 
      SetIsNullHomotopic( phi, false );
      return fail;
    else
      SetIsNullHomotopic( phi, true );
      return AsZFunction( n -> 
                PreCompose(
                  MorphismBetweenDirectSums(
                    [ 
                      [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n - 1 ] ) ]
                    ] ),
                  colift[ n - 1 ] )
                );
    fi;
    
end: CategoryFilter := IsCochainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );


## Lift in case chains has homomorphism structure over category of chains

##
AddDerivationToCAP( Lift,
            [
              [ DistinguishedObjectOfHomomorphismStructure, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ IdentityMorphism, 1 ],
              [ ZeroMorphism, 1, RangeCategoryOfHomomorphismStructure ],
              [ MorphismBetweenDirectSums, 2, RangeCategoryOfHomomorphismStructure ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
            ],
  function( cat, alpha, beta )
    local range_cat, P, N, M, D, D_to_hom_PN, PM_to_PN, m1, m2, lift;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    P := Source( alpha );
    
    N := Range( alpha );
    
    M := Source( beta );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    D_to_hom_PN := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
    
    PM_to_PN := HomomorphismStructureOnMorphisms( IdentityMorphism( P ), beta );
    
    m1 := [ [ D_to_hom_PN[ 0 ], ZeroMorphism( range_cat, D[ 0 ], Source( PM_to_PN )[ -1 ] ) ] ];
    
    m1 := MorphismBetweenDirectSums( range_cat, m1 );
    
    m2 := [ [ PM_to_PN[ 0 ], Source( PM_to_PN )^0 ] ];
    
    m2 := MorphismBetweenDirectSums( range_cat, m2 );
    
    lift := Lift( range_cat, m1, m2 );
    
    if lift = fail then
      
      return fail;
      
    else
      
      lift := ChainMorphism( D, Source( PM_to_PN ), [ lift ], 0 );
      
      return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( P, M, lift );
    
    fi;

end: ConditionsListComplete := true,
CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
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
  
  if not IsChainComplexCategory( range_cat ) then
    
    return false;
    
  fi;

  if HasIsAbCategory( chains ) and IsAbCategory( chains ) and HasRangeCategoryOfHomomorphismStructure( chains ) then

      range_chains := RangeCategoryOfHomomorphismStructure( chains );
      
      if not HasUnderlyingCategory( range_chains ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( range_chains ), range_cat ) then
        
        return false;
        
      fi;
      
  fi;

  return false;

end,
Description := "Lift in chain complexes using the homomorphism structure"
);

## Colift in case chains has homomorphism structure over category of chains

##
AddDerivationToCAP( Colift,
            [
              [ DistinguishedObjectOfHomomorphismStructure, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ IdentityMorphism, 1 ],
              [ ZeroMorphism, 1, RangeCategoryOfHomomorphismStructure ],
              [ MorphismBetweenDirectSums, 2, RangeCategoryOfHomomorphismStructure ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
            ],
  function( cat, alpha, beta )
    local range_cat, M, N, I, D, D_to_hom_MI, NI_to_MI, m1, m2, lift;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    M := Source( alpha );
    
    N := Range( alpha );
    
    I := Range( beta );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    D_to_hom_MI := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( beta );
    
    NI_to_MI := HomomorphismStructureOnMorphisms( alpha, IdentityMorphism( I ) );
    
    m1 := [ [ D_to_hom_MI[ 0 ], ZeroMorphism( range_cat, D[0], Source( NI_to_MI )[ -1 ] ) ] ];
    
    m1 := MorphismBetweenDirectSums( range_cat, m1 );
    
    m2 := [ [ NI_to_MI[ 0 ], Source( NI_to_MI )^0 ] ];
    
    m2 := MorphismBetweenDirectSums( range_cat, m2 );
    
    lift := Lift( range_cat, m1, m2 );
    
    if lift = fail then
      
      return fail;
      
    else
      
      lift := ChainMorphism( D, Source( NI_to_MI ), [ lift ], 0 );
      
      return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( N, I, lift );
    
    fi;
   
end: ConditionsListComplete := true,
CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
CategoryFilter := function( chains )
  local cat, range_cat, range_chains, conditions;
  
  if not IsChainComplexCategory( chains ) then
    
    return false;
  
  fi;
  
  cat := UnderlyingCategory( chains );
  
  if not ( HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat ) ) then
    
    return false;
    
  fi;
  
  range_cat := RangeCategoryOfHomomorphismStructure( cat );
  
  if not IsChainComplexCategory( range_cat ) then
    
    return false;
    
  fi;
  
  if HasIsAbCategory( chains ) and IsAbCategory( chains ) and HasRangeCategoryOfHomomorphismStructure( chains ) then

      range_chains := RangeCategoryOfHomomorphismStructure( chains );
      
      if not HasUnderlyingCategory( range_chains ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( UnderlyingCategory( range_chains ), range_cat ) then
        
        return false;
        
      fi;
      
  fi;

  return false;

end,
Description := "Colift in chain complexes using the homomorphism structure"
);

##
AddDerivationToCAP( Lift,
            [
              [ IdentityMorphism, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
            ],
  function( cat, alpha, beta )
    local range_cat, f, g, l;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    f := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
    
    g := HomomorphismStructureOnMorphisms( IdentityMorphism( Source( alpha ) ), beta );
    
    l := Lift( range_cat, f, g );
    
    if l = fail then
      
      return fail;
    
    else
      
      return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( alpha ), Source( beta ), l );
    
    fi;
    
end: ConditionsListComplete := true,
CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
CategoryFilter := HasRangeCategoryOfHomomorphismStructure,
Description := "Lift using the homomorphism structure"
);

##
AddDerivationToCAP( Colift,
            [
              [ IdentityMorphism, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
            ],
  function( cat, alpha, beta )
    local range_cat, f, g, l;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    f := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( beta );
    
    g := HomomorphismStructureOnMorphisms( alpha, IdentityMorphism( Range( beta ) ) );
    
    l := Lift( range_cat, f, g );
    
    if l = fail then
      
      return fail;
    
    else
      
      return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Range( alpha ), Range( beta ), l );
    
    fi;
  
end: ConditionsListComplete := true,
CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
CategoryFilter := HasRangeCategoryOfHomomorphismStructure,
Description := "Colift using the homomorphism structure"
);


