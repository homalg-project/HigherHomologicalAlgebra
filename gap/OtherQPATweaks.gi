

## Constructors with out any check

#
BindGlobal( "LINEAR_QUIVER",
  function( d, field, m, n )
    local L, A, c, l, constructor;
    
    if d = RIGHT then
      
      constructor := "RightQuiver";
      
    else
      
      constructor := "LeftQuiver";
      
    fi;

    if m <= n then
      
    	L := ValueGlobal( constructor )(
            Concatenation( "L(v", String(m), ")[d", String(m), "]" ),
            n - m + 1,
    		    List( [ m .. n - 1 ],
              i -> [ Concatenation( "v", String( i ) ), Concatenation( "v", String( i + 1 ) ) ]  )
          );
      
    	A := PathAlgebra( field, L );
      
    	c := ArrowLabels( L );
      
    	l := List( [ 1 .. Length( c ) - 1 ], i -> [ c[ i ], c[ i + 1 ] ] );
      
	    if d = RIGHT then
      
    	  l := List( l, label -> PrimitivePathByLabel( L, label[ 1 ] ) * PrimitivePathByLabel( L, label[ 2 ] ) );
	  
      else
	    
        l := List( l, label -> PrimitivePathByLabel( L, label[ 2 ] ) * PrimitivePathByLabel( L, label[ 1 ] ) );
	    
      fi;
    
      l := List( l, r -> QuiverAlgebraElement( A, [ 1 ], [ r ] ) );
    
      return [ L, A, l ];
      
    else
      
      L := ValueGlobal( constructor )(
              Concatenation( "L(v", String( n ), ")[d", String( n + 1 ), "]" ),
              m - n + 1,
	            List( [ n .. m - 1 ],
                i-> [ Concatenation( "v", String( i + 1 ) ), Concatenation( "v", String( i ) ) ]  )
            );
      
      A := PathAlgebra( field, L );
      
	    c := ArrowLabels( L );
      
	    l := List( [ 1 .. Length( c ) - 1 ], i -> [ c[ i + 1 ], c[ i ] ] );
    
	    if d = RIGHT then
        
	      l := List( l, label -> PrimitivePathByLabel( L, label[ 1 ] ) * PrimitivePathByLabel( L, label[ 2 ] ) );
        
	    else
	      
        l := List( l, label -> PrimitivePathByLabel( L, label[ 2 ] ) * PrimitivePathByLabel( L, label[ 1 ] ) );
        
	    fi;
      
    	l := List( l, r -> QuiverAlgebraElement( A, [1], [r] ) );
    	
      L!.( "m" ) := m;
      
    	L!.( "n" ) := n;
	    
      return [ L, A, l ];
    
    fi;
    
end );

##
BindGlobal( "LINEAR_LEFT_QUIVER",
  function( field, m, n )
  
    return LINEAR_QUIVER( LEFT, field, m, n );
    
end );

#                              d2   d3    d4
# Rationals, 2, 5 returns   2 --> 3 --> 4 --> 5 with d2*d3=0 and d3*d4=0.

#                              d3    d4    d5
# Rationals, 5, 2 returns   2 <-- 3 <-- 4 <-- 5 with d4*d3=0 and d5*d4=0.

##
BindGlobal( "LINEAR_RIGHT_QUIVER",
  function( field, m, n )
  
    return LINEAR_QUIVER( RIGHT, field, m, n );
    
end );

##
BindGlobal( "PRODUCT_OF_QUIVER_ALGEBRAS",
  function( A, m, n )
    local field, LL, AL;
     
    field := LeftActingDomain( A );
    
    LL := LINEAR_RIGHT_QUIVER( field, m, n );
    
    if LL[ 3 ] = [ ] then
      
      AL := LL[ 2 ];
    
    else
      
      AL := QuotientOfPathAlgebra( LL[ 2 ], LL[ 3 ] );
    
    fi;
    
    return TensorProductOfAlgebras( AL, A );
    
end );


##
BindGlobal( "CONVERT_COMPLEX_OF_QUIVER_REPS_TO_QUIVER_REP",
  function( C, A  )
    local L, m, n, Q, dimension_vector, matrices1, matrices2, matrices;
    
    L := QuiverOfAlgebra( TensorProductFactors( A )[ 1 ] );
    
    m := ShallowCopy( Label( Vertex( L, 1 ) ) );
    
    RemoveCharacters( m, "v" );
    
    m := Int( m );
    
    n := m + NumberOfVertices( L ) - 1;
    
    if IsChainComplex( C ) then
      
      dimension_vector := Concatenation( List( [ m .. n ], i-> DimensionVector( C[ i ] ) ) );
      
      matrices1 := Concatenation( List( [ m .. n ], i -> MatricesOfRepresentation( C[ i ] ) ) );
      
      matrices2 := Concatenation( List( [ m + 1 .. n ], i-> MatricesOfRepresentationHomomorphism( C^i ) ) );
      
      matrices := Concatenation( matrices1, matrices2 );
      
      return QuiverRepresentation( A, dimension_vector, matrices );
    
    else
      
      Q := QuiverOfAlgebra( A );
      
      dimension_vector := Concatenation( List( [ m .. n ], i-> DimensionVector( C[ i ] ) ) );
      
      matrices1 := Concatenation( List( [ m .. n ], i -> MatricesOfRepresentation( C[ i ] ) ) );
      
      matrices2 := Concatenation( List( [ m .. n - 1 ], i-> MatricesOfRepresentationHomomorphism( C ^ i ) ) );
      
      matrices := Concatenation( matrices1, matrices2 );
      
      return QuiverRepresentation( A, dimension_vector, matrices );
      
    fi;
    
end );

BindGlobal( "CONVERT_COMPLEX_MORPHISM_OF_QUIVER_REPS_TO_QUIVER_REP_MORPHISM",
  function( phi, A )
    local L,m,n, matrices, r1, r2;
    
    L := QuiverOfAlgebra( TensorProductFactors( A )[1] );
    
    m := ShallowCopy( Label( Vertex( L, 1 ) ) );
    
    RemoveCharacters( m, "v" );
    
    m := Int( m );
    
    n := m + NumberOfVertices( L ) - 1;
    
    matrices := Concatenation( List( [ m .. n ], i -> MatricesOfRepresentationHomomorphism( phi[ i ] ) ) );
    
    r1 := CONVERT_COMPLEX_OF_QUIVER_REPS_TO_QUIVER_REP( Source( phi ), A );
    
    r2 := CONVERT_COMPLEX_OF_QUIVER_REPS_TO_QUIVER_REP( Range( phi ), A );
    
    return QuiverRepresentationHomomorphism( r1, r2, matrices );
    
end );

##
BindGlobal( "CONVERT_QUIVER_REP_MORPHISM_TO_COMPLEX_MORPHISM_OF_QUIVER_REPS",
  function( C1, C2, mor, A )
    local Q, L, q, m, n, mats;
    
    Q := QuiverOfAlgebra( A );
    
    L := QuiverOfAlgebra( TensorProductFactors( A )[ 1 ] );
    
    q := QuiverOfAlgebra( TensorProductFactors( A )[ 2 ] );
    
    m := ShallowCopy( Label( Vertex( L, 1 ) ) );
    
    RemoveCharacters( m, "v" );
    
    m := Int( m );
    
    n := m + NumberOfVertices( L ) - 1;
    
    mats := MatricesOfRepresentationHomomorphism( mor );
    
    mats := List( [ 1 .. NumberOfVertices( L ) ],
                i -> List( [ 1 .. NumberOfVertices( q ) ],
                        j-> mats[ ( i - 1 ) * NumberOfVertices( q ) + j ] ) );
    
    mats := List( [ m .. n ], k -> QuiverRepresentationHomomorphism( C1[ k ], C2[ k ], mats[ k - m + 1 ] ) );
    
    if IsChainComplex( C1 ) then
      
      return ChainMorphism( C1, C2, mats, m );
    
    else
      
      return CochainMorphism( C1, C2, mats, m );
    
    fi;
    
end );

##
BindGlobal( "COMPUTE_LIFT_IN_COMPLEXES_OF_QUIVER_REPS",
  function( f, g )
    local m, n, A, f_, g_, lift;
    
    m := Minimum( ActiveLowerBound( Source( f ) ), ActiveLowerBound( Source( g ) ) ) + 1;
    
    n := Maximum( ActiveUpperBound( Source( f ) ), ActiveUpperBound( Source( g ) ) ) - 1;
    
    if IsChainMorphism( f ) then
      
      A := PRODUCT_OF_QUIVER_ALGEBRAS( AlgebraOfRepresentation( Source( f[ m ]) ), n, m );
    
    else
      
      A := PRODUCT_OF_QUIVER_ALGEBRAS( AlgebraOfRepresentation( Source( f[ m ]) ), m, n );
    
    fi;
    
    f_ := CONVERT_COMPLEX_MORPHISM_OF_QUIVER_REPS_TO_QUIVER_REP_MORPHISM( f, A );
    
    g_ := CONVERT_COMPLEX_MORPHISM_OF_QUIVER_REPS_TO_QUIVER_REP_MORPHISM( g, A );
    
    lift := Lift( f_, g_ );
    
    if lift = fail then
      
      return fail;
    
    else
      
      return CONVERT_QUIVER_REP_MORPHISM_TO_COMPLEX_MORPHISM_OF_QUIVER_REPS( Source( f ), Source( g ), lift, A );
    
    fi;
    
end );

BindGlobal( "COMPUTE_COLIFT_IN_COMPLEXES_OF_QUIVER_REPS",
  function( f, g )
    local m, n, A, f_, g_, colift;
    
    m := Minimum( ActiveLowerBound( Range( f ) ), ActiveLowerBound( Range( g ) ) ) + 1;
    
    n := Maximum( ActiveUpperBound( Range( f ) ), ActiveUpperBound( Range( g ) ) ) - 1;
    
    if IsChainMorphism( f ) then
      
      A := PRODUCT_OF_QUIVER_ALGEBRAS( AlgebraOfRepresentation( Source( f[ m ] ) ), n, m );
      
    else
      
      A := PRODUCT_OF_QUIVER_ALGEBRAS( AlgebraOfRepresentation( Source( f[ m ] ) ), m, n );
      
    fi;
    
    f_ := CONVERT_COMPLEX_MORPHISM_OF_QUIVER_REPS_TO_QUIVER_REP_MORPHISM( f, A );
    
    g_ := CONVERT_COMPLEX_MORPHISM_OF_QUIVER_REPS_TO_QUIVER_REP_MORPHISM( g, A );
    
    colift := Colift( f_, g_ );
    
    if colift = fail then
      
      return fail;
    
    else
      
      return CONVERT_QUIVER_REP_MORPHISM_TO_COMPLEX_MORPHISM_OF_QUIVER_REPS( Range( f ), Range( g ), colift, A );
    
    fi;
    
end );


