#############################################
#
#  Representations, families and types
#
#############################################


DeclareRepresentation( "IsChainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

DeclareRepresentation( "IsCochainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfChainComplexes",
            NewFamily( "chain complexes" ) );


BindGlobal( "FamilyOfCochainComplexes",
            NewFamily( "cochain complexes" ) );

BindGlobal( "TheTypeOfChainComplexes",
            NewType( FamilyOfChainComplexes,
                     IsChainComplex and IsChainComplexRep ) );

BindGlobal( "TheTypeOfCochainComplexes",
            NewType( FamilyOfCochainComplexes,
                     IsCochainComplex and IsCochainComplexRep ) );

###########################################
#
#  True Methods
#
###########################################

InstallTrueMethod( IsBoundedChainOrCochainComplex, IsBoundedBellowChainOrCochainComplex and IsBoundedAboveChainOrCochainComplex );

InstallTrueMethod( IsBoundedBellowChainComplex, IsBoundedBellowChainOrCochainComplex and IsChainComplex );

InstallTrueMethod( IsBoundedBellowCochainComplex, IsBoundedBellowChainOrCochainComplex and IsCochainComplex );

InstallTrueMethod( IsBoundedAboveChainComplex, IsBoundedAboveChainOrCochainComplex and IsChainComplex );

InstallTrueMethod( IsBoundedAboveCochainComplex, IsBoundedAboveChainOrCochainComplex and IsCochainComplex );

InstallTrueMethod( IsBoundedChainComplex, IsBoundedChainOrCochainComplex and IsChainComplex );

InstallTrueMethod( IsBoundedCochainComplex, IsBoundedChainOrCochainComplex and IsCochainComplex );

###########################################
#
# Constructors of (Co)chain complexes
#
###########################################

##
BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST",
function( cat, diffs, make_assertions, type )
  local C, assertion, f, msg;

  C := rec( );

  if type = "TheTypeOfChainComplexes" then

     ObjectifyWithAttributes( C, ValueGlobal( type ),
                           CatOfComplex, cat,
                           Differentials, diffs );

     if make_assertions then
#        To Do: Take care of this code!
#        for assertion in ComplexSingleAssertions do
#        f := assertion[ 1 ];
#        msg := assertion[ 2 ];
#        AddAssertion( diffs, MakeSingleAssertion( C, f, msg ) );
#        od;
#        for assertion in ComplexDoubleAssertions do
#        f := assertion[ 1 ];
#        msg := assertion[ 2 ];
#        AddAssertion( diffs, MakeDoubleAssertion( C, f, msg ) );
#        od;
     fi;

     Add( ChainComplexCategory( cat ), C );

  elif type = "TheTypeOfCochainComplexes" then

     ObjectifyWithAttributes( C, ValueGlobal( type ),
                              CatOfComplex, cat,
                              Differentials, diffs );

     if make_assertions then
#         This code need to be modified for the case of cochain complexes.
#         for assertion in ComplexSingleAssertions do
#         f := assertion[ 1 ];
#         msg := assertion[ 2 ];
#         AddAssertion( diffs, MakeSingleAssertion( C, f, msg ) );
#         od;
#         for assertion in ComplexDoubleAssertions do
#         f := assertion[ 1 ];
#         msg := assertion[ 2 ];
#         AddAssertion( diffs, MakeDoubleAssertion( C, f, msg ) );
#         od;
     fi;

     Add( CochainComplexCategory( cat ), C );

  fi;

  TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED( C );

  return C;

end );

##
InstallMethod( ChainComplex, [ IsCapCategory, IsZList, IsBool ],
  function( cat, diffs, make_assertions )

  return CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST( cat, diffs, make_assertions, "TheTypeOfChainComplexes" );

end );

##
InstallMethod( ChainComplex, [ IsCapCategory, IsZList ],
  function( cat, diffs )

  return ChainComplex( cat, diffs, false );

end );

##
InstallMethod( CochainComplex, [ IsCapCategory, IsZList, IsBool ],
  function( cat, diffs, make_assertions )

  return CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST( cat, diffs, make_assertions, "TheTypeOfCochainComplexes" );

end );

##
InstallMethod( CochainComplex, [ IsCapCategory, IsZList ],
  function( cat, diffs )

  return CochainComplex( cat, diffs, false );

end );

################################################
#
#  Constructors of inductive (co)chain complexes
#
################################################

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES",
  function( d0, negative_part_function, positive_part_function, string )
  local complex_constructor, negative_part, positive_part, cat, diffs;

  cat := CapCategory( d0 ); 

  if string = "chain" then 

     complex_constructor := ChainComplex;

  elif string = "cochain" then

     complex_constructor := CochainComplex;

  else

     Error( "string must be either chain or cochain" );

  fi;

  negative_part := InductiveList( negative_part_function( d0 ), negative_part_function );

  positive_part := InductiveList( d0, positive_part_function );

  diffs := Concatenate( negative_part, positive_part );

  return complex_constructor( cat, diffs );

end );

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE",
  function( d0, negative_part_function, string )
  local complex_constructor, negative_part, positive_part, cat, diffs, d1, zero_part, complex, upper_bound;

  cat := CapCategory( d0 ); 

  zero_part := RepeatListN( [ UniversalMorphismFromZeroObject( ZeroObject( cat ) ) ] );

  if string = "chain" then 

     complex_constructor := ChainComplex;

     d1 := UniversalMorphismFromZeroObject( Source( d0 ) );

     upper_bound := 1;

  elif string = "cochain" then

     complex_constructor := CochainComplex;

     d1 := UniversalMorphismIntoZeroObject( Range( d0 ) );

     upper_bound := 2;

  else

     Error( "string must be either chain or cochain" );

  fi;

  negative_part := InductiveList( negative_part_function( d0 ), negative_part_function );

  positive_part := Concatenate( [ d0, d1 ], zero_part );

  diffs := Concatenate( negative_part, positive_part );

  complex :=  complex_constructor( cat, diffs );

  SetUpperBound( complex, upper_bound );

  return complex;

end );

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE",
  function( d0, positive_part_function, string )
  local complex_constructor, negative_part, positive_part, cat, diffs, d_minus_1, zero_part, complex, lower_bound;

  cat := CapCategory( d0 ); 

  zero_part := RepeatListN( [ UniversalMorphismFromZeroObject( ZeroObject( cat ) ) ] );

  if string = "chain" then 

     complex_constructor := ChainComplex;

     d_minus_1 := UniversalMorphismIntoZeroObject( Range( d0 ) );

     lower_bound := -2;

  elif string = "cochain" then

     complex_constructor := CochainComplex;

     d_minus_1 := UniversalMorphismFromZeroObject( Source( d0 ) );

     lower_bound := -1;

  else

     Error( "string must be either chain or cochain" );

  fi;

  positive_part := InductiveList( d0, positive_part_function );

  negative_part := Concatenate( [ d_minus_1 ], zero_part );

  diffs := Concatenate( negative_part, positive_part );

  complex :=  complex_constructor( cat, diffs );

  SetLowerBound( complex, lower_bound );

  return complex;

end );

##
InstallMethod( ChainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
   function( d0, negative_part_function, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( d0, negative_part_function, positive_part_function, "chain" );
end );

##
InstallMethod( CochainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
   function( d0, negative_part_function, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( d0, negative_part_function, positive_part_function, "cochain" );
end );

##
InstallMethod( ChainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, negative_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( d0, negative_part_function, "chain" );
   end );

##
InstallMethod( ChainComplexWithInductivePositiveSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE( d0, positive_part_function, "chain" );
end );

##
InstallMethod( CochainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, negative_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( d0, negative_part_function, "cochain" );
   end );

##
InstallMethod( CochainComplexWithInductivePositiveSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE( d0, positive_part_function, "cochain" );
end );

########################################
#
# Upper and lower bounds of (co)chains
#
########################################

##
InstallMethod( SetUpperBound, 
              [ IsChainOrCochainComplex, IsInt ], 
   function( C, upper_bound )

   if not HasFAU_BOUND( C ) then 

      SetFAU_BOUND( C, upper_bound );

      SetHAS_FAU_BOUND( C, true );

   fi;

   if IsBound( C!.UpperBound ) and C!.UpperBound < upper_bound then

      Info( InfoWarning, 1, "Please notice that the input is greater than the already existing active upper bound!" );

   fi;

   C!.UpperBound := upper_bound;

end );


##
InstallMethod( SetLowerBound, 
              [ IsChainOrCochainComplex, IsInt ], 
   function( C, lower_bound )

   if not HasFAL_BOUND( C ) then

      SetFAL_BOUND( C, lower_bound );

      SetHAS_FAL_BOUND( C, true );

   fi;

   if IsBound( C!.LowerBound ) and C!.LowerBound > lower_bound then

      Info( InfoWarning, 1, "Please notice that the input is smaller than the already existing active lower bound!" );

   fi;

   C!.LowerBound := lower_bound;

end );

##
InstallMethod( ActiveUpperBound,
               [ IsChainOrCochainComplex ],
  function( C )

  if not IsBound( C!.UpperBound ) then

     Error( "The complex does not have yet an upper bound" );

  else

     return C!.UpperBound;

  fi;

end );

##
InstallMethod( ActiveLowerBound,
               [ IsChainOrCochainComplex ],
  function( C )

  if not IsBound( C!.LowerBound ) then

     Error( "The complex does not have yet an lower bound" );

  else

     return C!.LowerBound;

  fi;

end );

##
InstallMethod( HasActiveUpperBound,
               [ IsChainOrCochainComplex ],
  function( C )

  return IsBound( C!.UpperBound );

end );

##
InstallMethod( HasActiveLowerBound,
               [ IsChainOrCochainComplex ],
  function( C )

  return IsBound( C!.LowerBound );

end );

#########################################
#
# Components of a (co)chain complexes
#
#########################################

##
InstallMethod( Display, 
               [ IsChainOrCochainComplex, IsInt, IsInt ],
   function( C, m, n )

   local i;

   for i in [ m .. n ] do

   Print( "\n-----------------------------------------------------------------\n" );

   Print( "In index ", String( i ) );

   Print( "\n\nObject is\n" );

   Display( C[ i ] );

   Print( "\nDifferential is\n" );

   Display( C^i );

   od;

end );

#########################################
#
# Attributes of a (co)chain complexes
#
#########################################

##
InstallMethod( Objects, 
               [ IsChainOrCochainComplex ],
  function( C )

    return MapLazy( Differentials( C ), Source, 1 );

end );

##
InstallMethod( CertainDifferentialOp, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
  local d;

  d := Differentials( C )[ i ];

  AddToToDoList( ToDoListEntry( [ [ d, "IsZero", false ] ], function( )

                                                            if not HasIsZero( C ) then

                                                               SetIsZero( C, false );

                                                            fi;

                                                            end ) );

  return d;

end );

##
InstallMethod( \^, [ IsChainOrCochainComplex, IsInt], CertainDifferential );

##
InstallMethod( CertainObjectOp, 
               [ IsChainOrCochainComplex, IsInt ],
function( C, i )
local Obj;

  Obj := Objects( C )[ i ];

  AddToToDoList( ToDoListEntry( [ [ Obj, "IsZero", false ] ], function( )

                                                              if not HasIsZero( C ) then

                                                                 SetIsZero( C, false );

                                                              fi;

                                                              end ) );

  return Obj;

end );

InstallMethod( \[\], [ IsChainOrCochainComplex, IsInt ], CertainObject );

################################################
#
#  Constructors of finite (co)chain complexes
#
################################################

##
BindGlobal( "FINITE_CHAIN_OR_COCHAIN_COMPLEX",
   function( cat, list, index, string )
  local zero, zero_map, zero_part, n, diffs, new_list, complex, upper_bound, lower_bound;

  zero := ZeroObject( cat );

  zero_map := ZeroMorphism( zero, zero );

  zero_part := RepeatListN( [ zero_map ] );

  n := Length( list );

  if not ForAll( list, mor -> cat = CapCategory( mor ) ) then

     Error( "All morphisms in the list should live in the same category" );

  fi;

  if string = "chain" then

        new_list := Concatenation( [ ZeroMorphism( Range( list[ 1 ] ), zero ) ], list, [ ZeroMorphism( zero, Source( list[ n ] ) ) ] );

        diffs := Concatenate( zero_part, index - 1, new_list, zero_part );

        complex := ChainComplex( cat, diffs );

        lower_bound := index - 2;

        upper_bound := index + Length( list );

  else

        new_list := Concatenation( [ ZeroMorphism( zero, Source( list[ 1 ] ) ) ], list, [ ZeroMorphism( Range( list[ n ] ), zero ) ] );

        diffs := Concatenate( zero_part, index - 1, new_list, zero_part );

        complex := CochainComplex( cat, diffs );

        lower_bound := index - 1;

        upper_bound := index + Length( list ) + 1;

  fi;

  SetLowerBound( complex, lower_bound );

  SetUpperBound( complex, upper_bound );

  return complex;

end );


#n
InstallMethod( FiniteChainComplex,
               [ IsDenseList, IsInt ],
  function( diffs, n )
  local cat;

  cat := CapCategory( diffs[ 1 ] );

  return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "chain" );

end );

InstallMethod( FiniteCochainComplex,
               [ IsDenseList, IsInt ],

  function( diffs, n )
  local cat;

  cat := CapCategory( diffs[ 1 ] );

  return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "cochain" );

end );

##
InstallMethod( FiniteChainComplex,
               [ IsDenseList ],
  function( diffs )

  return FiniteChainComplex( diffs, 0 );

end );

##
InstallMethod( FiniteCochainComplex,
               [ IsDenseList ],
   function( diffs )

   return FiniteCochainComplex( diffs, 0 );

end );

##
InstallMethod( StalkChainComplex,
               [ IsCapCategoryObject, IsInt ],
  function( obj, n )
  local zero_obj, zero, diffs, complex;

  zero_obj := ZeroObject( CapCategory( obj ) );

  zero := RepeatListN( [ ZeroMorphism( zero_obj, zero_obj ) ] );

  diffs := Concatenate( zero, n, [ ZeroMorphism( obj, zero_obj ), ZeroMorphism( zero_obj, obj ) ], zero );

  complex := ChainComplex( CapCategory( obj ), diffs );

  SetLowerBound( complex, n - 1 );

  SetUpperBound( complex, n + 1 );

  return complex;

end );

##
InstallMethod( StalkCochainComplex,
                    [ IsCapCategoryObject, IsInt ],
  function( obj, n )
  local zero_obj, zero, diffs, complex;

  zero_obj := ZeroObject( CapCategory( obj ) );

  zero := RepeatListN( [ ZeroMorphism( zero_obj, zero_obj ) ] );

  diffs := Concatenate( zero, n - 1, [ ZeroMorphism( zero_obj, obj ), ZeroMorphism( obj, zero_obj ) ], zero );

  complex := ChainComplex( CapCategory( obj ), diffs );

  SetLowerBound( complex, n - 1 );

  SetUpperBound( complex, n + 1 );

  return complex;

end );

#############################################
##
## Homology and Cohomology computations
##
#############################################

##
InstallMethod( CertainCycleOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )

  return KernelEmbedding( C^i );

end );

##
InstallMethod( CertainBoundaryOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )

  if IsChainComplex( C ) then

     return ImageEmbedding( C^( i + 1 )  );

  else

     return ImageEmbedding( C^( i - 1 )  );

  fi;

end );

##
BindGlobal( "HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX",
  function( C, i )
  local im, inc;

  im := CertainBoundary( C, i );

  inc := KernelLift( C^i, im );

  return CokernelObject( inc );

end );

##
BindGlobal( "HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL",
  function( map, i )
  local C1, C2, im1, d1, inc1, im2, d2, inc2, cycle1, map_i, ker1_to_ker2;

  C1 := Source( map );

  C2 := Range( map );

  im1 := CertainBoundary( C1, i );

  d1 := C1^i;

  inc1 := KernelLift( d1, im1 );

  im2 := CertainBoundary( C2, i );

  d2 := C2^i;

  inc2 := KernelLift( d2, im2 );

  cycle1 := CertainCycle( C1, i );

  map_i := map[ i ];

  ker1_to_ker2 := KernelLift( d2, PreCompose( cycle1, map_i ) );

  return CokernelColift( inc1, PreCompose( ker1_to_ker2, CokernelProjection( inc2 ) ) );

end );

##
InstallMethod( CertainHomologyOp, [ IsChainComplex, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( CertainCohomologyOp, [ IsCochainComplex, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( DefectOfExactnessOp, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, n )

  if IsChainComplex( C ) then 

     return CertainHomology( C, n );

  else

     return CertainCohomology( C, n );

  fi;

end );

##
InstallMethod( IsExactInIndexOp, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, n )

  return IsZeroForObjects( DefectOfExactness( C, n ) );

end );

######################################
#
# Shift using lazy methods
#
######################################

##
InstallMethod( ShiftLazyOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
  local newDifferentials, complex;

  newDifferentials := ShiftLazy( Differentials( C ), i );

  if i mod 2 = 1 then

    newDifferentials := MapLazy( newDifferentials, d -> -d, 1 );

  fi;

  if IsChainComplex( C ) then

     complex := ChainComplex( UnderlyingCategory( CapCategory( C ) ), newDifferentials );

  else

     complex := CochainComplex( UnderlyingCategory( CapCategory( C ) ), newDifferentials );

  fi;

  SetComputedCertainObjects( complex, List( ComputedCertainObjects( C ), function( u ) if IsInt( u ) then return u - i; else return u; fi; end ) );

  SetComputedCertainDifferentials( complex, List( ComputedCertainDifferentials( C ), function( u ) if IsInt( u ) then return u - i; else return (-1)^i*u; fi; end ) );

  AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsZero", complex, "IsZero" ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( )

                                                                    if not HasFAU_BOUND( complex ) then

                                                                      SetUpperBound( complex, FAU_BOUND( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ], function( )

                                                                   if not HasFAU_BOUND( C ) then

                                                                      SetUpperBound( C, FAU_BOUND( complex ) + i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( complex ) then

                                                                      SetLowerBound( complex, FAL_BOUND( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( C ) then

                                                                      SetLowerBound( C, FAL_BOUND( complex ) + i );

                                                                   fi;

                                                                   end ) );

  return complex;
 
end );

##
InstallMethod( ShiftUnsignedLazyOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
  local newDifferentials, complex;

  newDifferentials := ShiftLazy( Differentials( C ), i );

  if IsChainComplex( C ) then 

     complex := ChainComplex( UnderlyingCategory( CapCategory( C ) ), newDifferentials );

  else

     complex := CochainComplex( UnderlyingCategory( CapCategory( C ) ), newDifferentials );

  fi;

  SetComputedCertainObjects( complex, List( ComputedCertainObjects( C ), function( u ) if IsInt( u ) then return u - i; else return u; fi; end ) );

  SetComputedCertainDifferentials( complex, List( ComputedCertainDifferentials( C ), function( u ) if IsInt( u ) then return u - i; else return u; fi; end ) );

  AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsZero", complex, "IsZero" ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( )

                                                                   if not HasFAU_BOUND( complex ) then

                                                                      SetUpperBound( complex, FAU_BOUND( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ], function( )

                                                                   if not HasFAU_BOUND( C ) then

                                                                      SetUpperBound( C, FAU_BOUND( complex ) + i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( complex ) then

                                                                      SetLowerBound( complex, FAL_BOUND( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( C ) then

                                                                      SetLowerBound( C, FAL_BOUND( complex ) + i );

                                                                   fi;

                                                                   end ) );

  return complex;

end );

#####################################
#
# To Do Lists operations
#
#####################################

##
InstallGlobalFunction( TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED,
              
  function( C )

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function() SetFilterObj( C, IsBoundedBellowChainOrCochainComplex ); end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function() SetFilterObj( C, IsBoundedAboveChainOrCochainComplex ); end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND,

  function( arg1, arg2 )

  AddToToDoList( ToDoListEntry( [ [ arg1, "HAS_FAU_BOUND", true ] ], function( )

                                                                     if not HasFAU_BOUND( arg2 ) then 

                                                                        SetUpperBound( arg2, FAU_BOUND( arg1 ) );

                                                                     fi; 

                                                                     end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND,

  function( arg1, arg2 )

  AddToToDoList( ToDoListEntry( [ [ arg1, "HAS_FAL_BOUND", true ] ], function( )

                                                                     if not HasFAL_BOUND( arg2 ) then 

                                                                        SetLowerBound( arg2, FAL_BOUND( arg1 ) );

                                                                     fi;

                                                                     end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_BOUNDS,
  
  function( arg1, arg2 )

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( arg1, arg2 );

  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( arg1, arg2 );

end );

