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
               [ IsInfList, IsInfList ],
 function( R, V )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( R, V, "TheTypeOfDoubleChainComplex" );

end );

InstallMethod( DoubleCochainComplex, 
               [ IsInfList, IsInfList ],
 function( R, V )

 return DOUBLE_CHAIN_OR_COCHAIN_COMPLEX_BY_TWO_FUNCTIONS( R, V, "TheTypeOfDoubleCochainComplex" );
 
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

