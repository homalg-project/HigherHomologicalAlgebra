# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

InstallOtherMethod( LaTeXStringOp,
        [ IsCapCategoryCellInAFullSubcategory ],
        
  cell -> LaTeXStringOp( UnderlyingCell( cell ) )
);
