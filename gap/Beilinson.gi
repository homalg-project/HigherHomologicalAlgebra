

BindGlobal( "BBGG", rec( ) );
BBGG!.QQ := HomalgFieldOfRationals( );

InstallGlobalFunction( ShowMatrix,
 function( C )
    local mat;

    if TestPackageAvailability( "Browse" ) = fail then
      Error( "Browse could not be loaded!" );
    else
      LoadPackage( "Browse" );
    fi;

    if IsHomalgMatrix( C ) then
      mat := C;
    elif IsCapCategoryCell( C ) and HasUnderlyingMatrix( C ) then
      mat := UnderlyingMatrix( C );
    else
      return fail;
    fi;

    if NrRows( mat ) * NrColumns( mat ) = 0 then
      Display( mat );
    else
      ValueGlobal( "Browse" )( EntriesOfHomalgMatrixAsListList( mat ) );
    fi;
 end );

 ##
InstallMethod( TwistedOmegaModuleOp,
          [ IsExteriorRing, IsInt ],
  function( A, i )
    
    return GradedFreeLeftPresentation( 1, A, [ Length( IndeterminatesOfExteriorRing( A ) ) - i ] );
    
end );

##
InstallMethod( BasisBetweenTwistedOmegaModules,
          [ IsExteriorRing, IsInt, IsInt ],
  function( A, i, j )
    local n, omega_i, omega_j, G, indeterminates, combinations, index, L;
    
    omega_i :=TwistedOmegaModule( A, i );
    
    omega_j :=TwistedOmegaModule( A, j );
    
    indeterminates := IndeterminatesOfExteriorRing( A );
    
    n := Length( indeterminates );

    if i < j then
        return [  ];
    fi;

    if i = j then
        return [ IdentityMorphism( TwistedOmegaModule( A, i ) ) ];
    fi;

    if i = j + 1 then
        G := List( indeterminates, ind -> HomalgMatrix( [ [ ind ] ], 1, 1, A ) );
        return List( G, g -> GradedPresentationMorphism( omega_i, g, omega_j ) );
    elif i = j + n then
        G := HomalgMatrix( [ [ Product( indeterminates ) ] ], 1, 1, A );
        return [ GradedPresentationMorphism( omega_i, G, omega_j ) ];
    elif i > j + n then
        return [  ];
    else
        G := Reversed( List( [ 1 .. n - 1 ], k -> BasisBetweenTwistedOmegaModules( A, k, k - 1 ) ) );
        index := n - i;
        combinations := Combinations( [ 1 .. n ], i - j );
        L := List( combinations, comb -> List( [ 1 .. i - j ], k-> G[ index + k - 1][ comb[ k ] ] ) );
        return List( L, l -> PreCompose( l ) );
    fi;

end );

##
InstallMethod( FullSubcategoryGeneratedByTwistedOmegaModules,
          [ IsExteriorRing ],
  function( A )
    local k, n, cat, omegas, full, FinalizeCategory;
    
    k := UnderlyingNonGradedRing( CoefficientsRing( A ) );
    
    if IsRationalsForHomalg( k ) then
      
      k := BBGG!.QQ;
      
    else
      
      Error( "This should not happen!" );
      
    fi;
    
    n := Size( Indeterminates( A ) );
    
    cat := GradedLeftPresentations( A );
    
    omegas := List( [ 0 .. n - 1 ], i -> TwistedOmegaModule( A, i ) );
    
    full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
    
    SetIsLinearCategoryOverCommutativeRing( full, true );
    
    SetCommutativeRingOfLinearCategory( full, k );
    
    AddIsEqualForObjects( full,
      function( a, b )
      
        return GeneratorDegrees( UnderlyingCell( a ) ) = GeneratorDegrees( UnderlyingCell( b ) );
        
    end );
   
    AddIsEqualForMorphisms( full,
      function( alpha, beta )
        
        return IsEqualForObjects( Source( alpha ), Source( beta ) ) and
                  IsEqualForObjects( Range( alpha ), Range( beta ) ) and
                    UnderlyingMatrix( UnderlyingCell( alpha ) ) = UnderlyingMatrix( UnderlyingCell( beta ) );
        
    end );
    
    AddIsEqualForCacheForObjects( full, IsEqualForObjects );
    
    AddIsEqualForCacheForMorphisms( full, IsEqualForMorphisms );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
      function( e, alpha )
        local mat;
        
        alpha := UnderlyingCell( alpha );
        
        mat := UnderlyingMatrix( alpha );
        
        mat := ( e / A ) * mat;
        
        return GradedPresentationMorphism( Source( alpha ), mat, Range( alpha ) ) / full;
        
    end );
    
    ##
    AddBasisOfExternalHom( full,
      function( a, b )
        local cell_a, cell_b, twist_a, twist_b, B; 
        
        cell_a := UnderlyingCell( a );
        
        cell_b := UnderlyingCell( b );
        
        twist_a := HomalgElementToInteger( - GeneratorDegrees( cell_a )[ 1 ] ) + n;
        
        twist_b := HomalgElementToInteger( - GeneratorDegrees( cell_b )[ 1 ] ) + n;
        
        B := BasisBetweenTwistedOmegaModules( A, twist_a, twist_b );
        
        return List( B, m -> m / full );
        
    end );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
      function( alpha, B )
        
        if IsEmpty( B ) then
          
          return [ ];
          
        fi;
        
        alpha := UnderlyingMatrix( UnderlyingCell( alpha ) );
        
        if IsZero( alpha ) then
          
          return ListWithIdenticalEntries( Size( B ), Zero( k ) );
          
        fi;
        
        B := List( B, UnderlyingCell );
        
        B := List( B, UnderlyingMatrix );
        
        B := UnionOfRows( B );
        
        return EntriesOfHomalgMatrix( RightDivide( alpha, B ) * k );

    end );
    
    SetCachingOfCategoryCrisp( full );
    #DeactivateCachingOfCategory( full );
    CapCategorySwitchLogicOff( full );
    DisableSanityChecks( full );
    
    Finalize( full );
    
    return full;
    
end );  

##
InstallMethod( TwistedGradedFreeModuleOp,
    [ IsHomalgGradedRing, IsInt ],
    function( S, i )
      return GradedFreeLeftPresentation( 1, S, [ -i ] );
end );

##
InstallMethod( TwistedCotangentModuleAsCochainOp,
    [ IsHomalgGradedRing, IsInt ],
    function( S, i )
      local L, graded_lp_cat, cochains, Tr;
      L := LCochainFunctor( S );
      graded_lp_cat := GradedLeftPresentations( S );
      cochains := CochainComplexCategory( graded_lp_cat );
      Tr := BrutalTruncationAboveFunctor( cochains, -1 );
      return ShiftUnsignedLazy( ApplyFunctor( PreCompose( [ L, Tr ] ), TwistedOmegaModule( KoszulDualRing( S ), i ) ), -1 );
end );

##
InstallMethod( TwistedCotangentModuleAsChainOp,
    [ IsHomalgGradedRing, IsInt ],
    function( S, i )
      return AsChainComplex( TwistedCotangentModuleAsCochain( S, i ) );
end );

InstallMethod( TwistedCotangentModuleOp,
    [ IsHomalgGradedRing, IsInt ],
    function( S, i )
      local n, cotangent_sheaf_as_chain;
      
      n := Length( IndeterminatesOfPolynomialRing( S ) );
      
      if i < 0 or i > n - 1 then
        
          Error( Concatenation( "Twisted cotangent sheaves Ω^i(i) are defined only for i = 0,...,", String( n - 1 ) ) );
      
      fi;
      
      # NOTICE THIS
      
      if i = -1 then
        
          return GradedFreeLeftPresentation( 1, S, [ 0 ] );
          
      else
        
        cotangent_sheaf_as_chain := TwistedCotangentModuleAsChain( S, i );
        
        return CokernelObject( cotangent_sheaf_as_chain^1 );
        
      fi;
end );

##
InstallMethodWithCache( BasisBetweenTwistedGradedFreeModules,
    [ IsHomalgGradedRing, IsInt, IsInt ],
    function( S, u, v )
      local n, L, l, o_u, o_v, indeterminates;

      n := Length( IndeterminatesOfPolynomialRing( S ) );
      
      if u > v then
        
          return [ ];
          
      elif u = v then
      
          return [ IdentityMorphism( TwistedGradedFreeModule( S, u ) ) ];
          
      elif u = 0 then
      
          o_u := GradedFreeLeftPresentation( 1, S, [ 0 ] );
          
          o_v := GradedFreeLeftPresentation( 1, S, [ -v ] );

          L := Combinations( [ 1 .. n+v-u-1 ], v-u );
          
          L := List( L, l -> l - [ 0 .. v-u - 1 ] );
          
          indeterminates := IndeterminatesOfPolynomialRing( S );
          
          L := List( L, indices -> Product( List( indices, index -> indeterminates[index] ) ) );
          
          L := List( L, l -> HomalgMatrix( [[l]], 1, 1, S ) );
          
          return List( L, mat -> GradedPresentationMorphism( o_u, mat, o_v ) );
          
      else
          
          o_u := GradedFreeLeftPresentation( 1, S, [ -u ] );
          
          o_v := GradedFreeLeftPresentation( 1, S, [ -v ] );
          
          L := BasisBetweenTwistedGradedFreeModules( S, 0, v - u );
          
          return List( L, l -> GradedPresentationMorphism( o_u, UnderlyingMatrix( l ), o_v ) );

      fi;
end );

##
InstallMethodWithCache( BasisBetweenTwistedCotangentModules, 
    "this should return the basis of Hom( omega^i(i),omega^j(j) )",
    [ IsHomalgGradedRing, IsInt, IsInt ],
    function( S, i, j )
      local L, graded_lp_cat, cochains, Tr, Cok, F, B;
      
      L := LCochainFunctor( S );
      
      graded_lp_cat := GradedLeftPresentations( S );
      
      cochains := CochainComplexCategory( graded_lp_cat );
      
      Tr := BrutalTruncationAboveFunctor( cochains, -1 );
      
      Cok := CokernelObjectFunctor( cochains, graded_lp_cat, -2 );
      
      F := PreCompose( [ L, Tr, Cok ] );
      
      B := BasisBetweenTwistedOmegaModules( KoszulDualRing( S ), i, j );
      
      return List( B, b -> ApplyFunctor( F, b ) );
      
end );

InstallMethod( BeilinsonReplacement, 
    [ IsCapCategoryObject and IsBoundedChainComplex ],
    function( C )
      local TC, reg, chains, cat, cochains, S, n, L, Tr, Cok, BB, diff, diffs, rep;
      
      TC := TateResolution( C );
      reg := CastelnuovoMumfordRegularity( C );
      
      chains := CapCategory( C );
      cat := UnderlyingCategory( chains );
      cochains := CochainComplexCategory( cat );
      
      S := cat!.ring_for_representation_category; 
      n := Length( IndeterminatesOfPolynomialRing( S ) );
      
      L := LCochainFunctor( S );;
      Tr := BrutalTruncationAboveFunctor( cochains, -1 );
      Cok := CokernelObjectFunctor( cochains, cat, -2 );
      BB := PreCompose( [ L, Tr, Cok ] );
      
      diff := function(i)
              local B, b, d, u;
              B := BeilinsonReplacement( C );
              
              # very nice trick to improve speed and reduce computations
                           
              if i = reg then
                return ApplyFunctor( BB, TC^reg );
              elif i > reg then
                b := B^( i - 1 );
              #else
              #  b := B^( i + 1 );
              fi;
              
              if i> ActiveUpperBound( B ) + 2 then
                  return UniversalMorphismFromZeroObject( Source( B^( i - 1 ) ) );
              elif i<= ActiveLowerBound( B ) + 1 and not i > reg then
                  return UniversalMorphismIntoZeroObject( Range( B^( i + 1 ) ) );
              else
                  if i-1 in ComputedDifferentialAts( TC ) then
                      d := GeneratorDegrees( TC[ i-1 ] );
                      # It would be more secure to write j<1, but since the Tate res is minimal,
                      # there is no units in differentials matrices. Hence it is ok to write i<=1
                      # Tate is minimal because I am using homalg to compute the projective cover.
                      if ForAll( d, j -> j <= 1 ) then
                          u := UniversalMorphismFromZeroObject( TC[ i - 1 ] );
                          SetUpperBound( B, i - 1 );
                          return ApplyFunctor( BB, u );
                      else
                          return ApplyFunctor( BB, TC^i );
                      fi;
                  
                  elif i+1 in ComputedDifferentialAts( TC ) then
                      d := GeneratorDegrees( TC[ i ] );
                      # Same as above
                      if ForAll( d, j -> j >= n ) then
                          u := UniversalMorphismIntoZeroObject( TC[ i ] );
                          SetLowerBound( B, i );
                          return ApplyFunctor( BB, u );
                      else
                          return ApplyFunctor( BB, TC^i );
                      fi;
                  else    
                      return ApplyFunctor( BB, TC^i );
                  fi;
              
              fi;
              end;
      diffs := MapLazy( IntegersList, diff, 1 );
      rep := ChainComplex( cat, diffs );
      SetUpperBound( rep, ActiveUpperBound( C ) + n - 1 );
      SetLowerBound( rep, ActiveLowerBound( C ) - n + 1 );
      rep!.underlying_chain_complex := C;
      return rep;
end );

InstallMethod( BeilinsonReplacement, 
    [ IsCapCategoryMorphism and IsBoundedChainMorphism ],
    function( phi )
    local Tphi, chains, cochains, cat, S, n, L, Tr, Cok, BB, source, range, mor, mors, rep;
    Tphi := TateResolution( phi );
    chains := CapCategory( phi );
    cat := UnderlyingCategory( chains );
    cochains := CochainComplexCategory( cat );
    S := cat!.ring_for_representation_category;
    n := Length( IndeterminatesOfPolynomialRing( S ) );

    L := LCochainFunctor( S );;
    Tr := BrutalTruncationAboveFunctor( cochains, -1 );
    Cok := CokernelObjectFunctor( cochains, cat, -2 );
    BB := PreCompose( [ L, Tr, Cok ] );

    source := BeilinsonReplacement( Source( phi ) );
    range := BeilinsonReplacement( Range( phi ) );

    mor :=  function( i )
            local a, b, l, u, L;
            a := source[ i ];
            b := range[ i ];

            l := Maximum( ActiveLowerBound( source ), ActiveLowerBound( range ) ) - 1;
            u := Minimum( ActiveUpperBound( source ), ActiveUpperBound( range ) ) + 1;

            if i >= u or i <= l then
                return ZeroMorphism( a, b );
            else
                return ApplyFunctor( BB, Tphi[ i ] );
            fi;

            end;
            
    mors := MapLazy( IntegersList, mor, 1 );
    
    rep := ChainMorphism( source, range, mors );
    
    return rep;
    
end );

InstallMethod( BeilinsonReplacement,
    [ IsCapCategoryObject and IsGradedLeftPresentation ],
    function( M )
    local R;
    R := UnderlyingHomalgRing( M );
    if HasIsExteriorRing( R ) and IsExteriorRing( R ) then
        TryNextMethod(  );
    else
        return BeilinsonReplacement( StalkChainComplex( M, 0 ) );
    fi;
end );

InstallMethod( BeilinsonReplacement,
    [ IsCapCategoryMorphism and IsGradedLeftPresentationMorphism ],
    function( phi )
    local R;
    R := UnderlyingHomalgRing( phi );
    if HasIsExteriorRing( R ) and IsExteriorRing( R ) then
        TryNextMethod(  );
    else
        return BeilinsonReplacement( StalkChainMorphism( phi, 0 ) );
    fi;
end );

InstallMethod( BeilinsonReplacement, 
    [ IsCapCategoryObject and IsGradedLeftPresentation ],
    function( P )
    local R, TP, reg, S, cat, chains, cochains, n, L, Tr, Cok, BB, diff, diffs, rep;

    R := UnderlyingHomalgRing( P );
    if HasIsExteriorRing( R ) and IsExteriorRing( R ) then

    TP := TateResolution( P );
    reg := 0;
    S := KoszulDualRing( R );

    cat := GradedLeftPresentations( S );
    
    chains := ChainComplexCategory( cat );
    cochains := CochainComplexCategory( cat );
    n := Length( IndeterminatesOfExteriorRing( R ) );
    
    L := LCochainFunctor( S );;
    Tr := BrutalTruncationAboveFunctor( cochains, -1 );
    Cok := CokernelObjectFunctor( cochains, cat, -2 );
    BB := PreCompose( [ L, Tr, Cok ] );

    diff := function(i)
            local B, b, d, u, L;
            B := BeilinsonReplacement( P );
            
            # very nice trick to improve speed and reduce computations
            if i < reg then
                b := B^( i + 1 );
            elif i> reg then
                b := B^( i - 1 );
            fi;

            if ( HasActiveUpperBound( B ) and i >= ActiveUpperBound( B ) + 1 ) or
                ( HasActiveLowerBound( B ) and i <= ActiveLowerBound( B ) - 1 ) then
                return ZeroObjectFunctorial( cat );
            else
                if i - 1 in ComputedDifferentialAts( TP ) then
                    d := GeneratorDegrees( TP[ i - 1 ] );
                    # It would be more secure to write j<1, but since the Tate res is minimal,
                    # there is no units in differentials matrices. Hence it is ok to write i<=1
                    # Tate is minimal because I am using homalg to compute the projective cover.
                    if ForAll( d, j -> j <= 1 ) then
                        u := UniversalMorphismFromZeroObject( TP[ i - 1 ] );
                        SetUpperBound( B, i - 1 );
                        return ApplyFunctor( BB, u );
                    else
                        return ApplyFunctor( BB, TP^i );
                    fi;
                
                elif i+1 in ComputedDifferentialAts( TP ) then
                    d := GeneratorDegrees( TP[ i ] );
                    # Same as above
                    if ForAll( d, j -> j >= n ) then
                        u := UniversalMorphismIntoZeroObject( TP[ i ] );
                        SetLowerBound( B, i );
                        return ApplyFunctor( BB, u );
                    else
                        return ApplyFunctor( BB, TP^i );
                    fi;
                else
                    return ApplyFunctor( BB, TP^i );
                fi;

            fi;
            end;

    diffs := MapLazy( IntegersList, diff, 1 );
    rep := ChainComplex( cat, diffs );
    return rep;
    else
        TryNextMethod();
    fi;

end );

##
InstallMethod( BeilinsonReplacement,
    [ IsCapCategoryMorphism and IsGradedLeftPresentationMorphism ],
    function( phi )
    local R, Tphi, S, cat, cochains, n, L, Tr, Cok, BB, source, range, mor, mors, rep;
    
    R := UnderlyingHomalgRing( phi );
    if HasIsExteriorRing( R ) and IsExteriorRing( R ) then

        Tphi := TateResolution( phi );
        S := KoszulDualRing( R );
        cat := GradedLeftPresentations( S );
        cochains := CochainComplexCategory( cat );
        n := Length( IndeterminatesOfPolynomialRing( S ) );
        
        L := LCochainFunctor( S );;
        Tr := BrutalTruncationAboveFunctor( cochains, -1 );
        Cok := CokernelObjectFunctor( cochains, cat, -2 );
        BB := PreCompose( [ L, Tr, Cok ] );

        source := BeilinsonReplacement( Source( phi ) );
        range := BeilinsonReplacement( Range( phi ) );

        mor :=  function( i )
                local a, b, l, u, L;
                a := source[ i ];
                b := range[ i ];
            
                l := -infinity;
                u := infinity;

                if HasActiveLowerBound( source ) and HasActiveLowerBound( range ) then
                    l := Maximum( ActiveLowerBound( source ), ActiveLowerBound( range ) ) - 1;
                fi;
            
                if HasActiveUpperBound( source ) and HasActiveUpperBound( range ) then
                    u := Minimum( ActiveUpperBound( source ), ActiveUpperBound( range ) ) + 1;
                fi;

                if i >= u or i <= l then
                    return ZeroMorphism( a, b );
                else
                   return ApplyFunctor( BB, Tphi[i] );
                fi;
              
              end;
                
        mors := MapLazy( IntegersList, mor, 1 );
        
        rep := ChainMorphism( source, range, mors );
        
        return rep;
      
    else
        
      TryNextMethod(  );
       
    fi;
end );

##
InstallMethod( BeilinsonReplacement,
  [ IsSerreQuotientCategoryByThreeArrowsObject ],
  function( P )
    local sheafification, b;
    sheafification := CanonicalProjection( CapCategory( P ) );
    sheafification := ExtendFunctorToChainComplexCategories( sheafification );
    b := BeilinsonReplacement( UnderlyingHonestObject( P ) );
    return ApplyFunctor( sheafification, b );
end );

##
InstallMethod( BeilinsonReplacement,
  [ IsSerreQuotientCategoryByThreeArrowsMorphism ],
  function( phi )
    local coh, sheafification, generalized_morphism, b_source_aid, b_arrow, b_range_aid, mors;
    coh := CapCategory( phi );
    sheafification := CanonicalProjection( coh );
    sheafification := ExtendFunctorToChainComplexCategories( sheafification );
    generalized_morphism := UnderlyingGeneralizedMorphism( phi );
    b_source_aid := BeilinsonReplacement( SourceAid( generalized_morphism ) );
    b_arrow := BeilinsonReplacement( Arrow( generalized_morphism ) );
    b_range_aid := BeilinsonReplacement( RangeAid( generalized_morphism ) );
    b_source_aid := ApplyFunctor( sheafification, b_source_aid );
    b_arrow := ApplyFunctor( sheafification, b_arrow );
    b_range_aid := ApplyFunctor( sheafification, b_range_aid );
    mors := MapLazy( IntegersList,
      i -> SerreQuotientCategoryByThreeArrowsMorphism(
        coh, GeneralizedMorphismByThreeArrows( b_source_aid[i], b_arrow[i], b_range_aid[i] ) ), 1 );
    return ChainMorphism( Range( b_source_aid ), Source( b_range_aid ), mors );
end );

##
InstallMethodWithCache( RECORD_TO_MORPHISM_OF_TWISTED_COTANGENT_SHEAVES,
        [ IsHomalgGradedRing, IsRecord ],
    function( S, record )
    local cat, projectives, coefficients, u, v, source, range;

    cat := GradedLeftPresentations( S );
    
    u := record!.indices[ 1 ];
    v := record!.indices[ 2 ];

    if u = -1 and v = -1 then
        return ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) );
    elif v = -1 then
        return UniversalMorphismIntoZeroObject( TwistedCotangentModule( S, u ) );
    elif  u = -1 then
        return UniversalMorphismFromZeroObject( TwistedCotangentModule( S, v ) );
    fi;

    if record!.coefficients = [] then
        source := TwistedCotangentModule( S, u );
        range :=  TwistedCotangentModule( S, v );
        return ZeroMorphism( source, range );
    else
        coefficients := List( record!.coefficients, c -> String( c )/S );
        return coefficients*BasisBetweenTwistedCotangentModules( S, u, v );
    fi;                     

end );


##
InstallMethodWithCache( LIST_OF_RECORDS_TO_MORPHISM_OF_TWISTED_COTANGENT_SHEAVES,
        [ IsHomalgGradedRing, IsList ],
    function( S, L )
    local mor;
    mor :=  MorphismBetweenDirectSums(
        List( L, l -> List( l, m -> RECORD_TO_MORPHISM_OF_TWISTED_COTANGENT_SHEAVES( S, m ) ) ) );
    mor!.UNDERLYING_LIST_OF_RECORDS := L;
    return mor;
end );

##
InstallMethod( MORPHISM_OF_TWISTED_OMEGA_MODULES_AS_LIST_OF_RECORDS,
    [ IsGradedLeftPresentationMorphism ],
    function( phi )
      local K, n, degrees_source, degrees_range, coefficients, index_1, index_2, B, A, sol, source_factors, positions_source, range_factors, positions_range, L, matrix;
    
    K := UnderlyingHomalgRing( phi );
    
    n := Length( IndeterminatesOfExteriorRing( K ) );
    
    degrees_source := GeneratorDegrees( Source( phi ) );
    
    degrees_range  := GeneratorDegrees( Range( phi ) );

    if NrRows( UnderlyingMatrix( Source( phi ) ) ) <> 0 or
      
        NrRows( UnderlyingMatrix( Range( phi ) ) ) <> 0 then
        
          Error( "The source and range should be free modules" );
    
    fi;

    if Length( degrees_source ) <= 1 and Length( degrees_range ) <= 1 then

      if degrees_source = [  ] and degrees_range = [  ] then
        
        return [ [ rec( indices := [ -1, -1 ], coefficients := [] ) ] ];
          
      elif degrees_source = [  ] and not HomalgElementToInteger( degrees_range[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ -1, -1  ], coefficients := [  ] ) ] ];
        
      elif degrees_source = [  ] and HomalgElementToInteger( degrees_range[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ -1, n - HomalgElementToInteger( degrees_range[ 1 ] ) ], coefficients := [] ) ] ];
        
      elif degrees_range = [ ] and not HomalgElementToInteger( degrees_source[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ -1, -1 ], coefficients := [] ) ] ];
        
      elif degrees_range = [ ] and HomalgElementToInteger( degrees_source[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ n - HomalgElementToInteger( degrees_source[ 1 ] ), -1 ], coefficients := [  ] ) ] ];
        
      elif not HomalgElementToInteger( degrees_source[ 1 ] ) in [ 1 .. n ] and
        not HomalgElementToInteger( degrees_range[ 1 ] ) in [ 1 .. n ] then
            
          return [ [ rec( indices := [ -1, -1  ], coefficients := [  ] ) ] ];
          
      elif not HomalgElementToInteger( degrees_source[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ -1, n - HomalgElementToInteger( degrees_range[ 1 ] ) ], coefficients := [  ] ) ] ];
        
      elif not HomalgElementToInteger( degrees_range[ 1 ] ) in [ 1 .. n ] then
      
        return [ [ rec( indices := [ n - HomalgElementToInteger( degrees_source[ 1 ] ), -1 ], coefficients := [  ] ) ] ];
          
      elif IsZeroForMorphisms( phi ) then
      
        return [ [ rec(  indices := [ n - HomalgElementToInteger( degrees_source[1] ),
                                        n - HomalgElementToInteger( degrees_range[1] ) ], 
                                          coefficients := [  ] ) ] ];
      
      else
        
        index_1 := n - HomalgElementToInteger( degrees_source[ 1 ] );
        
        index_2 := n - HomalgElementToInteger( degrees_range[ 1 ] );

        B := BasisBetweenTwistedOmegaModules( K, index_1, index_2 );
        
        B := List( B, UnderlyingMatrix );
        
        B := UnionOfRows( B );
        
        A := UnderlyingMatrix( phi );
        
        sol := EntriesOfHomalgMatrix( RightDivide( A, B ) );
        
        return [ [ rec( indices := [ index_1, index_2 ], coefficients := sol ) ] ];
        
      fi;
      
    else
        
      degrees_source := List( degrees_source, HomalgElementToInteger );
      
      source_factors := List( degrees_source, d -> GradedFreeLeftPresentation( 1, K, [ d ] ) );
      
      positions_source := PositionsProperty( degrees_source, d -> d in [ 1 .. n ] );
       
      degrees_range := List( degrees_range, HomalgElementToInteger );
      
      range_factors := List( degrees_range, d -> GradedFreeLeftPresentation( 1, K, [ d ] ) );
      
      positions_range := PositionsProperty( degrees_range, d -> d in [ 1 .. n ] );
      
      if positions_source = [ ] and positions_range = [ ] then
        
        return [ [ rec( indices := [ -1, -1  ], coefficients := [  ] ) ] ];
        
      elif positions_source = [ ] then
        
        L := [ List( positions_range, p -> UniversalMorphismFromZeroObject( range_factors[ p ] ) ) ];
        
      elif positions_range = [ ] then
        
        L := List( positions_source, p -> [ UniversalMorphismIntoZeroObject( source_factors[ p ] ) ] );
        
      else
        
        matrix := UnderlyingMatrix( phi );
        
        L := List( positions_source, u ->
        
          List( positions_range, v ->
          
            GradedPresentationMorphism(
            
              source_factors[ u ],
              
              HomalgMatrix( [ matrix[ u, v ] ], 1, 1, K ),
              
              range_factors[ v ]
              
          ) ) );
        
      fi;

      L := List( L, l -> List( l, m -> MORPHISM_OF_TWISTED_OMEGA_MODULES_AS_LIST_OF_RECORDS(m)[1][1] ) );

      L := Filtered( L, l -> not ForAll( l, r -> r.indices = [ -1, -1 ] ) );
      
      if L = [  ] then
        
        return [[ rec( indices := [ -1, -1  ], coefficients := [  ] ) ]];
        
      else
        
        return L;
      
      fi;
    
    fi;
  
end );

##
InstallMethodWithCache( PATH_FROM_j_TO_i_THROUGHT_TATE_COCHAIN,
    [ IsInt, IsInt, IsGradedLeftPresentation ],
    function( j, i, M )
      local S, graded_lp_cat_sym, coh, t, L, g_morphisms, Lt_k, H, V, span_to_3_arrows, k;
      
      if j <= i then
        Error( "the first argument should be greater than the second!" );
      fi;

      if i < CastelnuovoMumfordRegularity( M ) then
        Error( "the second argument should be greater than the regularity of the left module" );
      fi;

      S := UnderlyingHomalgRing( M );

      graded_lp_cat_sym := GradedLeftPresentations( S );

      coh := CoherentSheavesOverProjectiveSpace( S );

      t := AsCochainComplex( TateResolution( M ) );

      L := LCochainFunctor( S );

      g_morphisms := [  ];

      for k in [ i .. j - 1 ] do
        Lt_k := ApplyFunctor( L, t^k );
        H := Lt_k[ -k - 1 ];
        V := Source( Lt_k )^( -k - 1 );
        Add( g_morphisms, GeneralizedMorphismBySpan( H, V ) );
      od;
    
      span_to_3_arrows := FunctorFromSpansToThreeArrows( graded_lp_cat_sym );;

      Info( InfoBBGG, 1, "Converting span to 3-arrows ..." );  
      g_morphisms := List( g_morphisms, g -> ApplyFunctor( span_to_3_arrows, g ) );
      Info( InfoBBGG, 1, "Converting span to 3-arrows is done!" );
 
      return SerreQuotientCategoryMorphism( coh, PostCompose( g_morphisms ) );

end );

##
InstallMethodWithCache( PATH_FROM_j_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN,
    [ IsInt, IsGradedLeftPresentation ], 
    function( j, M )
    local S, t, L, g_morphisms, k, Lt_0, Lt_k, H, V, H0, V0, mor0, coh, 
    graded_lp_cat_sym, span_to_3_arrows, BM, mor_1, mor_2;

    S := UnderlyingHomalgRing( M );
    
    graded_lp_cat_sym := GradedLeftPresentations( S );

    coh := CoherentSheavesOverProjectiveSpace( S );

    t := AsCochainComplex( TateResolution( M ) );

    L := LCochainFunctor( S );
    
    BM := BeilinsonReplacement( M );
    
    mor_1 := GeneralizedProjectionOntoHomologyAt( BM, 0 );
    
    Lt_0 := ApplyFunctor( L, t^0 );

    H0 := Lt_0[ -1 ];
    V0 := CokernelProjection( Source( Lt_0 )^-2 );
    
    mor_2 := GeneralizedMorphismBySpan( H0, V0 );
    
    g_morphisms := [ mor_1, mor_2 ];
    
    for k in [ 1 .. j - 1 ] do
        Lt_k := ApplyFunctor( L, t^k );
        H := Lt_k[ -k - 1 ];
        V := Source( Lt_k )^( -k - 1 );
        Add( g_morphisms, GeneralizedMorphismBySpan( H, V ) );
    od;
    
    span_to_3_arrows := FunctorFromSpansToThreeArrows( graded_lp_cat_sym );; 

    Info( InfoBBGG, 1, "Converting span to 3-arrows ..." );  
    g_morphisms := List( g_morphisms, g -> ApplyFunctor( span_to_3_arrows, g ) );
    Info( InfoBBGG, 1, "Converting span to 3-arrows is done!" );
    
    return SerreQuotientCategoryMorphism( coh, PostCompose( g_morphisms ) );

end );

##
InstallMethodWithCache( PATH_FROM_j_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN,
    [ IsInt, IsGradedLeftPresentation ], 
    function( j, M )
    local S, t, L, g_morphisms, k, Lt_0, Lt_k, H, V, H0, V0, mor0, coh, 
    graded_lp_cat_sym, span_to_3_arrows, BM, mor_1;

    S := UnderlyingHomalgRing( M );
    
    graded_lp_cat_sym := GradedLeftPresentations( S );

    coh := CoherentSheavesOverProjectiveSpace( S );

    t := AsCochainComplex( TateResolution( M ) );

    L := LCochainFunctor( S );
    
    BM := BeilinsonReplacement( M );
    
    Lt_0 := ApplyFunctor( L, t^0 );

    H0 := Lt_0[ -1 ];
    V0 := CokernelProjection( Source( Lt_0 )^-2 );
    
    mor_1 := GeneralizedMorphismBySpan( H0, V0 );
    
    g_morphisms := [ mor_1 ];
    
    for k in [ 1 .. j - 1 ] do
        Lt_k := ApplyFunctor( L, t^k );
        H := Lt_k[ -k - 1 ];
        V := Source( Lt_k )^( -k - 1 );
        Add( g_morphisms, GeneralizedMorphismBySpan( H, V ) );
    od;
   
    span_to_3_arrows := FunctorFromSpansToThreeArrows( graded_lp_cat_sym );; 
    
    Info( InfoBBGG, 1, "Converting span to 3-arrows ..." );  
    g_morphisms := List( g_morphisms, g -> ApplyFunctor( span_to_3_arrows, g ) );
    Info( InfoBBGG, 1, "Converting span to 3-arrows is done!" );
    

    Info( InfoBBGG, 1, "Computing Postcompose of generalized morphisms given by 3-arrows ..." );  
    mor_1 := SerreQuotientCategoryMorphism( coh, PostCompose( g_morphisms ) );
    Info( InfoBBGG, 1, "Computing Postcompose of generalized morphisms given by 3-arrows is done!" );  
    
    return mor_1;

end );


InstallMethodWithCache( TRUNCATION_MORPHISM,
    [ IsInt, IsGradedLeftPresentation ],
function( i, M )
    local S, coh, Sh, hM, G, mor, F;
    
    S := UnderlyingHomalgRing( M );

    coh := CoherentSheavesOverProjectiveSpace( S );
    
    Sh := CanonicalProjection( coh );

    hM := AsPresentationInHomalg( M );
    
    SetPositionOfTheDefaultPresentation( hM, 1 );
    
    G := GeneratorsOfHomogeneousPart( i, hM );
    
    F := GradedFreeLeftPresentation( NrRows( G ), S, List( [ 1 .. NrRows( G ) ], j -> i ) );

    mor := GradedPresentationMorphism( F, G, M );
    
    return ApplyFunctor( Sh, mor );

end );

##
InstallMethodWithCache( MORPHISM_FROM_GLP_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT,
    [ IsInt, IsGradedLeftPresentation ],
    function( i, M )
      local S, coh, alpha, beta;
      
      if i <= CastelnuovoMumfordRegularity( M ) then
        Error( "The given integer should be greater or equal to reg(M)+1!" );
      fi;

      S := UnderlyingHomalgRing( M );

      coh := CoherentSheavesOverProjectiveSpace( S );

      alpha := TRUNCATION_MORPHISM( i, M );
      
      alpha := UnderlyingGeneralizedMorphism( alpha );

      beta := PATH_FROM_j_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN( i, M );
      
      beta := UnderlyingGeneralizedMorphism( beta );

      return SerreQuotientCategoryMorphism( coh, PreCompose( PseudoInverse( alpha ), beta ) );

end );

##
InstallMethodWithCache( MORPHISM_FROM_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_TO_GLP,
    [ IsInt, IsGradedLeftPresentation ],
    function( i, M )
      local S, coh, alpha, beta;
      
      S := UnderlyingHomalgRing( M );
      
      coh := CoherentSheavesOverProjectiveSpace( S );

      alpha := TRUNCATION_MORPHISM( i, M );
      
      alpha := UnderlyingGeneralizedMorphism( alpha );
      
      beta := PATH_FROM_j_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN( i, M );
      
      beta := UnderlyingGeneralizedMorphism( beta );
      
      return SerreQuotientCategoryMorphism( coh, PreCompose( PseudoInverse( beta ), alpha ) );

end );


##
InstallMethodWithCache( MORPHISM_FROM_GLP_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT,
    [ IsInt, IsGradedLeftPresentation ],
    function( i, M )
      local S, coh, alpha, beta;
      
      if i <= CastelnuovoMumfordRegularity( M ) then
        Error( "The given integer should be greater or equal to reg(M)+1!" );
      fi;

      S := UnderlyingHomalgRing( M );

      coh := CoherentSheavesOverProjectiveSpace( S );

      alpha := TRUNCATION_MORPHISM( i, M );
      
      alpha := UnderlyingGeneralizedMorphism( alpha );

      beta := PATH_FROM_j_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN( i, M );
      
      beta := UnderlyingGeneralizedMorphism( beta );

      return SerreQuotientCategoryMorphism( coh, PreCompose( PseudoInverse( alpha ), beta ) );

end );

##
InstallMethodWithCache( MORPHISM_FROM_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_TO_GLP,
    [ IsInt, IsGradedLeftPresentation ],
    function( i, M )
      local S, coh, alpha, beta;
      
      S := UnderlyingHomalgRing( M );
      
      coh := CoherentSheavesOverProjectiveSpace( S );

      alpha := TRUNCATION_MORPHISM( i, M );
      
      alpha := UnderlyingGeneralizedMorphism( alpha );
      
      beta := PATH_FROM_j_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN( i, M );
      
      beta := UnderlyingGeneralizedMorphism( beta );
      
      return SerreQuotientCategoryMorphism( coh, PreCompose( PseudoInverse( beta ), alpha ) );

end );

##
InstallMethod( MorphismFromZerothObjectOfBeilinsonReplacementToGLP,
    [ IsGradedLeftPresentation ],

    function( M )
      local reg;
      
      reg := HomalgElementToInteger( CastelnuovoMumfordRegularity( M ) );
      
      reg := Maximum( 2, Filtered( [ reg + 1, reg + 2 ], IsEvenInt )[ 1 ] );
      
      return MORPHISM_FROM_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_TO_GLP( reg, M );

end );

##
InstallMethod( MorphismFromZerothHomologyOfBeilinsonReplacementToGLP,
    [ IsGradedLeftPresentation ],

    function( M )
      local reg;
      
      reg := HomalgElementToInteger( CastelnuovoMumfordRegularity( M ) );
      
      reg := Maximum( 2, Filtered( [ reg + 1, reg + 2 ], IsEvenInt )[ 1 ] );
 
      return MORPHISM_FROM_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_TO_GLP( reg, M );

end );

##
InstallMethod( MorphismFromGLPToZerothObjectOfBeilinsonReplacement,
    [ IsGradedLeftPresentation ],

    function( M )
      local reg;
      
      reg := HomalgElementToInteger( CastelnuovoMumfordRegularity( M ) );
      
      reg := Maximum( 2, Filtered( [ reg + 1 , reg + 2 ], IsEvenInt )[ 1 ] );
      
      return MORPHISM_FROM_GLP_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT( reg, M );

end );

##
InstallMethod( MorphismFromGLPToZerothHomologyOfBeilinsonReplacement,
    [ IsGradedLeftPresentation ],

    function( M )
      local reg;
      
      reg := HomalgElementToInteger( CastelnuovoMumfordRegularity( M ) );
      
      reg := Maximum( 2, Filtered( [ reg + 1, reg + 2 ], IsEvenInt )[ 1 ] ); 

      return MORPHISM_FROM_GLP_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT( reg, M );

end );


DeclareAttribute( "DECOMPOSE_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES", IsGradedLeftPresentation );
InstallMethod( DECOMPOSE_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES, [ IsGradedLeftPresentation ],
function( M )
  local S, n, L, dimensions, non_zeros, func, non_zero_elements_in_first_row_and_column;

  S := UnderlyingHomalgRing( M );
  n := Length( Indeterminates( S ) );
  L := List( [ 1 .. n-1 ], i -> UnderlyingMatrix( TwistedCotangentModule( S, i-1 ) ) );
  Add( L, SyzygiesOfColumns( L[ 1 ] ), 1 );
  dimensions := List( L, l -> [ NrRows( l ), NrCols( l ) ] );
  
  non_zero_elements_in_first_row_and_column :=
    function( mat )
      local row_1, col_1;
      if NrRows( mat ) * NrCols( mat ) = 0 then
        return [ 0, 0 ];
      fi;
      col_1 := EntriesOfHomalgMatrix( CertainColumns( mat, [ 1 ] ) );
      col_1 := Length( Filtered( col_1, e -> not IsZero( e ) ) );
      row_1 := EntriesOfHomalgMatrix( CertainRows( mat, [ 1 ] ) );
      row_1 := Length( Filtered( row_1, e -> not IsZero( e ) ) );
      return [ col_1, row_1 ];
  end;
  
  non_zeros := List( L, non_zero_elements_in_first_row_and_column );

  func := function( M )
    local m, non_zeros_m, p, current_m, current_M;

    m := UnderlyingMatrix( M );

    if NrCols( m ) = 0 then

      return [  ];

    fi;
    
    non_zeros_m := non_zero_elements_in_first_row_and_column( m );

    if non_zeros_m[ 1 ] = 0 and GeneratorDegrees( M )[ 1 ] = 1 then

      current_m := CertainColumns( m, [ 2 .. NrCols( m ) ] );
      current_M := AsGradedLeftPresentation( current_m, GeneratorDegrees( M ){ [  2 .. NrCols( m ) ] } );
      return Concatenation( [ n-1 ], func( current_M  ) );

    elif non_zeros_m[ 1 ] = 0 and GeneratorDegrees( M )[ 1 ] = 0 then

      current_m := CertainColumns( m, [ 2 .. NrCols( m ) ] );
      current_M := AsGradedLeftPresentation( current_m, GeneratorDegrees( M ){ [  2 .. NrCols( m ) ] } );
      return Concatenation( [ 0 ], func( CertainColumns( m, [ 2 .. NrCols( m ) ] ) ) );

    elif non_zeros_m[ 1 ] <> 0 and non_zeros_m[ 2 ] = 0 then

      current_m := CertainRows( m, [ 2 .. NrRows( m ) ] );
      current_M := AsGradedLeftPresentation( current_m, GeneratorDegrees( M ) );
      return func( current_M );

    else

      p := Position( non_zeros, non_zeros_m );

      if p <> fail then

        current_m := CertainRows( CertainColumns( m, [ dimensions[p][ 2 ] + 1 .. NrCols( m ) ] ), [ dimensions[p][ 1 ] + 1 .. NrRows( m ) ] );
        current_M := AsGradedLeftPresentation( current_m, GeneratorDegrees( M ){ [ dimensions[p][ 2 ] + 1 .. NrCols( m ) ] } );
        return Concatenation(  [ p - 2 ], func( current_M ) );

      else

        return [ fail ];

      fi;

    fi;

  end;

  return func( M );

end );

DeclareAttribute( "CANONICALIZE_MORPHISM_OF_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES", IsGradedLeftPresentation );
InstallMethod( CANONICALIZE_MORPHISM_OF_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES,
  [ IsGradedLeftPresentation ],
  function( M )
    local mat, dec, S, syz, zero_sheaf, omega_00, n, L, sources, ranges, mor;
    
    if IsBound( M!.canonicalized ) and M!.canonicalized = true then
      
      return IdentityMorphism( M );
      
    fi;

    mat := UnderlyingMatrix( M );
    
    dec := DECOMPOSE_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES( M );
    
    if dec = [  ] then
      
      return UniversalMorphismIntoZeroObject( M );
      
    fi;

    S := UnderlyingHomalgRing( M );
    
    syz := SyzygiesOfColumns( UnderlyingMatrix( TwistedCotangentModule( S, 0 ) ) );
    
    zero_sheaf := AsGradedLeftPresentation( syz, [ 1 ] );
    
    omega_00 := GradedFreeLeftPresentation( 1, S, [ 0 ] );

    n := Length( dec );

    L := List( [ 1 .. n ],
    
          function( i )

            if dec[ i ] = -1 then
              
              return UniversalMorphismIntoZeroObject( zero_sheaf );
              
            elif dec[ i ] = 0 then
            
              return GradedPresentationMorphism( TwistedCotangentModule( S, 0 ), syz, omega_00 );
              
            else
              
              return IdentityMorphism( TwistedCotangentModule( S, dec[ i ] ) );
              
            fi;
            
          end );

    sources := List( L, Source );
    
    ranges := List( L, Range );
    
    mor := List( [ 1 .. n ], 
              i -> List( [ 1 .. n ],
              
                function( j )
                
                   if i = j then
                     
                     return L[ i ];
                     
                   else
                     
                     return ZeroMorphism( sources[ i ], ranges[ j ] );
                     
                   fi;
                   
                end ) );

    mor := MorphismBetweenDirectSums( mor );
    
    mor := GradedPresentationMorphism( M, UnderlyingMatrix( mor ), Range( mor ) );

    Range( mor )!.canonicalized := true;

    return mor;

end );

DeclareAttribute( "CANONICALIZE_FUNCTOR", IsHomalgGradedRing );
 
InstallMethod( CANONICALIZE_FUNCTOR,
          [ IsHomalgGradedRing ],
  function( S )
    local cat, Can;
    
    cat := GradedLeftPresentations( S );
    Can := CapFunctor( "canonicalize direct sums of twisted cotangent sheaves", cat, cat );
    
    AddObjectFunction( Can,
      function( M )
        return Range( CANONICALIZE_MORPHISM_OF_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES( M ) );
    end );
    
    AddMorphismFunction( Can,
      function( source, phi, range )
        local s, r, psi;
        s := CANONICALIZE_MORPHISM_OF_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES( Source( phi ) );
        r := CANONICALIZE_MORPHISM_OF_DIRECT_SUM_OF_TWISTED_COTANGENT_SHEAVES( Range( phi ) );
        return Colift( s, PreCompose( phi, r ) );
    end );
    
    return Can;
    
end );

######################################
#
# Full subcategories
#
######################################

##
InstallMethod( FullSubcategoryGeneratedByTwistedCotangentModules,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
  function( S )
    local graded_pres, k, coh, generalized_morphism_cat, sh, indeterminates, n, omegas, mats, dims, full;
    
    graded_pres := GradedLeftPresentations( S );
    
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
    
    if not IsRationalsForHomalg( k ) then
      
      Error( "The coefficient ring should be a rational homalg field" );
      
    fi;
    
    k := BBGG!.QQ;
         
    indeterminates := Indeterminates( S );
    
    n := Size( indeterminates );
    
    omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentModule( S, i ) );
    
    mats := List( omegas, UnderlyingMatrix );
    
    dims := List( mats, d -> [ NrRows( d ), NrCols( d ) ] );
    
    if not IsDuplicateFree( dims ) then
      
      Error( "This should not happen, please report this!\n" );
      
    fi;
    
    full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
               
    SetIsLinearCategoryOverCommutativeRing( full, true );
    
    SetCommutativeRingOfLinearCategory( full, k );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
      function( r, alpha )
        local coeff, beta;
                 
        beta := UnderlyingCell( alpha );
        
        beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
        
        beta := beta / full;
                  
        return beta;
        
    end, 99 );
   
    AddBasisOfExternalHom( full,
      function( M, N )
        local mat_M, dim_M, index_M, mat_N, dim_N, index_N, B;
        
        mat_M := UnderlyingMatrix( UnderlyingCell( M ) );
        dim_M := [ NrRows( mat_M ), NrCols( mat_M ) ];
        index_M := Position( dims, dim_M ) - 1;
        
        mat_N := UnderlyingMatrix( UnderlyingCell( N ) );
        dim_N := [ NrRows( mat_N ), NrCols( mat_N ) ];
        index_N := Position( dims, dim_N ) - 1;
        
        if index_M = fail or index_N = fail then
          
          Error( "This should not happen!" );
          
        fi;
        
        B := BasisBetweenTwistedCotangentModules( S, index_M, index_N );
        
        B := List( B, b -> b / full );
        
        return B;
        
    end, 99 );
    
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
      function( phi, B )
        local mat, sol;
        
        if B = [  ] then
          
          return [  ];
          
        fi;
        
        phi := UnderlyingCell( phi );
        
        mat := UnderlyingMatrix( phi ) * k;
        
        mat := ConvertMatrixToRow( mat );
        
        B := List( B, UnderlyingCell );
        
        B := List( B, b -> UnderlyingMatrix( b ) * k );
        
        B := UnionOfRows( List( B, ConvertMatrixToRow ) );
        
        sol := RightDivide( mat, B );
        
        return EntriesOfHomalgMatrix( sol );
        
    end );
    
    Finalize( full );
    
    return full;
    
end );

##
InstallMethod( IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentModules,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
  function( S )
    local A, omegas, objects_omegas, Omegas, objects_Omegas, object_func, morphism_func, name;
    
    A := KoszulDualRing( S );
    
    omegas := FullSubcategoryGeneratedByTwistedOmegaModules( A );
    
    objects_omegas := SetOfKnownObjects( omegas );
    
    Omegas := FullSubcategoryGeneratedByTwistedCotangentModules( S );
    
    objects_Omegas := SetOfKnownObjects( Omegas );
    
    object_func := w -> objects_Omegas[ Position( objects_omegas, w ) ];
    
    morphism_func := alpha -> 
      BasisOfExternalHom( object_func( Source( alpha ) ), object_func( Range( alpha ) ) )
        [ Position( BasisOfExternalHom( Source( alpha ), Range( alpha ) ), alpha ) ];
        
    name := "Isomorphism functor from 𝛚_E(i)'s into 𝛀^i(i)'s as modules";
    
    return ValueGlobal( "FunctorFromLinearCategoryByTwoFunctions" )( name, omegas, Omegas, object_func, morphism_func );
    
end );

##
InstallMethod( IsomorphismFromFullSubcategoryGeneratedByTwistedCotangentModulesIntoTwistedCotangentSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
  function( S )
    local coh, sh, modules, sheaves, name, cell_func;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    modules := FullSubcategoryGeneratedByTwistedCotangentModules( S );
    
    sheaves := FullSubcategoryGeneratedByTwistedCotangentSheaves( S );
        
    name := "Isomorphism functor from 𝛀^i(i)'s as modules to 𝛀^i(i)'s as sheaves";
    
    cell_func := c -> ApplyFunctor( sh, UnderlyingCell( c ) ) / sheaves;
    
    return ValueGlobal( "FunctorFromLinearCategoryByTwoFunctions" )( name, modules, sheaves, cell_func, cell_func );
    
end );

##
InstallMethod( IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
    S -> PreCompose( IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentModules( S ),
            IsomorphismFromFullSubcategoryGeneratedByTwistedCotangentModulesIntoTwistedCotangentSheaves( S ) )
);

######################################
#
# ViewObj
#
####################################

##
InstallMethod( ViewObj,
          [ IsGradedLeftPresentation ],
  function( o )
    local S, n, omegas, p;
    
    S := UnderlyingHomalgRing( o );
    
    if not ( HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) ) then
      
      TryNextMethod( );
      
    fi;
   
    S := UnderlyingHomalgRing( o );
    
    n := Size( Indeterminates( S ) );
    
    omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentModule( S, i ) );
    
    p := Position( omegas, o );
    
    if p = fail then
      
      TryNextMethod( );
      
    fi;
    
    Print( "Ω^", p - 1, "(", p - 1, ")" );
    
end );

##
InstallMethod( ViewObj, 
    [ IsGradedLeftPresentation ],
  function( o )
    local S, twists, c, p;
    
    if not IsZero( NrRows( UnderlyingMatrix( o ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    S := UnderlyingHomalgRing( o );
    
    if not ( HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) ) then
      
      TryNextMethod( );
      
    fi;
    
    twists := -GeneratorDegrees( o );
    
    #Print( "An object in Serre quotient category defined by: " );
    
    if IsEmpty( twists ) then
      
      Print( "0" );
      return; 
    fi;
    
    c := [ ];
    
    while true do
      
      p := PositionProperty( twists, i -> i <> twists[ 1 ] );
      
      if p = fail then
        
        if Size( twists ) > 1 then
          
          Print( "S(", twists[ 1 ], ")^", Size( twists ) );
          
        else
          
          Print( "S(", twists[ 1 ], ")" );
          
        fi;
        
        break;
        
      else
        
        if p > 2 then
          
          Print( "S(", twists[ 1 ], ")^", p - 1, "⊕" );
        
        else
          
          Print( "S(", twists[ 1 ], ")⊕" );
          
        fi;
       
        twists := twists{ [ p .. Size( twists ) ] };
      
      fi;
      
    od;

end );

