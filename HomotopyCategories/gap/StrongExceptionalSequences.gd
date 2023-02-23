# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
DeclareCategory( "IsStrongExceptionalSequence", IsCapFullSubcategory );

DeclareGlobalFunction( "CreateStrongExceptionalSequence" );

KeyDependentOperation( "IrreducibleMorphisms", IsCapFullSubcategory, IsList, ReturnTrue );
KeyDependentOperation( "CompositeMorphisms", IsCapFullSubcategory, IsList, ReturnTrue );

DeclareOperation( "DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence", [ IsCapFullSubcategory, IsCapCategoryObject ] );
DeclareOperation( "DataOfYonedaEmbeddingOnMorphismRelativeToStrongExceptionalSequence", [ IsCapFullSubcategory, IsCapCategoryMorphism ] );

DeclareOperation( "DataOfExceptionalCover", [ IsCapFullSubcategory, IsCapCategoryObject ] );
DeclareOperation( "ExceptionalCover", [ IsCapFullSubcategory, IsCapCategoryObject ] );
#DeclareOperation( "MorphismBetweenExceptionalCovers", [ IsCapFullSubcategory, IsCapCategoryMorphism ] );

DeclareOperation( "PossibileExceptionalShifts", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "ExceptionalShifts", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "MaximalExceptionalShift", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "DataOfExceptionalReplacement", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "ExceptionalReplacement", [ IsCapFullSubcategory, IsHomotopyCategoryObject, IsBool ] );
DeclareOperation( "InterpretExceptionalReplacementAsObjectInHomotopyCategoryOfAdditiveClosure", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "IsomorphismFromConvolutionOfExceptionalReplacement", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareOperation( "RemainderOfObjectRelativeToStrongExceptionalSequence", [ IsCapFullSubcategory, IsHomotopyCategoryObject ] );
DeclareAttribute( "TriangulatedSubcategory", IsCapFullSubcategory );

DeclareAttribute( "ConvolutionFunctor", IsCapFullSubcategory );
DeclareAttribute( "ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid", IsCapFullSubcategory );

DeclareAttribute( "ReplacementFunctor", IsCapFullSubcategory );
DeclareAttribute( "ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid", IsCapFullSubcategory );

DeclareAttribute( "CounitOfConvolutionReplacementAdjunction", IsCapFullSubcategory );
DeclareAttribute( "UnitOfConvolutionReplacementAdjunction", IsCapFullSubcategory );
