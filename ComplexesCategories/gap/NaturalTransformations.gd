# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#! @Chapter Functors and natural transformations

#! @Section Natural transformations

#! @Description
#!  The input is a natural transformation $\eta:F\to G$.
#!  The output is its extension to the complexes categories by chains.
#! @Arguments eta
#! @Returns a natural transformation
DeclareAttribute( "ExtendNaturalTransformationToComplexesCategoriesByChains",
  IsCapNaturalTransformation );

#! @Description
#!  The input is a natural transformation $\eta:F\to G$.
#!  The output is its extension to the complexes categories by cochains.
#! @Arguments eta
#! @Returns a natural transformation
DeclareAttribute( "ExtendNaturalTransformationToComplexesCategoriesByCochains",
  IsCapNaturalTransformation );


DeclareAttribute( "NaturalIsomorphismFromIdentityIntoMinusOneFunctor", IsComplexesCategory );
DeclareAttribute( "NaturalIsomorphismFromMinusOneFunctorIntoIdentity", IsComplexesCategory );
