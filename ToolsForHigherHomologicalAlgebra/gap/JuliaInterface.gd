# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#


DeclareGlobalFunction( "InstallOtherMethod_for_julia" );

if not IsBound( Show ) then
  DeclareOperation( "Show", [ IsString ] );
fi;
