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
          [ IsCapCategoryCell ],
  function( c )
  
    if ApplicableMethod( LaTeXStringOp, [ c ], 0, 1 ) <> fail then
      
      VisualizeLaTeXString( LaTeXStringOp( c ) );
      
    elif ApplicableMethod( LaTeXOutput, [ c ], 0, 1 ) <> fail then
      
      VisualizeLaTeXString( LaTeXOutput( c ) );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( VisualizeLaTeXString,
          [ IsString ],
          
  function( str )
    local scale, dir, filename, string, x, file;
       
    scale := ValueOption( "ScaleBox" );
    
    if scale = fail then
      
      scale := "1";
      
    elif not IsString( scale ) then
      
      scale := String( scale );
      
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "main.tex" );
    
    string := Concatenation(
"""
\documentclass[12pt,makeidx]{amsbook}
\usepackage{mathtools}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{amsmath}
\usepackage[dvipsnames]{xcolor}
\setcounter{MaxMatrixCols}{100}
\begin{document}
\begin{center}
\scalebox{""",
scale,
"""}{$""",
    str,
"""$}
\end{center}
\end{document}
"""
    );
    
    file := OutputTextFile( filename, true );
    
    SetPrintFormattingStatus( file, false );
    
    PrintTo( file, string );
    
    str := "";
    
    x := Process(
            dir,
            Filename( DirectoriesSystemPrograms(), "pdflatex" ),
            InputTextUser( ),
            OutputTextString( str, true ),
            [ "-halt-on-error", "main.tex" ]
          );
          
    if x <> 0 then
      
      Error( "Something went wrong!, please check the main.tex file at ", filename );
      
    elif Filename( DirectoriesSystemPrograms(), "xdg-open" ) <> fail then
      
      Exec( Concatenation( "xdg-open ", Filename( dir, "main.pdf" ), " &" ) );
      
    else
      
      Print( Filename( dir, "main.pdf" ) );
      
    fi;
    
    return;
    
end );

