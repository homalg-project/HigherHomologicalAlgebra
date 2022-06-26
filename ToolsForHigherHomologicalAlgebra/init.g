# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Reading the declaration part of the package.
#

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/EnhancePackage.gd");
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/CAP.gd");
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/LaTeX.gd");
ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Functors.gd");

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/JuliaInterface.gd" );
fi;
