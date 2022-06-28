# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareCategory( "IsCategoryOfArrowsObject", IsCapCategoryObject );

DeclareCategory( "IsCategoryOfArrowsMorphism", IsCapCategoryMorphism );

DeclareAttribute( "CategoryOfArrows", IsCapCategory );

DeclareOperation( "CategoryOfArrowsObject",
  [ IsCapCategory, IsCapCategoryMorphism ] );

DeclareOperation( "CategoryOfArrowsMorphism",
  [ IsCapCategoryObject, IsCapCategoryMorphism,
      IsCapCategoryMorphism, IsCapCategoryObject ] );
