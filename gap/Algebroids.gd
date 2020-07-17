

# field := HomalgFieldOfRationals( );
# objects := [ "A", "B", "C" ];
# morphisms := [ [ "alpha", 1, 2 ], [ "beta", 2, 3 ], [ "gamma", 1, 3 ] ];
# relations :=
#   [
#     [ [ [ 1, [ "alpha", "beta" ] ], [ -1, [ "gamma" ] ] ], "h" ], # i.e., 1 * alpha * beta - 1 * gamma is zero up to homotopy called /h/
#   ];
# bounds := [ 0, 3 ];

DeclareOperation( "CreateDiagramInHomotopyCategory", [ IsHomalgRing, IsList, IsList, IsList, IsList ] );

DeclareOperation( "CreateDiagramInHomotopyCategory", [ IsList, IsList, IsList, IsList ] );
