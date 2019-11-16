
DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromCanonicalDecomposition", IsQuiverRepresentation );

DeclareOperation( "EpimorphismFromSomeDirectSum", [ IsList, IsCapCategoryObject ] );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );
DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );
DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );
DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );
DeclareGlobalFunction( "StackMatricesDiagonally" );
