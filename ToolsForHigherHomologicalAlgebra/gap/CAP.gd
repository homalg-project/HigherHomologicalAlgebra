# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareAttribute( "Section",
                  IsCapCategoryMorphism );

DeclareOperation( "AddSection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSection",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSection",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSection",
                  [ IsCapCategory, IsList ] );



DeclareAttribute( "Retraction",
                  IsCapCategoryMorphism );

DeclareOperation( "AddRetraction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetraction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetraction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetraction",
                  [ IsCapCategory, IsList ] );



DeclareGlobalVariable( "DISABLE_ALL_SANITY_CHECKS" );
DeclareGlobalVariable( "SWITCH_LOGIC_OFF" );
DeclareGlobalVariable( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );

DeclareOperation( "ViewCapCategoryCell", [ IsCapCategoryCell ] );
DeclareOperation( "DisplayCapCategoryCell", [ IsCapCategoryCell ] );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );
DeclareGlobalFunction( "ActivateCachingForCertainOperations" );
DeclareGlobalFunction( "CurrentCaching" );

DeclareOperation( "_WeakKernelEmbedding", [ IsCapCategoryMorphism ] );

