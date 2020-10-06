# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> ProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> ProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    { alpha, bool } -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> InjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsHomotopyCategoryObject ],
  InjectiveResolution );

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> InjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  InjectiveResolution );

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    { alpha, bool } -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( HomologyAt,
          [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> HomologyAt( UnderlyingCell( a ), i )
);

##
InstallOtherMethod( ComputedHomologyAts,
          [ IsHomotopyCategoryObject ],
    a -> ComputedHomologyAts( UnderlyingCell( a ) )
);

##
InstallOtherMethod( HomologyFunctorialAt,
          [ IsHomotopyCategoryMorphism, IsInt ],
    { alpha, i } -> HomologyFunctorialAt( UnderlyingCell( alpha ), i )
);

##
InstallOtherMethod( ComputedHomologyFunctorialAts,
          [ IsHomotopyCategoryMorphism ],
    a -> ComputedHomologyFunctorialAts( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ObjectsSupport,
          [ IsHomotopyCategoryObject ],
    a -> ObjectsSupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( MorphismsSupport,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismsSupport( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( DifferentialsSupport,
          [ IsHomotopyCategoryObject ],
  a -> DifferentialsSupport( UnderlyingCell( a ) ));

##
InstallOtherMethod( HomologySupport,
          [ IsHomotopyCategoryObject ],
    a -> HomologySupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ActiveLowerBound,
          [ IsHomotopyCategoryCell ],
    a -> ActiveLowerBound( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ActiveUpperBound,
          [ IsHomotopyCategoryCell ],
    a -> ActiveUpperBound( UnderlyingCell( a ) )
);

##
InstallOtherMethod( SetLowerBound,
          [ IsHomotopyCategoryCell, IsInt ],
  function( a, n )
    
    SetLowerBound( UnderlyingCell( a ), n );
    
end );

##
InstallOtherMethod( SetUpperBound,
          [ IsHomotopyCategoryCell, IsInt ],
  function( a, n )
    
    SetUpperBound( UnderlyingCell( a ), n );
    
end );

##
InstallOtherMethod( HasActiveLowerBound,
          [ IsHomotopyCategoryCell ],
    a -> HasActiveLowerBound( UnderlyingCell( a ) )
);

##
InstallOtherMethod( HasActiveUpperBound,
          [ IsHomotopyCategoryCell ],
    a -> HasActiveUpperBound( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ActiveLowerBoundForSourceAndRange,
          [ IsHomotopyCategoryMorphism ],
    alpha -> ActiveLowerBoundForSourceAndRange( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( Objects,
              [ IsHomotopyCategoryObject ],
  a -> Objects( UnderlyingCell( a ) )
);

##
InstallOtherMethod( Differentials,
              [ IsHomotopyCategoryObject ],
  a -> Differentials( UnderlyingCell( a ) )
);

##
InstallOtherMethod( Morphisms,
              [ IsHomotopyCategoryMorphism ],
  alpha -> Morphisms( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( \*,
              [ IsRingElement, IsHomotopyCategoryObject ],
  { r, a } -> ( r * UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( BrutalTruncationAbove,
              [ IsHomotopyCategoryCell, IsInt ],
  { c, n } -> BrutalTruncationAbove( UnderlyingCell( c ), n ) / CapCategory( c )
);

##
InstallOtherMethod( BrutalTruncationBelow,
              [ IsHomotopyCategoryCell, IsInt ],
  { c, n } -> BrutalTruncationBelow( UnderlyingCell( c ), n ) / CapCategory( c )
);

##
InstallMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell ],
  c -> LaTeXOutput( UnderlyingCell( c ) )
);

##
InstallOtherMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell, IsInt, IsInt ],
  { c, l, u } -> LaTeXOutput( UnderlyingCell( c, l, u ) )
);

##
InstallMethod( LaTeXStringOp,
          [ IsHomotopyCategoryCell ],
  c -> LaTeXStringOp( UnderlyingCell( c ) )
);

##
InstallOtherMethod( LaTeXStringOp,
          [ IsHomotopyCategoryCell, IsInt, IsInt ],
  { c, l, u } -> LaTeXStringOp( UnderlyingCell( c, l, u ) )
);

