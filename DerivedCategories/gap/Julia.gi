# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
InstallMethod( CreateStrongExceptionalCollection,
        [ IsObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateStrongExceptionalCollection( full, ConvertJuliaToGAP( vertices_labels ) );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
        [ IsJuliaObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateStrongExceptionalCollection( ConvertJuliaToGAP( full ), ConvertJuliaToGAP( vertices_labels ) );
    
end );

##
InstallOtherMethod( CreateStrongExceptionalCollection,
        [ IsJuliaObject, IsJuliaObject, IsJuliaObject ],
        
  function( full, vertices_labels, vertices_latex )
    
    return CreateStrongExceptionalCollection(
                ConvertJuliaToGAP( full ),
                ConvertJuliaToGAP( vertices_labels ),
                ConvertJuliaToGAP( vertices_latex )
           );
    
end );

##
InstallOtherMethod( Show,
    [ IsAlgebroid ],
  function( algebroid )
    local q, str;
    
    if not IsRunningInJupyter( ) then
        TryNextMethod( );
    fi;
    
    q := UnderlyingQuiver( algebroid );
    
    str := String( List( [ 1 .. NumberOfVertices( q ) ], i -> ArrowTargetIndices( q ){Positions( ArrowSourceIndices( q ), i )} ) );
    
    Julia.Base.display(
            Julia.Base.MIME( GAPToJulia( "text/html" ) ),
            ValueGlobal( "JuliaEvalString" )(
                Concatenation(
                    "graphplot(",
                    str,
                    ", names=",
                    String( List(  VertexLabels( q ), v -> Concatenation( " ", String( v ), " " ) ) ),
                    ", nodeshape=:circle, fontsize=10)"
                )
            )
        );
    
end );
