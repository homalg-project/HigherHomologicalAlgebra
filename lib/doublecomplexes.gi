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


InstallMethod( CertainRow, 
               [ IsDoubleChainOrCochainComplex, IsInt ],
 function( C, n )
 return Rows( C )[ n ];
end );

InstallMethod( CertainColumn, 
               [ IsDoubleChainOrCochainComplex, IsInt ],
 function( C, m )
 return Columns( C )[ m ];
end );

InstallMethod( CertainRowMorphism, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
return CertainRow( C, n )[ m ];
end );

InstallMethod( CertainColumnMorphism, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
return CertainColumn( C, m )[ n ];
end );

InstallMethod( CertainObject, 
               [ IsDoubleChainOrCochainComplex, IsInt, IsInt ],
 function( C, m, n )
 return Source( CertainRowMorphism( C, m, n ) );
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
                                                                     elif i = j then return CertainColumnMorphism( C, x0 + i - 1, m - x0 - i + 1 );
                                                                     else return CertainRowMorphism( C, x0 + i - 1, m - x0 - i + 1 );
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
                                                                     elif i = j then return CertainRowMorphism( C, m -y1 + i - 1, y1 - i + 1 );
                                                                     else return CertainColumnMorphism( C, m -y1 + i - 1, y1 - i + 1 );
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
                                                                  elif i-1=j then return CertainRowMorphism( C, x0 + i - 1, m - x0 - i + 1 );
                                                                  else return CertainColumnMorphism(C, x0 + i - 1, m - x0 - i + 1 );
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
                                                                     elif i = j then return CertainRowMorphism( C, -y0 + m + i - 1 , y0 - i + 1 );
                                                                     else return CertainColumnMorphism( C, -y0 + m + i - 1 , y0 - i + 1 );
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
    Print( "<A double chain complex>" );
 else
    Print( "A double cochain cochain>" );
 fi;
 end );

