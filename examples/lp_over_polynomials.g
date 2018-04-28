LoadPackage( "BBGG" );

R := HomalgFieldOfRationalsInSingular()*"x,y,z";
S := GradedRing( R );

m := RandomMatrixBetweenGradedFreeLeftModules( [3,4],[1,2,2,3], S );

M := AsGradedLeftPresentation( m, [ 1,2,2,3] );


