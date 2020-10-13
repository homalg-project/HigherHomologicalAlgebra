# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Reading the declaration part of the package.
#

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/LaTeX.gd");

ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Functors.gd");

if IsPackageMarkedForLoading( "MatricesForHomalg", ">= 2020.06.27" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Homalg.gd" );
fi;

if IsPackageMarkedForLoading( "RingsForHomalg", ">= 2020.09.02" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/ExteriorAlgebra.gd");
fi;

if IsPackageMarkedForLoading( "ModulePresentationsForCAP", ">= 2020.04.16" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/ModulePresentations.gd" );
fi;

if IsPackageMarkedForLoading( "GradedModulePresentationsForCAP", ">= 2019.08.07" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/GradedModulePresentations.gd" );
fi;

if IsPackageMarkedForLoading( "Algebroids", ">= 2020.09.06" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Algebroids.gd");
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/Julia.gd");
fi;

if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2020.09.21" ) then
    ReadPackage( "ToolsForHigherHomologicalAlgebra", "gap/FreydCategoriesForCAP.gd");
fi;
