

DeclareCategory( "IsZFunction", IsObject );

DeclareAttribute( "AsZFunction", IsFunction );

DeclareAttribute( "UnderlyingFunction", IsZFunction );
DeclareAttribute( "Reflection", IsZFunction );

DeclareAttribute( "BaseZFunctions", IsZFunction );
DeclareAttribute( "AppliedMap", IsZFunction );

DeclareOperation( "ApplyMap", [ IsZFunction, IsFunction ] );
KeyDependentOperation( "ApplyShift", IsZFunction, IsInt, ReturnTrue );

DeclareOperation( "ApplyMap", [ IsDenseList, IsFunction ] );

# Extract infos from IsZFunction
KeyDependentOperation( "Value", IsZFunction, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsZFunction, IsInt ] );


###############

DeclareAttribute( "AsZFunction", IsZList );
DeclareOperation( "MapLazy", [ IsZFunction, IsFunction, IsInt ] );
