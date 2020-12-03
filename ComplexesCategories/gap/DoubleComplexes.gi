# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

########################################
#
# Representations, families and types
#
########################################


DeclareRepresentation( "IsDoubleChainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfDoubleChainComplexes",
            NewFamily( "double chain complexes" ) );

BindGlobal( "TheTypeOfDoubleChainComplex",
            NewType( FamilyOfDoubleChainComplexes,
                     IsDoubleChainComplex and IsDoubleChainComplexRep ) );

DeclareRepresentation( "IsDoubleCochainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfDoubleCochainComplexes",
            NewFamily( "double cochain complexes" ) );

BindGlobal( "TheTypeOfDoubleCochainComplex",
            NewType( FamilyOfDoubleCochainComplexes,
                     IsDoubleCochainComplex and IsDoubleCochainComplexRep ) );

##
DeclareRepresentation( "IsDoubleChainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfDoubleChainMorphisms",
            NewFamily( "morphisms of double chain complexes" ) );

BindGlobal( "TheTypeOfDoubleChainMorphism",
            NewType( FamilyOfDoubleChainComplexes,
                     IsDoubleChainMorphism and IsDoubleChainMorphismRep ) );

##
DeclareRepresentation( "IsDoubleCochainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfDoubleCochainMorphisms",
            NewFamily( "morphisms of double cochain complexes" ) );

BindGlobal( "TheTypeOfDoubleCochainMorphism",
            NewType( FamilyOfDoubleCochainComplexes,
                     IsDoubleCochainMorphism and IsDoubleCochainMorphismRep ) );


########################################
#
# creating double chain complexes
#
########################################

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_COMPLEX",

  function( cat, h, v, name )
    local C;
    
    C := rec( IndicesOfTotalComplex := rec( ) );
    
    ObjectifyWithAttributes(
        C, ValueGlobal( name ),
        Rows, h,
        Columns, v,
        UnderlyingCategory, cat
      );
      
  return C;
    
end );


InstallMethod( DoubleChainComplex,
          [ IsCapCategory, IsZFunction, IsZFunction ],
          
  function( cat, h, v )
    
    return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( cat, h, v, "TheTypeOfDoubleChainComplex" );
    
end );

InstallMethod( DoubleCochainComplex,
          [ IsCapCategory, IsZFunction, IsZFunction ],
          
  function( cat, h, v )
    
    return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( cat, h, v, "TheTypeOfDoubleCochainComplex" );
    
end );

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS",

  function( cat, R, V, name )
    local r,v;
    
    r := AsZFunction(  j -> AsZFunction(  i -> R( i, j ) ) );
    
    v := AsZFunction(  i -> AsZFunction(  j -> V( i, j ) ) );
    
    return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( cat, r, v, name );
    
end );

InstallMethod( DoubleChainComplex,
          [ IsCapCategory, IsFunction, IsFunction ],
          
  function( cat, R, V )
    
    return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( cat, R, V, "TheTypeOfDoubleChainComplex" );
    
end );

InstallMethod( DoubleCochainComplex,
          [ IsCapCategory, IsFunction, IsFunction ],
          
  function( cat, R, V )
    
    return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( cat, R, V, "TheTypeOfDoubleCochainComplex" );
    
end );

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES",

  function( C, name )
    local cat, R, V;
    
    cat := UnderlyingCategory( UnderlyingCategory( CapCategory( C ) ) );
    
    R := { i, j } -> ( C ^ i )[ j ];
    
    V := { i, j } -> ( -1 ) ^ i * C[ i ] ^ j;
    
    return  DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( cat, R, V, name );
    
end );

InstallMethod( DoubleChainComplex,
          [ IsChainComplex ],
          
  function( C )
    local d, l;
    
    d := DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES( C, "TheTypeOfDoubleChainComplex" );
    
    AddToToDoList(
      ToDoListEntry(
          [ [ C, "HAS_FAU_BOUND", true ] ],
          function( )
            SetRightBound( d, ActiveUpperBound( C ) );
          end
      )
    );
    
    AddToToDoList(
      ToDoListEntry(
          [ [ C, "HAS_FAL_BOUND", true ] ],
          function( )
            SetLeftBound( d, ActiveLowerBound( C ) );
          end
      )
    );
    
    AddToToDoList(
      ToDoListEntry(
          [ [ C, "HAS_FAL_BOUND", true ], [ C, "HAS_FAU_BOUND", true ] ],
          function( )
            local l, ll, lu;
            l := [ ActiveLowerBound( C ) .. ActiveUpperBound( C ) ];
            lu := List( l, u -> [ C[ u ], "HAS_FAU_BOUND", true ] );
            ll := List( l, u -> [ C[ u ], "HAS_FAL_BOUND", true ] );
            
            AddToToDoList(
              ToDoListEntry(
                lu,
                function( )
                  SetAboveBound( d, Maximum( List( l, u -> ActiveUpperBound( C[ u ] ) ) ) );
                end
              )
            );
            
            AddToToDoList(
              ToDoListEntry(
                ll,
                function( )
                  SetBelowBound( d, Minimum( List( l, u -> ActiveLowerBound( C[ u ] ) ) ) );
                end
              )
            );
          end ) );

    return d;

end );


# TODO: use to do lists as above
InstallMethod( DoubleCochainComplex,
          [ IsCochainComplex ],
          
  function( C)
    local d, l;
    
    d := DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES( C, "TheTypeOfDoubleCochainComplex" );
    
    AddToToDoList(
      ToDoListEntry(
        [ [ C, "HAS_FAU_BOUND", true ] ],
        function( )
          SetRightBound( d, ActiveUpperBound( C ) );
        end
      )
    );
    
    AddToToDoList(
      ToDoListEntry(
        [ [ C, "HAS_FAL_BOUND", true ] ],
        function( )
          SetLeftBound( d, ActiveLowerBound( C ) );
        end
      )
    );
    
    AddToToDoList(
      ToDoListEntry(
        [ [ C, "HAS_FAL_BOUND", true ], [ C, "HAS_FAU_BOUND", true ] ],
        function( )
          local l, ll, lu;
          l := [ ActiveLowerBound( C ) .. ActiveUpperBound( C ) ];
          lu := List( l, u -> [ C[ u ], "HAS_FAU_BOUND", true ] );
          ll := List( l, u -> [ C[ u ], "HAS_FAL_BOUND", true ] );
          
          AddToToDoList(
            ToDoListEntry(
              lu,
              function( )
                SetAboveBound( d, Maximum( List( l, u -> ActiveUpperBound( C[ u ] ) ) ) );
              end
            )
          );
          
          AddToToDoList(
            ToDoListEntry(
              ll,
              function( ) 
                SetBelowBound( d, Minimum( List( l, u -> ActiveLowerBound( C[ u ] ) ) ) );
              end
            )
          );
          
        end ) );
        
    return d;
    
end );

##
InstallMethod( DoubleChainComplex,
          [ IsDoubleCochainComplex ],
          
  function( d )
    local R, V, dd;
    
    R := { i, j } -> HorizontalDifferentialAt(d, -i, -j );
    
    V := { i, j } -> VerticalDifferentialAt(d, -i, -j );
    
    dd := DoubleChainComplex( UnderlyingCategory( d ), R, V );
    
    if IsBound( d!.BelowBound ) then
      SetAboveBound( dd, -d!.BelowBound );
    fi;
    
    if IsBound( d!.AboveBound ) then
      SetBelowBound( dd, -d!.AboveBound );
    fi;
    
    if IsBound( d!.LeftBound ) then
      SetRightBound( dd, -d!.LeftBound );
    fi;
    
    if IsBound( d!.RightBound ) then
      SetLeftBound( dd, -d!.RightBound );
    fi;
    
    #d!.EquivalentDoubleChainComplex := dd;
    
    return dd;
    
end );

##
InstallMethod( DoubleCochainComplex,
          [ IsDoubleChainComplex ],
          
  function( d )
    local R, V, dd;
    
    R := { i, j } -> HorizontalDifferentialAt( d, -i, -j );
    
    V := { i, j } -> VerticalDifferentialAt( d, -i, -j );
    
    dd := DoubleCochainComplex( UnderlyingCategory( d ), R, V );
    
    if IsBound( d!.BelowBound ) then
      SetAboveBound( dd, - d!.BelowBound );
    fi;
    
    if IsBound( d!.AboveBound ) then
      SetBelowBound( dd, - d!.AboveBound );
    fi;
    
    if IsBound( d!.LeftBound ) then
      SetRightBound( dd, - d!.LeftBound );
    fi;
    
    if IsBound( d!.RightBound ) then
      SetLeftBound( dd, - d!.RightBound );
    fi;
    
    #d!.EquivalentDoubleCochainComplex := dd;
    
    return dd;
    
end );

##
BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_MORPHISM_BY_FUNCTION",

  function( s, r, func, name )
    local cat, phi;
    
    cat := UnderlyingCategory( s );
    
    phi := rec( );
    
    ObjectifyWithAttributes(
        phi, ValueGlobal( name ),
        Source, s,
        Range, r,
        Morphisms, AsZFunction( i -> AsZFunction( j -> func( i, j ) ) ),
        UnderlyingCategory, cat
      );
      
    return phi;
    
end );

##
InstallMethod( DoubleChainMorphism,
          [ IsDoubleChainComplex, IsDoubleChainComplex, IsFunction ],
          
  { s, r, func } ->  DOUBLE_CHAIN_OR_COCHAIN_MORPHISM_BY_FUNCTION( s, r, func, "TheTypeOfDoubleChainMorphism" )
);

##
InstallMethod( DoubleCochainMorphism,
          [ IsDoubleCochainComplex, IsDoubleCochainComplex, IsFunction ],
          
  { s, r, func } ->  DOUBLE_CHAIN_OR_COCHAIN_MORPHISM_BY_FUNCTION( s, r, func, "TheTypeOfDoubleCochainMorphism" )
);

##
InstallOtherMethod( DoubleChainMorphism,
          [ IsDoubleCochainMorphism ],
          
  function( phi )
    local dSource, dRange;
    
    dSource := DoubleChainComplex( Source( phi ) );
    
    dRange := DoubleChainComplex( Range( phi ) );
    
    return DoubleChainMorphism( dSource, dRange, { i, j } -> phi[ -i, -j ] );
    
end );

##
InstallOtherMethod( DoubleCochainMorphism,
          [ IsDoubleChainMorphism ],
          
  function( phi )
    local dSource, dRange;
    
    dSource := DoubleCochainComplex( Source( phi ) );
    
    dRange := DoubleCochainComplex( Range( phi ) );
    
    return DoubleCochainMorphism( dSource, dRange, { i, j } -> phi[ -i, -j ] );
    
end );


##
InstallOtherMethod( MorphismAt,
      [ IsDoubleChainOrCochainMorphism, IsInt, IsInt ],
  
  { phi, i, j } -> Morphisms( phi )[ i ][ j ]
);

##
InstallOtherMethod( \[\,\],
      [ IsDoubleChainOrCochainMorphism, IsInt, IsInt ],
  
  { phi, i, j } -> Morphisms( phi )[ i ][ j ]
);

###############################
#
#  methods on double complexes
#
###############################

##
InstallMethod( CertainRowOp,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, n )
    
    return Rows( C )[ n ];
    
end );

##
InstallMethod( CertainColumnOp,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, m )
    
    return Columns( C )[ m ];
    
end );

##
InstallMethod( HorizontalDifferentialAt,
          [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
          
  function( C, m, n )
    
    return CertainRow( C, n )[ m ];
    
end );

##
InstallMethod( VerticalDifferentialAt,
          [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
          
  function( C, m, n )
    
    return CertainColumn( C, m )[ n ];
    
end );

##
InstallOtherMethod( ObjectAt,
          [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
          
  { C, m, n } -> Source( HorizontalDifferentialAt( C, m, n ) )
);

##
InstallOtherMethod( \[\,\],
      [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
      
  ObjectAt
);

#####################################
#
# Computations in double complexes
#
#####################################

# concentrated in
# x0 =< x =< x1
#
BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX",

  function ( C, x0, x1 )
    local cat, diff, complex;
    
    cat := UnderlyingCategory( C );
    
    diff := AsZFunction(
          function ( m )
            local list;
            
            C!.IndicesOfTotalComplex.( String( m )) := [ x0, x1 ];
            
            list := List( [ 1 .. x1 - x0 + 1 ],
                function ( i )
                  return List( [ 1 .. x1 - x0 + 1 ],
                    function ( j )
                      local zero;
                      
                      zero := ZeroMorphism(
                                  ObjectAt( C, x0 + i - 1, m - x0 - i + 1 ),
                                  ObjectAt( C, x0 + j - 1, m - x0 - j )
                                );
                                
                      if i <> j and i - 1 <> j then
                          return zero;
                      elif i = j then
                          return VerticalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                      else
                          return HorizontalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                      fi;
                      
                    end );
                end );
                
            return MorphismBetweenDirectSums( list );
            
          end );
    
    complex := ChainComplex( cat, diff );
    
    complex!.UnderlyingDoubleComplex := C;
    
    return complex;
    
end );

# concentrated in
# y >= y0 and y =< y1
#
BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_DOUBLE_CHAIN_COMPLEX",
  function( C, y0, y1 )
    local cat, diff, complex;
    
    cat := UnderlyingCategory( C );
    
    diff := AsZFunction(
              function( m )
                local list;
                
                C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y1, m - y0 ];
                
                list := List( [ 1 .. y1 - y0 + 1 ], i -> List( [ 1 .. y1 - y0 + 1 ],
                    function( j )
                      local zero;
                      
                      zero := ZeroMorphism(
                                  ObjectAt( C, m -y1 + i - 1, y1 - i + 1  ),
                                  ObjectAt( C, m -y1 + j - 2, y1 - j + 1 )
                                );
                      
                      if i <> j and i + 1 <> j then
                          return zero;
                      elif i = j then
                          return HorizontalDifferentialAt( C, m -y1 + i - 1, y1 - i + 1 );
                      else
                          return VerticalDifferentialAt( C, m -y1 + i - 1, y1 - i + 1 );
                      fi;
                      
                    end ) );
                    
                return MorphismBetweenDirectSums( list );
                
              end );
              
    complex := ChainComplex( cat, diff );
    
    complex!.UnderlyingDoubleComplex := C;
    
    return complex;
    
end );

# concentrated in
# x >= x0 and y >= y0
#
BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_DOUBLE_CHAIN_COMPLEX",
  function( C, x0, y0 )
    local cat, diff, complex;
    
    cat := UnderlyingCategory( C ); 
    
    diff := AsZFunction(
          function( m )
            local l;
            
            if m = x0 + y0 then
               C!.IndicesOfTotalComplex.( String( m ) ) := [ x0, x0 ];
               return UniversalMorphismIntoZeroObject( ObjectAt( C, x0, y0 ) );
            elif m < x0 + y0 then
               C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y0, m - y0 ];
               return ZeroObjectFunctorial( cat );
            fi;
            
            C!.IndicesOfTotalComplex.( String( m ) ) := [ x0, m - y0 ];
            
            l := List( [ 1 .. m - x0 - y0 + 1 ], i -> List( [ 1 .. m - x0 - y0 ],
                    function( j )
                      local zero;
                      
                      zero := ZeroMorphism(
                                  ObjectAt( C, x0 + i - 1, m - x0 - i + 1  ),
                                  ObjectAt( C, x0 + j - 1, m - x0 - j )
                                );
                                
                      if i <> j and i - 1 <> j then
                        return zero;
                      elif i-1=j then
                        return HorizontalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                      else
                        return VerticalDifferentialAt(C, x0 + i - 1, m - x0 - i + 1 );
                      fi;
                      
                    end ) );
                    
            return MorphismBetweenDirectSums( l );
            
          end
        );

    complex := ChainComplex( cat, diff );
    
    complex!.UnderlyingDoubleComplex := C;
    
    SetLowerBound( complex, x0 + y0 );
     
    return complex;
    
end );

# concentrated in
# x <= x0 and y <= y0
#
BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX",

  function( C, x0, y0 )
    local cat, diff, complex;
    
    cat := UnderlyingCategory( C );
    
    diff := AsZFunction(
          function( m )
            local l;
            
            if m = x0 + y0 + 1 then
               C!.IndicesOfTotalComplex.( String( m ) ) := [ x0 + 1, x0 + 1 ];
               return UniversalMorphismFromZeroObject( ObjectAt( C, x0, y0 ) );
            elif m > x0 + y0 + 1 then
               C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y0, m - y0 ];
               return ZeroObjectFunctorial( cat );
            fi;
            
            C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y0, x0 ];
            
            l := List( [ 1 .. x0 + y0 -m + 1 ], i -> List( [ 1 .. x0 + y0 -m + 2 ],
                  function( j )
                    local zero;
                    zero := ZeroMorphism( ObjectAt( C, -y0 + m + i - 1 , y0 - i + 1  ),
                                         ObjectAt( C, -y0 + m + j - 2 , y0 - j + 1 ) );
                    if i <> j and j - 1 <> i then
                      return zero;
                    elif i = j then
                      return HorizontalDifferentialAt( C, -y0 + m + i - 1 , y0 - i + 1 );
                    else
                      return VerticalDifferentialAt( C, -y0 + m + i - 1 , y0 - i + 1 );
                    fi;
                  end ) );
                  
            return MorphismBetweenDirectSums( l );
            
          end );
          
    complex := ChainComplex( cat, diff );
    
    complex!.UnderlyingDoubleComplex := C;
    
    SetUpperBound( complex, x0 + y0 );
    
    return complex;
    
end );

InstallMethod( TotalComplex,
          [ IsDoubleChainComplex ],
          
  function( C )
    local T, T1;
    
    if IsBound( C!.RightBound ) and IsBound( C!.AboveBound ) then
       T := TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX( C, C!.RightBound, C!.AboveBound );
    fi;
    
    if IsBound( C!.LeftBound ) and IsBound( C!.BelowBound ) then
       T1 := TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_DOUBLE_CHAIN_COMPLEX( C, C!.LeftBound, C!.BelowBound );
       if IsBound( T ) then
          SetLowerBound( T, ActiveLowerBound( T1 ) );
          return T;
       else
          return T1;
       fi;
    fi;
     
    if IsBound( C!.LeftBound ) and IsBound( C!.RightBound ) then
       T := TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX( C, C!.LeftBound, C!.RightBound );
    fi;
    
    if IsBound( C!.AboveBound ) and IsBound( C!.BelowBound ) then
       T := TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_DOUBLE_CHAIN_COMPLEX( C, C!.BelowBound, C!.AboveBound );
    fi;
    
    if IsBound( T ) then
      return T;
    fi;
    
    Error( "The double chain complex does not have the required bounds" );
    
end );

##
InstallMethod( TotalMorphism,
          [ IsDoubleChainMorphism ],
  function( phi )
    local T;
    
    T := TotalMorphism(
            TotalComplex( Source( phi ) ),
            phi,
            TotalComplex( Range( phi ) )
          );
    
    return TotalMorphism( phi );
    
end );

##
InstallMethod( TotalMorphism,
          [ IsChainComplex, IsDoubleChainMorphism, IsChainComplex ],
          
  function( tSource, phi, tRange )
    local dSource, dRange, l, tphi;
    
    if HasTotalMorphism( phi ) then
      
      return TotalMorphism( phi );
      
    fi;
    
    dSource := tSource!.UnderlyingDoubleComplex;
    
    dRange := tRange!.UnderlyingDoubleComplex;
    
    l := AsZFunction(
          function( m )
            local ind_r, ind_s, morphisms;
            
            ind_s := IndicesUsedToComputeTotalComplexAt( dSource, m );
            ind_r := IndicesUsedToComputeTotalComplexAt( dRange, m );
            
            morphisms :=
              List( [ ind_s[1] .. ind_s[2] ],
                      i-> List( [ ind_r[1] .. ind_r[2] ],
                          function( j )
                            
                            if i = j then
                                return phi[ i, m - i ];
                            else
                                return ZeroMorphism( dSource[ i, m - i ], dRange[ j, m - j ] );
                            fi;
                            
                          end )
                        );
                          
            if morphisms = [] or morphisms = [[]] then
                 return ZeroMorphism( tSource[m], tRange[m] );
            else
                 return MorphismBetweenDirectSums( morphisms );
            fi;
            
          end );
          
    tphi := ChainMorphism( tSource, tRange, l );
    
    tphi!.UnderlyingDoubleComplexMorphism := phi;
    
    SetTotalMorphism( phi, tphi );
    
    return tphi;
    
end );

##
InstallMethod( TotalMorphism,
          [ IsDoubleCochainMorphism ],
          
  phi -> AsCochainMorphism( TotalMorphism( DoubleChainMorphism( phi ) ) )
);

InstallMethod( TotalComplex,
          [ IsDoubleCochainComplex ],
          
  D -> AsCochainComplex( TotalComplex( DoubleChainComplex( D ) ) )
);

##
InstallMethod( IndicesUsedToComputeTotalComplexAtOp,
          [ IsDoubleChainOrCochainComplex, IsInt ],
  
  function( D, m )
    local obj;
    
    obj := TotalComplex( D )[ m ];
    
    return D!.IndicesOfTotalComplex.( String( m ) );
    
end );

#####################################
#
# Bounds
#
#####################################

InstallMethod( SetAboveBound,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, b )
    C!.AboveBound := b;  
end );

InstallMethod( SetBelowBound,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, b )
    C!.BelowBound := b;
end );

InstallMethod( SetRightBound,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, b )
    C!.RightBound := b;
end );

InstallMethod( SetLeftBound,
          [ IsDoubleChainOrCochainComplex, IsInt ],
          
  function( C, b )
    C!.LeftBound := b;
end );

#####################################
#
# View and Display
#
#####################################

InstallMethod( ViewObj,
          [ IsDoubleChainOrCochainComplex ],
          
  function( C )
  
    if IsDoubleChainComplex( C ) then
       Print( "<A double chain complex" );
    else
       Print( "<A double cochain complex" );
    fi;

    Print( " concentrated in window [ " );

    if IsBound( C!.LeftBound ) then
       Print( C!.LeftBound, " .. " );
    else 
       Print( "-inf", " .. " );
    fi;
    
    if IsBound( C!.RightBound ) then
       Print( C!.RightBound, " ] x " );
    else 
       Print( "inf", " ] x " );
    fi;
    Print( "[ " );
    if IsBound( C!.BelowBound ) then
       Print( C!.BelowBound, " .. " );
    else 
       Print( "-inf", " .. " );
    fi;
    
    if IsBound( C!.AboveBound ) then
       Print( C!.AboveBound, " ]" );
    else 
       Print( "inf", " ]" );
    fi;
    
    Print( ">" );
 end );

