#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Complexes
##
#############################################################################

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

InstallTrueMethod( IsBoundedChainOrCochainComplex, IsBoundedBelowChainOrCochainComplex and IsBoundedAboveChainOrCochainComplex );

InstallTrueMethod( IsBoundedBelowChainComplex, IsBoundedBelowChainOrCochainComplex and IsChainComplex );

InstallTrueMethod( IsBoundedBelowCochainComplex, IsBoundedBelowChainOrCochainComplex and IsCochainComplex );

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

   if IsBound( C!.UpperBound ) and C!.UpperBound < upper_bound then

      return;

   elif IsBound( C!.LowerBound ) and C!.LowerBound > upper_bound then

      C!.UpperBound := C!.LowerBound;

      if not HasIsZeroForObjects( C ) then SetIsZeroForObjects( C, true ); fi;

   else

      C!.UpperBound := upper_bound;

   fi;

   if not HasFAU_BOUND( C ) then

      SetFAU_BOUND( C, upper_bound );

      SetHAS_FAU_BOUND( C, true );

   fi;

end );

##
InstallMethod( SetLowerBound,
              [ IsChainOrCochainComplex, IsInt ],
   function( C, lower_bound )

   if IsBound( C!.LowerBound ) and C!.LowerBound > lower_bound then

      return;

   fi;

   if IsBound( C!.UpperBound ) and C!.UpperBound < lower_bound then

      C!.LowerBound := C!.UpperBound;

      if not HasIsZeroForObjects( C ) then SetIsZeroForObjects( C, true ); fi;

   else

      C!.LowerBound := lower_bound;

   fi;

   if not HasFAL_BOUND( C ) then

      SetFAL_BOUND( C, lower_bound );

      SetHAS_FAL_BOUND( C, true );

   fi;

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
# Dispaying, viewing (co)chain complexes
#
#########################################

##
BindGlobal( "Big_to_Small",
  function( name )
  local s, new_name, l, i;

  s := name[ 1 ];

  new_name := ShallowCopy( name );

  l := [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ];

  i := Position( [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ], s );

  if i = fail then return name; fi;

  Remove( new_name, 1 );

  Add( new_name, l[ i ], 1 );

  return new_name;

end );

##
InstallMethod( ViewObj, 
        [ IsChainOrCochainComplex ],

  function( C )
  local is_exact;

  if HasIsExact( C ) then

     if IsExact( C ) then 

        is_exact := " cyclic, ";

     else

        is_exact := " not cyclic, ";

     fi;

  else

     is_exact := " ";

  fi;

  if IsBoundedChainOrCochainComplex( C ) then

     Print( "<A", is_exact, "bounded object in ", Big_to_Small( Name( CapCategory( C ) ) ), " with active lower bound ", ActiveLowerBound( C ), " and active upper bound ", ActiveUpperBound( C ), ">" );

  elif IsBoundedBelowChainOrCochainComplex( C ) then

     Print( "<A", is_exact, "bounded from below object in ", Big_to_Small( Name( CapCategory( C ) ) ), " with active lower bound ", ActiveLowerBound( C ), ">" );

  elif IsBoundedAboveChainOrCochainComplex( C ) then

     Print( "<A", is_exact, "bounded from above object in ", Big_to_Small( Name( CapCategory( C ) ) ), " with active upper bound ", ActiveUpperBound( C ), ">" );

  else

     TryNextMethod( );

  fi;

end );

##
InstallMethod( Display, 
               [ IsChainOrCochainComplex, IsInt, IsInt ],
    function( C, m, n )
    local i, co_homo, dashes;

    if IsChainComplex( C ) then
	    co_homo := "homological";
        dashes := "\n------------------------/\\--------------------------\n";
        for i in [ m .. n ] do
            Print( dashes );
            Print( TextAttr.(2),  "In ", co_homo," degree ", String( i ) , TextAttr.reset );
            Print( "\n\n", TextAttr.(2), "Differential:", TextAttr.reset, "\n" );
            Display( C^i );
            Print( "\n", TextAttr.(2), "Object:", TextAttr.reset, "\n" );
            Display( C[ i ] );
        od;
    else
        co_homo := "cohomological";
        dashes := "\n------------------------\\/--------------------------\n";
        for i in [ m .. n ] do
            Print( dashes );
            Print( TextAttr.(2),  "In ", co_homo," degree ", String( i ) , TextAttr.reset );
            Print( "\n\n", TextAttr.(2), "Object:", TextAttr.reset, "\n" );
            Display( C[ i ] );
            Print( "\n", TextAttr.(2), "Differential:", TextAttr.reset, "\n" );
            Display( C^i );
        od;
    fi;

end );

##
InstallMethod( Display,
      [ IsBoundedChainOrCochainComplex ],
    function( C )
    if ActiveUpperBound( C ) -  ActiveLowerBound( C ) >= 2 then
        Display( C, ActiveLowerBound( C ) + 1 , ActiveUpperBound( C ) - 1 );
    else
	      Print( "A zero complex in ", Name( CapCategory( C ) ) );
    fi;
end );

InstallMethod( DisplayComplex, [ IsChainOrCochainComplex, IsInt, IsInt ], Display );
InstallMethod( DisplayComplex, [ IsBoundedChainOrCochainComplex ], Display );


##
InstallMethod( ViewComplex, 
               [ IsChainOrCochainComplex, IsInt, IsInt ],
    function( C, m, n )
    local i, co_homo, dashes;

    if IsChainComplex( C ) then
	    co_homo := "homological";
        dashes := "\n------------------------/\\--------------------------\n";
    else
        co_homo := "cohomological";
        dashes := "\n------------------------\\/--------------------------\n";
    fi;

    for i in [ m .. n ] do
        Print( dashes );
        Print( TextAttr.(2),  "In ", co_homo," degree ", String( i ) , TextAttr.reset );
        Print( "\n\n", TextAttr.(2), "Object:", TextAttr.reset, "\n" );
        View( C[ i ] );
        Print( "\n", TextAttr.(2), "Differential:", TextAttr.reset, "\n" );
        View( C^i );
    od;
end );

##
InstallMethod( ViewComplex,
    [ IsBoundedChainOrCochainComplex ],
    function( C )
    if ActiveUpperBound( C ) -  ActiveLowerBound( C ) >= 2 then
        ViewComplex( C, ActiveLowerBound( C ) + 1 , ActiveUpperBound( C ) - 1 );
    else
	    Print( "A zero complex in ", Name( CapCategory( C ) ) );
    fi;
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
InstallMethod( DifferentialAtOp, 
               [ IsChainOrCochainComplex, IsInt ], 
  function( C, i )
  local d;

  d := Differentials( C )[ i ];

  AddToToDoList( ToDoListEntry( [ [ d, "IsZeroForObjects", false ] ], function( )

                                                            if not HasIsZeroForObjects( C ) then

                                                               SetIsZeroForObjects( C, false );

                                                            fi;

                                                            end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "IsZeroForObjects", true ] ], function( )

                                                            if not HasIsZeroForObjects( d ) then

                                                              SetIsZeroForObjects( d, true );

                                                           fi;

                                                           end ) );

  return d;

end );

##
InstallMethod( \^, [ IsChainOrCochainComplex, IsInt], DifferentialAt );

##
InstallMethod( ObjectAtOp, 
               [ IsChainOrCochainComplex, IsInt ],
function( C, i )
local Obj;

  Obj := Objects( C )[ i ];

  AddToToDoList( ToDoListEntry( [ [ Obj, "IsZeroForObjects", false ] ], function( )

                                                              if not HasIsZeroForObjects( C ) then

                                                                 SetIsZeroForObjects( C, false );

                                                              fi;

                                                              end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "IsZeroForObjects", true ] ], function( )

                                                           if not HasIsZeroForObjects( Obj ) then

                                                              SetIsZeroForObjects( Obj, true );

                                                           fi;

                                                           end ) );
  return Obj;

end );

InstallMethod( \[\], [ IsChainOrCochainComplex, IsInt ], ObjectAt );

##
InstallMethod( AsChainComplex,
    [ IsCochainComplex ],
    function( C )
    local F, cochains, chains, D;
    cochains := CapCategory( C );
    chains := ChainComplexCategory( UnderlyingCategory( cochains ) );
    F := CochainToChainComplexFunctor( cochains, chains );
    D := ApplyFunctor( F, C );
    SetAsCochainComplex( D, C );
    return D;
end );

##
InstallMethod( AsCochainComplex,
    [ IsChainComplex ],
    function( C )
    local F, cochains, chains, D;
    chains := CapCategory( C );
    cochains := CochainComplexCategory( UnderlyingCategory( chains ) );
    F := ChainToCochainComplexFunctor( chains, cochains );
    D := ApplyFunctor( F, C );
    SetAsChainComplex( D, C );
    return D;
end );

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
InstallMethod( ChainComplex,
               [ IsDenseList, IsInt ],
  function( diffs, n )
  local cat;

  cat := CapCategory( diffs[ 1 ] );

  return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "chain" );

end );

InstallMethod( CochainComplex,
               [ IsDenseList, IsInt ],

  function( diffs, n )
  local cat;

  cat := CapCategory( diffs[ 1 ] );

  return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "cochain" );

end );

##
InstallMethod( ChainComplex,
               [ IsDenseList ],
  function( diffs )

  return ChainComplex( diffs, 0 );

end );

##
InstallMethod( CochainComplex,
               [ IsDenseList ],
   function( diffs )

   return CochainComplex( diffs, 0 );

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

  complex := CochainComplex( CapCategory( obj ), diffs );

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
InstallMethod( CyclesAtOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )

  return KernelEmbedding( C^i );

end );

##
InstallMethod( BoundariesAtOp, [ IsChainOrCochainComplex, IsInt ],
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

  im := BoundariesAt( C, i );

  inc := KernelLift( C^i, im );

  im := CokernelObject( inc );

  AddToToDoList( ToDoListEntry( [ [ im, "IsZeroForObjects", false ] ], function( )

                                                             if not HasIsExact( C ) then

                                                                SetIsExact( C, false );

                                                             fi;

                                                             end ) );
  return im;

end );

##
BindGlobal( "PROJECTION_ONTO_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX",
  function( C, i )
  local im, inc, pi, cyc;

  im := BoundariesAt( C, i );

  inc := KernelLift( C^i, im );

  pi := CokernelProjection( inc );
  
  cyc := CyclesAt( C, i );

  AddToToDoList( ToDoListEntry( [ [ Range( pi ), "IsZeroForObjects", false ] ], function( )

                                                             if not HasIsExact( C ) then

                                                                SetIsExact( C, false );

                                                             fi;

                                                             end ) );
  return GeneralizedMorphismBySpan( cyc, pi );

end );

##
BindGlobal( "INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX",
  function( C, i )
  local im, inc, pi, cyc;

  im := BoundariesAt( C, i );

  inc := KernelLift( C^i, im );

  pi := CokernelProjection( inc );
  
  cyc := CyclesAt( C, i );

  AddToToDoList( ToDoListEntry( [ [ Range( pi ), "IsZeroForObjects", false ] ], function( )

                                                             if not HasIsExact( C ) then

                                                                SetIsExact( C, false );

                                                             fi;

                                                             end ) );
  return GeneralizedMorphismBySpan( pi, cyc );

end );

##
BindGlobal( "HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL",
  function( map, i )
  local C1, C2, im1, d1, inc1, im2, d2, inc2, cycle1, map_i, ker1_to_ker2;

  C1 := Source( map );

  C2 := Range( map );

  im1 := BoundariesAt( C1, i );

  d1 := C1^i;

  inc1 := KernelLift( d1, im1 );

  im2 := BoundariesAt( C2, i );

  d2 := C2^i;

  inc2 := KernelLift( d2, im2 );

  cycle1 := CyclesAt( C1, i );

  map_i := map[ i ];

  ker1_to_ker2 := KernelLift( d2, PreCompose( cycle1, map_i ) );

  return CokernelColift( inc1, PreCompose( ker1_to_ker2, CokernelProjection( inc2 ) ) );

end );

##
InstallMethod( HomologyAtOp, [ IsChainComplex, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( CohomologyAtOp, [ IsCochainComplex, IsInt ], HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

InstallMethod( GeneralizedProjectionOntoHomologyAtOp, [ IsChainComplex, IsInt ], PROJECTION_ONTO_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

InstallMethod( GeneralizedEmbeddingOfHomologyAtOp, [ IsChainComplex, IsInt ], INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );
##
InstallMethod( GeneralizedProjectionOntoCohomologyAtOp, [ IsCochainComplex, IsInt ], PROJECTION_ONTO_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

InstallMethod( GeneralizedEmbeddingOfCohomologyAtOp, [ IsCochainComplex, IsInt ], INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

InstallMethod( DefectOfExactnessAtOp, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, n )

  if IsChainComplex( C ) then 

     return HomologyAt( C, n );

  else

     return CohomologyAt( C, n );

  fi;

end );

##
InstallMethod( IsExactInIndexOp, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, n )
  local bool;

  bool := IsZeroForObjects( DefectOfExactnessAt( C, n ) );

  if bool = false then 

     SetIsExact( C, false );

  fi;

  return bool;
 
end );

InstallMethod( IsExact,
               [ IsChainOrCochainComplex ], 
  function( C )
  local i;

  if not HasActiveLowerBound( C ) or not HasActiveUpperBound( C ) then 

     Error( "The complex must have upper and lower bounds" );

  fi;

  for i in [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ] do 

      if not IsExactInIndex( C, i ) then 

         return false;

      fi;

  od;

  return true;

end );

##
InstallMethod( CohomologySupport, 
               [ IsCochainComplex, IsInt, IsInt ],
  function( C, m, n )
  local l, i;
  l := [ ];
  for i in [ m .. n ] do 
  if not IsZeroForObjects( CohomologyAt( C, i ) ) then 
     Add( l, i );
  fi;
  od;
  return l;
end );

##
InstallMethod( HomologySupport, 
               [ IsChainComplex, IsInt, IsInt ],
  function( C, m, n )
  local l, i;
  l := [ ];
  for i in [ m .. n ] do 
  if not IsZeroForObjects( HomologyAt( C, i ) ) then 
     Add( l, i );
  fi;
  od;
  return l;
end );

##
InstallMethod( ObjectsSupport, 
               [ IsChainOrCochainComplex, IsInt, IsInt ],
  function( C, m, n )
    local l, i;
    l := [ ];
    for i in [ m .. n ] do 
    if not IsZeroForObjects( C[i] ) then 
        Add( l, i );
    fi;
    od;
    
    if l = [ ] then
        SetUpperBound( C, ActiveLowerBound(C) );
    else
        SetLowerBound( C, l[1]-1 );
        SetUpperBound( C, l[Length(l)] + 1 );
    fi;

    return l;
end );


##
InstallMethod( DifferentialsSupport, 
               [ IsChainOrCochainComplex, IsInt, IsInt ],
  function( C, m, n )
  local l, i;
  l := [ ];
  for i in [ m .. n ] do 
  if not IsZeroForMorphisms( C^i ) then 
     Add( l, i );
  fi;
  od;
  return l;
end );

##
InstallMethod( CohomologySupport,
               [ IsBoundedCochainComplex ],
  function( C )
  if not IsBoundedAboveCochainComplex(C) or not IsBoundedBelowCochainComplex(C) then
    Error( "The cochain must be bounded, you can  still use: CohomologySupport(C,m,n)" );
  fi;
  return CohomologySupport( C, ActiveLowerBound(C), ActiveUpperBound(C) );
end );

##
InstallMethod( HomologySupport,
               [ IsBoundedChainComplex ],
  function( C )
  if not IsBoundedAboveChainComplex(C) or not IsBoundedBelowChainComplex(C) then
    Error( "The chain must be bounded, you can  still use: HomologySupport(C,m,n)" );
  fi;
  return HomologySupport( C, ActiveLowerBound(C), ActiveUpperBound(C) );
end );

##
InstallMethod( ObjectsSupport,
               [ IsBoundedChainOrCochainComplex ],
  function( C )
  if not IsBoundedBelowChainOrCochainComplex(C) or not IsBoundedAboveChainOrCochainComplex(C) then
    Error( "The (co)chain complex must be bounded, you can  still use: ObjectsSupport(C,m,n)" );
  fi;
  return ObjectsSupport( C, ActiveLowerBound(C), ActiveUpperBound(C) );
end );

##
InstallMethod( DifferentialsSupport,
               [ IsBoundedChainOrCochainComplex ],
  function( C )
  if not IsBoundedBelowChainOrCochainComplex(C) or not IsBoundedAboveChainOrCochainComplex(C) then
    Error( "The (co)chain complex must be bounded, you can  still use: DifferentialsSupport(C,m,n)" );
  fi;
  return DifferentialsSupport( C, ActiveLowerBound(C), ActiveUpperBound(C) );
end );

InstallMethod( IsWellDefined, 
               [ IsCochainComplex, IsInt, IsInt ],
  function( C, m, n )
    local i;
    for i in [ m .. n ] do 
        if not IsZeroForMorphisms( PreCompose( C^i, C^(i+1) ) ) then 
            AddToReasons( Concatenation( "IsWellDefined: The composition is not zero in index ", String( i ) ) );  
            return false;
        fi;
        
        if not IsWellDefined( C[ i ] ) then 
            AddToReasons( Concatenation( "IsWellDefined: The object is not well-defined in index ", String( i ) ) );  
            return false;
        fi;
    od;
    return true;
end );

InstallMethod( IsWellDefined, 
               [ IsChainComplex, IsInt, IsInt ],
 function( C, m, n )
 local i;
 
 for i in [ m .. n ] do 
    if not IsZeroForMorphisms( PostCompose( C^i, C^(i+1) ) ) then 
        return false;
    fi;
 
    if not IsWellDefined( C[ i ] ) then 
        return false;
    fi;
 od;
 return true;
end );

InstallMethod( IsWellDefined,
               [ IsBoundedChainOrCochainComplex ],
  function( C )
  return IsWellDefined( C, ActiveLowerBound( C ) + 1, ActiveUpperBound( C ) - 1 );
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

  SetComputedObjectAts( complex, List( ComputedObjectAts( C ), 
            function( u ) 
            if IsInt( u ) then 
              return u - i; 
            else 
              return u; 
            fi; 
            end ) );

  SetComputedDifferentialAts( complex, List( ComputedDifferentialAts( C ), 
            function( u ) 
            if IsInt( u ) then 
              return u - i; 
            else
              if i mod 2 = 0 then
                return u; 
              else
                return AdditiveInverse( u );
              fi;
            fi; 
            end ) );

  AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsZeroForObjects", complex, "IsZeroForObjects" ) );

  AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsExact", complex, "IsExact" ) );

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

  SetComputedObjectAts( complex, List( ComputedObjectAts( C ), function( u ) if IsInt( u ) then return u - i; else return u; fi; end ) );

  SetComputedDifferentialAts( complex, List( ComputedDifferentialAts( C ), function( u ) if IsInt( u ) then return u - i; else return u; fi; end ) );

  AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsZeroForObjects", complex, "IsZeroForObjects" ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( )

                                                                   if not HasFAU_BOUND( complex ) then

                                                                      SetUpperBound( complex, ActiveUpperBound( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ], function( )

                                                                   if not HasFAU_BOUND( C ) then

                                                                      SetUpperBound( C, ActiveUpperBound( complex ) + i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( complex ) then

                                                                      SetLowerBound( complex, ActiveLowerBound( C ) - i );

                                                                   fi;

                                                                   end ) );

  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ], function( )

                                                                   if not HasFAL_BOUND( C ) then

                                                                      SetLowerBound( C, ActiveLowerBound( complex ) + i );

                                                                   fi;

                                                                   end ) );

  return complex;

end );


#####################################
#
# Truncations of complexes
#
#####################################

##
InstallMethod( GoodTruncationBelowOp,
               [ IsChainComplex, IsInt ],

  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i < n  then 
                                     return ZeroMorphism( zero, zero );
                                  elif i = n then
                                     return ZeroMorphism( KernelObject( C^n ), zero );
                                  elif i = n+1 then
                                     return KernelLift( C^n, C^( n + 1 ) );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

 tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

 TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( C, tr_C );

 TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND( C, tr_C );

 SetLowerBound( tr_C, n - 1 );

 return tr_C;

end );

##
InstallMethod( GoodTruncationBelowOp,
               [ IsCochainComplex, IsInt ],

  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i < n - 1 then 
                                     return ZeroMorphism( zero, zero );
                                  elif i = n - 1 then
                                     return ZeroMorphism( zero, CokernelObject( KernelEmbedding( C^n ) ) );
                                  elif i = n then
                                     return CokernelColift( KernelEmbedding( C^n ), C^n );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

 tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

 TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( C, tr_C );

 TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND( C, tr_C );

 SetLowerBound( tr_C, n - 1 );

 return tr_C;
 
end );

##
InstallMethod( GoodTruncationAboveOp,
               [ IsChainComplex, IsInt ],

  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i > n + 1  then
                                     return ZeroMorphism( zero, zero );
                                  elif i = n + 1 then
                                     return ZeroMorphism( zero, CokernelObject( KernelEmbedding( C^n ) ) );
                                  elif i = n then
                                     return CokernelColift( KernelEmbedding( C^n ), C^n  );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( C, tr_C );

  TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND( C, tr_C );

  SetUpperBound( tr_C, n + 1 );

 return tr_C;

end );

##
InstallMethod( GoodTruncationAboveOp,
               [ IsCochainComplex, IsInt ],

  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i > n  then
                                     return ZeroMorphism( zero, zero );
                                  elif i = n then
                                     return ZeroMorphism( KernelObject( C^n ), zero );
                                  elif i = n -1 then
                                     return KernelLift( C^n, C^(n-1)  );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( C, tr_C );

  TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND( C, tr_C );

  SetUpperBound( tr_C, n + 1 );

  return tr_C;

end );

## sigma_>= n 
##  <------ C_n-1 <---- C_n <---- C_n+1 <-----
##  <------  0    <---- C_n <---- C_n+1 <-----

InstallMethod( BrutalTruncationBelowOp,
               [ IsChainComplex, IsInt ],
  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i < n  then
                                     return ZeroMorphism( zero, zero ); 
                                  elif i = n then
                                     return ZeroMorphism( C[ n ], zero );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

  # tr_C may get better lower bound than n - 1.
  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( C, tr_C );

  TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND( C, tr_C );

  SetLowerBound( tr_C, n - 1 );

  return tr_C;

end );

## sigma_>n =
##  <------ C_n-1 <---- C_n <---- C_n+1 <-----
##  <------ C_n-1 <----  0  <----   0   <-----

InstallMethod( BrutalTruncationAboveOp,
               [ IsChainComplex, IsInt ],
  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i >= n + 1  then
                                     return ZeroMorphism( zero, zero );
                                  elif i = n then
                                     return ZeroMorphism( zero, C[ n-1 ]  );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

  #G this.
  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( C, tr_C );

  TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND( C, tr_C );

  SetUpperBound( tr_C, n );

  return tr_C;

end );

##  -------> C_n-1 -----> C_n -----> C_n+1 ------>
##  -------> 0     ----->  0 -----> C_n+1 ------>

InstallMethod( BrutalTruncationBelowOp,
               [ IsCochainComplex, IsInt ],
  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
  
  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i < n  then
                                     return ZeroMorphism( zero, zero ); 
                                  elif i = n then
                                     return ZeroMorphism( zero, C[ n + 1 ] );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );

  #G this.
  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( C, tr_C );
 
  TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND( C, tr_C );

  SetLowerBound( tr_C, n );

  return tr_C;
 
end );

##  ------> C_i-1 -----> C_i -----> C_i+1 ------>
##  ------> C_i-1 -----> C_i ----->  0    ------>

InstallMethod( BrutalTruncationAboveOp,
               [ IsCochainComplex, IsInt ],
  function( C, n )
  local zero, diffs, tr_C;

  zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );

  diffs := Differentials( C );

  diffs := MapLazy( IntegersList, function( i )
                                  if i > n   then
                                     return ZeroMorphism( zero, zero );
                                  elif i = n then
                                     return ZeroMorphism( C[ n ], zero  );
                                  else
                                     return C^i;
                                  fi;
                                  end, 1 );

  tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
 
  #G this.
  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( C, tr_C );

  TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND( C, tr_C );

  SetUpperBound( tr_C, n + 1 );

  return tr_C;

end );


#####################################
#
# To Do Lists operations
#
#####################################

##
InstallGlobalFunction( TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED,

  function( C )

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function() SetFilterObj( C, IsBoundedBelowChainOrCochainComplex ); end ) );

  AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function() SetFilterObj( C, IsBoundedAboveChainOrCochainComplex ); end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND,

  function( arg1, arg2 )

  AddToToDoList( ToDoListEntry( [ [ arg1, "HAS_FAU_BOUND", true ] ], function( )

                                                                        SetUpperBound( arg2, ActiveUpperBound( arg1 ) );

                                                                     end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND,
  function( arg1, arg2 )

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( arg1, arg2 );

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( arg2, arg1 );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND,

  function( arg1, arg2 )

  AddToToDoList( ToDoListEntry( [ [ arg1, "HAS_FAL_BOUND", true ] ], function( )

                                                                        SetLowerBound( arg2, ActiveLowerBound( arg1 ) );

                                                                     end ) );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND,
  function( arg1, arg2 )

  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( arg1, arg2 );

  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( arg2, arg1 );

end );

##
InstallGlobalFunction( TODO_LIST_TO_PUSH_BOUNDS,
  
  function( arg1, arg2 )

  TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND( arg1, arg2 );

  TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND( arg1, arg2 );

end );

InstallGlobalFunction( TODO_LIST_TO_PUSH_PULL_BOUNDS,
  function( arg1, arg2 )

  TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND( arg1, arg2 );

  TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND( arg1, arg2 );

end );


