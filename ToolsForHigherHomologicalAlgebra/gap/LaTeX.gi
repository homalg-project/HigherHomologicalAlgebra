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
          [ IsCapCategoryCell ],
  function( c )
    
  if ApplicableMethod( LaTeXOutput, [ c ], 0, 1 ) <> fail then
      
      Show( LaTeXOutput( c ) );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallOtherMethod( Show,
          [ IsCapCategoryCell, IsObject ],
  function( c, r )
    
    Show( c : ScaleBox := r );
    
end );

##
InstallOtherMethod( Show,
          [ IsString, IsObject ],
  function( c, r )
    
    Show( c : scale := r );
    
end );

##
InstallMethod( Show,
          [ IsString ],
          
  function( str )
    local scale, width, height, dir, filename, string, file, x;
    
    scale := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "scale", "1" );
    width := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "width", "10in" );
    height := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "height", "15in" );
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "main.tex" );
    
    string := Concatenation(
"""
\documentclass{article}
\usepackage{geometry}
% Set custom paper size
\geometry{paperwidth=""", width, ", paperheight=", height, """, margin=1in}
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
      
    elif Filename( DirectoriesSystemPrograms(), "open" ) <> fail then
      
      Exec( Concatenation( "open ", Filename( dir, "main.pdf" ), " &" ) );
      
    else
      
      Print( Filename( dir, "main.pdf" ) );
      
    fi;
    
    return;
    
end );

