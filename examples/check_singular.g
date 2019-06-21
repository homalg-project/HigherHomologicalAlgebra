LoadPackage( "BBGG" );
Q := HomalgFieldOfRationalsInSingular(  );
S := GradedRing( Q * "x0,x1" );
graded_lp_cat := GradedLeftPresentations( S );
chains := ChainComplexCategory( graded_lp_cat );
coh := CoherentSheavesOverProjectiveSpace( S );

InstallFunctor( CanonicalProjection( coh ), "sh" );
InstallFunctor( HomologyFunctorAt( chains, graded_lp_cat, 0 ), "H0" );

check_morphism := function( f )
  local a, b, nat_a, nat_b, beilinson_f_0, bool;

  a := Source( f );
  b := Range( f );
  nat_a := MorphismFromGLPToZerothObjectOfBeilinsonReplacement( a );
  nat_b := MorphismFromGLPToZerothObjectOfBeilinsonReplacement( b );
  beilinson_f_0 := sh( BeilinsonReplacement( f )[ 0 ] );
  bool := IsCongruentForMorphisms( PreCompose( nat_a, beilinson_f_0 ),
            PreCompose( sh( f ), nat_b ) );
  if not bool then
    Display( a );
    Display( b );
    Display( f );
    Error( "counter example has been found" );
  fi;

  return bool;

end;

a := AsGradedLeftPresentation( 
  HomalgMatrix( "[ [ -2*x0+6*x1, 0, x0+3*x1 ] ]", S ), [ 0, 2, 0 ] );
b := AsGradedLeftPresentation(
  HomalgMatrix( "[ [ 4, 0 ], [ -13, 0 ], [ -1, 0 ] ]", S ), [ 0, 1 ] );
f := GradedPresentationMorphism( a, 
  HomalgMatrix( "[ [ 0, 0 ], [ 4*x0^2, x0+3*x1 ], [ -4, 0 ] ]", S ), b );

