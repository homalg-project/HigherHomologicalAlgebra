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
# Constructors of (Co)chain complexes
#
###########################################

BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST",
function( cat, diffs, make_assertions, type )
  local C, assertion, f, msg;

  C := rec( );

  if type = "TheTypeOfChainComplexes" then

     ObjectifyWithAttributes( C, ValueGlobal( type ),

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

  C!.ListOfComputedDifferentials := [ ];

  C!.ListOfComputedObjects := [ ];

  return C;

end );

InstallMethod( ChainComplex, [ IsCapCategory, IsZList, IsBool ],
  function( cat, diffs, make_assertions )

  return CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST( cat, diffs, make_assertions, "TheTypeOfChainComplexes" );

end );

InstallMethod( ChainComplex, [ IsCapCategory, IsZList ],
  function( cat, diffs )

  return ChainComplex( cat, diffs, false );

end );

InstallMethod( CochainComplex, [ IsCapCategory, IsZList, IsBool ],
  function( cat, diffs, make_assertions )

  return CHAIN_OR_COCHAIN_COMPLEX_BY_DIFFERENTIAL_LIST( cat, diffs, make_assertions, "TheTypeOfCochainComplexes" );

end );

InstallMethod( CochainComplex, [ IsCapCategory, IsZList ],
  function( cat, diffs )

  return CochainComplex( cat, diffs, false );

end );

################################################
#
#  Constructors of inductive (co)chain complexes
#
################################################

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

#n
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

InstallMethod( ChainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
   function( d0, negative_part_function, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( d0, negative_part_function, positive_part_function, "chain" );
end );

InstallMethod( CochainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
   function( d0, negative_part_function, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( d0, negative_part_function, positive_part_function, "cochain" );
end );

InstallMethod( ChainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, negative_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( d0, negative_part_function, "chain" );
   end );

InstallMethod( ChainComplexWithInductivePositiveSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, positive_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE( d0, positive_part_function, "chain" );
end );

InstallMethod( CochainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
   function( d0, negative_part_function )
   return CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( d0, negative_part_function, "cochain" );
   end );

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

      Error( "The input is bigger than the one that already exists!" );

   fi;

   C!.UpperBound := upper_bound;

end );


##
InstallMethod( SetLowerBound, 
              [ IsChainOrCochainComplex, IsInt ], 
   function( C, lower_bound )

   if IsBound( C!.LowerBound ) and C!.LowerBound > lower_bound then 

      Error( "The input is smaller than the one that already exists!" );

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

InstallMethod( Display, 
               [ IsChainOrCochainComplex, IsInt, IsInt ], 
   function( C, m, n )

   local i;

   for i in [ m .. n ] do

   Print( "-----------------------------------------------------------------\n" );

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
  
    return MapLazy( Differentials( C ), Source );

end );

##
InstallMethod( \^, 
               [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
  local l, L;
  
  l := C!.ListOfComputedDifferentials;

  L :=  List( l, i->i[ 1 ] ); 

  if i in L then 

     return l[ Position( L, i ) ][ 2 ];

  fi;
  
  l := Differentials( C )[ i ];

  Add( C!.ListOfComputedDifferentials, [ i, l ] );

  return l;

end );

##
InstallMethod( \[\], 
               [ IsChainOrCochainComplex, IsInt ],
function( C, i )
  local l, L;
  
  l := C!.ListOfComputedObjects;

  L :=  List( l, i->i[ 1 ] ); 

  if i in L then 

     return l[ Position( L, i ) ][ 2 ];

  fi;

  l := Objects( C )[ i ];
  
  Add( C!.ListOfComputedObjects, [ i, l ] );

  return l;

end );

