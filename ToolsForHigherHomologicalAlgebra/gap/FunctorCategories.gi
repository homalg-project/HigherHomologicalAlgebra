# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#


EnhancePackage( "LinearAlgebraForCAP" );

##
InstallMethod( LaTeXStringOp,
          [ IsCapCategoryObjectInHomCategory ],
          
  function( F )
    local objects, g_morphisms, s, o, m;
    
    objects := List( SetOfObjects( F ), o -> [ o, ApplyCell( F, o ) ] );
    
    g_morphisms := List( SetOfGeneratingMorphisms( F ), m -> [ m, ApplyCell( F, m ) ] );
    
    s := "\\begin{array}{ccc}\n ";
    
    for o in objects do
      
      s := Concatenation(
              s,
              LaTeXStringOp( o[ 1 ] ),
              " & \\mapsto & ",
              LaTeXStringOp( o[ 2 ] ),
              " \\\\ "
            );
      
    od;
    
    s := Concatenation( s, "\\hline & & \\\\" );
    
    for m in g_morphisms do
      
      s := Concatenation(
              s,
              LaTeXStringOp( m[ 1 ] : OnlyDatum := true ),
              " & \\mapsto & ",
              LaTeXStringOp( m[ 2 ] : OnlyDatum := true ),
              " \\\\ & & \\\\"
            );
    od;
   
    s := Concatenation( s, "\\end{array}" );
    
    return s;
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsCapCategoryMorphismInHomCategory ],
          
  function( eta )
    local morphisms, only_datum, s, OnlyDatum, o;
    
    morphisms := List( SetOfObjects( eta ), o -> [ o, ApplyCell( eta, o ) ] );
     
    only_datum := ValueOption( "OnlyDatum" );
    
    s := "\\begin{array}{ccc}\n";
    
    if only_datum <> true then
      
      for o in morphisms do
        
        s := Concatenation(
                s,
                LaTeXStringOp( o[ 2 ] : OnlyDatum := true ),
                " \\\\ & & \\\\"
              );
        
      od;
      
    else
      
      for o in morphisms do
        
        s := Concatenation(
                s,
                LaTeXStringOp( o[ 1 ] ),
                " & \\mapsto & ",
                LaTeXStringOp( o[ 2 ] : OnlyDatum := true ),
                " \\\\ & & \\\\"
              );
        
      od;
    
    fi;
    
    s := Concatenation( s, "\\end{array}" );
    
    s := Concatenation( "{\\color{blue}", s, "}" );
     
    if only_datum = true then
      
      return s;
      
    else
      
      return Concatenation(
                LaTeXStringOp( Source( eta ) ),
                "\\xrightarrow{",
                s,
                "}",
                LaTeXStringOp( Range( eta ) )
              );
      
    fi;
    
end );
