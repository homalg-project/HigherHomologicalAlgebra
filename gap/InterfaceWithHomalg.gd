
DeclareAttribute( "AsPresentationInCAP",  IsHomalgGradedModule  );
DeclareAttribute( "AsPresentationInHomalg",  IsGradedLeftOrRightPresentation  );

DeclareAttribute( "AsPresentationMorphismInCAP",  IsHomalgGradedMap  );
DeclareAttribute( "AsPresentationMorphismInHomalg",  IsGradedLeftOrRightPresentationMorphism  );


KeyDependentOperation( "TruncationFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "HomogeneousPartOverCoefficientsRingFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );

DeclareOperation( "RepresentationMapOfRingElement", [ IsRingElement, IsGradedLeftOrRightPresentation, IsInt ] );

KeyDependentOperation( "GradedLeftPresentationGeneratedByHomogeneousPart", IsGradedLeftPresentation, IsInt, ReturnTrue );
DeclareAttribute( "EmbeddingInSuperObject", IsGradedLeftPresentation);

DeclareAttribute( "CastelnuovoMumfordRegularity", IsCapCategoryObject );

