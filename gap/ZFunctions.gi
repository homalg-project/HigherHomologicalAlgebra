
DeclareRepresentation( "IsZFunctionRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfZFunctions",
            NewFamily( "z functions" ) );


BindGlobal( "TheTypeOfZFunctions",
            NewType( FamilyOfZFunctions,
                     IsZFunction and IsZFunctionRep ) );

##
InstallGlobalFunction( VoidZFunction,
  function( )
    local z_function;
    
    z_function := rec( );
    
    ObjectifyWithAttributes( z_function, TheTypeOfZFunctions );
    
    return z_function;
    
end );


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
InstallMethod( ZFunctionWithInductiveSides,
          [ IsInt, IsObject, IsFunction, IsFunction, IsFunction ],
  function( N, val, neg_side_func, pos_side_func, compare_func )
    local z_function, func;
    
    z_function := VoidZFunction( );
    
    SetFilterObj( z_function, IsZFunctionWithInductiveSides );
    
    func :=
      function( i )
        local prev_value, value;
        
        if i > N then
          
          if HasStablePosValue( z_function ) then
            
            return StablePosValue( z_function );
            
          else
            
            prev_value := z_function[ i - 1 ];
            
            value := pos_side_func( prev_value );
            
            if compare_func( value, prev_value ) then
              
              SetStablePosValue( z_function, value );
              
            fi;
            
            return value;
            
          fi;
          
        elif i < N then
          
          if HasStableNegValue( z_function ) then
            
            return StableNegValue( z_function );
            
          else
            
            prev_value := z_function[ i + 1 ];
            
            value := neg_side_func( prev_value );
            
            if compare_func( value, prev_value ) then
              
              SetStableNegValue( z_function, value );
              
            fi;
            
            return value;
            
          fi;
          
        else
          
          return val;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_function, func );
    SetFirstIndex( z_function, N );
    SetFirstValue( z_function, val );
    SetPosFunction( z_function, pos_side_func );
    SetNegFunction( z_function, neg_side_func );
    SetCompareFunction( z_function, compare_func );
    
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

##
InstallMethod( CombineZFunctions,
          [ IsList ],
  function( L )
    return ApplyMap( L, function( arg ) return arg; end );
end );

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
InstallMethod( ApplyShiftOp,
          [ IsZFunction, IsInt ],
  { z_function, n } -> AsZFunction( i -> z_function[ i + n ] )
);

##
InstallOtherMethod( ShiftLazy, [ IsZFunction, IsInt ], ApplyShift );
#InstallOtherMethod( BaseList, [ IsZFunction ], z_function -> BaseZFunctions( z_function )[ 1 ] );
