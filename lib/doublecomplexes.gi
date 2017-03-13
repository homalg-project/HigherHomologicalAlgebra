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

 r := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> R(i,j ), 1 ), 1 );

 v := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> V(i,j ), 1 ), 1 );

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

BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_FIRST_QUADRANT_DOUBLE_CHAIN_COMPLEX",
function( C )
local d, cat, zero_object, diff;

d := CertainObject( C, 0, 0 );
cat := CapCategory( d );
zero_object := ZeroObject( cat );

diff := MapLazy( IntegersList, function( m )
                               local l;
                               if m = 0 then 
                                  return UniversalMorphismIntoZeroObject( d );
                               elif m < 0 then
                                  return UniversalMorphismIntoZeroObject( zero_object );
                               fi;

                               l := List( [ 1 .. m + 1 ], i -> List( [ 1 .. m ], function( j )
                                                                         local zero;
                                                                         zero := ZeroMorphism( CertainObject( C, i - 1, m - i + 1  ), CertainObject( C, j - 1, m - j ) );
                                                                         if i <> j and i - 1 <> j then return zero;
                                                                         elif i-1=j then return CertainRowMorphism( C, i - 1, m - i + 1 );
                                                                         else return CertainColumnMorphism(C, i - 1, m - i + 1 );
                                                                         fi;
                                                                         end ) );
                               return MorphismBetweenDirectSums( l );
                               end, 1 );
return ChainComplex( cat, diff );
end );

BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_THIRD_QUADRANT_DOUBLE_CHAIN_COMPLEX",
function( C )
local d, cat, zero_object, diff;

d := CertainObject( C, 0, 0 );
cat := CapCategory( d );
zero_object := ZeroObject( cat );

diff := MapLazy( IntegersList, function( m )
                               local l;
                               if m = 1 then 
                                  return UniversalMorphismFromZeroObject( d );
                               elif m > 1 then
                                  return UniversalMorphismFromZeroObject( zero_object );
                               fi;

                               l := List( [ 1 .. -m + 1 ], i -> List( [ 1 .. -m + 2 ], 
                                                                     function( j )
                                                                     local zero;
                                                                     zero := ZeroMorphism( CertainObject( C, m + i - 1 , - i + 1  ), CertainObject( C, m + j - 2, 1 - j ) );
                                                                     if i <> j and j - 1 <> i then return zero;
                                                                     elif i = j then return CertainRowMorphism( C, m + i - 1 , - i + 1 );
                                                                     else return CertainColumnMorphism( C, m + i - 1 , - i + 1 );
                                                                     fi;
                                                                     end ) );
                               return MorphismBetweenDirectSums( l );
                               end, 1 );
return ChainComplex( cat, diff );
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
    Print( "<A double chain complex>" );
 else
    Print( "A double cochain cochain>" );
 fi;
 end );

