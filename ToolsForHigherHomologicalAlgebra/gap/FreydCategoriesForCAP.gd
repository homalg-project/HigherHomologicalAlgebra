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
