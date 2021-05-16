# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
##
## NaturalTransformation.gd
##
#############################################################################

#! @Chapter Functors and natural transformations
#! @Section Natural transformations

#! @Description
#!  The input is an exceptional collection <A>E</A> in some abelian category <C>C</C>.
#! The output is the unit of the tensor-hom adjunction
#! $\lambda:\mathrm{Id}_{ \mathrm{mod}\mbox{-}\mathrm{End}(\oplus_i E_i)} \to \mathrm{Hom}(T,-\otimes_{\mathrm{End}(\oplus_i E_i)} \oplus_i E_i)$.
#! @Arguments E
#! @Returns a natural transformation
DeclareAttribute( "UnitOfTensorHomAdjunction", IsStrongExceptionalCollection );

#! @Description
#!  The input is an exceptional collection <A>E</A>. The output is the unit of the tensor-hom adjunction
#! $\eta: \mathrm{Hom}(\oplus_i E_i,-)\otimes_{\mathrm{End}(\oplus_i E_i)} \oplus_i E_i \to \mathrm{Id}_C$.
#! @Arguments E
#! @Returns a natural transformation
DeclareAttribute( "CounitOfTensorHomAdjunction", IsStrongExceptionalCollection );

DeclareAttribute( "CounitOfConvolutionReplacementAdjunction", IsStrongExceptionalCollection );
DeclareAttribute( "UnitOfConvolutionReplacementAdjunction", IsStrongExceptionalCollection );

DeclareOperation( "COMPUTE_STANDARD_ISOMORPHISM", [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ] );
DeclareOperation( "COMPUTE_ISOMORPHISM", [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ] );

