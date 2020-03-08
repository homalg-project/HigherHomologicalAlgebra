
DeclareRepresentation( "IsZFunctionRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfZFunctions",
            NewFamily( "z functions" ) );


BindGlobal( "TheTypeOfZFunctions",
            NewType( FamilyOfZFunctions,
                     IsZFunction and IsZFunctionRep ) );

##
InstallMethod( AsZFunction,
          [ IsFunction ],
  function( func )
    local z_function;
    
    z_function := rec( );
    
    ObjectifyWithAttributes( z_function, TheTypeOfZFunctions,
                            UnderlyingFunction, func );
    
    return z_function;
    
end );

##
InstallMethod( ValueOp,
          [ IsZFunction, IsInt ],
  function( z_function, i )
    
    return UnderlyingFunction( z_function )( i );
    
end );

##
InstallMethod( \[\], [ IsZFunction, IsInt ],
  { z_function, i } -> Value( z_function, i )
);

##
InstallMethod( ApplyMap,
          [ IsDenseList, IsFunction ],
  function( z_functions, map )
    local z_function;
    
    z_function := AsZFunction( i -> CallFuncList( map, List( z_functions, z_function -> z_function[ i ] ) ) );
    
    SetBaseZFunctions( z_function, z_functions );
    
    SetAppliedMap( z_function, map );
    
    return z_function;
    
end );

##
InstallMethod( ApplyMap,
          [ IsZFunction, IsFunction ],
  function( z_function, map )
  
    return ApplyMap( [ z_function ], map );
    
end );

###
#InstallMethod( AsZFunction,
#          [ IsZList ],
#  l -> AsZFunction( i -> l[i] )
#);

##
InstallMethod( MapLazy,
          [ IsZFunction, IsFunction, IsInt ],
  { z_function, map, n } -> ApplyMap( z_function, map )
);

###
#InstallMethod( MapLazy,
#          [ IsZList, IsFunction, IsInt ],
#  { z_list, map, n } -> ApplyMap( AsZFunction( z_list ), map )
#, 3000 );


##
InstallMethod( Reflection,
          [ IsZFunction ],
  function( z_function )
    local reflection;
    
    reflection := AsZFunction( i -> z_function[ -i ] );
    
    SetReflection( reflection, z_function );
    
    return reflection;
    
end );

##
InstallMethod( ApplyShift,
          [ IsZFunction, IsInt ],
  { z_function, n } -> AsZFunction( i -> z_function[ i + n ] )
);

##
InstallOtherMethod( ShiftLazy, [ IsZFunction, IsInt ], ApplyShift );
#InstallOtherMethod( BaseList, [ IsZFunction ], z_function -> BaseZFunctions( z_function )[ 1 ] );
