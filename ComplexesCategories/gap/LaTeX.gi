# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
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
          
  FunctionWithNamedArguments(
    [
      [ "scale", 1 ],
      [ "width", Immutable( "10in" ) ],
      [ "height", Immutable( "15in" ) ],
    ],
    function( CAP_NAMED_ARGUMENTS, str )
      local dir, filename, string, file, x;
      
      dir := DirectoryTemporary();
      
      filename := Filename( dir, "main.tex" );
      
      string := Concatenation(
"""
\documentclass{article}
\usepackage{geometry}
% Set custom paper size
\geometry{paperwidth=""", CAP_NAMED_ARGUMENTS.width, ", paperheight=", CAP_NAMED_ARGUMENTS.height, """, margin=1in}
\usepackage{mathtools}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{amsmath}
\usepackage[dvipsnames]{xcolor}
\setcounter{MaxMatrixCols}{100}
\begin{document}
\begin{center}
\scalebox{""",
String( CAP_NAMED_ARGUMENTS.scale ),
"""}{
\(""",
    str,
"""\)
}
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
              InputTextNone( ),
              OutputTextNone( ),
              [ "-interaction=nonstopmode", "-halt-on-error", "main.tex" ] );
            
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
    
end )  );

##
InstallMethod( Show,
          [ IsCapCategoryCell ],
          
  function( c )
    
    Show( LaTeXOutput( c ) );
    
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
