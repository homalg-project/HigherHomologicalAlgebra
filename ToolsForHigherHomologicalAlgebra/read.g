# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Reading the implementation part of the package.
#

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/LaTeX.gi" );

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Functors.gi" );

if IsPackageMarkedForLoading( "MatricesForHomalg", ">= 2020.06.27" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Homalg.gi" );
fi;

if IsPackageMarkedForLoading( "RingsForHomalg", ">= 2020.09.02" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/ExteriorAlgebra.gi");
fi;

if IsPackageMarkedForLoading( "ModulePresentationsForCAP", ">= 2020.04.16" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/ModulePresentations.gi" );
fi;

if IsPackageMarkedForLoading( "GradedModulePresentationsForCAP", ">= 2019.08.07" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/GradedModulePresentations.gi" );
fi;

if IsPackageMarkedForLoading( "Algebroids", ">= 2020.09.06" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Algebroids.gi");
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Julia.gi");
fi;

if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2020.09.21" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/FreydCategoriesForCAP.gi");
fi;
