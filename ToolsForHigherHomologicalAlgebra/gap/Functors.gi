




##
InstallMethod( AddSomeFunctor,
          [ IsObject, IsObject, IsFunction, IsFunction, IsString ],
          
  function( F1, F2, F3, F4, F5 )
  
    AddSomeFunctor( [ F1, F2, F3, F4, F5 ] );
  
end );

##
InstallMethod( AddSomeFunctor,
          [ IsDenseList ],
  function( F )
    
    if Size( F ) <> 5 then
      
      Error( "The list should contain 5 entries" );
      
    fi;
    
    ##
    InstallMethod( SomeFunctor,
                F[ 5 ],
              [ F[ 1 ], F[ 2 ] ],
              
          function( c1, c2 )
            
            if not F[ 3 ]( c1, c2 ) then
              
              TryNextMethod( );
              
            else
              
              return F[ 4 ]( c1, c2 );
              
            fi;
            
          end );
          
end );

##
AddSomeFunctor(
    IsCapCategory,
    IsCapCategory,
    IsIdenticalObj,
    { c1, c2 } -> IdentityFunctor( c1 ),
    "Identity functor"
);
