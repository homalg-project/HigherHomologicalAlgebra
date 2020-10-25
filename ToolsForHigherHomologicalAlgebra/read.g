# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Reading the implementation part of the package.
#

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/CAP.gi");
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/LaTeX.gi" );
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Functors.gi" );
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/EnhancePackage.gi" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/JuliaInterface.gi" );
fi;
