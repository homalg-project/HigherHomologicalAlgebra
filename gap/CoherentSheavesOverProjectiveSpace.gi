

##
BindGlobal( "IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE",
    function( N )
      return IsZero( HilbertPolynomial( AsPresentationInHomalg( N ) ) );
end );

##
InstallMethod( CoherentSheavesOverProjectiveSpace,
          [ IsHomalgGradedRing ],
  function( S )
    local graded_lp_cat_sym, sub_cat;
    
    graded_lp_cat_sym := GradedLeftPresentations( S );
    
    sub_cat := FullSubcategoryByMembershipFunction( graded_lp_cat_sym, IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE );
    
    return graded_lp_cat_sym / sub_cat;
    
end );

##
InstallMethod( SheafificationFunctor,
          [ IsCapCategory ],
  CanonicalProjection
);

##
InstallMethod( TwistedStructureSheafOp,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt ],
  function( S, d )
    local coh, sh;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    return ApplyFunctor( sh, TwistedGradedFreeModule( S, d ) );
    
end );

##
InstallMethod( BasisBetweenTwistedStructureSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt, IsInt ],
  function( S, i, j )
    local coh, sh, B;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    B := BasisBetweenTwistedGradedFreeModules( S, i, j );
    
    return List( B, b -> ApplyFunctor( sh, b ) );
    
end );

##
InstallMethod( TwistedCotangentSheafOp,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt ],
  function( S, d )
    local coh, sh;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    return ApplyFunctor( sh, TwistedCotangentModule( S, d ) );
    
end );

##
InstallMethod( BasisBetweenTwistedCotangentSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt, IsInt ],
  function( S, i, j )
    local coh, sh, B;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    B := BasisBetweenTwistedCotangentModules( S, i, j );
    
    return List( B, b -> ApplyFunctor( sh, b ) );
    
end );

########################################
#
# View & Display methods
#
#######################################

## 𝒪, 𝓞, 𝛀, 𝛚 ⨁,, ⊕, Ω

##
InstallMethod( ViewObj,
          [ IsSerreQuotientCategoryObject ],
  function( M )
    local o, S, n, omegas, p;
     
    o := UnderlyingHonestObject( M );
    
    S := UnderlyingHomalgRing( o );
    
    n := Size( Indeterminates( S ) );
    
    omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentModule( S, i ) );
    
    p := Position( omegas, o );
    
    if p = fail then
      
      TryNextMethod( );
      
    fi;
    
    Print( "Ω^", p - 1, "(", p - 1, ")" );
    
end );

InstallMethod( ViewObj,
          [ IsSerreQuotientCategoryObject ],
  function( M )
    local o, twists, c, p;
    
    o := UnderlyingHonestObject( M );
    
    if not IsZero( NrRows( UnderlyingMatrix( o ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    twists := -GeneratorDegrees( o );
    
    #Print( "An object in Serre quotient category defined by: " );
    
    if IsEmpty( twists ) then
      
      Print( "0" );
      
    fi;
    
    c := [ ];
    
    while true do
      
      p := PositionProperty( twists, i -> i <> twists[ 1 ] );
      
      if p = fail then
        
        if Size( twists ) > 1 then
          
          Print( "𝓞(", twists[ 1 ], ")^", Size( twists ) );
          
        else
          
          Print( "𝓞(", twists[ 1 ], ")" );
          
        fi;
        
        break;
        
      else
        
        if p > 2 then
          
          Print( "𝓞(", twists[ 1 ], ")^", p - 1, "⊕" );
        
        else
          
          Print( "𝓞(", twists[ 1 ], ")⊕" );
          
        fi;
       
        twists := twists{ [ p .. Size( twists ) ] };
      
      fi;
      
    od;
     
end );
  
##
InstallMethod( ViewObj,
          [ IsSerreQuotientCategoryMorphism ],
  function( alpha )
    local s, mat_s, r, mat_r;
    
    s := Source( alpha );
    
    mat_s := UnderlyingMatrix( UnderlyingHonestObject( s ) );
    
    if not IsZero( NrRows( mat_s ) ) then
    
      TryNextMethod( );
    
    fi;
    
    r := Range( alpha );
    
    mat_r := UnderlyingMatrix( UnderlyingHonestObject( r ) );
 
    if not IsZero( NrRows( mat_r ) ) then
    
      TryNextMethod( );
    
    fi;

    ViewObj( s );
    
    Print( "--" );
    
    if NrCols( mat_s ) = 1 and NrCols( mat_r ) = 1 then
      
      Print( "{",UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) ) )[ 1, 1 ],"}" );
      
    fi;
     
    Print( " --> " );
    
    ViewObj( r );
    
end );

