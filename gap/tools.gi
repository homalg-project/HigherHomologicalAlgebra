
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

if not IsBound( CheckNaturality ) then
  
  DeclareGlobalFunction( "CheckNaturality" );
  
  ##
  InstallGlobalFunction( CheckNaturality,
    function( eta, alpha )
      local S, R;
      
      S := Source( eta );
      
      R := Range( eta );
      
      return IsCongruentForMorphisms(
                PreCompose( ApplyFunctor( S, alpha ), ApplyNaturalTransformation( eta, Range( alpha ) ) ),
                PreCompose( ApplyNaturalTransformation( eta, Source( alpha ) ), ApplyFunctor( R, alpha ) )
              );
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
