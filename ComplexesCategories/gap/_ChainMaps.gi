# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##  Chapter Complexes morphisms
##
#############################################################################


########################################
#
# Representations, families and types
#
########################################


DeclareRepresentation( "IsChainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfChainMorphisms",
            NewFamily( "chain morphisms" ) );

BindGlobal( "TheTypeOfChainMorphism",
            NewType( FamilyOfChainMorphisms,
                     IsChainMorphism and IsChainMorphismRep ) );

DeclareRepresentation( "IsCochainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfCochainMorphisms",
            NewFamily( "cochain morphisms" ) );

BindGlobal( "TheTypeOfCochainMorphism",
            NewType( FamilyOfCochainMorphisms,
                     IsCochainMorphism and IsCochainMorphismRep ) );

###########################################
#
#  True Methods
#
###########################################

InstallTrueMethod( IsBoundedChainOrCochainMorphism, IsBoundedBelowChainOrCochainMorphism and IsBoundedAboveChainOrCochainMorphism );

InstallTrueMethod( IsBoundedBelowChainMorphism, IsBoundedBelowChainOrCochainMorphism and IsChainMorphism );

InstallTrueMethod( IsBoundedBelowCochainMorphism, IsBoundedBelowChainOrCochainMorphism and IsCochainMorphism );

InstallTrueMethod( IsBoundedAboveChainMorphism, IsBoundedAboveChainOrCochainMorphism and IsChainMorphism );

InstallTrueMethod( IsBoundedAboveCochainMorphism, IsBoundedAboveChainOrCochainMorphism and IsCochainMorphism );

InstallTrueMethod( IsBoundedChainMorphism, IsBoundedChainOrCochainMorphism and IsChainMorphism );

InstallTrueMethod( IsBoundedCochainMorphism, IsBoundedChainOrCochainMorphism and IsCochainMorphism );

####################################
#
# global variables:
#
####################################

InstallValue( PROPAGATION_LIST_FOR_CO_CHAIN_MORPHISMS,
        [
         "IsMonomorphism",
         "IsEpimorphism",
         "IsIsomorphism",
         "IsSplitMonomorphism",
         "IsSplitEpimorphism",
         "IsZeroForMorphisms",
         # ..
         ]
        );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS,
  function( phi, psi )
    local i;

    for i in PROPAGATION_LIST_FOR_CO_CHAIN_MORPHISMS do

        AddToToDoList( ToDoListEntryForEqualAttributes( phi, i, psi, i ) );

    od;

end );

#########################################
#
# (Co)chain morphisms constructors 
#
#########################################

## Morphisms
##
InstallMethod( CreateComplexMorphism,
            [ IsCochainComplexCategory, IsCochainComplex, IsCochainComplex, IsList ],
  
  { ch_cat, S, R, triple }  -> CreateCapCategoryMorphismWithAttributes( ch_cat, S, R, Morphisms, triple[1], LowerBoundOfComplexMorphism, triple[2], UpperBoundOfComplexMorphism, triple[3] )
);

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsCochainComplexCategory, IsCochainComplex, IsCochainComplex, IsZFunction, IsInt, IsInt ],
  
  { ch_cat, S, R, morphisms, lower_bound, upper_bound } -> CreateComplexMorphism( ch_cat, S, R, [ morphisms, lower_bound, upper_bound ] )
);

##
InstallOtherMethod( CreateComplexMorphism,
            [ IsCochainComplexCategory, IsCochainComplex, IsCochainComplex, IsZFunction ],
  
  { ch_cat, S, R, morphisms } -> CreateComplexMorphism( ch_cat, S, R, [ morphisms, Minimum( LowerBoundOfComplex( S ), LowerBoundOfComplex( R ) ), Maximum( UpperBoundOfComplex( S ), UpperBoundOfComplex( R ) ) ] )
);

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsCochainComplexCategory, IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ],
  
  function( ch_cat, S, R, dense_list_of_morphisms, lower_bound )
    local upper_bound, morphisms;
    
    upper_bound := lower_bound + Length( dense_list_of_morphisms ) - 1;
    
    morphisms :=
        AsZFunction(
          function( i )
            if i >= lower_bound and i <= upper_bound then
              return dense_list_of_morphisms[i - lower_bound + 1];
            else
              return ZeroMorphism( UnderlyingCategory( ch_cat ), S[i], R[i] );
            fi;
          end );
    
    return CreateComplexMorphism( ch_cat, S, R, [ morphisms, lower_bound, upper_bound ] );
    
end );

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsCochainComplex, IsCochainComplex, IsInt, IsDenseList, IsInt ],
        
        { S, R, degree, mors, lower_bound } -> CochainMorphism( CapCategory( S ), S, R, degree, mors, lower_bound )
);

BindGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_Z_FUNCTION",
  function( C1, C2, morphisms )
    
    if ForAll( [ C1, C2 ], IsChainComplex ) then
        
        Error( "" );
        
    elif ForAll( [ C1, C2 ], IsCochainComplex ) then
        
        return CreateComplexMorphism( C1, C2, morphisms );
        
    fi;
    
end );

BindGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST",
  function( C1, C2, mor, n )
    if IsChainComplex( C1 ) then
      Error( "" );
    else
      return CreateComplexMorphism( CapCategory( C1 ), C1, C2, mor, n );
    fi;
end );

##
InstallMethod( ChainMorphism,
               [ IsChainComplex, IsChainComplex, IsZFunction ],
CHAIN_OR_COCHAIN_MORPHISM_BY_Z_FUNCTION );

##
InstallOtherMethod( ChainMorphism,
        [ IsChainComplex, IsZFunction, IsChainComplex ],
  { S, mor, R } -> ChainMorphism( S, R, mor )
);

##
InstallMethod( CochainMorphism,
               [ IsCochainComplex, IsCochainComplex, IsZFunction ],
CHAIN_OR_COCHAIN_MORPHISM_BY_Z_FUNCTION );

##
InstallOtherMethod( CochainMorphism,
        [ IsCochainComplex, IsZFunction, IsCochainComplex ],
  { S, mor, R } -> CochainMorphism( S, R, mor )
);

##
InstallMethod( ChainMorphism,
               [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ],
CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST );

##
InstallOtherMethod( ChainMorphism,
        [ IsChainComplex, IsDenseList, IsInt, IsChainComplex ],
  { S, mor, lower_bound, R } -> ChainMorphism( S, R, mor, lower_bound )
);


##
InstallMethod( CochainMorphism,
               [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ],
CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST );

##
InstallOtherMethod( CochainMorphism,
        [ IsCochainComplex, IsDenseList, IsInt, IsCochainComplex ],
  { S, mor, lower_bound, R } -> CochainMorphism( S, R, mor, lower_bound )
);

##
InstallOtherMethod( \/,
      [ IsDenseList, IsChainOrCochainComplexCategory ],
  function( data_list, complex_cat )
    
    if Length( data_list ) = 2 then
      
      TryNextMethod( );
      
    fi;
    
    if IsChainComplexCategory( complex_cat ) then
      return CallFuncList( ChainMorphism, data_list );
    else
      return CallFuncList( CochainMorphism, data_list );
    fi;
    
end );

###################################
#
# Components of co-chain morphisms
#
###################################

##
InstallMethod( MorphismAtOp,
          [ IsChainOrCochainMorphism, IsInt ],

  function( phi, i )
     local m;

     m := Morphisms( phi )[ i ];

     AddToToDoList( ToDoListEntry( [ [ m, "IsZeroForMorphisms", false ] ], function( )

                                                               if not HasIsZeroForMorphisms( phi ) then

                                                                 SetIsZeroForMorphisms( phi, false );

                                                               fi;

                                                               end ) );

     AddToToDoList( ToDoListEntry( [ [ phi, "IsZeroForMorphisms", true ] ], function( )

                                                                if not HasIsZeroForMorphisms( m ) then

                                                                   SetIsZeroForMorphisms( m, true );

                                                                fi;

                                                                end ) );

     return m;

end );

##
InstallMethod( \[\], [ IsChainOrCochainMorphism, IsInt ], MorphismAt );

##
InstallOtherMethod( \^, [ IsChainOrCochainMorphism, IsInt ],
  function( phi, n )
  
    Error( "Maybe you should use brackets [] ;)" );
    
end );

#################################
#
# Display and View
#
#################################

##
InstallMethod( ViewObj,
        [ IsCochainMorphism ],
        
  function( phi )
    local lower_bound, upper_bound, dots;
    
    if HasLowerBoundOfComplexMorphism( phi ) and HasUpperBoundOfComplexMorphism( phi ) then
      
      upper_bound := UpperBoundOfComplexMorphism( phi );
      lower_bound := LowerBoundOfComplexMorphism( phi );
      
      if IsInt( upper_bound ) then
        upper_bound := String( upper_bound );
      elif upper_bound = infinity then
        upper_bound := Concatenation( "+", TEXTMTRANSLATIONS!.infty );
      else
        upper_bound := Concatenation( "-", TEXTMTRANSLATIONS!.infty );
      fi;
      
      if IsInt( lower_bound ) then
        lower_bound := String( lower_bound );
      elif lower_bound = infinity then
        lower_bound := Concatenation( "+", TEXTMTRANSLATIONS!.infty );
      else
        lower_bound := Concatenation( "-", TEXTMTRANSLATIONS!.infty );
      fi;
      
      dots := Concatenation( ListWithIdenticalEntries( 3, TEXTMTRANSLATIONS!.cdot ) );
      
      Print( "<A morphism in ", Name( CapCategory( phi ) ), " supported in the window [", lower_bound, " ", dots, " ", upper_bound, "]>" );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

BindGlobal( "DISPLAY_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX_MORPHISM",
  function( map, m, n )
    local r, s, i;
    
    r := RandomTextColor( "" );
     
    Print( "\n" );
    for i in Reversed( [ m .. n ] ) do
      
      s := Concatenation( "== ", r[ 1 ], String( i ), r[ 2 ], " =======================" );
      Print( s );
      Print( "\n" ); 
      Display( map[ i ] );
      Print( "\n" );
      
    od;

end );

##
InstallMethod( Display,
               [ IsChainOrCochainMorphism, IsInt, IsInt ],
  function( map, m, n )
    
    DISPLAY_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX_MORPHISM( map, m, n );
    
    Print( "\nA morphism in ", Name( CapCategory( map ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
    [ IsCochainMorphism ],
    function( phi )
      
      if HasUpperBoundOfComplexMorphism( phi ) and HasLowerBoundOfComplexMorphism( phi ) then
        
        Display( phi, LowerBoundOfComplexMorphism( phi ), UpperBoundOfComplexMorphism( phi ) );
        
      else
        
        Print( "A zero complex morphism in ", Name( CapCategory( phi ) ) );
        
      fi;
    
end );

##
InstallMethod( MorphismsSupport,
               [ IsChainOrCochainMorphism, IsInt, IsInt ],
  function( phi, m, n )
    local l, i;
    l := [ ];
    for i in [ m .. n ] do
    if not IsZeroForMorphisms( phi[i] ) then
       Add( l, i );
    fi;
    od;
    return l;
end );

##
InstallMethod( MorphismsSupport,
               [ IsBoundedChainOrCochainMorphism ],
  function( phi )
    
    return MorphismsSupport( phi, ActiveLowerBound( phi ), ActiveUpperBound( phi ) );
    
end );

##
InstallMethod( IsWellDefined,
               [ IsChainOrCochainMorphism, IsInt, IsInt ],
  function( phi, m, n )
    local i, S, T;
    S := Source( phi );
    T := Range( phi );
    if not IsWellDefined( Source( phi ), m, n ) then
        AddToReasons( "IsWellDefined: The source of the morphism is not well-defined in the given interbal" );
        return false;
    fi;
    if not IsWellDefined( Range( phi ), m, n ) then
        AddToReasons( "IsWellDefined: The range of the morphism is not well-defined in the given interbal" );
        return false;
    fi;
   if IsChainMorphism( phi ) then 
     for i in [ m .. n ] do 
        if not IsCongruentForMorphisms( PreCompose( S^(i + 1), phi[ i ] ), PreCompose( phi[ i + 1 ], T^(i + 1) ) ) then
          AddToReasons( Concatenation( "IsWellDefined: problem at the squar whose differentials are in index ", String( i + 1 ) ) );
          return false;
        fi;
     od;
   elif IsCochainMorphism( phi ) then
     for i in [ m .. n ] do 
        if not IsCongruentForMorphisms( PreCompose( S^i, phi[ i + 1 ] ), PreCompose( phi[ i ], T^i ) ) then
          AddToReasons( Concatenation( "IsWellDefined: problem at the squar whose differentials are in index ", String( i ) ) );
           return false;
        fi;
     od;
   fi;
   return true;
end );


#################################
#
# Operations
#
#################################

##
InstallMethod( HasActiveLowerBound,
          [ IsChainOrCochainMorphism ],
          
  function( phi )
    
    if HasActiveLowerBound( Source( phi ) ) or HasActiveLowerBound( Range( phi ) ) then
      
      return true;
      
    fi;
    
    if IsBound( phi!.LowerBound ) then
      
      return true;
      
    fi;
    
    return false;
    
end );

##
InstallMethod( HasActiveUpperBound,
               [ IsChainOrCochainMorphism ],
  function( phi )
    
    if HasActiveUpperBound( Source( phi ) ) or HasActiveUpperBound( Range( phi ) ) then
      
      return true;
      
    fi;
    
    if IsBound( phi!.UpperBound ) then
      
      return true;
      
    fi;
    
    return false;
    
end );

##
InstallMethod( SetUpperBound,
              [ IsChainOrCochainMorphism, IsInt ],
  function( phi, upper_bound )
    
    if IsBound( phi!.UpperBound ) and phi!.UpperBound < upper_bound then
      
      return;
      
    fi;
    
    if IsBound( phi!.LowerBound ) and phi!.LowerBound > upper_bound then
      
      phi!.UpperBound := phi!.LowerBound; 
      
      if not HasIsZeroForMorphisms( phi ) then
        
        SetIsZeroForMorphisms( phi, true );
        
      fi;
      
    else
      
      phi!.UpperBound := upper_bound;
      
    fi;
      
    if not HasUpperBoundOfComplexMorphism( phi ) then
      
      SetUpperBoundOfComplexMorphism( phi, upper_bound ); 
            
    fi;
    
end );

##
InstallMethod( SetLowerBound,
              [ IsChainOrCochainMorphism, IsInt ], 
  function( phi, lower_bound )
    
    if IsBound( phi!.LowerBound ) and phi!.LowerBound > lower_bound then
      
      return;
      
    fi;
    
    if IsBound( phi!.UpperBound ) and phi!.UpperBound < lower_bound then
      
      phi!.LowerBound := phi!.UpperBound;
      
      if not HasIsZeroForMorphisms( phi ) then
        
        SetIsZeroForMorphisms( phi, true );
        
      fi;
      
    else
      
      phi!.LowerBound := lower_bound;
      
    fi;
    
    if not HasLowerBoundOfComplexMorphism( phi ) then
      
      SetLowerBoundOfComplexMorphism( phi, lower_bound );
            
    fi;
    
end );

##
InstallMethod( ActiveLowerBound,
          [ IsChainOrCochainMorphism ],
          
  function( phi )
    local l;
    
    if not HasActiveLowerBound( phi ) then
      
      Error( "The morphism has no active lower bounds" );
      
    fi;
    
    if HasActiveLowerBound( Source( phi ) ) then
      
      if HasActiveLowerBound( Range( phi ) ) then
        
        l := Maximum( ActiveLowerBound( Source( phi ) ), ActiveLowerBound( Range( phi ) ) );
        
      else
        
        l := ActiveLowerBound( Source( phi ) );
        
      fi;
      
    elif HasActiveLowerBound( Range( phi ) ) then 
      
      l := ActiveLowerBound( Range( phi ) );
      
    else 
      
      l := -infinity;
      
    fi;
    
    if IsBound( phi!.LowerBound ) then
      
      SetLowerBound( phi, Maximum( l, phi!.LowerBound ) );
      
    else
      
      SetLowerBound( phi, l );
      
    fi;
    
    if IsBound( phi!.UpperBound ) and phi!.LowerBound > phi!.UpperBound then
      
      phi!.LowerBound := phi!.UpperBound;
      
      if not HasIsZeroForMorphisms( phi ) then
        
        SetIsZeroForMorphisms( phi, true );
        
      fi;
      
    fi;
    
    return phi!.LowerBound;
    
end );

##
InstallMethod( ActiveUpperBound,
          [ IsChainOrCochainMorphism ],
          
  function( phi )
    local l;
    
    if not HasActiveUpperBound( phi ) then
      
      Error( "The morphism has no active lower bounds" );
      
    fi;
    
    if HasActiveUpperBound( Source( phi ) ) then
      
      if HasActiveUpperBound( Range( phi ) ) then
        
        l := Minimum( ActiveUpperBound( Source( phi ) ), ActiveUpperBound( Range( phi ) ) );
        
      else
        
        l := ActiveUpperBound( Source( phi ) );
        
      fi;
      
    elif HasActiveUpperBound( Range( phi ) )  then
      
      l := ActiveUpperBound( Range( phi ) );
      
    else 
      
      l := +infinity;
      
    fi;
    
    if IsBound( phi!.UpperBound ) then
      
      SetUpperBound( phi, Minimum( l, phi!.UpperBound ) );
      
    else
      
      SetUpperBound( phi, l );
      
    fi;
    
    if IsBound( phi!.LowerBound ) and phi!.UpperBound < phi!.LowerBound then
      
      phi!.UpperBound := phi!.LowerBound;
        
        if not HasIsZeroForMorphisms( phi ) then
          
          SetIsZeroForMorphisms( phi, true );
          
        fi;
        
    fi;
    
    return phi!.UpperBound;
    
end );

##
InstallMethod( ActiveUpperBoundForSourceAndRange,
          [ IsChainOrCochainMorphism ],
  alpha -> Maximum( List( [ Source, Range ],
              oper -> ActiveUpperBound( oper( alpha ) ) ) )
);

##
InstallMethod( ActiveLowerBoundForSourceAndRange,
          [ IsChainOrCochainMorphism ],
  alpha -> Minimum( List( [ Source, Range ],
              oper -> ActiveLowerBound( oper( alpha ) ) ) )
);

##
InstallMethod( AsChainMorphism,
          [ IsCochainMorphism ],
  function( phi )
    local F, cochains, chains, psi;
    
    cochains := CapCategory( phi );
    
    chains := ChainComplexCategory( UnderlyingCategory( cochains ) );
    
    F := CochainToChainComplexFunctor( cochains, chains );
    
    psi := ApplyFunctor( F, phi );
    
    SetAsCochainMorphism( psi, phi );
    
    return psi;
    
end );

##
InstallMethod( AsCochainMorphism,
    [ IsChainMorphism ],
  function( phi )
    local F, cochains, chains, psi;
    
    chains := CapCategory( phi );
    
    cochains := CochainComplexCategory( UnderlyingCategory( chains ) );
    
    F := ChainToCochainComplexFunctor( chains, cochains );
    
    psi := ApplyFunctor( F, phi );
    
    SetAsChainMorphism( psi, phi );
    
    return psi;
    
end );

##
InstallMethod( AsChainMorphism, [ IsChainMorphism ], IdFunc );

##
InstallMethod( AsCochainMorphism, [ IsCochainMorphism ], IdFunc );

##
InstallMethod( AsChainOrCochainMorphismOverCapFullSubcategory,
      [ IsChainOrCochainComplex, IsChainOrCochainMorphism, IsChainOrCochainComplex ],
  function( source, phi, range )
    local full_subcategory, morphisms;
    
    full_subcategory := UnderlyingCategory( CapCategory( source ) );
    
    morphisms := Morphisms( phi );
    
    morphisms := ApplyMap( morphisms, m -> ValueGlobal( "AsSubcategoryCell" )( full_subcategory, m ) );
    
    if IsChainMorphism( phi ) then
      
      return ChainMorphism( source, range, morphisms );
      
    else
      
      return CochainMorphism( source, range, morphisms );
      
    fi;
    
end );

##
InstallMethod( AsChainMorphismOverCapFullSubcategory,
      [ IsChainComplex, IsChainMorphism, IsChainComplex ],
        AsChainOrCochainMorphismOverCapFullSubcategory );

##
InstallMethod( AsCochainMorphismOverCapFullSubcategory,
      [ IsCochainComplex, IsCochainMorphism, IsCochainComplex ],
        AsChainOrCochainMorphismOverCapFullSubcategory );

########################################
#
# Mapping Cones and Nat (in)projections
#
########################################

##
InstallMethod( MappingCone,
            [ IsChainOrCochainMorphism ],
  function ( phi )
    local complex_cat, B, C, diffs, complex;
    
    complex_cat := CapCategory( phi );
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then
      
      diffs := AsZFunction( n ->
                    MorphismBetweenDirectSums(
                      [
                        [ AdditiveInverse( B ^ (n - 1) ), phi[n - 1] ],
                        [ ZeroMorphism( C[n], B[n - 2] ), C ^ n      ]
                      ] )
                  );
                  
      complex := ChainComplex( UnderlyingCategory( complex_cat ), diffs );
      
    else
        
      diffs := AsZFunction( n ->
                  MorphismBetweenDirectSums(
                    [
                      [ AdditiveInverse( B ^ ( n + 1 ) ), phi[n + 1] ],
                      [ ZeroMorphism( C[ n ], B[ n + 2 ] ), C ^ n    ]
                    ] )
                  );
            
      complex := CochainComplex( UnderlyingCategory( complex_cat ), diffs );
        
    fi;
    
    return complex;
    
end );

##
InstallMethod( NaturalInjectionInMappingCone,
               [ IsChainOrCochainMorphism ],
  function( phi )
    local B, C, cone, morphisms; 
    
    B := Source( phi );
    
    C := Range( phi );
    
    cone := MappingCone( phi );
    
    if IsChainMorphism( phi ) then 
      
      morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( C[ n ], B[ n - 1 ] ), IdentityMorphism( C[ n ] ) ]
                        ] )
                      );
      
      return ChainMorphism( C, cone, morphisms );
      
    else
      
      morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( C[ n ], B[ n + 1 ] ), IdentityMorphism( C[ n ] ) ]
                        ] )
                      );
      
      return CochainMorphism( C, cone, morphisms );
      
    fi;
    
end );


##
InstallMethod( NaturalProjectionFromMappingCone,
               [ IsChainOrCochainMorphism ],
  function ( phi )
    local B, C, cone, morphisms;
    
    B := Source( phi );
    
    C := Range( phi );
    
    cone := MappingCone( phi );
    
    if IsChainMorphism( phi ) then
        
        morphisms := AsZFunction( n ->
                        MorphismBetweenDirectSums(
                          [
                            [ IdentityMorphism( B[ n - 1 ] )   ],
                            [ ZeroMorphism( C[ n ], B[ n - 1 ] ) ]
                          ] )
                        );
        
        return ChainMorphism( cone, ShiftLazy( B, -1 ), morphisms );
        
    else
        
        morphisms := AsZFunction( n ->
                        MorphismBetweenDirectSums( 
                          [
                            [ IdentityMorphism( B[ n + 1 ] )   ],
                            [ ZeroMorphism( C[ n ], B[ n + 1 ] ) ]
                          ] )
                        );
        
        return CochainMorphism( cone, ShiftLazy( B, 1 ), morphisms );
        
    fi;
    
end );

##
InstallMethodWithCrispCache( MappingConeColift,
    [ IsChainMorphism, IsChainMorphism ],
  function( phi, psi )
    local chains, H, maps;
    
    chains := CapCategory( phi );
    
    if not IsNullHomotopic( PreCompose( phi, psi ) ) then
      
      Error( "The composition of the morphisms in the input should be homotopic to null" );
      
    fi;
    
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := AsZFunction( n -> MorphismBetweenDirectSums( [ [ H[ n - 1 ] ], [ psi[ n ] ] ] ) );
    
    return ChainMorphism( MappingCone( phi ), Range( psi ), maps );
    
end );

#    Commutes on the nose
#
#    A ----- phi ----> B ----------> Cone( phi )
#    |                 |
#    | alpha_0         | alpha_1
#    |                 |
#    v                 v
#    A' --- psi -----> B' ---------> Cone( psi )
#

InstallOtherMethod( MappingConeFunctorial,
          [ IsChainComplex, IsChainMorphism, IsChainMorphism, IsChainMorphism, IsChainMorphism, IsChainComplex ],
          
  function( cone_phi, phi, alpha_0, alpha_1, psi, cone_psi )
    local maps;
    
    maps := AsZFunction( i ->
              MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i - 1 ], ZeroMorphism( Source( alpha_0 )[ i - 1 ], Range( alpha_1 )[ i ] ) ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i - 1 ] ), alpha_1[ i ] ]
                ] )
              );
              
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

##
InstallMethod( MappingConeFunctorial,
   [ IsChainMorphism, IsChainMorphism, IsChainMorphism, IsChainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    return MappingConeFunctorial( cone_phi, phi, alpha_0, alpha_1, psi, cone_psi );
    
end );

#    Commutes up to homotopy
#
#    A ----- phi ----> B ----------> Cone( phi )
#    |                 |
#    | alpha_0         | alpha_1
#    |                 |
#    v                 v
#    A' --- psi -----> B' ---------> Cone( psi )
#
InstallMethodWithCrispCache( MappingConePseudoFunctorial,
   [ IsChainMorphism, IsChainMorphism, IsChainMorphism, IsChainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    s := HomotopyMorphisms( PreCompose( phi, alpha_1 ) - PreCompose( alpha_0, psi ) );
    
    maps := AsZFunction( i ->
              MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i - 1 ], s[ i - 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i - 1 ] ), alpha_1[ i ] ]
                ] )
              );
              
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

InstallMethodWithCrispCache( MappingConeColift,
    [ IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi )
    local cochains, H, maps;
    
    cochains := CapCategory( phi );
    
    if not IsNullHomotopic( PreCompose( phi, psi ) ) then
      
      Error( "The composition of the morphisms in the input should be homotopic to null" );
      
    fi;
    
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := AsZFunction( n -> MorphismBetweenDirectSums( [ [ H[ n + 1 ] ], [ psi[ n ] ] ] ) );
    
    return CochainMorphism( MappingCone( phi ), Range( psi ), maps );
    
end );


#    Commutes on the nose
#
#    A ----- phi ----> B ----------> Cone( phi )
#    |                 |
#    | alpha_0         | alpha_1
#    |                 |
#    v                 v
#    A' --- psi -----> B' ---------> Cone( psi )
#

##
InstallOtherMethod( MappingConeFunctorial,
          [ IsCochainComplex, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainComplex ],
  function( cone_phi, phi, alpha_0, alpha_1, psi, cone_psi )
    local maps;
     
    maps := AsZFunction( i ->
              MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i + 1 ], ZeroMorphism( Source( alpha_0 )[ i + 1 ], Range( alpha_1 )[ i ] ) ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i + 1 ] ), alpha_1[ i ] ]
                ] )
              );
              
    return CochainMorphism( cone_phi, cone_psi, maps );
    
end );

InstallMethod( MappingConeFunctorial,
          [ IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism ],
  function( phi, alpha_0, alpha_1, psi )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    return MappingConeFunctorial( cone_phi, phi, alpha_0, alpha_1, psi, cone_psi );
    
end );

InstallMethodWithCrispCache( MappingConePseudoFunctorial,
          [ IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    s := HomotopyMorphisms( PreCompose( phi, alpha_1 ) - PreCompose( alpha_0, psi ) );
    
    maps := AsZFunction( i ->
              MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i + 1 ], s[ i + 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i + 1 ] ), alpha_1[ i ] ]
                ] )
              );
              
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

##
InstallMethod( NaturalMorphismFromMappingCylinderInMappingCone,
            [ IsChainOrCochainMorphism ],
    function( phi )
    local B, C, morphisms;
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then
      
      morphisms := AsZFunction( n ->
                    MorphismBetweenDirectSums(
                      [
                        [ IdentityMorphism( B[ n - 1 ] ), ZeroMorphism( B[ n - 1 ], C[ n ] ) ],
                        [ ZeroMorphism( C[ n ], B[ n - 1 ] ), AdditiveInverse( IdentityMorphism( C[ n ] ) ) ],
                        [ ZeroMorphism( B[ n ], B[ n - 1 ] ), ZeroMorphism( B[ n ], C[ n ] ) ]
                      ] )
                    );
                     
      return ChainMorphism( MappingCylinder( phi ), MappingCone( phi ), morphisms );
      
    else
      
      morphisms := AsZFunction( n ->
                    MorphismBetweenDirectSums(
                        [
                          [ IdentityMorphism( B[ n + 1 ] ), ZeroMorphism( B[ n + 1 ], C[ n ] ) ],
                          [ ZeroMorphism( C[ n ], B[ n + 1 ] ), AdditiveInverse( IdentityMorphism( C[ n ] ) ) ],
                          [ ZeroMorphism( B[ n ], B[ n + 1 ] ), ZeroMorphism( B[ n ], C[ n ] ) ]
                        ] )
                    );
                    
      return CochainMorphism( MappingCylinder( phi ), MappingCone( phi ), morphisms );
       
    fi;
       
end );

#######################################
#
#  MappingCylinder Objects
#
#######################################

InstallMethod( MappingCylinder,
               [ IsChainOrCochainMorphism ],
  function( phi )
    
    return MappingCone( MorphismBetweenDirectSums( [ [ AdditiveInverse( phi ), IdentityMorphism( Source( phi ) ) ] ] ) );
    
end );

##
InstallMethod( NaturalInjectionOfSourceInMappingCylinder,
               [ IsChainOrCochainMorphism ],
  function ( phi )
    local morphisms, B, C;
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( B[ n ], B[ n - 1 ] ), ZeroMorphism( B[ n ], C[ n ] ), IdentityMorphism( B[ n ] ) ]
                        ] )
                      );
                      
        return ChainMorphism( B, MappingCylinder( phi ), morphisms );
        
    else
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( B[ n ], B[ n + 1 ] ), ZeroMorphism( B[ n ], C[ n ] ), IdentityMorphism( B[ n ] ) ]
                        ] )
                      );
                      
        return CochainMorphism( B, MappingCylinder( phi ), morphisms );
        
    fi;
    
end );

# 
##
InstallMethod( NaturalInjectionOfRangeInMappingCylinder,
               [ IsChainOrCochainMorphism ],
  function ( phi )
    local morphisms, B, C;
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( C[n], B[n - 1] ), IdentityMorphism( C[n] ), ZeroMorphism( C[n], B[n] ) ]
                        ] )
                      );
                      
        return ChainMorphism( C, MappingCylinder( phi ), morphisms );
        
    else
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ ZeroMorphism( C[n], B[n + 1] ), IdentityMorphism( C[n] ), ZeroMorphism( C[n], B[n] ) ]
                        ] )
                      );
                      
        return CochainMorphism( C, MappingCylinder( phi ), morphisms );
        
    fi;
    
end );

##
InstallMethod( NaturalMorphismFromMappingCylinderInRange,
               [ IsChainOrCochainMorphism ],
  function( phi )
    local morphisms, B, C;
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then
      
      morphisms := AsZFunction( n ->
                    MorphismBetweenDirectSums(
                      [
                        [ ZeroMorphism( B[ n - 1 ], C[ n ] ) ],
                        [ IdentityMorphism( C[ n ] )         ],
                        [ phi[ n ]                           ]
                      ] )
                    );
                    
      return ChainMorphism( MappingCylinder( phi ), C, morphisms );
      
    else
      
      morphisms := AsZFunction( n ->
                    MorphismBetweenDirectSums(
                      [
                        [ ZeroMorphism( B[ n + 1 ], C[ n ] ) ],
                        [ IdentityMorphism( C[ n ] )         ],
                        [ phi[ n ]                           ]
                      ] )
                    );
                    
      return CochainMorphism( MappingCylinder( phi ), C, morphisms );
      
    fi;
    
end );

##
InstallMethod( MappingCocylinder,
               [ IsChainOrCochainMorphism ],
  function( phi )
    local cat, F;
    
    cat := CapCategory( phi );
    
    if IsChainMorphism( phi ) then
        
        F := ShiftFunctor( cat, 1 );
        
        return MappingCone( ApplyFunctor( F, MorphismBetweenDirectSums( [ [ IdentityMorphism( Range( phi ) ) ], [ AdditiveInverse( phi ) ] ] ) ) );
        
    else
        
        F := ShiftFunctor( cat, -1 );
        
        return MappingCone( ApplyFunctor( F, MorphismBetweenDirectSums( [ [ IdentityMorphism( Range( phi ) ) ], [ AdditiveInverse( phi ) ] ] ) ) );
        
    fi;

end );

# This morphism defines a homotopy equivalence between the source of phi and the cocylinder object.
# Hence it is always quasi isomorphism.

InstallMethod( NaturalMorphismFromSourceInMappingCocylinder,
               [ IsChainOrCochainMorphism ],
  function ( phi )
    local morphisms, B, C;
    
    C := Source( phi );
    
    B := Range( phi );
    
    if IsChainMorphism( phi ) then
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ phi[ n ], IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], B[ n + 1 ] ) ]
                        ] )
                      );
        
        return ChainMorphism( C, MappingCocylinder( phi ), morphisms );
        
    else
        
        morphisms := AsZFunction( n ->
                      MorphismBetweenDirectSums(
                        [
                          [ phi[ n ], IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], B[ n - 1 ] ) ]
                        ] )
                      );
        
        return CochainMorphism( C, MappingCocylinder( phi ), morphisms );
        
    fi;
    
end );

InstallMethod( NaturalMorphismFromMappingCocylinderToRange,
               [ IsChainOrCochainMorphism ],
  function( phi )
    local C, B, morphisms;
    
    C := Source( phi );
    
    B := Range( phi );
    
    if IsChainMorphism( phi ) then 
        
        morphisms := AsZFunction( n ->
              MorphismBetweenDirectSums(
                [
                  [ IdentityMorphism( B[ n ] ) ],
                  [ ZeroMorphism( C[ n ], B[ n ] ) ], 
                  [ ZeroMorphism( B[ n + 1 ], B[ n ] ) ]
                ] )
              );
            
        return ChainMorphism( MappingCocylinder( phi ), B, morphisms );
        
    else 
        
        morphisms := AsZFunction( n ->
              MorphismBetweenDirectSums(
                [ [ IdentityMorphism( B[ n ] ) ],
                  [ ZeroMorphism( C[ n ], B[ n ] ) ], 
                  [ ZeroMorphism( B[ n - 1 ], B[ n ] ) ]
                ] )
              );
            
        return CochainMorphism( MappingCocylinder( phi ), B, morphisms );
        
    fi;
    
end );

##
InstallMethod( IsQuasiIsomorphism,
                  [ IsChainOrCochainMorphism ],
  function( phi )
    local min, max, h_functor, functor, i;
    
    if not HasActiveUpperBound(  Source( phi ) ) or not HasActiveLowerBound(  Source( phi ) ) then
      
      Error( "The source is not known to be bounded" );
      
    fi;
    
    if not HasActiveUpperBound(  Range( phi ) ) or not HasActiveLowerBound(  Range( phi ) ) then
      
      Error( "The range is not known to be bounded" );
      
    fi;
    
    min := Minimum( ActiveLowerBound( Source( phi ) ), ActiveLowerBound( Range( phi ) ) );
    
    max := Maximum( ActiveUpperBound( Source( phi ) ), ActiveUpperBound( Range( phi ) ) );
    
    if IsChainMorphism( phi ) then
      
      h_functor := HomologyFunctor;
      
    else
      
      h_functor := CohomologyFunctor;
      
    fi;
    
    for i in [ min .. max ] do
      
      functor := h_functor( CapCategory( phi ), i );
      
      if not IsIsomorphism( ApplyFunctor( functor, phi ) ) then
        
        return false;
        
      fi;
      
    od;
    
    return true;
    
end );

##
InstallMethod( CyclesFunctorialAtOp,
        [ IsChainOrCochainMorphism, IsInt ],
  function( phi, n )
    
    return KernelLift( Range( phi )^n, PreCompose( CyclesAt( Source( phi ), n ), phi[ n ] ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
                  [ IsChainOrCochainMorphism, IsInt, IsInt ],
  function( phi, min, max )
    local h_functor, functor, i;
    
    if IsChainMorphism( phi ) then
      
      h_functor := HomologyFunctor;
      
    else 
      
      h_functor := CohomologyFunctor;
      
    fi;
    
    for i in [ min .. max ] do
      
      functor := h_functor( CapCategory( phi ), i );
      
      if not IsIsomorphism( ApplyFunctor( functor, phi ) ) then
        
        return false;
        
      fi;
      
    od;
    
    return true;
    
end );

##
InstallMethod( StalkChainMorphismOp,
          [ IsCapCategoryMorphism, IsInt ],
  function( f, n )
    local morphism;
    
    morphism := ChainMorphism( StalkChainComplex( Source( f ), n ), StalkChainComplex( Range( f ), n ), [ f ], n );
    
    n := morphism[ n ];
    
    return morphism;
    
end );

##
InstallMethod( StalkCochainMorphismOp,
          [ IsCapCategoryMorphism, IsInt ],
  function( f, n )
    local morphism;
    
    morphism := CochainMorphism( StalkCochainComplex( Source( f ), n ), StalkCochainComplex( Range( f ), n ), [ f ], n );
    
    # Doing the following help identifying morphisms for the Cache
    n := morphism[ n ];
    
    return morphism;
    
end );

##
InstallMethod( HomologyFunctorialAtOp, [ IsChainMorphism, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL );

##
InstallMethod( CohomologyFunctorialAtOp, [ IsCochainMorphism, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL );

##
InstallMethod( BoxProduct,
          [ IsBoundedChainMorphism, IsBoundedChainMorphism, IsChainComplexCategory ],
  function( phi, psi, category )
    local underlying_category, S, T, ss, tt, l;
    
    underlying_category := UnderlyingCategory( category );
    
    S := BoxProduct( Source( phi ), Source( psi ), category );
    
    T := BoxProduct( Range( phi ), Range( psi ), category );
    
    ss := S!.UnderlyingDoubleComplex;
    
    tt := T!.UnderlyingDoubleComplex;
    
    l := AsZFunction(
      
      function( m )
        local ind_s, ind_t, morphisms, obj;
        
        # this is important to write the used indices.
        obj := ObjectAt( S, m );
        
        obj := ObjectAt( T, m );
        
        ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
        
        ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
        
        morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ],
          
          function( i )
            
            return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ],
              
              function( j )
                
                if i = j then
                  
                  return BoxProduct( phi[ i ], psi[ m - i ], underlying_category );
                  
                else
                  
                  return ZeroMorphism( ObjectAt( ss, i, m - i), ObjectAt( tt, j, m - j ) );
                  
                fi;
                
              end );
              
          end );
          
        return MorphismBetweenDirectSums( morphisms );
        
      end );
      
    return ChainMorphism( S, T, l );
    
end );

##
InstallOtherMethod( ShiftLazy,
        [ IsChainOrCochainMorphism, IsInt ],
  function( phi, n )
    local cat;
    
    cat := CapCategory( phi );
    
    return ApplyFunctor( ShiftFunctor( cat, n ), phi );
    
end );

##
InstallOtherMethod( BrutalTruncationAbove,
      [ IsChainOrCochainMorphism, IsInt ],
  function( phi, n )
    
    return BrutalTruncationAboveFunctor( CapCategory( phi ), n )( phi );
    
end );

##
InstallOtherMethod( BrutalTruncationBelow,
      [ IsChainOrCochainMorphism, IsInt ],
  function( phi, n )
    
    return BrutalTruncationBelowFunctor( CapCategory( phi ), n )( phi );
    
end );

#####################################
#
# To Do Lists operations
#
#####################################

##
InstallGlobalFunction( TODO_LIST_TO_CHANGE_MORPHISM_FILTERS_WHEN_NEEDED,
  function( phi )
      
end );

