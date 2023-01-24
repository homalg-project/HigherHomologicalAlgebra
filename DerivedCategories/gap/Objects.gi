# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
InstallOtherMethod( CreateComplex,
          [ IsDerivedCategory, IsHomotopyCategoryObject ],
  
  ObjectConstructor
);

##
InstallOtherMethod( \/,
          [ IsHomotopyCategoryObject, IsDerivedCategory ],
  
  { C, derived_cat } -> ObjectConstructor( derived_cat, C )
);

##
InstallOtherMethod( \[\],
          [ IsDerivedCategoryObject, IsInt ],

ObjectAt );

##
InstallOtherMethod( \^,
          [ IsDerivedCategoryObject, IsInt ],

DifferentialAt );

##
for info in [ [ "Objects", 1 ],
              [ "ObjectAt", 2 ],
              [ "ObjectsSupport", 1 ],
              [ "Differentials", 1 ],
              [ "DifferentialAt", 2 ],
              [ "DifferentialsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyAt", 2 ],
              [ "CohomologySupport", 1 ],
              [ "HomologyAt", 2 ],
              [ "HomologySupport", 1 ],
              [ "CoboundariesAt", 2 ],
              [ "CoboundariesEmbeddingAt", 2 ],
              [ "BoundariesAt", 2 ],
              [ "BoundariesEmbeddingAt", 2 ],
              [ "CocyclesEmbeddingAt", 2 ],
              [ "CocyclesAt", 2 ],
              [ "CyclesEmbeddingAt", 2 ],
              [ "CyclesAt", 2 ],
              ] do
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if info[2] = 1 then
            return [ IsDerivedCategoryObject ];
          elif info[2] = 2 then
            return [ IsDerivedCategoryObject, IsInt ];
          fi;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    rec( oper := info[1],
                         i_args := (function()
                                      if info[2] = 1 then
                                        return "C";
                                      elif info[2] = 2 then
                                        return "{ C, i }";
                                      fi;
                                    end)(),
                         s_args := (function()
                                      if info[2] = 1 then
                                        return "UnderlyingCell( UnderlyingCell( C ) )";
                                      elif info[2] = 2 then
                                        return "UnderlyingCell( UnderlyingCell( C ) ), i";
                                      fi;
                                    end)()))));
  
od;


InstallMethod( LaTeXOutput,
              [ IsDerivedCategoryObject ],
  a -> LaTeXOutput( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ViewObj,
        [ IsDerivedCategoryObject ],

_complexes_ViewObj );

##
InstallOtherMethod( Display,
        [ IsDerivedCategoryObject ],
  
  function ( C )
    local l, u;
    
    l := LowerBound( UnderlyingCell( C ) );
    u := UpperBound( UnderlyingCell( C ) );
    
    if ForAll( [ l, u ], IsInt ) then
        Display( UnderlyingCell( UnderlyingCell( C ) ), l, u );
        Print( "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    fi;
    
end );

