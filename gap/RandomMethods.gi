#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################


##
InstallMethod( RandomObjectByList,
          [ IsHomotopyCategory, IsList ],
  { homotopy_category, L } -> RandomObjectByList( UnderlyingCategory( homotopy_category ), L ) / homotopy_category , -1
);

##
InstallMethod( RandomMorphismByList,
          [ IsHomotopyCategory, IsList ],
  { homotopy_category, L } -> RandomMorphism( UnderlyingCategory( homotopy_category ), L ) / homotopy_category, -1
);

##
InstallMethod( RandomMorphismWithFixedSourceByList,
          [ IsHomotopyCategoryObject, IsList ],
  { a, L } -> RandomMorphismWithFixedSourceByList( UnderlyingCell( a ), L ) / CapCategory( a ), -1
);

##
InstallMethod( RandomMorphismWithFixedRangeByList,
          [ IsHomotopyCategoryObject, IsList ],
  { a, L } -> RandomMorphismWithFixedRangeByList( UnderlyingCell( a ), L ) / CapCategory( a ), -1
);

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsList ],
  { a, b, L } -> RandomMorphismWithFixedSourceAndRangeByList(
                  UnderlyingCell( a ), UnderlyingCell( b ), L ) / CapCategory( a ), -1
);

##
InstallMethod( RandomObjectByInteger,
          [ IsHomotopyCategory, IsInt ],
  { homotopy_category, n } -> RandomObjectByInteger( UnderlyingCategory( homotopy_category ), n ) / homotopy_category , -1
);

##
InstallMethod( RandomMorphismByInteger,
          [ IsHomotopyCategory, IsInt ],
  { homotopy_category, n } -> RandomMorphismByInteger( UnderlyingCategory( homotopy_category ), n ) / homotopy_category, -1
);

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsHomotopyCategoryObject, IsInt ],
  { a, n } -> RandomMorphismWithFixedSourceByInteger( UnderlyingCell( a ), n ) / CapCategory( a ), -1
);

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsHomotopyCategoryObject, IsInt ],
  { a, n } -> RandomMorphismWithFixedRangeByInteger( UnderlyingCell( a ), n ) / CapCategory( a ), -1
);

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsInt ],
  { a, b, n } -> RandomMorphismWithFixedSourceAndRangeByInteger(
                  UnderlyingCell( a ), UnderlyingCell( b ), n ) / CapCategory( a ), -1
);


