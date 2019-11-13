

DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromCanonicalDecomposition", IsQuiverRepresentation );



DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );
DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );
DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );
DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );
DeclareGlobalFunction( "StackMatricesDiagonally" );
