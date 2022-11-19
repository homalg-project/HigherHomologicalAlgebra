# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################


#! @Chapter Functors
#! @Section Basic functors for homotopy categories.

if false then
  #! @Group f1
  #! @Description
  #! The first argument in the input must be the chain (resp. cochain) homotopy category of an additive category $A$, 
  #! the second argument is <A>A</A> and 
  #! the third argument is an integer <A>n</A>. The output is the $n$'th homology (resp. cohomology) functor $:\mathrm{H}(A) \rightarrow A$.
  #! @Arguments H(A), A, n
  #! @Returns a functor
  KeyDependentOperation( "HomologyFunctor", IsHomotopyCategory, IsInt, ReturnTrue );
fi;

KeyDependentOperation( "ShiftFunctor", IsHomotopyCategory, IsInt, ReturnTrue );

KeyDependentOperation( "UnsignedShiftFunctor", IsHomotopyCategory, IsInt, ReturnTrue );

KeyDependentOperation( "EquivalenceIntoFullSubcategoryGeneratedByObjectsConcentratedInDegree",
          IsHomotopyCategory, IsInt, ReturnTrue );

KeyDependentOperation( "ExtendFunctorToHomotopyCategories", IsCapFunctor, IsBool, ReturnTrue );

DeclareAttribute( "ExtendFunctorToHomotopyCategoriesAttr", IsCapFunctor );

#DeclareOperation( "ExtendFunctorToHomotopyCategories", [ IsCapFunctor ] );

DeclareAttribute( "EmbeddingFunctorInHomotopyCategory", IsCapCategory );

DeclareAttribute( "ExtendFunctorFromProductCategoryToHomotopyCategories", IsCapFunctor );

KeyDependentOperation( "ExtendNaturalTransformationToHomotopyCategories", IsCapNaturalTransformation, IsBool, ReturnTrue );

DeclareAttribute( "ExtendNaturalTransformationToHomotopyCategoriesByChain", IsCapNaturalTransformation );

DeclareAttribute( "ExtendNaturalTransformationToHomotopyCategoriesByCochains", IsCapNaturalTransformation );

DeclareAttribute( "LocalizationFunctorByProjectiveObjects", IsHomotopyCategory );

DeclareAttribute( "LocalizationFunctorByInjectiveObjects", IsHomotopyCategory );

DeclareAttribute( "MinusOneFunctor", IsHomotopyCategory );

DeclareAttribute( "NaturalIsomorphismFromIdentityIntoMinusOneFunctor", IsHomotopyCategory );

DeclareAttribute( "NaturalIsomorphismFromMinusOneFunctorIntoIdentity", IsHomotopyCategory );

DeclareAttribute( "EquivalenceOntoHomotopyCategoryByCochainComplexes", IsHomotopyCategory );

DeclareAttribute( "EquivalenceFromHomotopyCategoryByCochainComplexes", IsHomotopyCategory );

DeclareAttribute( "EquivalenceOntoHomotopyCategoryByChainComplexes", IsHomotopyCategory );

DeclareAttribute( "EquivalenceFromHomotopyCategoryByChainComplexes", IsHomotopyCategory );

DeclareOperation( "ExtendFunctorMethodToHomotopyCategories", [ IsDenseList ] );
