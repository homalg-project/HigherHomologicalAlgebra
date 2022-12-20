# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

#! @Chapter Functors and natural transformations

#! @Section Functors

#! @Description
#! Returns the natural inclusion into the complexes category by cochains $A \to \mathcal{C}^b(A)$.
#! @Arguments A
#! @Returns a CAP functor
DeclareAttribute( "InclusionFunctorIntoComplexesCategoryByCochains", IsCapCategory );

#! @Description
#! Returns the natural inclusion into the complexes category by chains $A \to \mathcal{C}^b(A)$.
#! @Arguments A
#! @Returns a CAP functor
DeclareAttribute( "InclusionFunctorIntoComplexesCategoryByChains", IsCapCategory );

#! @Description
#! Returns the natural extension of the functor $F: A \to B$ to the complexes categories by cochains $\mathcal{C}^b(A) \to \mathcal{C}^b(B)$.
#! @Arguments F
#! @Returns a CAP functor
DeclareAttribute( "ExtendFunctorToComplexesCategoriesByCochains", IsCapFunctor );

#! @Description
#! Returns the natural extension of the functor $F: A \to B$ to the complexes categories by chains $\mathcal{C}^b(A) \to \mathcal{C}^b(B)$.
#! @Arguments F
#! @Returns a CAP functor
DeclareAttribute( "ExtendFunctorToComplexesCategoriesByChains", IsCapFunctor );

