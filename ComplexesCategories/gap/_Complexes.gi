# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#



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

InstallMethod( CreateComplex,
        [ IsCochainComplexCategory, IsList ],

  { ch_cat, object_datum } ->
      
      CreateCapCategoryObjectWithAttributes( ch_cat,
                            Objects, object_datum[1],
                            Differentials, object_datum[2],
                            LowerBoundOfComplex, object_datum[3],
                            UpperBoundOfComplex, object_datum[4] )
);

## Convenience methods
InstallOtherMethod( CreateComplex,
        [ IsCochainComplexCategory, IsZFunction, IsZFunction, IsObject, IsObject ],
  
  { ch_cat, objs, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, [ objs, diffs, lower_bound, upper_bound ] )
);

##
InstallOtherMethod( CreateComplex,
        [ IsCochainComplexCategory, IsZFunction, IsObject, IsObject ],
  
  { ch_cat, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, ApplyMap( diffs, Source ), diffs, lower_bound, upper_bound )
);

##
InstallOtherMethod( CreateComplex,
        [ IsCochainComplexCategory, IsZFunction ],
  
  { ch_cat, diffs } -> CreateComplex(  ch_cat, diffs, -infinity, infinity )
);

##
InstallOtherMethod( CreateComplex,
        [ IsCochainComplexCategory, IsDenseList, IsInt ],
        
  function( ch_cat, diffs_list, lower_bound )
    local zero_obj, upper_bound, diffs;
    
    zero_obj := ZeroObject( UnderlyingCategory( ch_cat ) );
    
    upper_bound := lower_bound + Length( diffs_list );
    
    diffs :=
      function( i )
        
        if i = lower_bound - 1 then
          return UniversalMorphismFromZeroObject( Source( diffs_list[ 1 ] ) );
        elif i >= lower_bound and i <= upper_bound - 1 then
          return diffs_list[ i - lower_bound + 1 ];
        elif i = upper_bound then
          return UniversalMorphismIntoZeroObject( Range( diffs_list[ Length( diffs_list ) ] ) );
        else
          return ZeroObjectFunctorial( UnderlyingCategory( ch_cat ) );
        fi;
        
      end;
    
    return CreateComplex( ch_cat, AsZFunction( diffs ), lower_bound, upper_bound );
    
end );


## Old and to be removed
##
BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_BY_Z_FUNCTION",
  function( cat, diffs, type )
    local C;
    
    Display( "WARNING: deprecated method has been called!\n" );
    
    if type = "TheTypeOfChainComplexes" then
      
      Error( "Not yet implemented!\n" );
      
    elif type = "TheTypeOfCochainComplexes" then
      
      C := CreateComplex( CochainComplexCategory( cat ), diffs );
      
    fi;
   
    TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED( C );
    
    return C;
    
end );

##
InstallMethod( ChainComplex, [ IsCapCategory, IsZFunction ],
  function( cat, diffs )
    
    return CHAIN_OR_COCHAIN_COMPLEX_BY_Z_FUNCTION(
            cat, diffs, "TheTypeOfChainComplexes"
              );
   
end );

##
InstallMethod( CochainComplex, [ IsCapCategory, IsZFunction ],
  function( cat, diffs )
    
    return CHAIN_OR_COCHAIN_COMPLEX_BY_Z_FUNCTION(
            cat, diffs, "TheTypeOfCochainComplexes"
              );

end );

################################################
#
#  Constructors of inductive (co)chain complexes
#
################################################

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES",
  function( N, d_N, negative_part_function, positive_part_function, string )
    local cat, complex_constructor, diff, func;
    
    cat := CapCategory( d_N );
    
    if string = "chain" then 
      
      complex_constructor := ChainComplex;
      
    elif string = "cochain" then
      
      complex_constructor := CochainComplex;
      
    else
      
      Error( "string must be either chain or cochain" );
      
    fi;
    
    diff := ZFunctionWithInductiveSides( N, d_N, negative_part_function, positive_part_function, IsEqualForMorphismsOnMor );
    
    return complex_constructor( cat, diff );
    
end );

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE",
  function( N, d_N, negative_part_function, string )
    local cat, positive_part_function, upper_bound, complex;
     
    cat := CapCategory( d_N );
     
    if string = "chain" then 
      
      positive_part_function := d -> UniversalMorphismFromZeroObject( Source( d ) );
      
      upper_bound := N;
      
    elif string = "cochain" then
      
      positive_part_function := d -> UniversalMorphismIntoZeroObject( Range( d ) );
      
      upper_bound := N + 1;
      
    fi;
    
    complex := CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( N, d_N, negative_part_function, positive_part_function, string );
    
    SetUpperBound( complex, upper_bound );
    
    return complex;
    
end );

##
BindGlobal( "CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE",
  function( N, d_N, positive_part_function, string )
    local cat, negative_part_function, lower_bound, complex;
     
    cat := CapCategory( d_N );
     
    if string = "chain" then 
      
      negative_part_function := d -> UniversalMorphismIntoZeroObject( Range( d ) );
      
      lower_bound := N - 1;
      
    elif string = "cochain" then
      
      negative_part_function := d -> UniversalMorphismFromZeroObject( Source( d ) );
      
      lower_bound := N;
      
    fi;
    
    complex := CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES( N, d_N,
                  negative_part_function, positive_part_function,
                    string );
    
    SetLowerBound( complex, lower_bound );
    
    return complex;
  
end );

##
InstallMethod( ChainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
  { d_0, negative_part_function, positive_part_function } ->
      ChainComplexWithInductiveSides( 0, d_0, negative_part_function, positive_part_function )
);

##
InstallMethod( ChainComplexWithInductiveSides,
               [ IsInt, IsCapCategoryMorphism, IsFunction, IsFunction ],
  { n, d_n, negative_part_function, positive_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES(
              n, d_n, negative_part_function, positive_part_function,
                "chain" )
);

##
InstallMethod( ChainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
  { d_0, negative_part_function } -> ChainComplexWithInductiveNegativeSide( 0, d_0, negative_part_function )
);

##
InstallMethod( ChainComplexWithInductiveNegativeSide,
              [ IsInt, IsCapCategoryMorphism, IsFunction ],
  { n, d_n, negative_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( n, d_n, negative_part_function, "chain" )
);

##
InstallMethod( ChainComplexWithInductivePositiveSide,
               [ IsCapCategoryMorphism, IsFunction ],
  { d_0, positive_part_function } ->
    ChainComplexWithInductivePositiveSide( 0, d_0, positive_part_function )
);

##
InstallMethod( ChainComplexWithInductivePositiveSide,
              [ IsInt, IsCapCategoryMorphism, IsFunction ],
  { n, d_n, positive_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE( n, d_n, positive_part_function, "chain" )
);

##
InstallMethod( CochainComplexWithInductiveSides,
               [ IsCapCategoryMorphism, IsFunction, IsFunction ],
  { d_0, negative_part_function, positive_part_function } ->
    CochainComplexWithInductiveSides( 0, d_0, negative_part_function, positive_part_function )
);

##
InstallMethod( CochainComplexWithInductiveSides,
               [ IsInt, IsCapCategoryMorphism, IsFunction, IsFunction ],
  { n, d_n, negative_part_function, positive_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_SIDES(
              n, d_n, negative_part_function, positive_part_function,
                "cochain" )
);

##
InstallMethod( CochainComplexWithInductiveNegativeSide,
               [ IsCapCategoryMorphism, IsFunction ],
  { d_0, negative_part_function } ->
    CochainComplexWithInductiveNegativeSide( 0, d_0, negative_part_function )
);

##
InstallMethod( CochainComplexWithInductiveNegativeSide,
              [ IsInt, IsCapCategoryMorphism, IsFunction ],
  { n, d_n, negative_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_NEGATIVE_SIDE( n, d_n, negative_part_function, "cochain" )
);

##
InstallMethod( CochainComplexWithInductivePositiveSide,
               [ IsCapCategoryMorphism, IsFunction ],
  { d_0, positive_part_function } ->
    CochainComplexWithInductivePositiveSide( 0, d_0, positive_part_function )
);

##
InstallMethod( CochainComplexWithInductivePositiveSide,
              [ IsInt, IsCapCategoryMorphism, IsFunction ],
  { n, d_n, positive_part_function } ->
    CHAIN_OR_COCHAIN_WITH_INDUCTIVE_POSITIVE_SIDE( n, d_n, positive_part_function, "cochain" )
);

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
    
    if not HasUpperBoundOfComplex( C ) then
      
      SetUpperBoundOfComplex( C, upper_bound );
      
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
        
end );

##
InstallMethod( ActiveUpperBound,
               [ IsChainOrCochainComplex ],
  function( C )
    
    if not HasActiveUpperBound( C ) then
      
      Error( "The complex does not have yet an upper bound" );
      
    else
      
      return C!.UpperBound;
      
    fi;
    
end );

##
InstallMethod( ActiveLowerBound,
               [ IsChainOrCochainComplex ],
  function( C )
    
    if not HasActiveLowerBound( C ) then
      
      Error( "The complex does not have yet an lower bound" );
      
    else
      
      return C!.LowerBound;
      
    fi;
    
end );

##
InstallMethod( HasActiveUpperBound,
               [ IsChainOrCochainComplex ],
  function( C )
    
    if not IsBound( C!.UpperBound ) and HasUpperBoundOfComplex( C ) then
      C!.UpperBound := UpperBoundOfComplex( C );
    fi;
    
    return IsBound( C!.UpperBound );
    
end );

##
InstallMethod( HasActiveLowerBound,
               [ IsChainOrCochainComplex ],
  function( C )
         
    return IsBound( C!.LowerBound );
    
end );

InstallMethod( DisplayComplex, [ IsChainOrCochainComplex, IsInt, IsInt ], Display );

InstallMethod( DisplayComplex, [ IsBoundedChainOrCochainComplex ], Display );

BindGlobal( "VIEW_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX",
  function( C, m, n )
    local r, s, i;
    
    r := RandomTextColor( "" );
    
    if IsCochainComplex( C ) then
      
      for i in Reversed( [ m .. n ] ) do
        if i <> n then
          Print( "  ", r[ 1 ], " Λ", r[ 2 ], "\n" );
          Print( "  ", r[ 1 ], " |", r[ 2 ], "\n" );
          ViewObj( C^i );
          Print( "\n" );
          Print( "  ", r[ 1 ], " |", r[ 2 ], "\n\n" );
        fi;
        s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
        Print( s );
        Print( "\n" );
        ViewObj( C[ i ] );
        Print( "\n" );
        Print( Concatenation(
          ListWithIdenticalEntries(
            Length( s ) - Length( r[ 1 ] ) - Length( r[ 2 ] ) , "-" ) )
          );
        Print( "\n\n" );
      od;
      
    else
      
      for i in Reversed( [ m .. n ] ) do
        
        s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
        Print( s );
        Print( "\n" );
        ViewObj( C[ i ] );
        Print( "\n" );
        Print( Concatenation(
          ListWithIdenticalEntries(
            Length( s ) - Length( r[ 1 ] ) - Length( r[ 2 ] ), "-" ) )
          );
        Print( "\n\n" );
        if i <> m then
          Print( "  ", r[ 1 ], " |", r[ 2 ], "\n" );
          ViewObj( C^i );
          Print( "\n" );
          Print( "  ", r[ 1 ], " |", r[ 2 ], "\n" );
          Print( "  ", r[ 1 ], " V", r[ 2 ], "\n" );
          Print( "\n" );
        fi;
      od;
      
    fi;

end );

##
InstallMethod( ViewComplex,
               [ IsChainOrCochainComplex, IsInt, IsInt ],
  function( C, m, n )
    local r, co_homo, s, dashes, i;
    
    VIEW_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX( C, m, n );
    
    Print( "\nAn object in ", Name( CapCategory( C ) ), " given by the above data\n" );
         
end );

##
InstallMethod( ViewComplex,
    [ IsBoundedChainOrCochainComplex ],
  
  function( C )
    
    if ActiveUpperBound( C ) - ActiveLowerBound( C ) >= 0 then
      
      ViewComplex( C, ActiveLowerBound( C ), ActiveUpperBound( C ) );
      
    else
      
      Print( "A zero complex in ", Name( CapCategory( C ) ) );
    
    fi;
    
end );


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

##
InstallMethod( AsChainComplex, [ IsChainComplex ], IdFunc );

##
InstallMethod( AsCochainComplex, [ IsCochainComplex ], IdFunc );

##
InstallMethod( AsChainCell,
          [ IsCapCategoryCell ],
  function( cell )
    if IsCapCategoryObject( cell ) then
      return AsChainComplex( cell );
    else
      return AsChainMorphism( cell );
    fi;
end );

##
InstallMethod( AsCochainCell,
          [ IsCapCategoryCell ],
  function( cell )
    if IsCapCategoryObject( cell ) then
      return AsCochainComplex( cell );
    else
      return AsCochainMorphism( cell );
    fi;
end );

################################################
#
#  Constructors of finite (co)chain complexes
#
################################################

##
BindGlobal( "FINITE_CHAIN_OR_COCHAIN_COMPLEX",
  function( cat, diffs, N, string )
    local zero_obj, complex_constructor, func, lower_bound, upper_bound, z_func, complex;
    
    zero_obj := ZeroObject( cat );
    
    if string = "chain" then
      
      complex_constructor := ChainComplex;
      
      func := function( i )
                if i < N - 1 then
                  return UniversalMorphismIntoZeroObject( zero_obj );
                elif i = N - 1 then
                  return UniversalMorphismIntoZeroObject( Range( diffs[ 1 ] ) );
                elif i >= N and i <= N + Length( diffs ) - 1 then
                  return diffs[ i - N + 1 ]; 
                elif i = N + Length( diffs ) then
                  return UniversalMorphismFromZeroObject( Source( diffs[ Length( diffs ) ] ) );
                else
                  return UniversalMorphismFromZeroObject( zero_obj );
                fi;
              end;
      
      lower_bound := N - 1;
      
      upper_bound := N + Length( diffs ) - 1;
      
    else
      
      complex_constructor := CochainComplex;
      
      func := function( i )
                
                if i < N - 1 then
                  return UniversalMorphismFromZeroObject( zero_obj );
                elif i = N - 1 then
                  return UniversalMorphismFromZeroObject( Source( diffs[ 1 ] ) );
                elif i >= N and i <= N + Length( diffs ) - 1 then
                  return diffs[ i - N + 1 ];
                elif i = N + Length( diffs ) then
                  return UniversalMorphismIntoZeroObject( Range( diffs[ Length( diffs ) ] ) );
                else
                  return UniversalMorphismIntoZeroObject( zero_obj );
                fi;
              end;
      
      lower_bound := N;
      
      upper_bound := N + Length( diffs );

    fi;
    
    z_func := AsZFunction( func );
    
    complex := complex_constructor( cat, z_func );
    
    SetLowerBound( complex, lower_bound );
    
    SetUpperBound( complex, upper_bound );
    
    return complex;
    
end );

##
InstallMethod( ChainComplex,
          [ IsDenseList, IsInt ],
  function( diffs, n )
    local cat;
    
    cat := CapCategory( diffs[ 1 ] );
    
    return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "chain" );
    
end );

##
InstallMethod( CochainComplex,
          [ IsDenseList, IsInt ],
          
  function( diffs, n )
    local cat;
    
    cat := CapCategory( diffs[ 1 ] );
    
    return FINITE_CHAIN_OR_COCHAIN_COMPLEX( cat, diffs, n, "cochain" );
    
end );

##
InstallOtherMethod( \/,
      [ IsDenseList, IsChainOrCochainComplexCategory ],
  function( diffs_and_index, complex_cat )
    
    if not Length( diffs_and_index ) = 2 then
      
      TryNextMethod( );
      
    fi;
    
    if not IsIdenticalObj( CapCategory( diffs_and_index[ 1 ][ 1 ] ), UnderlyingCategory( complex_cat ) ) then
      
      TryNextMethod( );
      
    fi;
    
    if IsChainComplexCategory( complex_cat ) then
      return CallFuncList( ChainComplex, diffs_and_index );
    else
      return CallFuncList( CochainComplex, diffs_and_index );
    fi;
    
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
InstallMethod( StalkChainComplexOp,
          [ IsCapCategoryObject, IsInt ],
  function( obj, n )
    local complex, complex_n;
    
    complex := ChainComplex( [ UniversalMorphismIntoZeroObject( obj ) ], n );
    
    SetLowerBound( complex, n );
    
    # See IsEqualForCacheForObjects to understand why I am adding the next line
    complex_n := complex[ n ];
    
    return complex;
    
end );

##
InstallMethod( StalkCochainComplexOp,
          [ IsCapCategoryObject, IsInt ],
  function( obj, n )
    local complex, complex_n;
    
    complex := CochainComplex( [ UniversalMorphismIntoZeroObject( obj ) ], n );
    
    SetUpperBound( complex, n );
    
    # See IsEqualForCacheForObjects to understand why I am adding the next line
    complex_n := complex[ n ];
    
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
    local cat, im, inc;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not ( HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) ) then
      
      Error( "(Co)homology is computable only in complexes over abelian categories!\n" );
      
    fi;
    
    im := BoundariesAt( C, i );
    
    inc := KernelLift( C^i, im );
    
    im := CokernelObject( inc );
    
    AddToToDoList( ToDoListEntry( [ [ im, "IsZeroForObjects", false ] ],
      function( )
        
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
    
    if not IsPackageMarkedForLoading( "GeneralizedMorphismsForCAP", ">= 2019.01.16" ) then
      
      Error( "The package GeneralizedMorphismsForCAP is needed for this operation!" );
      
    fi;
    
    im := BoundariesAt( C, i );
    
    inc := KernelLift( C^i, im );
    
    pi := CokernelProjection( inc );
    
    cyc := CyclesAt( C, i );
    
    AddToToDoList( ToDoListEntry( [ [ Range( pi ), "IsZeroForObjects", false ] ],
      function( )
        
        if not HasIsExact( C ) then
          
          SetIsExact( C, false );
          
        fi;
        
      end ) );
      
    return ValueGlobal( "GeneralizedMorphismBySpan" )( cyc, pi );
    
end );

##
BindGlobal( "INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX",
  function( C, i )
    local im, inc, pi, cyc;
    
    if not IsPackageMarkedForLoading( "GeneralizedMorphismsForCAP", ">= 2019.01.16" ) then
      
      Error( "The package GeneralizedMorphismsForCAP is needed for this operation!" );
      
    fi;
   
    im := BoundariesAt( C, i );
    
    inc := KernelLift( C^i, im );
    
    pi := CokernelProjection( inc );
    
    cyc := CyclesAt( C, i );
    
    AddToToDoList( ToDoListEntry( [ [ Range( pi ), "IsZeroForObjects", false ] ],
      function( )
        
        if not HasIsExact( C ) then
          
          SetIsExact( C, false );
          
        fi;
        
      end ) );
      
    return ValueGlobal( "GeneralizedMorphismBySpan" )( pi, cyc );
    
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
InstallMethod( HomologyAtOp,
          [ IsChainComplex, IsInt ],
  HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( CohomologyAtOp,
          [ IsCochainComplex, IsInt ],
  HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( GeneralizedProjectionOntoHomologyAtOp,
          [ IsChainComplex, IsInt ],
  PROJECTION_ONTO_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( GeneralizedEmbeddingOfHomologyAtOp,
          [ IsChainComplex, IsInt ],
  INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( GeneralizedProjectionOntoCohomologyAtOp,
          [ IsCochainComplex, IsInt ],
  PROJECTION_ONTO_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
InstallMethod( GeneralizedEmbeddingOfCohomologyAtOp,
          [ IsCochainComplex, IsInt ],
  INJECTION_OF_HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX );

##
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

##
InstallMethod( IsExact,
          [ IsChainOrCochainComplex ],
  function( C )
    local i;
    
    if not HasActiveLowerBound( C ) or not HasActiveUpperBound( C ) then
      
      Error( "The complex must have upper and lower bounds" );
      
    fi;
    
    for i in [ ActiveLowerBound( C ) .. ActiveUpperBound( C ) ] do
      
      if not IsExactInIndex( C, i ) then
        
        return false;
        
      fi;
      
    od;
    
    return true;
    
end );

##
InstallMethod( IsContractable,
          [ IsChainOrCochainComplex ],
          
  C -> IsNullHomotopic( IdentityMorphism( C ) )
);

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
      
      SetUpperBound( C, ActiveLowerBound( C ) );
      
    else
      
      SetLowerBound( C, l[ 1 ] );
      
      SetUpperBound( C, l[ Length( l ) ] );
      
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
    
    return DifferentialsSupport( C, ActiveLowerBound( C ), ActiveUpperBound( C ) );
    
end );

##
InstallOtherMethod( \*,
          [ IsRingElement, IsChainOrCochainComplex ],
  function( r, C )
    local cat, diffs, rC;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    diffs := Differentials( C );
    
    diffs := ApplyMap( diffs, d -> MultiplyWithElementOfCommutativeRingForMorphisms( r, d ) );
    
    if IsChainComplex( C ) then
      
      rC := ChainComplex( cat, diffs );
      
    else
      
      rC := CochainComplex( cat, diffs );
      
    fi;
    
    if HasActiveUpperBound( C ) then
      SetUpperBound( rC, ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetLowerBound( rC, ActiveLowerBound( C ) );
    fi;
    
    return rC;
    
end );

##
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

##
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

##
InstallMethod( IsWellDefined,
          [ IsBoundedChainOrCochainComplex ],
  
  function( C )
    
    return IsWellDefined( C, ActiveLowerBound( C ), ActiveUpperBound( C ) );
    
end );

######################################
#
# Shift using lazy methods
#
######################################

##
InstallMethod( ShiftLazyOp,
          [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
    local newDifferentials, complex;
    
    newDifferentials := ApplyShift( Differentials( C ), i );
    
    if i mod 2 = 1 then
      
      newDifferentials := ApplyMap( newDifferentials, d -> -d );
      
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
    
    if HasActiveLowerBound( C ) then
      
      SetLowerBound( complex, ActiveLowerBound( C ) - i );
      
    fi;
    
    if HasActiveUpperBound( C ) then
      
      SetUpperBound( complex, ActiveUpperBound( C ) - i );
      
    else
            
    fi;
    
    return complex;
    
end );

##
InstallMethod( ShiftUnsignedLazyOp, [ IsChainOrCochainComplex, IsInt ],
  function( C, i )
    local newDifferentials, complex;
    
    newDifferentials := ApplyShift( Differentials( C ), i );
    
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
          
          return u;
          
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
    
    diffs := AsZFunction(
      function( i ) 
        if i < n  then 
          return ZeroMorphism( zero, zero );
        elif i = n then
          return ZeroMorphism( KernelObject( C^n ), zero );
        elif i = n+1 then
          return KernelLift( C^n, C^( n + 1 ) );
        else
          return C^i;
        fi;
        
      end );
      
    tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetLowerBound( tr_C, n );
    
    return tr_C;
    
end );

##
InstallMethod( GoodTruncationBelowOp,
          [ IsCochainComplex, IsInt ],
  
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := Differentials( C );
    
    diffs := AsZFunction(
      
      function( i )
        if i < n - 1 then
          
          return ZeroMorphism( zero, zero );
          
        elif i = n - 1 then
          
          return ZeroMorphism( zero, CokernelObject( KernelEmbedding( C^n ) ) );
          
        elif i = n then
          
          return CokernelColift( KernelEmbedding( C^n ), C^n );
          
        else
          
          return C^i;
          
        fi;
        
      end );
      
    tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetLowerBound( tr_C, n );
    
    return tr_C;
    
end );

##
InstallMethod( GoodTruncationAboveOp,
          [ IsChainComplex, IsInt ],
  
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := Differentials( C );
    
    diffs := AsZFunction(
      function( i )
        
        if i > n + 1  then
          
          return ZeroMorphism( zero, zero );
        
        elif i = n + 1 then
          
          return ZeroMorphism( zero, CokernelObject( KernelEmbedding( C^n ) ) );
          
        elif i = n then
          
          return CokernelColift( KernelEmbedding( C^n ), C^n  );
          
        else
          
          return C^i;
          
        fi;
        
      end );
    
    tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetUpperBound( tr_C, n );
    
    return tr_C;
    
end );

##
InstallMethod( GoodTruncationAboveOp,
          [ IsCochainComplex, IsInt ],
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := Differentials( C );
    
    diffs := AsZFunction(
      function( i )
        
        if i > n  then
          
          return ZeroMorphism( zero, zero );
          
        elif i = n then
          
          return ZeroMorphism( KernelObject( C^n ), zero );
          
        elif i = n -1 then
          
          return KernelLift( C^n, C^(n-1)  );
          
        else
          
          return C^i;
          
        fi;
        
      end );
    
    tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
    
    SetUpperBound( tr_C, n );
    
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
    
    diffs := AsZFunction(
      function( i )
        
        if i < n  then
          
          return ZeroMorphism( zero, zero ); 
          
        elif i = n then
          
          return ZeroMorphism( C[ n ], zero );
          
        else
          
          return C^i;
          
        fi;
        
      end );
      
    tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
    
    # tr_C may get better lower bound than n - 1.    
    SetLowerBound( tr_C, n );
    
    return tr_C;
    
end );

## sigma_>=n
##  <------ C_n-1 <---- C_n <---- C_n+1 <-----
##  <------ C_n-1 <---- C_n  <----   0  <-----

InstallMethod( BrutalTruncationAboveOp,
          [ IsChainComplex, IsInt ],
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := AsZFunction(
      function( i )
        
        if i >= n + 2  then
          
          return ZeroMorphism( zero, zero );
          
        elif i = n + 1 then
          
          return ZeroMorphism( zero, C[ n-1 ]  );
          
        else
          
          return C ^ i;
          
        fi;
        
      end );
      
    tr_C := ChainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetUpperBound( tr_C, n );
    
    return tr_C;
    
end );


##  -------> C_n-1 -----> C_n -----> C_n+1 ------>
##  -------> 0     -----> C_n -----> C_n+1 ------>

InstallMethod( BrutalTruncationBelowOp,
          [ IsCochainComplex, IsInt ],
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := AsZFunction(
      function( i )
        
        if i < n - 1  then
          
          return ZeroMorphism( zero, zero );
          
        elif i = n - 1 then
          
          return ZeroMorphism( zero, C[ n ] );
          
        else
          
          return C ^ i;
          
        fi;
        
      end );
    
    tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetLowerBound( tr_C, n );
    
    return tr_C;
    
end );

##  ------> C_n-1 -----> C_n -----> C_n+1 ------>
##  ------> C_n-1 -----> C_n ----->  0    ------>

InstallMethod( BrutalTruncationAboveOp,
               [ IsCochainComplex, IsInt ],
  function( C, n )
    local zero, diffs, tr_C;
    
    zero := ZeroObject( UnderlyingCategory( CapCategory( C ) ) );
    
    diffs := AsZFunction(
      function( i )
        
        if i > n then
          
          return ZeroMorphism( zero, zero );
          
        elif i = n then
          
          return ZeroMorphism( C[ n ], zero  );
          
        else
          
          return C ^ i;
          
        fi;
        
      end );
      
    tr_C := CochainComplex( UnderlyingCategory( CapCategory( C ) ), diffs );
        
    SetUpperBound( tr_C, n );
    
    return tr_C;
    
end );


##
InstallMethod( BoxProduct,
          [ IsBoundedChainComplex, IsBoundedChainComplex, IsChainComplexCategory ],
  function( C, D, category )
    local underlying_category, H, V, d;
    
    underlying_category := UnderlyingCategory( category );
    
    H := function( i, j )
      
      return BoxProduct( C^i, IdentityMorphism( D[ j ] ), underlying_category );
      
    end;
    
    V := function( i, j )
      
      if i mod 2 = 0 then
        
        return BoxProduct( IdentityMorphism( C[ i ] ), D^j, underlying_category );
        
      else
        
        return AdditiveInverse( BoxProduct( IdentityMorphism( C[ i ] ), D^j, underlying_category ) );
        
      fi;
      
    end;
    
    d := DoubleChainComplex( UnderlyingCategory( category ), H, V );
    
    SetRightBound( d, ActiveUpperBound( C ) );
    
    SetLeftBound( d, ActiveLowerBound( C ) );
    
    SetBelowBound( d, ActiveLowerBound( D ) );
    
    SetAboveBound( d, ActiveUpperBound( D ) );
    
    d := TotalComplex( d );
    
    return d;
    
end );

##
InstallMethod( SimplifyObject,
          [ IsChainOrCochainComplex, IsObject ],
  function( C, i )
    local cat, diffs, D;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    diffs := Differentials( C );
    
    diffs := ApplyMap( diffs, diff ->
               SimplifyMorphism( 
                  PreCompose(
                     [
                       SimplifyObject_IsoToInputObject( Source( diff ), i ),
                       diff,
                       SimplifyObject_IsoFromInputObject( Range( diff ), i )
                     ]
                   ), i )
              );
    
    if IsChainComplex( C ) then
      
      D := ChainComplex( cat, diffs );
      
    else
      
      D := CochainComplex( cat, diffs );
      
    fi;
    
    if HasActiveUpperBound( C ) then
      SetUpperBound( D, ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetLowerBound( D, ActiveLowerBound( C ) );
    fi;
    
    return D;
    
end, -1 );

##
InstallMethod( SimplifyObject_IsoFromInputObject,
          [ IsChainOrCochainComplex, IsObject ],
  function( C, i )
    local D, maps;
    
    D := SimplifyObject( C, i );
    
    maps := AsZFunction( j -> SimplifyObject_IsoFromInputObject( C[ j ], i ) );
    
    if IsChainComplex( C ) then
      
      return ChainMorphism( C, D, maps );
      
    else
      
      return CochainMorphism( C, D, maps );
      
    fi;
    
end, -1 );

##
InstallMethod( SimplifyObject_IsoToInputObject,
          [ IsChainOrCochainComplex, IsObject ],
  function( C, i )
    local D, maps;
    
    D := SimplifyObject( C, i );
    
    maps := AsZFunction( j -> SimplifyObject_IsoToInputObject( C[ j ], i ) );
    
    if IsChainComplex( C ) then
      
      return ChainMorphism( D, C, maps );
      
    else
      
      return CochainMorphism( D, C, maps );
      
    fi;
    
end, -1 );
