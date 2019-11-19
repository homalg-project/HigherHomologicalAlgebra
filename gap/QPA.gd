
DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );
DeclareAttribute( "DecomposeInjectiveQuiverRepresentation", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromInjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismIntoInjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );


DeclareOperation( "EpimorphismFromSomeDirectSum", [ IsList, IsCapCategoryObject ] );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );
DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );
DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );
DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );

DeclareOperation( "StackMatricesDiagonally", [ IsQPAMatrix, IsQPAMatrix ] );
DeclareOperation( "StackMatricesDiagonally", [ IsDenseList ] );
