#
# Bicomplexes: Bicomplexes for Abelian categories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2019.04.10") then
    Error("AutoDoc version 2019.04.10 or newer is required.");
fi;

AutoDoc( 
        rec(
            scaffold := rec( gapdoc_latex_options := rec( 
                             LateExtraPreamble := "\\usepackage{amsmath}\\usepackage[T1]{fontenc}\n\\usepackage{tikz}\n\\usetikzlibrary{shapes,arrows,matrix}\n\\usepackage{faktor}" 
                                                        ),
                             entities := [ "GAP4", "homalg", "CAP" ],
                             ),
            
            autodoc := rec( files := [ "doc/Doc.autodoc" ] ),

#            maketest := rec( folder := ".",
#                             commands :=
#                             [ "LoadPackage( \"Bicomplexes\" );",
#                               "LoadPackage( \"M2\" );",
#                             ],
#                             compareFunction := function(s,t) return true;end,
#                           ),

            extract_examples := rec( units := "Single" ),
            )
);

QUIT;
