#
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
InstallMethod( Algebroid,
          [ IsQuiverAlgebra ],
          
  function( A )
    local v, algebroid, name, r;
    
    v := ValueOption( "Algebroid_ToolsForHigherHomologicalAlgebra" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
    
    algebroid := Algebroid( A : Algebroid_ToolsForHigherHomologicalAlgebra := false );
    
    if HasTensorProductFactors( A ) then
      
      name := List( TensorProductFactors( A ), Name );
      
      name := JoinStringsWithSeparator( name, "⊗ " );
      
      A!.alternative_name := name;
      
    else
      
      name := Name( A );
      
    fi;
    
    r := RandomTextColor( "" );
    
    algebroid!.Name := Concatenation( r[ 1 ], "Algebroid( ", r[ 2 ], name, r[ 1 ], " )", r[ 2 ] );
    
    return algebroid;
    
end );
