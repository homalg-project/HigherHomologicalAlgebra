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
InstallMethod( Display,
          [ IsDerivedCategoryMorphism ],
  
  function( alpha )
    
    Print( TextAttr.b4, "The first morphism S <~~ X:", TextAttr.reset, "\n\n" );
    Display( DefiningPairOfMorphisms( alpha )[1] );
    
    Print( TextAttr.b4, "\n\nThe second morphism X --> R:", TextAttr.reset, "\n\n" );
    Display( DefiningPairOfMorphisms( alpha )[2] );
    
    Print( "\n\nA morphism in ", Name( CapCategory( alpha ) ), " defined by the pair S <~~ X --> R displayed above" );
    
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
    local pair, f, g, s, OnlyDatum, i;
    
    pair := DefiningPairOfMorphisms( phi );
    
    f := pair[1];
    g := pair[2];
    
    s := "\\begin{array}{ccccc}\n ";
    
    s := Concatenation(
            s,
            LaTeXOutput( Range( f )[ u ] ),
            "&\\leftarrow\\phantom{-}{",
            LaTeXOutput( f[ u ] : OnlyDatum := true ),
            "}\\phantom{-}-&{",
            LaTeXOutput( Source( f )[ u ] ),
            "}&-\\phantom{-}{",
            LaTeXOutput( g[ u ] : OnlyDatum := true ),
            "}\\phantom{-}\\rightarrow&{",
            LaTeXOutput( Range( g )[ u ] ),
            "}\n \\\\ \n"
          );
    
    for i in Reversed( [ l .. u - 1 ] ) do
      
      s := Concatenation(
              s,
              " \\uparrow_{\\phantom{", String( i ), "}}",
              "&&",
              " \n \\uparrow_{\\phantom{", String( i ), "}}",
              "&&",
              " \n \\uparrow_{\\phantom{", String( i ), "}}",
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
              "\\vert_{", String( i ), "} ",
              "&&",
              "\\vert_{", String( i ), "} ",
              "&&",
              "\\vert_{", String( i ), "} ",
              "\n \\\\ \n "
            );
      
      s := Concatenation(
            s,
            LaTeXOutput( Range( f )[ i ] ),
            "&\\leftarrow\\phantom{-}",
            LaTeXOutput( f[ i ] : OnlyDatum := true ),
            "\\phantom{-}-&",
            LaTeXOutput( Source( f )[ i ] ),
            "&-\\phantom{-}{",
            LaTeXOutput( g[ i ] : OnlyDatum := true ),
            "}\\phantom{-}\\rightarrow&",
            LaTeXOutput( Range( g )[ i ] ),
            "\n \\\\ \n "
          );
    
    od;
    
    s := Concatenation( s, "\\end{array}" );
    
    return s;
    
end );

