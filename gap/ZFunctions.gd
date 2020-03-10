

DeclareCategory( "IsZFunction", IsObject );
DeclareCategory( "IsZFunctionWithInductiveSides", IsZFunction );

DeclareAttribute( "AsZFunction", IsFunction );

DeclareAttribute( "PosFunction", IsZFunctionWithInductiveSides );
DeclareAttribute( "NegFunction", IsZFunctionWithInductiveSides );
DeclareAttribute( "FirstIndex", IsZFunctionWithInductiveSides );
DeclareAttribute( "FirstValue", IsZFunctionWithInductiveSides );
DeclareAttribute( "CompareFunction", IsZFunctionWithInductiveSides );
DeclareAttribute( "StablePosValue", IsZFunctionWithInductiveSides );
DeclareAttribute( "StableNegValue", IsZFunctionWithInductiveSides );

DeclareOperation( "ZFunctionWithInductiveSides",
      [ IsInt, IsObject, IsFunction, IsFunction, IsFunction ] );

DeclareGlobalFunction( "VoidZFunction" );

DeclareAttribute( "UnderlyingFunction", IsZFunction );
DeclareAttribute( "Reflection", IsZFunction );

DeclareAttribute( "BaseZFunctions", IsZFunction );
DeclareAttribute( "AppliedMap", IsZFunction );

DeclareOperation( "ApplyMap", [ IsZFunction, IsFunction ] );
DeclareOperation( "CombineZFunctions", [ IsList ] );

KeyDependentOperation( "ApplyShift", IsZFunction, IsInt, ReturnTrue );

DeclareOperation( "ApplyMap", [ IsDenseList, IsFunction ] );

# Extract infos from IsZFunction
KeyDependentOperation( "Value", IsZFunction, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsZFunction, IsInt ] );
