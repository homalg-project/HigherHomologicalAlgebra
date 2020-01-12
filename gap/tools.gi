
##
DeclareAttribute( "EntriesOfHomalgMatrixAttr", IsHomalgMatrix );
DeclareAttribute( "EntriesOfHomalgMatrixAsListListAttr", IsHomalgMatrix );

##
InstallMethod( EntriesOfHomalgMatrixAttr, [ IsHomalgMatrix ], EntriesOfHomalgMatrix );
InstallMethod( EntriesOfHomalgMatrixAsListListAttr, [ IsHomalgMatrix ], EntriesOfHomalgMatrixAsListList );


