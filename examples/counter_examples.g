S := Q[x0,x1]
a := AsGradedLeftPresentation( 
  HomalgMatrix( "[ [ -2*x0+6*x1, 0, x0+3*x1 ] ]", S ), [ 0, 2, 0 ] );
b := AsGradedLeftPresentation(
  HomalgMatrix( "[ [ 4, 0 ], [ -13, 0 ], [ -1, 0 ] ]", S ), [ 0, 1 ] );
f := GradedPresentationMorphism( a, 
  HomalgMatrix( "[ [ 0, 0 ], [ 4*x0^2, x0+3*x1 ], [ -4, 0 ] ]", S ), b );

