#
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "ToolsForHigherHomologicalAlgebra" );

TestDirectory(DirectoriesPackageLibrary( "ToolsForHigherHomologicalAlgebra", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
