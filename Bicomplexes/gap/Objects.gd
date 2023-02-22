# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Declarations
#

#! @Chapter Constructors

#! @Section Constructing objects

#! @Description
#!  GAP-categories of the chain or cochain complexes.
#! @Arguments C
DeclareCategory( "IsChainOrCochainBicomplex", IsCapCategoryObject );

#! @Description
#!  GAP-categories of the chain complexes.
#! @Arguments C
DeclareCategory( "IsCochainBicomplex", IsChainOrCochainBicomplex );

#! @Description
#!  GAP-categories of the cochain complexes.
#! @Arguments C
DeclareCategory( "IsChainBicomplex", IsChainOrCochainBicomplex );

DeclareOperation( "CreateBicomplex",
      [ IsBicomplexesCategory, IsList ] );

DeclareAttribute( "ObjectFunction", IsChainOrCochainBicomplex );
DeclareAttribute( "HorizontalDifferentialFunction", IsChainOrCochainBicomplex );
DeclareAttribute( "VerticalDifferentialFunction", IsChainOrCochainBicomplex );
DeclareAttribute( "LeftBound", IsChainOrCochainBicomplex );
DeclareAttribute( "RightBound", IsChainOrCochainBicomplex );
DeclareAttribute( "BelowBound", IsChainOrCochainBicomplex );
DeclareAttribute( "AboveBound", IsChainOrCochainBicomplex );


DeclareOperation( "ObjectAt", [ IsChainOrCochainBicomplex, IsInt, IsInt ] );
DeclareOperation( "HorizontalDifferentialAt", [ IsChainOrCochainBicomplex, IsInt, IsInt ] );
DeclareOperation( "VerticalDifferentialAt", [ IsChainOrCochainBicomplex, IsInt, IsInt ] );
