LoadPackage( "LinearAlgebra" );
LoadPackage( "TriangulatedCategoriesForCAP" );

Q := HomalgFieldOfRationals( );

cat := MatrixCategory( Q: FinalizeCategory := false );

SetIsTriangulatedCategory( cat, true );
SetIsTriangulatedCategoryWithShiftAutomorphism( cat, true );

##############################
#
# Adding triangulated methods
#
##############################

AddShiftOfObject( cat, IdFunc );
AddShiftOfMorphism( cat, IdFunc );
AddReverseShiftOfObject( cat, IdFunc );
AddReverseShiftOfMorphism( cat, IdFunc );

AddIsomorphismToReverseShiftOfShift( cat, IdentityMorphism );
AddIsomorphismFromReverseShiftOfShift( cat, IdentityMorphism );
AddIsomorphismToShiftOfReverseShift( cat, IdentityMorphism );
AddIsomorphismFromShiftOfReverseShift( cat, IdentityMorphism );

## to understand the code see this commutative diagram
# \begin{tikzcd}[transform canvas={scale=0.75}]
#  & ker(f)\oplus A/ker(f) &  & im(f)\oplus B/im(f) \arrow[rr] &  
# & B/im(f)\oplus ker(f) \arrow[rr] \arrow[rrd] &  & ker(f)\oplus A/ker(f) \arrow[d, two heads, tail] \\
#  & A \arrow[d, two heads] \arrow[u, two heads, tail] \arrow[rr, "f"] \arrow[ld, two heads, dashed, bend right] &
# & B \arrow[d, two heads] \arrow[ld, two heads, dashed, bend right] \arrow[u, two heads, tail] \arrow[rru] &  &  &  & A \\
# ker(f) \arrow[ru, tail] & A/ker(f) & im(f) \arrow[ru, tail] & B/im(f) &  &  &  & 
# \end{tikzcd}
#
AddCompleteMorphismToCanonicalExactTriangle( cat, 
    function( f )
    local g, h;
    
    g := PreCompose( CokernelProjection( f ), 
                        InjectionOfCofactorOfDirectSum( [ CokernelObject(f), KernelObject( f ) ], 1 ) );
    h := PreCompose( ProjectionInFactorOfDirectSum( [ CokernelObject(f), KernelObject( f ) ], 2 ),
                        KernelEmbedding( f ) );

    return CreateCanonicalExactTriangle( f, g, h );
       
end );

##
AddIsExactTriangle( cat, 
  function( T )
  local f,g,h;
    
  if not IsEvenInt( Dimension( ObjectAt( T, 0 ) ) + 
                        Dimension( ObjectAt( T, 1 ) ) 
                            - Dimension( ObjectAt( T, 2 ) ) ) then 
    
     return false;
    
  fi;
  
  f:= MorphismAt( T, 0 );
  g:= MorphismAt( T, 1 );
  h:= MorphismAt( T, 2 );
  
  if not IsZeroForMorphisms( PreCompose( f, g ) ) or 
      not IsZeroForMorphisms( PreCompose( g, h ) ) or 
      not IsZeroForMorphisms( PreCompose( h, f ) ) then 
    
  return false;
  
  fi;
  
  ## in abelian categories, for f:A ---> B we have
  ## im( f )   = ker( coker( f ) )
  ## coim( f ) = coker( ker( f ) )
 
  if not Dimension( KernelObject( g ) ) = Dimension( KernelObject( CokernelProjection( f ) ) ) or
       not Dimension( KernelObject( h ) ) = Dimension( KernelObject( CokernelProjection( g ) ) ) or
         not Dimension( KernelObject( f ) ) = Dimension( KernelObject( CokernelProjection( h ) ) ) then
  
  return false;
  
  fi;
  
  return true;

end );

##
AddIsomorphismToCanonicalExactTriangle( cat, 
    function( T )
    local f, g, h, can_triangle, A, B, a, b;
    f := MorphismAt( T, 0 );
    g := MorphismAt( T, 1 );
    h := MorphismAt( T, 2 );
    
    can_triangle := CompleteMorphismToCanonicalExactTriangle( f );
    A := ObjectAt( T, 0 );
    B := ObjectAt( T, 1 );
    
    a := CokernelColift( f, MorphismAt( can_triangle, 1 ) );
    a := Colift( a, IdentityMorphism( Source( a ) ) );
    a := PreCompose( a, CokernelColift( f, g ) );
    b := KernelLift( f, h );
    b := Lift( IdentityMorphism( Range( b ) ), b );
    b := PreCompose( KernelLift( f, MorphismAt( can_triangle, 2) ), b );
    
    return CreateTrianglesMorphism( T, can_triangle, IdentityMorphism( A ), IdentityMorphism( B ), Inverse( AdditionForMorphisms(a,b) ) );

end );

##
AddCompleteToMorphismOfCanonicalExactTriangles( cat, 
    function( T1, T2, u, v )
    local f1, f2, a, b, m22;
    
    f1 := MorphismAt( T1, 0 );
    f2 := MorphismAt( T2, 0 );
    a := CokernelColift( ImageEmbedding( f1 ), PreCompose( v, CokernelProjection( f2 ) ) );
    b := KernelLift( f2, PreCompose( KernelEmbedding( f1 ), u ) );
    m22 := MorphismBetweenDirectSums( [ [a, ZeroMorphism( Source( a ), Range( b ) ) ], 
                                        [ ZeroMorphism( Source( b ), Range( a ) ), b ] ] );
    
    return CreateTrianglesMorphism( T1, T2, u, v, m22 );
    end );

AddOctahedralAxiom( cat, 
  function( f, g )
  local t, i,j,T, S, W, N, u,v, w;
   
  T := CompleteMorphismToCanonicalExactTriangle( f );
   
  S := CompleteMorphismToCanonicalExactTriangle( PreCompose( f, g ) );
   
  u := CompleteToMorphismOfCanonicalExactTriangles( T, S, IdentityMorphism( Source( f ) ), g );

  W := CompleteMorphismToCanonicalExactTriangle( g );
   
  v := CompleteToMorphismOfCanonicalExactTriangles( S, W, f, IdentityMorphism( Range( g ) ) );
   
  j:= MorphismAt( T, 1 );
  i:= MorphismAt( W, 2 );
   
  w:= PreCompose( i, ShiftOfMorphism( j ) );
   
  t := CreateTriangle( MorphismAt( u, 2 ), MorphismAt( v, 2 ), w );

  IsExactTriangle( t );
  IsomorphismFromCanonicalExactTriangle( t );
  IsomorphismToCanonicalExactTriangle( t );
  
  return t;
end );

# AddTesttt( cat, 
#    function( x )
#    Print( "I am not the default method 1\n" );
#    return false;
#    
# end, 2 );
# 
# AddTesttt( cat, 
#    function( x )
#    Print( "I am not the default method 2\n" );
#    return false;
#    
# end, 1 );

Finalize( cat );

#############################

# this function creates a morphism R^m -> R^n
create_random_morphism := 
    function( m, n )
    local Qm, Qn, Qr, q, r;

    r := Random( [ 1 .. Minimum(m,n) - 1 ] );
    Qm := VectorSpaceObject( m - r, Q );
    Qn := VectorSpaceObject( n - r, Q );
    Qr := VectorSpaceObject( r, Q );
    
    q := VectorSpaceMorphism( Qm,
                            HomalgMatrix( List( [ 1 .. m -r ], i-> List( [ 1 .. n -r ], j -> Random([ -5..5 ]) ) ), m-r, n-r, Q ), 
                              Qn );
    q := HomalgMatrix( RandomInvertibleMat(m), m, m, Q)*
    UnderlyingMatrix( MorphismBetweenDirectSums( [ [q, ZeroMorphism( Qm,Qr )], [ ZeroMorphism( Qr, Qn), ZeroMorphism(Qr,Qr )]]))
    *HomalgMatrix( RandomInvertibleMat(n), n, n, Q);
    return VectorSpaceMorphism( DirectSum(Qm,Qr), q, DirectSum(Qn,Qr) );
end;


v := create_random_morphism(4,2);
g := create_random_morphism(3,2);
f := ProjectionInFactorOfFiberProduct( [ v, g ], 1 );
u := ProjectionInFactorOfFiberProduct( [ v, g ], 2 );
Tf := CompleteMorphismToCanonicalExactTriangle( f );
Tg := CompleteMorphismToCanonicalExactTriangle( g );
phi := CompleteToMorphismOfCanonicalExactTriangles( Tf, Tg, u, v );
Display( phi );