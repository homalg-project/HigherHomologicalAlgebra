# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#
DeclareAttribute( "IndicesForBasisOfExteriorAlgebra", IsHomalgRing );

DeclareOperation( "SolveTwoSidedEquationOverExteriorAlgebra",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );
