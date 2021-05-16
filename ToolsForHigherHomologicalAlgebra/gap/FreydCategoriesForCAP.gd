# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareAttribute( "DualOfFpModuleByFreyd", IsFreydCategoryObject );

DeclareAttribute( "DualOfFpModuleHomomorphismByFreyd", IsFreydCategoryMorphism );

DeclareAttribute( "IsomorphismOntoDoubleDualOfFpModuleByFreyd", IsFreydCategoryObject );

DeclareAttribute( "UniversalEquivalenceFromFreydCategory",
                  IsCapFunctor );

DeclareOperation( "LaTeXStringOp", [ IsFreydCategoryObject ] );

DeclareOperation( "LaTeXStringOp", [ IsFreydCategoryMorphism ] );

DeclareOperation( "LaTeXStringOp", [ IsCategoryOfRowsObject ] );

DeclareOperation( "LaTeXStringOp", [ IsCategoryOfRowsMorphism ] );

DeclareOperation( "LaTeXStringOp", [ IsAdditiveClosureObject ] );

DeclareOperation( "LaTeXStringOp", [ IsAdditiveClosureMorphism ] );

DeclareOperation( "LaTeXStringOp", [ IsQuiverRowsObject ] );

DeclareOperation( "LaTeXStringOp", [ IsQuiverRowsMorphism ] );
