# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Reading the implementation part of the package.
#

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/LaTeX.gi" );
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Functors.gi" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/JuliaInterface.gi" );
fi;
