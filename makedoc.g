#
# This file is a script which compiles the package manual.
#

if fail = LoadPackage("AutoDoc", ">= 2019.09.04") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( 
        rec(
            scaffold := rec( 
              entities := [ "GAP4", "homalg" ],
              gapdoc_latex_options := rec( 
                  LateExtraPreamble := """
                  \\usepackage{amsmath}
                  \\usepackage[T1]{fontenc}
                  \\usepackage{tikz}
                  \\usetikzlibrary{shapes,arrows,matrix}""" )
            ),
            
            autodoc := rec( files := [ "doc/Intro.autodoc" ] ),
            #extract_examples := rec( units := "Single" )
            ) 
        );

QUIT;
