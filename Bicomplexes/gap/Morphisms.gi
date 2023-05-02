# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

##
InstallMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplex, IsFunction, IsChainOrCochainBicomplex ],
  
  MorphismConstructor );

##
InstallOtherMethod( CreateBicomplexMorphism,
          [ IsChainOrCochainBicomplex, IsFunction, IsChainOrCochainBicomplex ],
  
  MorphismConstructor );

##
InstallOtherMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplex, IsChainOrCochainMorphism, IsChainOrCochainBicomplex ],
  
  { bicomplexes_cat, source, m, range } -> ReinterpretationOfMorphism( bicomplexes_cat, source, m, range )
);

##
InstallOtherMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainMorphism ],
  
  { bicomplexes_cat, m } -> ReinterpretationOfMorphism( bicomplexes_cat,
                                CreateBicomplex( bicomplexes_cat, Source( m ) ),
                                m,
                                CreateBicomplex( bicomplexes_cat, Range( m ) ) )
);

##
InstallOtherMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplexMorphism ],
  
  { bicomplexes_cat, m } -> MorphismConstructor( bicomplexes_cat,
                                  CreateBicomplex( bicomplexes_cat, Source( m ) ),
                                  {i,j} -> MorphismFunction( m )( -i, -j ),
                                  CreateBicomplex( bicomplexes_cat, Range( m ) ) )
);

##
InstallOtherMethod( MorphismAt,
          [ IsChainOrCochainBicomplexMorphism, IsInt, IsInt ],
  
  { mor, i, j } -> MorphismFunction( mor )( i, j )
);

##
InstallMethod( ViewObj,
          [ IsChainOrCochainBicomplexMorphism ],
    
    _bicomplexes_ViewObj
);

##
InstallMethod( Display,
          [ IsChainOrCochainBicomplexMorphism ],
  
  function ( mor )
    local b, i, j;
    
    b := [ Minimum( LeftBound( Source( mor ) ), LeftBound( Range( mor ) )  ),
           Maximum( RightBound( Source( mor ) ), RightBound( Range( mor ) ) ),
           Minimum( BelowBound( Source( mor ) ), BelowBound( Range( mor ) ) ),
           Maximum( AboveBound( Source( mor ) ), AboveBound( Range( mor ) ) ) ];

    for i in [ b[1] .. b[2] ] do
      for j in [ b[3] .. b[4] ] do
        
        Print( "\n-------------------------------------------\n" );
        Print( "At Indices ", [i, j], ":" );
        Print( "\n-------------------------------------------\n" );
        
        Print( "\nMorphism:\n" );
        Display( MorphismFunction( mor )(i, j) );
        
      od;
    od;
    
    Print( "\nAn object in ", Name( CapCategory( mor ) ), " defined by the above data\n" );
    
end );

