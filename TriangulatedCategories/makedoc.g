#
# TriangulatedCategoriesForCAP: frame work for triangulated categories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( rec( scaffold := rec( 

         gapdoc_latex_options := rec( 
         LateExtraPreamble := "\\usepackage{amsmath}\\usepackage[T1]{fontenc}\n\\usepackage{tikz}\n\\usepackage{tikz-cd}\n\\usetikzlibrary{shapes,arrows,matrix}\n" ) 
                             ),

         autodoc := rec(
            files := [
                    "doc/intro.autodoc",
                    ]
            ) ) );
QUIT;
