# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
fi;

AutoDoc( rec(
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc", "examples/doc/verbatims" ],
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
            \newcommand{\comp}[2]{#1 \cdot #2}
            \newcommand{\CC}{\mathscr{C}}
            \newcommand{\EE}{\mathcal{E}}
            \newcommand{\QQ}{\mathcal{Q}}
            \newcommand{\LL}{\mathcal{L}}
            \newcommand{\id}{\mathrm{id}}
            \newcommand{\Ch}[1]{\mathrm{Ch}^b(#1)}
            \newcommand{\Ho}[1]{\mathrm{K}^b(#1)}
            \definecolor{colorcomment}{rgb}{0.52, 0.52, 0.51}
            \newcommand{\ccomment}[1]{{\color{colorcomment}{\textit{#1}}}}
            \definecolor{colorint}{rgb}{0.52, 0.52, 0.51}
            \newcommand{\cint}[1]{{\color{colorint}{#1}}}
            \definecolor{colorbracket}{rgb}{0.13, 0.67, 0.8}
            \newcommand{\cbracket}[1]{{\color{colorbracket}{#1}}}
            %%\definecolor{colorstring}{rgb}{0.76, 0.13, 0.28}
            \definecolor{colorstring}{rgb}{0.0, 0.42, 0.24}
            \newcommand{\cstring}[1]{{\color{colorstring}{#1}}}
            \definecolor{colorequlity}{rgb}{0.0, 0.42, 0.24}
            \newcommand{\cequality}[1]{{\color{colorequlity}{#1}}}
            \definecolor{colorkey}{rgb}{0.6, 0.0, 0.0}
            %
            %\usepackage[scaled]{beramono}
            %\newcommand{\ckey}[1]{{\textbf{\color{colorkey}{#1}}}}
            %
            \newcommand{\ckey}[1]{{\color{colorkey}{#1}}}
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP" ],
    ),
) );

QUIT;
