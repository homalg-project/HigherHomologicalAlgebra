# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#
DeclareOperation( "EnhanceHomalgRingWithRandomFunctions", [ IsHomalgRing ] );

if IsPackageMarkedForLoading( "GradedRingForHomalg", ">= 2020.06.27" ) then
  
  DeclareOperation( "EnhanceHomalgGradedRingWithRandomFunctions", [ IsHomalgGradedRing ] );
  DeclareAttribute( "CoefficientsOfGradedRingElement", IsHomalgGradedRingElement );
  DeclareAttribute( "MonomialsOfGradedRingElement", IsHomalgGradedRingElement );
  DeclareAttribute( "HomalgElementToListOfIntegers", IsHomalgElement );
  
fi;

DeclareAttribute( "EntriesOfHomalgMatrixAttr", IsHomalgMatrix );
DeclareAttribute( "EntriesOfHomalgMatrixAsListListAttr", IsHomalgMatrix );
