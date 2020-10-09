# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
#
# Visualize LaTeX stings
#
##########################

##
InstallMethod( Show,
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

