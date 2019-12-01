
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
InstallMethod( FinalizeCategory,
          [ IsCapCategory, IsBool ],
  function( cat, bool )
    
    if bool then
      
      Finalize( cat );
      
    fi;
    
end );
