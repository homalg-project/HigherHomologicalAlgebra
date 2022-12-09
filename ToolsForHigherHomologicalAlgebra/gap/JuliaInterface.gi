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
InstallGlobalFunction( InstallOtherMethod_for_julia,
  function( oper, filter_list )
    
    ##
    InstallOtherMethod( oper,
              filter_list,
      
      { arg } -> CallFuncList( oper, ListN( arg, filter_list, function( a, filter ) if filter = IsJuliaObject then return ConvertJuliaToGAP( a ); fi; return a; end ) ) );
      
end );

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

