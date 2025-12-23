# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2025.12.19" ) then
    
    Error( "AutoDoc version 2025.12.19 or newer is required." );
    
fi;

AutoDoc( rec(
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc" ],
    ),
    extract_examples := rec(
        units := "Single",
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage[T1]{fontenc}
                \usepackage{microtype}
                \usepackage{amssymb}
                \usepackage{cite}
                \usepackage{mathrsfs}
                \usepackage{amsmath}
                \usepackage{mathtools}
                \usepackage{faktor}
                \usepackage{tikz-cd}
                \newcommand{\comp}[2]{ #1 \cdot #2 }
                \newcommand{\CC}{\mathscr{C}}
                \newcommand{\EE}{\mathcal{E}}
                \newcommand{\QQ}{\mathcal{Q}}
                \newcommand{\LL}{\mathcal{L}}
                \newcommand{\id}{\mathrm{id}}
                \newcommand{\Ch}[1]{\mathrm{Ch}^b(#1)}
                \newcommand{\Ho}[1]{\mathrm{K}^b(#1)}
            """,
        ),
    ),
    scaffold := rec(
        entities := rec( homalg := "homalg", CAP := "CAP" ),
    ),
) );

QUIT;
