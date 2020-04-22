
DeclareGlobalFunction( "ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS" );
DeclareAttribute( "HomalgElementToListOfIntegers", IsHomalgElement );
DeclareAttribute( "CoefficientsOfGradedRingElement", IsHomalgGradedRingElement );
DeclareAttribute( "MonomialsOfGradedRingElement", IsHomalgGradedRingElement );
DeclareOperation( "MonomialsOfDegree", [ IsHomalgGradedRing, IsHomalgModuleElement ] );
DeclareAttribute( "EntriesOfHomalgMatrixAttr", IsHomalgMatrix );
DeclareAttribute( "EntriesOfHomalgMatrixAsListListAttr", IsHomalgMatrix );
