LoadPackage( "BBGG" );
Q := HomalgFieldOfRationalsInSingular(  );
S := GradedRing( Q * "x0,x1,x2" );
graded_lp_cat := GradedLeftPresentations( S );
chains := ChainComplexCategory( graded_lp_cat );
coh := CoherentSheavesOverProjectiveSpace( S );

InstallFunctor( CanonicalProjection( coh ), "sh" );
InstallFunctor( HomologyFunctorAt( chains, graded_lp_cat, 0 ), "H0" );

test := function( N )
  local f, a, b, nat_a, nat_b, beilinson_f_0, bool, i;
  
  for i in [ 1 .. N ] do
    f := RandomMorphism( graded_lp_cat, 3 );
    a := Source( f );
    b := Range( f );
    nat_a := MorphismFromGLPToZerothObjectOfBeilinsonReplacement(a);
    nat_b := MorphismFromGLPToZerothObjectOfBeilinsonReplacement(b);
    beilinson_f_0 := sh( BeilinsonReplacement( f )[ 0 ] );
    bool := IsCongruentForMorphisms( PreCompose( nat_a, beilinson_f_0 ), PreCompose( sh( f ), nat_b ) );
    if bool = true then
      Print( TextAttr.1, "i = ", i, TextAttr.reset, "\n" );
    else
      Display( a );
      Display( b );
      Display( f );
      Error( "counter example has been found" );
    fi;
  od;
  
  return bool;
  
end;

