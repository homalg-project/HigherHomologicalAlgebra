# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareAttribute( "SectionForMorphisms",
                  IsCapCategoryMorphism );

DeclareOperation( "AddSectionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSectionForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSectionForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSectionForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "RetractionForMorphisms",
                  IsCapCategoryMorphism );

DeclareOperation( "AddRetractionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetractionForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetractionForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetractionForMorphisms",
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

