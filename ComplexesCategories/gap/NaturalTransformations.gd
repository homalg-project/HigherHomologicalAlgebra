# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#! @Chapter Functors

#! @Section Natural transformations

#! @Description
#!  The input is a natural transformation $\eta:F\to G$. The output is its extension to the
#!  chain complexes.
#! @Arguments eta
#! @Returns a natural transformation
DeclareAttribute( "ExtendNaturalTransformationToComplexesCategoriesByChains",
  IsCapNaturalTransformation );

#! @Description
#!  The input is a natural transformation $\eta:F\to G$. The output is its extension to the
#!  cochain complexes.
#! @Arguments eta
#! @Returns a natural transformation
DeclareAttribute( "ExtendNaturalTransformationToComplexesCategoriesByCochains",
  IsCapNaturalTransformation );


DeclareAttribute( "NaturalIsomorphismFromIdentityIntoMinusOneFunctor", IsChainOrCochainComplexCategory );
DeclareAttribute( "NaturalIsomorphismFromMinusOneFunctorIntoIdentity", IsChainOrCochainComplexCategory );
