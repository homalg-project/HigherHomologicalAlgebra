# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareGlobalVariable( "DISABLE_ALL_SANITY_CHECKS" );
DeclareGlobalVariable( "SWITCH_LOGIC_OFF" );
DeclareGlobalVariable( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );
DeclareGlobalFunction( "ActivateCachingForCertainOperations" );
DeclareGlobalFunction( "CurrentCaching" );

DeclareOperation( "_WeakKernelEmbedding", [ IsCapCategoryMorphism ] );

