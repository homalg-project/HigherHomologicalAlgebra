

DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );
DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );
DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );
DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );
DeclareGlobalFunction( "StackMatricesDiagonally" );
