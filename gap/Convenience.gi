

if not IsBound( Time ) then
  
  DeclareGlobalFunction( "Time" );
  
  ##
  InstallGlobalFunction( Time,
    function( command, arguments )
      local t0, t1;
      
      t0 := NanosecondsSinceEpoch( );
      
      CallFuncList( command, arguments );
      
      t1 := NanosecondsSinceEpoch( );
      
      return Float( ( t1 - t0 ) / 10^9 );
      
  end );
  
fi;

##
InstallMethod( \.,
        [ IsAdditiveClosureCategory, IsPosInt ],
        
  function( AC, string_as_int )
    local name, C;
    
    name := NameRNam( string_as_int );
 
    C := UnderlyingCategory( AC );
    
    if IsAlgebroid( C ) then
      return C.( name ) / AC;
    elif IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C ) then
      return C[ Int( name ) ] / AC;
    else
      Error( "Wrong input!\n" );
    fi;
    
end );

##
InstallMethod( \.,
        [ IsChainComplexCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

##
InstallMethod( \.,
        [ IsHomotopyCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

