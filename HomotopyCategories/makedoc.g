# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
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
                \usepackage{tikz}
                \usepackage{fancyvrb}
                \usepackage{fvextra}
                \fvset{breaklines=true}
                \usetikzlibrary{shapes,arrows,matrix}
                \DeclareUnicodeCharacter{2C76}{\ensuremath{\vdash}\!\!}
                \DeclareUnicodeCharacter{2192}{\ensuremath{\!\!\rightarrow\!}}
                \DeclareUnicodeCharacter{27F6}{\ensuremath{\!\!\longrightarrow\!}}
                \DeclareUnicodeCharacter{21AA}{\ensuremath{\!\!\hookrightarrow\!}}
                \DeclareUnicodeCharacter{21A0}{\ensuremath{\!\!\twoheadrightarrow\!}}
                \DeclareUnicodeCharacter{2B47}{\ensuremath{\!\!\xrightarrow{\sim}\!}}
                \DeclareUnicodeCharacter{27F9}{\ensuremath{\!\!\Rightarrow\!}}
                \DeclareUnicodeCharacter{22A3}{\ensuremath{\!\!\dashv\!}}
                \DeclareUnicodeCharacter{03F5}{\ensuremath{\!\!\epsilon\!}}
                \DeclareUnicodeCharacter{2218}{\ensuremath{\!\!\circ\!}}
                \DeclareUnicodeCharacter{227B}{\ensuremath{\succ}}
                \DeclareUnicodeCharacter{22C5}{\ensuremath{\cdot}}
                \usetikzlibrary{shapes,arrows,matrix}
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP" ],
    ),
) );

QUIT;
