# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#



###########################################
#
# Constructors of (Co)chain complexes
#
###########################################

##
InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsList ],
  
  function( ch_cat, datum )
    
    if not ( Length( datum ) = 4 and IsZFunction( datum[1] ) and IsZFunction( datum[2] ) ) then
      Error( "the list passed to 'CreateComplex' in ", TextAttr.4, Name( ch_cat ), TextAttr.reset, " must have 4 entries and the first two entries are IsZFunction's!\n" );
    fi;
    
    return ObjectConstructor( ch_cat, datum );
    
end );

## Convenience methods
InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction, IsZFunction, IsObject, IsObject ],
  
  { ch_cat, objs, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, [ objs, diffs, lower_bound, upper_bound ] )
);

InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction, IsFunction, IsObject, IsObject ],
  
  { ch_cat, objs, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, [ AsZFunction( objs ), AsZFunction( diffs ), lower_bound, upper_bound ] )
);

##
InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction, IsObject, IsObject ],
  
  { ch_cat, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, ApplyMap( diffs, Source ), diffs, lower_bound, upper_bound )
);

##
InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction, IsObject, IsObject ],
  
  { ch_cat, diffs, lower_bound, upper_bound } -> CreateComplex( ch_cat, AsZFunction( diffs ), lower_bound, upper_bound )
);

##
InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction ],
  
  { ch_cat, diffs } -> CreateComplex(  ch_cat, diffs, -infinity, infinity )
);

##
InstallOtherMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction ],
  
  { ch_cat, diffs } -> CreateComplex(  ch_cat, AsZFunction( diffs ) )
);

##
InstallMethod( CreateComplex,
        [ IsComplexesCategoryByCochains, IsDenseList, IsInt ],
        
  function( ch_cat, diffs_list, lower_bound )
    local underlying_cat, zero_obj, upper_bound, diffs;
    
    underlying_cat := UnderlyingCategory( ch_cat );
    
    if ForAny( diffs_list, delta -> not IsIdenticalObj( CapCategory( delta ), underlying_cat ) ) then
        Error( "all morphisms in the list passed to 'CreateComplex' must belong to the category ", Name( underlying_cat ) );
    fi;
    
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
    
    return CreateComplex( ch_cat, diffs, lower_bound, upper_bound );
    
end );

##
InstallMethod( CreateComplex,
        [ IsComplexesCategoryByChains, IsDenseList, IsInt ],
        
  function( ch_cat, diffs_list, homological_index )
    local underlying_cat, zero_obj, upper_bound, diffs;
    
    underlying_cat := UnderlyingCategory( ch_cat );
    
    if ForAny( diffs_list, delta -> not IsIdenticalObj( CapCategory( delta ), underlying_cat ) ) then
        Error( "all morphisms in the list passed to 'CreateComplex' must belong to the category ", Name( underlying_cat ) );
    fi;
    
    zero_obj := ZeroObject( UnderlyingCategory( ch_cat ) );
    
    upper_bound := homological_index + Length( diffs_list ) - 1;
    
    diffs :=
      function( i )
        
        if i = homological_index - 1 then
          return UniversalMorphismIntoZeroObject( Range( diffs_list[1] ) );
        elif i >= homological_index and i <= upper_bound then
          return diffs_list[i - homological_index + 1];
        elif i = upper_bound + 1 then
          return UniversalMorphismFromZeroObject( Source( diffs_list[ Length( diffs_list ) ] ) );
        else
          return ZeroObjectFunctorial( UnderlyingCategory( ch_cat ) );
        fi;
        
      end;
    
    return CreateComplex( ch_cat, diffs, homological_index - 1, upper_bound );
    
end );

##
InstallOtherMethod( CreateComplex,
      [ IsComplexesCategory, IsCapCategoryObject, IsInt ],
  
  function ( ch_cat, o, i )
    local cat, C;
    
    cat := UnderlyingCategory( ch_cat );
    
    if not IsIdenticalObj( cat, CapCategory( o ) ) then
        Error( "the object passed in 'CreateComplex' does not belong to the underlying category of !\n", Name( ch_cat ) );
    fi;
    
    C := CreateComplex( ch_cat, [ UniversalMorphismIntoZeroObject( cat, o ) ], i );
    
    return CreateComplex( ch_cat, [ Objects( C ), Differentials( C ), i, i ] );
    
end );

##
InstallOtherMethod( \/,
      [ IsCapCategoryObject, IsComplexesCategory ],
  
  function ( o, ch_cat )
    
    if not IsIdenticalObj( CapCategory( o ), UnderlyingCategory( ch_cat ) ) then
        TryNextMethod();
    fi;
    
    return CreateComplex( ch_cat, o, 0 );
    
end );

#########################################
#
# Attributes of a (co)chain complexes
#
#########################################

##
InstallMethod( DifferentialAtOp,
               [ IsChainOrCochainComplex, IsInt ],
  
  { C, i } -> Differentials( C )[ i ]
);

##
InstallMethod( \^,
          [ IsChainOrCochainComplex, IsInt],
  
  DifferentialAt
);

##
InstallMethod( ObjectAtOp,
               [ IsChainOrCochainComplex, IsInt ],
  
  { C, i } -> Objects( C )[ i ]
);

##
InstallMethod( \[\],
          [ IsChainOrCochainComplex, IsInt ],
  
  ObjectAt
);

##
InstallMethod( ObjectsSupport,
          [ IsChainOrCochainComplex, IsInt, IsInt ],
  
  { C, m, n } -> Filtered( [ m .. n ], i -> not IsZeroForObjects( C[i] ) )
);

##
InstallMethod( ObjectsSupport,
          [ IsChainOrCochainComplex ],
  
  C -> ObjectsSupport( C, LowerBound( C ), UpperBound( C ) )
);

##
InstallMethod( DifferentialsSupport,
          [ IsChainOrCochainComplex, IsInt, IsInt ],
  
  { C, m, n } -> Filtered( [ m .. n ], i -> not IsZeroForMorphisms( C^i ) )
);

##
InstallMethod( DifferentialsSupport,
          [ IsChainOrCochainComplex ],
  
  C -> DifferentialsSupport( C, LowerBound( C ), UpperBound( C ) )
);

##
InstallMethod( CocyclesAtOp,
          [ IsCochainComplex, IsInt ],
  
  { C, i } -> KernelObject( C^i )
);

##
InstallMethod( CocyclesEmbeddingAtOp,
          [ IsCochainComplex, IsInt ],
  
  { C, i } -> KernelEmbeddingWithGivenKernelObject( C^i, CocyclesAt( C, i ) )
);

##
InstallMethod( CoboundariesAtOp,
          [ IsCochainComplex, IsInt ],
  
  { C, i } -> ImageObject( DifferentialAt( C, i - 1 ) )
);

##
InstallMethod( CoboundariesEmbeddingAtOp,
          [ IsCochainComplex, IsInt ],
  
  { C, i } -> ImageEmbeddingWithGivenImageObject( DifferentialAt( C, i - 1 ), CoboundariesAt( C, i ) )
);

##
InstallMethod( CohomologyAtOp,
          [ IsCochainComplex, IsInt ],
  
  function ( C, i )
    local cat;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not ( HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) ) then
      
      Error( "(Co)homology is computable only in abelian categories!\n" );
      
    fi;
    
    return CokernelObject( KernelLiftWithGivenKernelObject( C^i, CoboundariesEmbeddingAt( C, i ), CocyclesAt( C, i ) ) );
    
end );

##
InstallMethod( CohomologySupport,
          [ IsCochainComplex, IsInt, IsInt ],
  
  { C, m, n } -> Filtered( [ m .. n ], i -> not IsZeroForObjects( CohomologyAt( C, i ) ) )
);

##
InstallMethod( CohomologySupport,
          [ IsCochainComplex ],
  
  C -> CohomologySupport( C, LowerBound( C ), UpperBound( C ) )
);

##
InstallMethod( CyclesAtOp,
        [ IsChainComplex, IsInt ],
  
  { C, i } -> CocyclesAtOp( AsCochainComplex( C ), -i )
);

##
InstallMethod( CyclesEmbeddingAtOp,
        [ IsChainComplex, IsInt ],
  
  { C, i } -> CocyclesEmbeddingAtOp( AsCochainComplex( C ), -i )
);

##
InstallMethod( BoundariesAtOp,
        [ IsChainComplex, IsInt ],
  
  { C, i } -> CoboundariesAtOp( AsCochainComplex( C ), -i )
);

##
InstallMethod( BoundariesEmbeddingAtOp,
        [ IsChainComplex, IsInt ],
  
  { C, i } -> CoboundariesEmbeddingAtOp( AsCochainComplex( C ), -i )
);

##
InstallMethod( HomologyAtOp,
        [ IsChainComplex, IsInt ],
  
  { C, i } -> CohomologyAtOp( AsCochainComplex( C ), -i )
);

##
InstallMethod( HomologySupport,
          [ IsChainComplex, IsInt, IsInt ],
  
  { C, m, n } -> -1 * Reversed( CohomologySupport( AsCochainComplex( C ), -n, -m ) )
);

##
InstallMethod( HomologySupport,
          [ IsChainComplex ],
  
  C -> HomologySupport( C, LowerBound( C ), UpperBound( C ) )
);

##
InstallMethod( IsExact,
          [ IsCochainComplex, IsInt, IsInt ],
  
  { C, m, n } -> IsEmpty( CohomologySupport( C, m, n ) )
);

##
InstallMethod( IsExact,
          [ IsChainComplex, IsInt, IsInt ],

  { C, m, n } -> IsEmpty( HomologySupport( C, m, n ) )
);

##
InstallMethod( IsExact,
          [ IsChainOrCochainComplex ],
  
  C -> IsExact( C, LowerBound( C ), UpperBound( C ) )
);

##
InstallMethod( AsComplexOverOppositeCategory,
          [ IsCochainComplex ],
  
  function( C )
    local coch_cat_op, o, diff, B;
    
    coch_cat_op := ComplexesCategoryByCochains( Opposite( UnderlyingCategory( CapCategory( C ) ) ) );
    
    o := i -> Opposite( Objects( C )[-i] );
    
    diff := i -> Opposite( Differentials( C )[-i-1] );
    
    B := CreateComplex( coch_cat_op, o, diff, -UpperBound( C ), -LowerBound( C ) );
    
    SetAsComplexOverOppositeCategory( B, C );
    
    return B;
    
end );

##
InstallMethod( AsCochainComplex,
          [ IsChainComplex ],
  
  C -> ModelingTowerObjectConstructor( CapCategory( C ), ObjectDatum( C ) )
);

##
InstallMethod( AsChainComplex,
          [ IsCochainComplex ],
  
  function( C )
    local ch_cat;
    
    ch_cat := ComplexesCategoryByChains( UnderlyingCategory( CapCategory( C ) ) );
    
    return ObjectConstructor( ch_cat, ModelingTowerObjectDatum( ch_cat, C ) );
    
end );

#########################################
#
# Displaying, viewing (co)chain complexes
#
#########################################

BindGlobal( "_complexes_ViewObj",
  
  function ( x )
    local b, cell, i, bounds_includes_infty;
    
    b := [ LowerBound( x ), UpperBound( x ) ];
    
    bounds_includes_infty := false;
    
    for i in [ 1, 2 ] do
      
      if not IsInt( b[i] ) then
        
        bounds_includes_infty := true;
        
        if  b[i] = infinity then
          b[i] := "+∞";
        elif b[i] = -infinity then
          b[i] := "-∞";
        fi;
        
      fi;
      
    od;
    
    if IsCapCategoryObject( x ) then
        cell := "An object";
    elif IsCapCategoryMorphism( x ) then
        cell := "A morphism";
    fi;
    
    if bounds_includes_infty then
      Print( "<", cell, " in ", Name( CapCategory( x ) ), " supported on the interval [ ", b[1], " .. ", b[2], " ]>" );
    else
      Print( "<", cell, " in ", Name( CapCategory( x ) ), " supported on the interval ", [ b[1] .. b[2] ] , ">" );
    fi;
    
end );

##
InstallOtherMethod( ViewObj, [ IsChainOrCochainComplex ], _complexes_ViewObj );

##
InstallOtherMethod( Display,
        [ IsCochainComplex, IsInt, IsInt ],

  function ( C, l, u )
    local s, i;
    
    for i in Reversed( [ l .. u ] ) do
      if i <> u then
        Print( "   ", TEXTMTRANSLATIONS.curlywedge, "\n" );
        Print( "  ", " |", "\n" );
        Display( C^i );
        Print( "\n" );
        Print( "  ", " |", "\n\n" );
      fi;
      s := Concatenation( "== ", String( i ), " =======================" );
      Print( s );
      Print( "\n" );
      Display( C[i] );
      Print( Concatenation(
        ListWithIdenticalEntries(
          Length( s ), "=" ) )
        );
      Print( "\n\n" );
    od;
    
end );

##
InstallOtherMethod( Display,
        [ IsChainComplex, IsInt, IsInt ],
  
  function ( C, l, u )
    local s, i;
    
    for i in Reversed( [ l .. u ] ) do
      
      s := Concatenation( "== ", String( i ), " =======================" );
      Print( s );
      Print( "\n" );
      ViewObj( C[i] );
      Print( "\n" );
      Print( Concatenation(
        ListWithIdenticalEntries(
          Length( s ), "=" ) )
        );
      Print( "\n\n" );
      if i <> l then
        Print( "  ", " |", "\n" );
        Display( C^i );
        Print( "\n" );
        Print( "  ", " |", "\n" );
        Print( "   ", TEXTMTRANSLATIONS.curlyvee, "\n" );
        Print( "\n" );
      fi;
      
    od;
    
end );

##
InstallOtherMethod( Display,
        [ IsChainOrCochainComplex ],
        
  function ( C )
    local l, u;
    
    l := LowerBound( C );
    u := UpperBound( C );
    
    if ForAll( [ l, u ], IsInt ) then
        Display( C, l, u );
        Print( "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod();
    fi;
    
end );

##
InstallOtherMethod( LaTeXOutput,
        [ IsCochainComplex, IsInt, IsInt ],
        
  function ( C, l, u )
    local latex_string, i;
    
    latex_string := "\\begin{array}{c}\n";
    latex_string := Concatenation( latex_string, LaTeXOutput( C[ u ] ), "\n" );
    
    for i in Reversed( [ l .. u - 1 ] ) do
      
      latex_string := Concatenation( latex_string, "\\\\\n\\uparrow_{\\phantom{", String( i ), "}}\n\\\\\n" );
      latex_string := Concatenation( latex_string, LaTeXOutput( C ^ i : OnlyDatum := true ), "\n\\\\\n" );
      latex_string := Concatenation( latex_string, "{\\vert_{", String( i ), "}}\n" );
      latex_string := Concatenation( latex_string, "\n\\\\\n", LaTeXOutput( C[ i ] ) );
      
    od;
    
    return Concatenation( latex_string, "\\end{array}" );
    
end );

#
InstallOtherMethod( LaTeXOutput,
        [ IsChainComplex, IsInt, IsInt ],
  function ( C, l, u )
    local latex_string, i;
    
    latex_string := "\\begin{array}{c}\n ";
    
    for i in Reversed( [ l + 1 .. u ] ) do
      
      latex_string := Concatenation( latex_string, "\n", LaTeXOutput( C[ i ] ), "\n" );
      latex_string := Concatenation( latex_string, "\\\\\n\\vert^{", String( i ), "}\n\\\\\n" );
      latex_string := Concatenation( latex_string, LaTeXOutput( C ^ i : OnlyDatum := true ), "\n\\\\\n" );
      latex_string := Concatenation( latex_string, "{\\downarrow_{\\phantom{", String( i ), "}}}\\\\\n" );
      
    od;
    
    latex_string := Concatenation( latex_string, "\n", LaTeXOutput( C[ l ] ) );
    latex_string := Concatenation( latex_string, "\\end{array}" );
    
    return latex_string;
    
end );

##
InstallOtherMethod( LaTeXOutput,
          [ IsChainOrCochainComplex ],
  function ( C )
    local l, u;
    
    l := LowerBound( C );
    u := UpperBound( C );
    
    if ForAll( [ l, u ], IsInt ) then
        return LaTeXOutput( C, l, u );
    else
        return fail;
    fi;
    
end );

