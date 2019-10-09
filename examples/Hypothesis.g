LoadPackage( "BBGG" );

TEST_1 := function( f, m )
  local S, tr_f, u, v, L_f_m;
  
  S := UnderlyingHomalgRing( f );
  
  if m <= CastelnuovoMumfordRegularity( Source( f ) ) or
    m <= CastelnuovoMumfordRegularity( Range( f ) ) then
    
    Print( "Increasing the integer\n" );
    return TEST_1( f, m + 1 );
    
  fi;
  
  tr_f := ApplyFunctor( TruncationFunctorUsingHomalg( S, m ), f );
  
  u := EpimorphismFromSomeProjectiveObject( Source( tr_f ) );
  
  v := EpimorphismFromSomeProjectiveObject( Range( tr_f ) );
  
  L_f_m := ApplyFunctor( LCochainFunctor( S ), AsCochainMorphism( TateResolution( f ) )[ m ] )[ -m ];
  
  return IsCongruentForMorphisms( 
          PreCompose( u, tr_f ),
          PreCompose( L_f_m, v )
          );
end;

TEST_2 := function( a, m )
  local T, l, H, V, G, r, k1, k2, S;
  
  if IsZero( a ) then
    return true;
  fi;
  
  S := UnderlyingHomalgRing( a );
  
  if m <= CastelnuovoMumfordRegularity( a ) then
    
    Print( "Increasing the integer\n" );
    return TEST_2( a, m + 1 );
    
  fi;
 
  T := AsCochainComplex( TateResolution( a ) );
  l := ApplyFunctor( LCochainFunctor( S ), T^m );
  H := PreCompose( l[ - m - 1 ],
    EpimorphismFromSomeProjectiveObject( ApplyFunctor( TruncationFunctorUsingHomalg( S, m + 1 ), a ) ) );
  V := PreCompose( Source( l )^( - m - 1 ),
    EpimorphismFromSomeProjectiveObject( ApplyFunctor( TruncationFunctorUsingHomalg( S, m ), a ) ) );
  G := GeneralizedMorphismBySpan( H, V );
  r := HonestRepresentative( G );
  
  k1 := ApplyNaturalTransformation( NatTransFromTruncationUsingHomalgToIdentityFunctor( S, m ), a );
  k2 := ApplyNaturalTransformation( NatTransFromTruncationUsingHomalgToIdentityFunctor( S, m + 1 ), a );
  l := Lift( k2, k1 );
  
  return IsCongruentForMorphisms(r,l);
  
end;

S := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
graded_lp_cat := GradedLeftPresentations( S );

