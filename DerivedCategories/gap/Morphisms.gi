# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
InstallOtherMethod( CreateComplexMorphism,
          [ IsDerivedCategoryObject, IsHomotopyCategoryMorphism, IsDerivedCategoryObject ],
  
  { B, alpha, C } -> MorphismConstructor( B, [ IdentityMorphism( Source( alpha ) ), alpha ], C )
);

##
InstallOtherMethod( \/,
          [ IsHomotopyCategoryMorphism, IsDerivedCategory ],
  
  { alpha, derived_cat } -> CreateComplexMorphism( ObjectConstructor( derived_cat, Source( alpha ) ), alpha, ObjectConstructor( derived_cat, Range( alpha ) ) )
);

##
InstallMethod( DisplayString,
          [ IsDerivedCategoryMorphism ],
  
  function( alpha )
    local str;
    
    str := "The first morphism S <~~ X: \n\n";
    str := Concatenation( str, DisplayString( DefiningPairOfMorphisms( alpha )[1] ) );
    
    str := Concatenation( str, "\n\nThe second morphism X --> R: \n\n" );
    str := Concatenation( str, DisplayString( DefiningPairOfMorphisms( alpha )[2] ) );
    
    return Concatenation( str, "\n\nA morphism in ", Name( CapCategory( alpha ) ), " defined by the pair S <~~ X --> R displayed above\n" );
    
end );

##
InstallMethod( LaTeXOutput,
        [ IsDerivedCategoryMorphism ],
        
  function( phi )
    local pair, q, r, l, u;
    
    pair := DefiningPairOfMorphisms( phi );
    
    q := pair[1];
    r := pair[2];
    
    l := Minimum(
            [
              LowerBound( Range( q ) ),
              LowerBound( Source( q ) ),
              LowerBound( Range( r ) )
            ]
          );
    
    u := Maximum(
            [
              UpperBound( Range( q ) ),
              UpperBound( Source( q ) ),
              UpperBound( Range( r ) )
            ]
          );
    
    return LaTeXOutput( phi, l, u );
    
end );

##
InstallOtherMethod( LaTeXOutput,
        [ IsDerivedCategoryMorphism, IsInt, IsInt ],
        
  function( phi, l, u )
    local pair, f, g, s, i;
    
    pair := DefiningPairOfMorphisms( phi );
    
    f := pair[1];
    g := pair[2];
    
    s := Concatenation( "\\begin", LATEX_LBRACE, "array", LATEX_RBRACE, LATEX_LBRACE, "ccccc", LATEX_RBRACE, "\n " );
    
    s := Concatenation(
            s,
            LaTeXOutput( Range( f )[ u ] ),
            "&\\leftarrow\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, LATEX_LBRACE,
            LaTeXOutput( f[ u ] : OnlyDatum := true ),
            LATEX_RBRACE, "\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, "-&", LATEX_LBRACE,
            LaTeXOutput( Source( f )[ u ] ),
            LATEX_RBRACE, "&-\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, LATEX_LBRACE,
            LaTeXOutput( g[ u ] : OnlyDatum := true ),
            LATEX_RBRACE, "\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, "\\rightarrow&", LATEX_LBRACE,
            LaTeXOutput( Range( g )[ u ] ),
            LATEX_RBRACE, "\n \\\\ \n"
          );
    
    for i in Reversed( [ l .. u - 1 ] ) do
      
      s := Concatenation(
              s,
              " \\uparrow_", LATEX_LBRACE, "\\phantom", LATEX_LBRACE, String( i ), LATEX_RBRACE, LATEX_RBRACE,
              "&&",
              " \n \\uparrow_", LATEX_LBRACE, "\\phantom", LATEX_LBRACE, String( i ), LATEX_RBRACE, LATEX_RBRACE,
              "&&",
              " \n \\uparrow_", LATEX_LBRACE, "\\phantom", LATEX_LBRACE, String( i ), LATEX_RBRACE, LATEX_RBRACE,
              "\n \\\\ \n "
            );
      
      s := Concatenation(
              s,
              LaTeXOutput( Range( f ) ^ i : OnlyDatum := true ),
              "&&",
              LaTeXOutput( Source( f ) ^ i : OnlyDatum := true ),
              "&&",
              LaTeXOutput( Range( g ) ^ i : OnlyDatum := true ),
              "\n \\\\ \n "
            );
      
      s := Concatenation(
              s,
              "\\vert_", LATEX_LBRACE, String( i ), LATEX_RBRACE, " ",
              "&&",
              "\\vert_", LATEX_LBRACE, String( i ), LATEX_RBRACE, " ",
              "&&",
              "\\vert_", LATEX_LBRACE, String( i ), LATEX_RBRACE, " ",
              "\n \\\\ \n "
            );
      
      s := Concatenation(
            s,
            LaTeXOutput( Range( f )[ i ] ),
            "&\\leftarrow\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE,
            LaTeXOutput( f[ i ] : OnlyDatum := true ),
            "\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, "-&",
            LaTeXOutput( Source( f )[ i ] ),
            "&-\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, LATEX_LBRACE,
            LaTeXOutput( g[ i ] : OnlyDatum := true ),
            LATEX_RBRACE, "\\phantom", LATEX_LBRACE, "-", LATEX_RBRACE, "\\rightarrow&",
            LaTeXOutput( Range( g )[ i ] ),
            "\n \\\\ \n "
          );
    
    od;
    
    s := Concatenation( s, "\\end", LATEX_LBRACE, "array", LATEX_RBRACE );
    
    return s;
    
end );

