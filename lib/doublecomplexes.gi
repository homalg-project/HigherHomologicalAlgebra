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

########################################
#
# creating double chain complexes
#
########################################

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_COMPLEX",
 function( h, v, name )
 local C;

 C := rec( );

 ObjectifyWithAttributes( C, ValueGlobal( name ),

                          Rows, h,

                          Columns, v );

 return C; 

 end );


InstallMethod( DoubleChainComplex, 
               [ IsInfList, IsInfList ],
 function( h, v )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( h, v, "TheTypeOfDoubleChainComplex" );

end );

InstallMethod( DoubleCochainComplex, 
               [ IsInfList, IsInfList ],
 function( h, v )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( h, v, "TheTypeOfDoubleCochainComplex" );

end );

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS",
 function( R, V, name )
 local r,v;

 r := MapLazy( IntegersList, j -> MapLazy( IntegersList, i -> R( i, j ), 1 ), 1 );

 v := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> V( i, j ), 1 ), 1 );

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX( r, v, name );

end );

InstallMethod( DoubleChainComplex, 
               [ IsFunction, IsFunction ],
 function( R, V )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( R, V, "TheTypeOfDoubleChainComplex" );

end );

InstallMethod( DoubleCochainComplex, 
               [ IsFunction, IsFunction ],
 function( R, V )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( R, V, "TheTypeOfDoubleCochainComplex" );
 
end );

BindGlobal( "DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES",
 function( C, name )
 local R, V;

 R := function( i, j )
         return CertainDifferential( C, i )[ j ];
      end;

 V := function( i, j )
      if i mod 2 = 0 then 
         return CertainObject( C, i )^j;
      else
         return AdditiveInverseForMorphisms( C[i]^j );
      fi;
      end;

 return  DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( R, V, name );

end );

InstallMethod( DoubleChainComplex, 
               [ IsChainComplex ],
 function( C )
 local d, l;

 d := DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES( C, "TheTypeOfDoubleChainComplex" );

 AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) 
                                                                 SetRightBound( d, ActiveUpperBound( C ) - 1 );
                                                                 end ) );

 AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) 
                                                                 SetLeftBound( d, ActiveLowerBound( C ) + 1 );
                                                                 end ) );

 AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ], [ C, "HAS_FAU_BOUND", true ] ], 
                                 function( ) 
                                 local l, ll, lu;
                                 l := [ ActiveLowerBound( C ) + 1.. ActiveUpperBound( C ) - 1];
                                 lu := List( l, u -> [ C[ u ], "HAS_FAU_BOUND", true ] );
                                 ll := List( l, u -> [ C[ u ], "HAS_FAL_BOUND", true ] );
                                 AddToToDoList( ToDoListEntry( lu, function( ) 
                                                                   SetAboveBound( d, Maximum( List( l, u -> ActiveUpperBound( C[ u ] ) ) ) - 1 );
                                                                   end ) );
                                 AddToToDoList( ToDoListEntry( ll, function( ) 
                                                                   SetBelowBound( d, Minimum( List( l, u -> ActiveLowerBound( C[ u ] ) ) ) + 1 );
                                                                   end ) );
                                 end ) );

return d;
end );

InstallMethod( DoubleCochainComplex, 
               [ IsCochainComplex ],
 function( C)
 local d, l;
 
 d :=  DOUBLE_CHAIN_OR_COCHAIN_BY_COMPLEX_Of_COMPLEXES( C, "TheTypeOfDoubleCochainComplex" );
 
 if HasActiveUpperBound( C ) then 
    SetRightBound( d, ActiveUpperBound( C ) - 1 );
 fi;

 if HasActiveLowerBound( C ) then 
    SetLeftBound( d, ActiveLowerBound( C ) + 1 );
 fi;
 
 # more things can be done
 if IsBoundedChainOrCochainComplex( C ) then 
    l := [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ];
    if ForAll( l, u -> HasActiveUpperBound( C[ u ] ) ) then
       SetAboveBound( d, Maximum( List( l, u -> ActiveUpperBound( C[ u ] ) ) ) - 1 );
    fi;

    if ForAll( l, u -> HasActiveLowerBound( C[ u ] ) ) then
       SetBelowBound( d, Minimum( List( l, u -> ActiveLowerBound( C[ u ] ) ) ) + 1 );
    fi;
 fi;

 return d;
  
end );

##
InstallMethod( DoubleChainComplex,
               [ IsDoubleCochainComplex ], 
  function( d )
  local R, V, dd;
  R := function( i, j )
       return CertainHorizontalDifferential(d, -i, -j );
       end;
  V := function( i, j )
       return CertainVerticalDifferential(d, -i, -j );
       end;
  dd := DoubleChainComplex( R, V );
  
  if IsBound( d!.BelowBound ) then SetAboveBound( dd, - d!.BelowBound ); fi;
  if IsBound( d!.AboveBound ) then SetBelowBound( dd, - d!.AboveBound ); fi;
  if IsBound( d!.LeftBound ) then SetRightBound( dd, - d!.LeftBound ); fi;
  if IsBound( d!.RightBound ) then SetLeftBound( dd, - d!.RightBound ); fi;
  
  return dd;
end );

##
InstallMethod( DoubleCochainComplex,
               [ IsDoubleChainComplex ], 
  function( d )
  local R, V, dd;
  R := function( i, j )
       return CertainHorizontalDifferential( d, -i, -j );
       end;
  V := function( i, j )
       return CertainVerticalDifferential( d, -i, -j );
       end;
  dd := DoubleCochainComplex( R, V );
  
  if IsBound( d!.BelowBound ) then SetAboveBound( dd, - d!.BelowBound ); fi;
  if IsBound( d!.AboveBound ) then SetBelowBound( dd, - d!.AboveBound ); fi;
  if IsBound( d!.LeftBound ) then SetRightBound( dd, - d!.LeftBound ); fi;
  if IsBound( d!.RightBound ) then SetLeftBound( dd, - d!.RightBound ); fi;
  
  return dd;
end );

###############################
#
#  methods on double complexes
#
###############################

InstallMethod( CertainRowOp, 
               [ IsDoubleChainOrCochainComplex, IsInt ],
 function( C, n )
 return Rows( C )[ n ];
end );

InstallMethod( CertainColumnOp, 
               [ IsDoubleChainOrCochainComplex, IsInt ],
 function( C, m )
 return Columns( C )[ m ];
end );

InstallMethod( CertainHorizontalDifferential, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
return CertainRow( C, n )[ m ];
end );

InstallMethod( CertainVerticalDifferential, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
return CertainColumn( C, m )[ n ];
end );

InstallMethod( CertainObject, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
 return Source( CertainHorizontalDifferential( C, m, n ) );
end );

#####################################
#
# Computations in double complexes
#
#####################################

BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX",
function( C, x0, x1 )
local d, cat, diff;

d := CertainObject( C, 0, 0 );

cat := CapCategory( d );

diff := MapLazy( IntegersList, function( m )
                               local list;
                               list := List( [ 1 .. x1 - x0 + 1 ], i ->   List( [ 1 .. x1 - x0 + 1 ], 
                                                                     function( j )
                                                                     local zero;
                                                                     zero := ZeroMorphism( CertainObject( C, x0 + i - 1, m - x0 - i + 1  ), 
                                                                                           CertainObject( C, x0 + j - 1, m - x0 - j ) );
                                                                     if i <> j and i - 1 <> j then return zero;
                                                                     elif i = j then return CertainVerticalDifferential( C, x0 + i - 1, m - x0 - i + 1 );
                                                                     else return CertainHorizontalDifferential( C, x0 + i - 1, m - x0 - i + 1 );
                                                                     fi;
                                                                     end ) );
                               return MorphismBetweenDirectSums( list );
                               end, 1 );
return ChainComplex( cat, diff );
end );

BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_DOUBLE_CHAIN_COMPLEX",
function( C, y0, y1 )
local d, cat, diff;

d := CertainObject( C, 0, 0 );

cat := CapCategory( d );

diff := MapLazy( IntegersList, function( m )
                               local list;
                               list := List( [ 1 .. y1 - y0 + 1 ], i ->   List( [ 1 .. y1 - y0 + 1 ], 
                                                                     function( j )
                                                                     local zero;
                                                                     zero := ZeroMorphism( CertainObject( C, m -y1 + i - 1, y1 - i + 1  ), 
                                                                                           CertainObject( C, m -y1 + j - 2, y1 - j + 1 ) );
                                                                     if i <> j and i + 1 <> j then return zero;
                                                                     elif i = j then return CertainHorizontalDifferential( C, m -y1 + i - 1, y1 - i + 1 );
                                                                     else return CertainVerticalDifferential( C, m -y1 + i - 1, y1 - i + 1 );
                                                                     fi;
                                                                     end ) );
                               return MorphismBetweenDirectSums( list );
                               end, 1 );
return ChainComplex( cat, diff );
end );

# concentrated in
# x > x0 and y > y0
#
BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_DOUBLE_CHAIN_COMPLEX",
function( C, x0, y0 )
local d, cat, zero_object, diff, complex;

d := CertainObject( C, x0, y0 );
cat := CapCategory( d );
zero_object := ZeroObject( cat );

diff := MapLazy( IntegersList, function( m )
                               local l;
                               if m = x0 + y0 then 
                                  return UniversalMorphismIntoZeroObject( d );
                               elif m < x0 + y0 then
                                  return UniversalMorphismIntoZeroObject( zero_object );
                               fi;

                               l := List( [ 1 .. m - x0 - y0 + 1 ], i -> List( [ 1 .. m - x0 - y0 ], function( j )
                                                                  local zero;
                                                                  zero := ZeroMorphism( CertainObject( C, x0 + i - 1, m - x0 - i + 1  ), 
                                                                                        CertainObject( C, x0 + j - 1, m - x0 - j ) );
                                                                  if i <> j and i - 1 <> j then return zero;
                                                                  elif i-1=j then return CertainHorizontalDifferential( C, x0 + i - 1, m - x0 - i + 1 );
                                                                  else return CertainVerticalDifferential(C, x0 + i - 1, m - x0 - i + 1 );
                                                                  fi;
                                                                  end ) );
                               return MorphismBetweenDirectSums( l );
                               end, 1 );
complex := ChainComplex( cat, diff );

SetLowerBound( complex, x0 + y0 - 1 );

return complex;
end );

BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_DOUBLE_CHAIN_COMPLEX",
function( C, x0, y0 )
local d, cat, zero_object, diff, complex;
d := CertainObject( C, x0, y0 );
cat := CapCategory( d );
zero_object := ZeroObject( cat );

diff := MapLazy( IntegersList, function( m )
                               local l;
                               if m = x0 + y0 + 1 then 
                                  return UniversalMorphismFromZeroObject( d );
                               elif m > x0 + y0 + 1 then
                                  return UniversalMorphismFromZeroObject( zero_object );
                               fi;

                               l := List( [ 1 .. x0 + y0 -m + 1 ], i -> List( [ 1 .. x0 + y0 -m + 2 ], 
                                                                     function( j )
                                                                     local zero;
                                                                     zero := ZeroMorphism( CertainObject( C, -y0 + m + i - 1 , y0 - i + 1  ), 
                                                                                           CertainObject( C, -y0 + m + j - 2 , y0 - j + 1 ) );
                                                                     if i <> j and j - 1 <> i then return zero;
                                                                     elif i = j then return CertainHorizontalDifferential( C, -y0 + m + i - 1 , y0 - i + 1 );
                                                                     else return CertainVerticalDifferential( C, -y0 + m + i - 1 , y0 - i + 1 );
                                                                     fi;
                                                                     end ) );
                               return MorphismBetweenDirectSums( l );
                               end, 1 );

complex := ChainComplex( cat, diff );

SetUpperBound( complex, x0 + y0 + 1 );

return complex;

end );

InstallMethod( TotalChainComplex, 
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
 
 if IsBound( T ) then return T; fi;
 
 Error( "The double chain complex does not have the required bounds" );
  
end );

InstallMethod( TotalCochainComplex,
               [ IsDoubleCochainComplex ],
 function( d )
 local dd, T, cat, chain_cat, cochain_cat, F;

 dd := DoubleChainComplex( d );

 T := TotalChainComplex( dd );

 chain_cat := CapCategory( T );

 cat := UnderlyingCategory( chain_cat );

 cochain_cat := CochainComplexCategory( cat );

 F := ChainToCochainComplexFunctor( chain_cat, cochain_cat );

 return ApplyFunctor( F, T );

end );

#####################################
#
# Bounds
#
#####################################

InstallMethod( SetAboveBound, [ IsDoubleChainOrCochainComplex, IsInt ], function( C, u ) C!.AboveBound := u; end );
InstallMethod( SetBelowBound, [ IsDoubleChainOrCochainComplex, IsInt ], function( C, u ) C!.BelowBound := u; end );
InstallMethod( SetRightBound, [ IsDoubleChainOrCochainComplex, IsInt ], function( C, u ) C!.RightBound := u; end );
InstallMethod( SetLeftBound, [ IsDoubleChainOrCochainComplex, IsInt ],  function( C, u ) C!.LeftBound := u; end );

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
    Print( C!.LeftBound, " ... " );
 else 
    Print( "-inf", " ... " );
 fi;
 
 if IsBound( C!.RightBound ) then 
    Print( C!.RightBound, " ] X " );
 else 
    Print( "inf", " ] X " );
 fi;
 Print( "[ " );
 if IsBound( C!.BelowBound ) then 
    Print( C!.BelowBound, " ... " );
 else 
    Print( "-inf", " ... " );
 fi;
 
 if IsBound( C!.AboveBound ) then 
    Print( C!.AboveBound, " ]" );
 else 
    Print( "inf", " ]" );
 fi;
 
 Print( ">" );
 end );

