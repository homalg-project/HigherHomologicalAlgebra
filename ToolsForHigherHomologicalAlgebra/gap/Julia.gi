#
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
#
# Visualize LaTeX stings
#
##########################

##
InstallMethod( VisualizeLaTeXString,
        [ IsString ],
        
  function( str )
    
    if not IsRunningInJupyter( ) then
        TryNextMethod( );
    fi;
    
    Julia.Base.display(
            Julia.Base.MIME( GAPToJulia( "text/latex" ) ),
            GAPToJulia( Concatenation( "\$\$", str, "\$\$" ) )
          );
          
end );

