gap> field := HomalgFieldOfRationalsInSingular( );;
gap> S := field * "x,y,z,t";;
gap> rows := CategoryOfRows( S );;
gap> freyd := FreydCategory( rows );;
gap> chains := ChainComplexCategory( freyd );;
gap> M := HomalgMatrix( "x,y,z,t", 4, 1, S )/rows/freyd;;
gap> N := HomalgMatrix( "x-y,y+t,z+x,t^2", 4, 1, S )/rows/freyd;;
gap> m := HomalgMatrix( "16*y^4*z^4*t-32*y^3*z^3*t^2+24*y^2*z^2*t^3-8*y*z*t^4-16*x^4*t+z^4*t+t^5+t", 1, 1, S );;
gap> phi := FreydCategoryMorphism( M, m/rows, N );;
gap> phi := StalkChainMorphism( phi, 0 );;
gap> tau := MorphismBetweenProjectiveResolutions( phi, true );;
gap> q_source := QuasiIsomorphismFromProjectiveResolution( Source( phi ), true );;
gap> IsQuasiIsomorphism( q_source );
true
gap> q_range := QuasiIsomorphismFromProjectiveResolution( Range( phi ), true );;
gap> IsWellDefined( tau );
true
gap> IsWellDefined( q_source );
true
gap> IsWellDefined( q_range );
true
gap> IsWellDefined( tau );
true
gap> IsCongruentForMorphisms( PreCompose( tau, q_range ), PreCompose( q_source, phi ) );
true
gap> Display( HomologyFunctor( chains, 10 ) );
10-th homology functor in Freyd( Rows( Q[x,y,z,t] ) ):

Chain complexes( Freyd( Rows( Q[x,y,z,t] ) ) )
  |
  V
Freyd( Rows( Q[x,y,z,t] ) )
gap> Display( StalkChainFunctor( freyd, 5 ) );
Stalk chain functor from Freyd( Rows( Q[x,y,z,t] ) ) to Chain complexes( Freyd( Rows( Q[x,y,z,t] ) ) ):

Freyd( Rows( Q[x,y,z,t] ) )
  |
  V
Chain complexes( Freyd( Rows( Q[x,y,z,t] ) ) )
gap> M := Source( phi[0] );
<An object in Freyd( Rows( Q[x,y,z,t] ) )>
gap> H := CapFunctor( "Hom(M,-)", freyd, freyd );;
gap> AddObjectFunction( H, N -> HomStructure( M, N ) );;
gap> AddMorphismFunction( H, {s,alpha,r} -> HomStructure(M,alpha) );;
gap> IsZero( LeftDerivedFunctor(H,1)( Range( phi[0] ) ) );
true
