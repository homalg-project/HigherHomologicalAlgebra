# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

##
BindGlobal( "InstallOtherMethod_for_julia",
    
    function( oper, filter_list )
    
    ##
    InstallOtherMethod( oper,
              filter_list,
      
      { arg } -> CallFuncList( oper, ListN( arg, filter_list,
                    function( a, filter )
                        if filter = IsJuliaObject then
                            return ConvertJuliaToGAP( a );
                        else
                            return a;
                        fi;
                    end ) ) );
      
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

InstallOtherMethod_for_julia( CreateComplex,
          [ IsComplexesCategory, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsComplexesCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsChainOrCochainComplex, IsChainOrCochainComplex, IsJuliaObject, IsInt ] );

