# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareOperation( "BasisOfPostAnnihilatorsInLinearCategory",
      [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddBasisOfPostAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBasisOfPostAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBasisOfPostAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBasisOfPostAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "BasisOfPreAnnihilatorsInLinearCategory",
      [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddBasisOfPreAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBasisOfPreAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBasisOfPreAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBasisOfPreAnnihilatorsInLinearCategory",
                  [ IsCapCategory, IsList ] );

