#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
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
         "IsZero",
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

BindGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_LIST",
     function( C1, C2, morphisms )
     local phi;

     phi := rec( );

     if ForAll( [ C1, C2 ], IsChainComplex ) then 

           ObjectifyWithAttributes( phi, TheTypeOfChainMorphism,

                           Source, C1,

                           Range, C2,

                           Morphisms, morphisms );

     elif ForAll( [ C1, C2 ], IsCochainComplex ) then 

           ObjectifyWithAttributes( phi, TheTypeOfCochainMorphism,

                           Source, C1,

                           Range, C2,

                           Morphisms, morphisms );

     else

        Error( "first and second argument should be both chains or cochains" );

     fi;

     AddMorphism( CapCategory( C1 ), phi );

     TODO_LIST_TO_CHANGE_MORPHISM_FILTERS_WHEN_NEEDED( phi );

     TODO_LIST_TO_PUSH_BOUNDS( C1, phi );

     TODO_LIST_TO_PUSH_BOUNDS( C2, phi );

     return phi;

end );

BindGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST",
  function( C1, C2, mor, n )
  local all_morphisms;

  all_morphisms := MapLazy( IntegersList, function( i )

                                              if i >= n and i <= n + Length( mor ) - 1 then 

                                                 return mor[ i - n + 1 ];

                                              else

                                                 return ZeroMorphism( C1[ i ], C2[ i ] );

                                              fi;

                                           end, 1 );

  all_morphisms := CHAIN_OR_COCHAIN_MORPHISM_BY_LIST( C1, C2, all_morphisms );

  SetLowerBound( all_morphisms, n - 1 );

  SetUpperBound( all_morphisms, n + Length( mor ) );

  return all_morphisms;

end );

BindGlobal( "FINITE_CHAIN_OR_COCHAIN_MORPHISM_BY_THREE_LISTS",
   function( l1,m1, l2,m2, mor, n, string )
   local C1, C2, base_list, maps, zero, all_maps, cat, complex_category, complex_constructor, map_constructor, map;

   cat := CapCategory( l1[ 1 ] );

   if string = "chain_map" then 

      complex_category := ChainComplexCategory( cat );

      complex_constructor := ChainComplex;

      map_constructor := ChainMorphism;

   else 

      complex_category := CochainComplexCategory( cat );

      complex_constructor := CochainComplex;

      map_constructor := CochainMorphism;

   fi;

   C1 := complex_constructor( l1, m1 );

   C2 := complex_constructor( l2, m2 );

   base_list := [ Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) ) + 1 .. Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) ) - 1 ];

   maps := List( base_list,      function( i )

                                 if i >= n and i <= n + Length( mor ) - 1 then 

                                        return mor[ i - n + 1 ];

                                 else 

                                        return ZeroMorphism( C1[ i ], C2[ i ] );

                                 fi;

                                 end );

   zero := ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) );

   zero := RepeatListN( [ zero ] );

   all_maps := Concatenate( zero, base_list[ 1 ], maps, zero );

   map := map_constructor( C1, C2, all_maps );

   if n > base_list[ Length( base_list ) ] and not HasIsZero( map ) then SetIsZero( map, true );fi;

   if n + Length( mor ) -1 < base_list[ 1 ] and not HasIsZero( map ) then SetIsZero( map, true ); fi;

   return map;

end );


##
InstallMethod( ChainMorphism,
               [ IsChainComplex, IsChainComplex, IsZList ],
CHAIN_OR_COCHAIN_MORPHISM_BY_LIST );

##
InstallMethod( CochainMorphism,
               [ IsCochainComplex, IsCochainComplex, IsZList ],
CHAIN_OR_COCHAIN_MORPHISM_BY_LIST );

##
InstallMethod( ChainMorphism,
               [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ],
CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST );

##
InstallMethod( CochainMorphism,
               [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ],
CHAIN_OR_COCHAIN_MORPHISM_BY_DENSE_LIST );

##
InstallMethod( ChainMorphism,
               [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ],
   function( c1, m1, c2, m2, maps, n )
   return FINITE_CHAIN_OR_COCHAIN_MORPHISM_BY_THREE_LISTS( c1, m1, c2, m2, maps, n, "chain_map" );
end );

##
InstallMethod( CochainMorphism,
               [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ],
   function( c1, m1, c2, m2, maps, n )
   return FINITE_CHAIN_OR_COCHAIN_MORPHISM_BY_THREE_LISTS( c1, m1, c2, m2, maps, n, "cochain_map" );
end );

###################################
#
# Components of co-chain morphisms
#
###################################

InstallMethod( MorphismAtOp, 
          [ IsChainOrCochainMorphism, IsInt ], 

  function( phi, i )
     local m;

     m := Morphisms( phi )[ i ];

     AddToToDoList( ToDoListEntry( [ [ m, "IsZero", false ] ], function( )

                                                               if not HasIsZero( phi ) then

                                                                 SetIsZero( phi, false );

                                                               fi;

                                                               end ) );

     AddToToDoList( ToDoListEntry( [ [ phi, "IsZero", true ] ], function( )

                                                                if not HasIsZero( m ) then

                                                                   SetIsZero( m, true );

                                                                fi;

                                                                end ) );

     return m;

end );

InstallMethod( \[\], [ IsChainOrCochainMorphism, IsInt ], MorphismAt );

#################################
#
# Display and View
#
#################################

##
InstallMethod( ViewObj,
        [ IsChainOrCochainMorphism ],

  function( phi )

  if IsBoundedChainOrCochainMorphism( phi ) then

     Print( "<A bounded morphism in ", Big_to_Small( Name( CapCategory( phi ) ) ), " with active lower bound ", ActiveLowerBound( phi ), " and active upper bound ", ActiveUpperBound( phi ), ">" );

  elif IsBoundedBelowChainOrCochainMorphism( phi ) then

     Print( "<A bounded from below morphism in ", Big_to_Small( Name( CapCategory( phi ) ) ), " with active lower bound ", ActiveLowerBound( phi ), ">" );

  elif IsBoundedAboveChainOrCochainMorphism( phi ) then

     Print( "<A bounded from above morphism in ", Big_to_Small( Name( CapCategory( phi ) ) ), " with active upper bound ", ActiveUpperBound( phi ), ">" );

  else

     TryNextMethod( );

  fi;

end );


##
InstallMethod( Display, 
               [ IsChainOrCochainMorphism, IsInt, IsInt ], 
   function( map, m, n )
   local i;

   for i in [ m .. n ] do

     Print( "In index ", String( i ) );

     Print( "\n\nMorphism is\n" );

     Display( map[ i ] );

     Print( "\n-----------------------------------------------------------------\n" );

     od;

end );

InstallMethod( IsWellDefined,
               [ IsChainOrCochainMorphism, IsInt, IsInt ],
   function( phi, m, n )
   local i, S, T;
   
   S := Source( phi );
   
   T := Range( phi );
   
   if IsChainMorphism( phi ) then 
   
     for i in [ m .. n ] do 
        if not IsCongruentForMorphisms( PreCompose( S^(i + 1), phi[ i ] ), PreCompose( phi[ i + 1 ], T^(i + 1) ) ) then
           return false;
        fi;
     od;
     
   elif IsCochainMorphism( phi ) then
   
     for i in [ m .. n ] do 
        if not IsCongruentForMorphisms( PreCompose( S^i, phi[ i + 1 ] ), PreCompose( phi[ i ], T^i ) ) then
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

      if not HasIsZero( phi ) then SetIsZero( phi, true ); fi;

   else

      phi!.UpperBound := upper_bound;

   fi;

   if not HasFAU_BOUND( phi ) then

      SetFAU_BOUND( phi, upper_bound ); 

      SetHAS_FAU_BOUND( phi, true );

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

      if not HasIsZero( phi ) then SetIsZero( phi, true ); fi;

   else

      phi!.LowerBound := lower_bound;

   fi;

   if not HasFAL_BOUND( phi ) then

      SetFAL_BOUND( phi, lower_bound );

      SetHAS_FAL_BOUND( phi, true );

   fi;

end );


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

     l := NegativeInfinity;

  fi;

  if IsBound( phi!.LowerBound ) then

     SetLowerBound( phi, Maximum( l, phi!.LowerBound ) );

  else

     SetLowerBound( phi, l );

  fi;

  if IsBound( phi!.UpperBound ) and phi!.LowerBound > phi!.UpperBound then

        phi!.LowerBound := phi!.UpperBound;

        if not HasIsZero( phi ) then SetIsZero( phi, true ); fi;

  fi;

  return phi!.LowerBound;

end );

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

     l := PositiveInfinity;

  fi;

  if IsBound( phi!.UpperBound ) then

     SetUpperBound( phi, Minimum( l, phi!.UpperBound ) );

  else

     SetUpperBound( phi, l );

  fi;

  if IsBound( phi!.LowerBound ) and phi!.UpperBound < phi!.LowerBound then

        phi!.UpperBound := phi!.LowerBound;

        if not HasIsZero( phi ) then SetIsZero( phi, true ); fi;

  fi;

  return phi!.UpperBound;
 
end );

########################################
#
# Mapping Cones and Nat (in)projections
#
########################################

InstallMethod( MappingCone,
            [ IsChainOrCochainMorphism ],
   function( phi )
   local complex_cat, B, C, diffs, complex;
   
   complex_cat := CapCategory( phi );
   
   B := Source( phi );
      
   C := Range( phi );

   if IsChainMorphism( phi ) then 
         
        diffs := MapLazy( IntegersList, function( n )
                                     
                                      return MorphismBetweenDirectSums( [ [ AdditiveInverse( B^(n-1) ), phi[ n - 1 ] ], 
                                                                          [ ZeroMorphism( C[ n ], B[ n - 2 ] ), C^n ] ] );
                                      end, 1 );
      
        complex := ChainComplex( UnderlyingCategory( complex_cat ), diffs );
      
        AddToToDoList( ToDoListEntry( [ [ B, "HAS_FAL_BOUND", true ], [ C, "HAS_FAL_BOUND", true ] ], 

                                  function( )

                                  if not HasFAL_BOUND( complex ) then

                                     SetLowerBound( complex, Minimum( FAL_BOUND( B ) + 1, FAL_BOUND( C ) ) );

                                  fi;

                                  end ) );

        AddToToDoList( ToDoListEntry( [ [ B, "HAS_FAU_BOUND", true ], [ C, "HAS_FAU_BOUND", true ] ],

                                  function( )

                                  if not HasFAU_BOUND( complex ) then

                                     SetUpperBound( complex, Maximum( FAU_BOUND( B ) + 1, FAU_BOUND( C ) ) );

                                  fi;

                                  end ) );
                                  
   else
   
        diffs := MapLazy( IntegersList, function( n )
      
                                      return MorphismBetweenDirectSums( [ [ AdditiveInverse( B^(n+1) ), phi[ n + 1 ] ], 
                                                                          [ ZeroMorphism( C[ n ], B[ n + 2 ] ), C^n ] ] );
                                                                          
                                      end, 1 );
                                
        complex :=  CochainComplex( UnderlyingCategory( complex_cat ), diffs );
      
        AddToToDoList( ToDoListEntry( [ [ B, "HAS_FAL_BOUND", true ], [ C, "HAS_FAL_BOUND", true ] ], 

                                  function( )

                                  if not HasFAL_BOUND( complex ) then

                                     SetLowerBound( complex, Minimum( FAL_BOUND( B ) - 1, FAL_BOUND( C ) ) );

                                  fi;

                                  end ) );

        AddToToDoList( ToDoListEntry( [ [ B, "HAS_FAU_BOUND", true ], [ C, "HAS_FAU_BOUND", true ] ],

                                  function( )

                                  if not HasFAU_BOUND( complex ) then

                                     SetUpperBound( complex, Maximum( FAU_BOUND( B ) - 1, FAU_BOUND( C ) ) );

                                  fi;

                                  end ) );

    fi;
                                  
    return complex;

end );

InstallMethod( NaturalInjectionInMappingCone,
               [ IsChainOrCochainMorphism ],
    function( phi )
    local B, C, cone, morphisms; 
    
    B := Source( phi );
    
    C := Range( phi );
    
    cone := MappingCone( phi );
    
    if IsChainMorphism( phi ) then 
    
       morphisms := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ ZeroMorphism( C[ n ], B[ n - 1 ] ), IdentityMorphism( C[ n ] ) ] ] ), 1 );
    
       return ChainMorphism( C, cone, morphisms );
       
    else
    
       morphisms := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ ZeroMorphism( C[ n ], B[ n + 1 ] ), IdentityMorphism( C[ n ] ) ] ] ), 1 );
       
       return CochainMorphism( C, cone, morphisms );
       
    fi;
       
end );

InstallMethod( NaturalProjectionFromMappingCone,
               [ IsChainOrCochainMorphism ],
    function( phi )
    local B, C, cone, morphisms; 
    
    B := Source( phi );
    
    C := Range( phi );
    
    cone := MappingCone( phi );
    
    if IsChainMorphism( phi ) then 
    
       morphisms := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ IdentityMorphism( B[ n - 1 ] ) ], [ ZeroMorphism( C[ n ], B[ n - 1 ] ) ] ] ), 1 );
    
       return ChainMorphism( cone, ShiftLazy( B, -1 ), morphisms );
       
    else
    
       morphisms := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ IdentityMorphism( B[ n + 1 ] ) ], [ ZeroMorphism( C[ n ], B[ n + 1 ] ) ] ] ), 1 );
       
       return CochainMorphism( cone, ShiftLazy( B, 1 ), morphisms );
       
    fi;
       
end );

InstallMethod( NaturalMorphismFromMappingCylinderInMappingCone, 
            [ IsChainOrCochainMorphism ],
    function( phi )
    local B, C, morphisms;
    
    B := Source( phi );
    
    C := Range( phi );
    
    if IsChainMorphism( phi ) then 
    
       morphisms := MapLazy( IntegersList, 
                             n -> MorphismBetweenDirectSums( [ [ IdentityMorphism( B[ n - 1 ] ), ZeroMorphism( B[ n - 1 ], C[ n ] ) ],
                                                               [ ZeroMorphism( C[ n ], B[ n - 1 ] ), AdditiveInverse( IdentityMorphism( C[ n ] ) ) ],
                                                               [ ZeroMorphism( B[ n ], B[ n - 1 ] ), ZeroMorphism( B[ n ], C[ n ] ) ] ] ), 1 );
    
       return ChainMorphism( MappingCylinder( phi ), MappingCone( phi ), morphisms );
       
    else
    

       morphisms := MapLazy( IntegersList, 
                             n -> MorphismBetweenDirectSums( [ [ IdentityMorphism( B[ n + 1 ] ), ZeroMorphism( B[ n + 1 ], C[ n ] ) ],
                                                               [ ZeroMorphism( C[ n ], B[ n + 1 ] ), AdditiveInverse( IdentityMorphism( C[ n ] ) ) ],
                                                               [ ZeroMorphism( B[ n ], B[ n + 1 ] ), ZeroMorphism( B[ n ], C[ n ] ) ] ] ), 1 );
                                                               
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
    function( phi )
    local morphisms, B, C;
    
    B := Source( phi );
      
    C := Range( phi );
   
    if IsChainMorphism( phi ) then 
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( B[ n ], B[ n - 1 ] ), ZeroMorphism( B[ n ], C[ n ] ), IdentityMorphism( B[ n ] ) ] ] );
                                        end, 1 );
    return ChainMorphism( B, MappingCylinder( phi ), morphisms );
    
    else
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( B[ n ], B[ n + 1 ] ), ZeroMorphism( B[ n ], C[ n ] ), IdentityMorphism( B[ n ] ) ] ] );
                                        end, 1 );
    return CochainMorphism( B, MappingCylinder( phi ), morphisms );

    fi;
    
end );
# 
##
InstallMethod( NaturalInjectionOfRangeInMappingCylinder, 
               [ IsChainOrCochainMorphism ], 
               
    function( phi )
    local morphisms, B, C;
    
    B := Source( phi );
      
    C := Range( phi );
       
    if IsChainMorphism( phi ) then 
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( C[ n ], B[ n - 1 ] ), IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], B[ n ] ) ] ] );
                                        end, 1 );
    return ChainMorphism( C, MappingCylinder( phi ), morphisms );
    
    else
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( C[ n ], B[ n + 1 ] ), IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], B[ n ] ) ] ] );
                                        end, 1 );
                                        
    return CochainMorphism( C, MappingCylinder( phi ), morphisms );

    fi;
    
end );
# 
##
InstallMethod( NaturalMorphismFromMappingCylinderInRange,
               [ IsChainOrCochainMorphism ],
    function( phi )
    local morphisms, B, C;
    
    B := Source( phi );
      
    C := Range( phi );
       
    if IsChainMorphism( phi ) then 
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( B[ n - 1 ], C[ n ] ) ],
                                                                            [ IdentityMorphism( C[ n ] )         ],
                                                                            [ phi[ n ]                           ]  ] );
                                        end, 1 );
    return ChainMorphism( MappingCylinder( phi ), C, morphisms );
    
    else
    
    morphisms := MapLazy( IntegersList, function( n )
                                        return MorphismBetweenDirectSums( [ [ ZeroMorphism( B[ n + 1 ], C[ n ] ) ],
                                                                            [ IdentityMorphism( C[ n ] )         ],
                                                                            [ phi[ n ]                           ]  ] );
                                        end, 1 );
                                        
    return CochainMorphism( MappingCylinder( phi ), C, morphisms );

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

   min := Minimum( ActiveLowerBound(  Source( phi ) ), ActiveLowerBound(  Range( phi ) ) ) + 1;

   max := Maximum( ActiveUpperBound(  Source( phi ) ), ActiveUpperBound(  Range( phi ) ) ) - 1;

   if IsChainMorphism( phi ) then

      h_functor := HomologyFunctorAt;

   else 

      h_functor := CohomologyFunctorAt;

   fi;

   for i in [ min .. max ] do

     functor := h_functor( CapCategory( phi ), UnderlyingCategory( CapCategory( phi ) ), i );

     if not IsIsomorphism( ApplyFunctor( functor, phi ) ) then

        return false;

     fi;

   od;

   return true;

end );

##
InstallMethod( IsQuasiIsomorphism,
                  [ IsChainOrCochainMorphism, IsInt, IsInt ],
   function( phi, min, max )
   local h_functor, functor, i;

   if IsChainMorphism( phi ) then

      h_functor := HomologyFunctorAt;

   else 

      h_functor := CohomologyFunctorAt;

   fi;

   for i in [ min .. max ] do

     functor := h_functor( CapCategory( phi ), UnderlyingCategory( CapCategory( phi ) ), i );

     if not IsIsomorphism( ApplyFunctor( functor, phi ) ) then

        return false;

     fi;

   od;

   return true;

end );

#####################################
#
# To Do Lists operations
#
#####################################

##
InstallGlobalFunction( TODO_LIST_TO_CHANGE_MORPHISM_FILTERS_WHEN_NEEDED,
  function( phi )

  AddToToDoList( ToDoListEntry( [ [ phi, "HAS_FAL_BOUND", true ] ], function() SetFilterObj( phi, IsBoundedBelowChainOrCochainMorphism ); end ) );

  AddToToDoList( ToDoListEntry( [ [ phi, "HAS_FAU_BOUND", true ] ], function() SetFilterObj( phi, IsBoundedAboveChainOrCochainMorphism ); end ) );

end );

