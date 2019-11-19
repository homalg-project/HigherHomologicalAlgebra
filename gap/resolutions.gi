#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Resolutions
##
#############################################################################

###############################
#
# Resolutions
#
###############################

# version 1
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
                [ IsBoundedAboveCochainComplex ],
  
  function( C )
    local cat, u, zero, maps, r;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "It is not known whether the underlying category has enough projectives or not" );
    
    fi;
    
    if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "The underlying category must have enough projectives" );
    
    fi;
    
    u := ActiveUpperBound( C );
    
    zero := ZeroObject( cat );
    
    maps := MapLazy( IntegersList,
      function( k )
        local temp, m, p1, p2, ker, pk;
        
        if k >= u then
          
          return [ ZeroMorphism( zero, zero ), ZeroMorphism( zero, C[ k ] ) ];
        
        else
          
          temp := maps[ k + 1 ][ 1 ];
          
          m := MorphismBetweenDirectSums(
                        [
                          [ AdditiveInverse( temp ), maps[ k + 1 ][ 2 ] ],
                          [ ZeroMorphism( C[ k ], Range( temp ) ), C^k ]
                        ]
                      );
          
          p1 := ProjectionInFactorOfDirectSum( [ Source( temp ), C[ k ] ], 1 );
          
          p2 := ProjectionInFactorOfDirectSum( [ Source( temp ), C[ k ] ], 2 );
          
          ker := KernelEmbedding( m );
          
          pk := EpimorphismFromSomeProjectiveObject( Source( ker ) );
          
          return [ PreCompose( [ pk, ker, p1 ] ), PreCompose( [ pk, ker, p2 ] ), m ];
        
        fi;
      
      end, 1 );
    
    r := CochainComplex( cat, MapLazy( maps, function( j ) return j[ 1 ]; end, 1 ) );
    
    SetUpperBound( r, u );
    
    return CochainMorphism( r, C, 
      MapLazy( IntegersList,
        function( j )
          if j mod 2 = 0 then
            
            return  maps[ j ][ 2 ]; 
          
          else
            
            return AdditiveInverse( maps[ j ][ 2 ] );
          
          fi;
        
        end, 1 ) );
      
end );

##
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
        [ IsBoundedBelowChainComplex ], 
  function( C )
    
    return AsChainMorphism( QuasiIsomorphismFromProjectiveResolution( AsCochainComplex( C ) ) );
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedAboveCochainComplex ],
  function( C )
    
    return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
  
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedBelowChainComplex ],
  function( C )
    
    return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
  
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedAboveCochainMorphism ],
  function( phi )
    local C, D, q_C, p_C, q_D, p_D, u, maps;
    
    C := Source( phi );
    
    D := Range( phi );
    
    q_C := QuasiIsomorphismFromProjectiveResolution( C );
    
    p_C := Source( q_C );
    
    q_D := QuasiIsomorphismFromProjectiveResolution( D );
    
    p_D := Source( q_D );
    
    u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
    
    maps := MapLazy( IntegersList,
      function( k )
        local temp_C, temp_D, m, kappa, ep_C, ep_D;
        
        if k >= u then
          
          return ZeroMorphism( p_C[ k ], p_D[ k ] );
          
        else
          
          #temp_C := MorphismBetweenDirectSums(
          #              [
          #                [ AdditiveInverse( p_C^( k + 1) ), q_C[ k + 1 ] ],
          #                [ ZeroMorphism( C[ k ], p_C[ k + 2 ] ), C^k ]
          #              ]
          #            );
          
          #temp_D := MorphismBetweenDirectSums(
          #              [
          #                [ AdditiveInverse( p_D^( k + 1) ), q_D[ k + 1 ] ],
          #                [ ZeroMorphism( D[ k ], p_D[ k + 2 ] ), D^k ]
          #              ]
          #            );
          
          temp_C := BaseList( Differentials( p_C ) )[ k ][ 3 ];
          
          temp_D := BaseList( Differentials( p_D ) )[ k ][ 3 ];
         
          m := DirectSumFunctorial( [ maps[ k + 1 ], phi[ k ] ] );
          
          kappa := KernelObjectFunctorial( temp_C, m, temp_D );
          
          ep_C := EpimorphismFromSomeProjectiveObject( Source( kappa ) );
          
          ep_D := EpimorphismFromSomeProjectiveObject( Range( kappa ) );
          
          return ProjectiveLift( PreCompose( ep_C, kappa ), ep_D );
         
         fi;
         
      end, 1 );
    
    return CochainMorphism( p_C, p_D, maps );
    
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedBelowChainComplex ],
  function( phi )
    
    return AsChainMorphism( MorphismBetweenProjectiveResolutions( AsCochainMorphism( phi ) ) );
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedCochainComplex, IsBool ],
  function( C, bool )
    local p, i;
    
    p := ProjectiveResolution( C );
    
    if HasActiveLowerBound( p ) then
      
      return p;
    
    fi;
    
    i := ActiveLowerBound( C );
    
    while bool do
      
      if IsZeroForObjects( p[ i ] ) then
        
        SetLowerBound( p, i );
        
        return p;
      
      fi;
      
      i := i - 1;
    
    od;
    
    return p;
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedChainComplex, IsBool ],
  function( C, bool )
    local p, i;
    
    p := ProjectiveResolution( C );
    
    if HasActiveUpperBound( p ) then
      
      return p;
    
    fi;
    
    i := ActiveUpperBound( C );
    
    while bool do
        
      if IsZeroForObjects( p[ i ] ) then
        
        SetUpperBound( p, i );
        
        return p;
      
      fi;
      
      i := i + 1;
    
    od;
    
    return p;
    
end );

##
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
                [ IsBoundedChainOrCochainComplex, IsBool ],
  
  function( C, bool )
    local q;
    
    q := QuasiIsomorphismFromProjectiveResolution( C );
    
    ProjectiveResolution( C, bool );
    
    return q;

end );

#######################################
##
## resolutions of objects 
##
#######################################

InstallMethod( ProjectiveResolution,
       [ IsCapCategoryObject ],
function( obj )
  local func, C, cat, ep, ker, ep_ker, d;
  
  if IsBoundedAboveCochainComplex( obj ) or IsBoundedBelowChainComplex( obj ) then 
    
    TryNextMethod();
  
  fi;
  
  cat := CapCategory( obj );
  
  if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
    
    Error( "It is not known whether the category has enough projectives or not" );
  
  fi;
  
  if not IsAbelianCategoryWithEnoughProjectives( cat ) then 
    
    Error( "The category must have enough projectives" );
  
  fi;
  
  func := function( mor )
            local k,p; 
            k := KernelEmbedding( mor );
            p := EpimorphismFromSomeProjectiveObject( Source( k ) );
            return PreCompose( p, k );
          end;
  
  ep := EpimorphismFromSomeProjectiveObject( obj );
  
  ker := KernelEmbedding( ep );
  
  ep_ker := EpimorphismFromSomeProjectiveObject( Source( ker ) );
  
  d := PreCompose( ep_ker, ker );
  
  C := CochainComplexWithInductiveNegativeSide( d, func );
  
  return ShiftLazy( C, 1 );
  
end );

##
InstallMethod( ProjectiveResolution,
       [ IsCapCategoryObject, IsBool ],
  function( M, bool )
    local p, i;
    
    if IsChainOrCochainComplex( M ) then
      
      TryNextMethod();
    
    fi;
    
    p := ProjectiveResolution( M );
    
    if HasActiveLowerBound( p ) then
      
      return p;
      
    fi;
    
    i := 0;
    
    while bool do
      
      if IsZero( p[ i ] ) then
        
        SetLowerBound( p, i );
        
        return p;
        
      fi;
        
      i := i - 1;
      
      if IsZero( i mod 5000 ) then
        
        Error( "It seems that the object have infinite resolution; do you want me to continue trying? then return!\n" );
        
      fi;
     
    od;
    
    return p;
    
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
       [ IsCapCategoryMorphism ],
  function( phi )
    local cat, P, Q, func, maps, temp;
    
    if IsChainOrCochainMorphism( phi ) then
      
      TryNextMethod( );
    
    fi;
    
    cat := CapCategory( phi );
    
    if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "It is not known whether the category has enough projectives or not" );
    
    fi;
    
    if not IsAbelianCategoryWithEnoughProjectives( cat ) then 
      
      Error( "The category must have enough projectives" );
    
    fi;
    
    P := ProjectiveResolution( Source( phi ) );
    
    Q := ProjectiveResolution( Range( phi ) );
    
    temp := rec(  );
    
    func := function( i )
              local a, b, c;
              if i > 0 then
                c := ZeroMorphism( P[i], Q[i] );
              elif i = 0 then
                a := PreCompose( EpimorphismFromSomeProjectiveObject( Source( phi ) ), phi );
                b := EpimorphismFromSomeProjectiveObject( Range( phi ) );
                c := ProjectiveLift( a, b );
              else
                if IsBound( temp!.( i + 1 ) ) then
                  a := KernelLift( Q^( i+1 ), PreCompose( P^i, temp!.( i + 1 ) ) );
                else
                  a := KernelLift( Q^( i+1 ), PreCompose( P^i, func( i + 1 ) ) );
                fi;
                b := KernelLift( Q^( i+1 ), Q^i );
                c := ProjectiveLift( a, b );
              fi;
              temp!.( String( i ) ) := c;
              return c;
            end;
    
    maps := MapLazy( IntegersList, func, 1 );
    
    return CochainMorphism( P, Q, maps );
  
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
       [ IsCapCategoryMorphism, IsBool ],
  function( phi, bool )
    local psi;
    
    psi := MorphismBetweenProjectiveResolutions( phi );
    
    ProjectiveResolution( Source( phi ), bool );
    
    ProjectiveResolution( Range( phi ), bool );
    
    return psi;
    
end );

##############################
#
# Injective resolutions
#
##############################

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsBoundedBelowCochainComplex ],
 
  function( C )
    local cat, u, zero, maps, inj;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
       
       Error( "It is not known whether the underlying category has enough injectives or not" );
    
    fi;
    
    if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
      
      Error( "The underlying category must have enough injectives" );
    
    fi;
    
    u := ActiveLowerBound( C );
    
    zero := ZeroObject( cat );
    
    maps := MapLazy( IntegersList, function( k )
      local temp, m, coker, iota, mor1, mor2;
      
      if k <= u then
        
        return [ ZeroMorphism( zero, zero ), ZeroMorphism( C[ k ], zero ) ];
      
      else
        
        temp := maps[ k - 1 ][ 1 ];
         
        m := MorphismBetweenDirectSums(
                            [
                              [ AdditiveInverse( C^( k - 1 ) ), maps[ k - 1 ][ 2 ] ],
                              [ ZeroMorphism( Source( temp ), C[ k ] ), temp ]
                            ]
                        );
               
        coker := CokernelProjection( m );
        
        iota := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
        
        mor1 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( temp ) ], 1 );
        
        mor2 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( temp ) ], 2 );
          
        return [ PostCompose( [ iota, coker, mor2 ] ), PostCompose( [ iota, coker, mor1 ] ), m ];
      
      fi;
      
    end, 1 );
    
    inj := CochainComplex( cat, ShiftLazy( MapLazy( maps, j -> j[ 1 ], 1 ), 1 ) );
    
    SetLowerBound( inj, u );
    
    return CochainMorphism( C, inj, MapLazy( maps, j -> j[ 2 ], 1 ) );
    
 end );

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
        [ IsBoundedAboveChainComplex ], 
function( C )
  
  return AsChainMorphism( QuasiIsomorphismIntoInjectiveResolution( AsCochainComplex( C ) ) );
  
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedBelowCochainComplex ],
function( C )
  return Range( QuasiIsomorphismIntoInjectiveResolution( C ) );
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedAboveChainComplex ],
function( C )
  return Range( QuasiIsomorphismIntoInjectiveResolution( C ) );
end );


##
InstallMethod( MorphismBetweenInjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedBelowCochainMorphism ],
  function( phi )
    local C, D, q_C, i_C, q_D, i_D, u, maps;
    
    C := Source( phi );
    
    D := Range( phi );
    
    q_C := QuasiIsomorphismIntoInjectiveResolution( C );
    
    i_C := Range( q_C );
    
    q_D := QuasiIsomorphismIntoInjectiveResolution( D );
    
    i_D := Range( q_D );
    
    u := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
    
    maps := MapLazy( IntegersList,
      function( k )
        local temp_C, temp_D, m, kappa, mo_C, mo_D;
        
        if k <= u then
          
          return ZeroMorphism( i_C[ k ], i_D[ k ] );
          
        else
          
          #temp_C := MorphismBetweenDirectSums(
          #                  [
          #                    [ AdditiveInverse( C^( k - 1 ) ), q_C[ k - 1 ] ],
          #                    [ ZeroMorphism( i_C[ k - 2 ], C[ k ] ), i_C^( k - 2 ) ]
          #                  ]
          #              );
          
          #temp_D := MorphismBetweenDirectSums(
          #                  [
          #                    [ AdditiveInverse( D^( k - 1 ) ), q_D[ k - 1 ] ],
          #                    [ ZeroMorphism( i_D[ k - 2 ], D[ k ] ), i_D^( k - 2 ) ]
          #                  ]
          #              );
          
          temp_C := BaseList( Differentials( i_C ) )[ k ][ 3 ];
          
          temp_D := BaseList( Differentials( i_D ) )[ k ][ 3 ];
          
          m := DirectSumFunctorial( [ phi[ k ], maps[ k - 1 ] ] );
          
          kappa := CokernelObjectFunctorial( temp_C, m, temp_D );
          
          mo_C := MonomorphismIntoSomeInjectiveObject( Source( kappa ) );
          
          mo_D := MonomorphismIntoSomeInjectiveObject( Range( kappa ) );
          
          return InjectiveColift( mo_C, PreCompose( kappa, mo_D ) );
         
         fi;
         
      end, 1 );
    
    return CochainMorphism( i_C, i_D, maps );
    
end );

##
InstallMethod( MorphismBetweenInjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedAboveChainMorphism ],
  function( phi )
    
    return AsChainMorphism(
            MorphismBetweenInjectiveResolutions(
              AsCochainMorphism( phi ) ) );
    
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedCochainComplex, IsBool ],
  function( C, bool )
    local p, i;
    
    p := InjectiveResolution( C );
    
    if HasActiveUpperBound( p ) then
      
      return p;
    
    fi;
    
    i := ActiveUpperBound( C );
    
    while bool do
          
      if IsZeroForObjects( p[ i ] ) then
        
        SetUpperBound( p, i );
        
        return p;
      
      fi;
      
      i := i + 1;
    
    od;
    
    return p;
    
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedChainComplex, IsBool ],
  function( C, bool )
    local p, i;
    
    p := InjectiveResolution( C );
    
    if HasActiveLowerBound( p ) then
      
      return p;
    
    fi;
    
    i := ActiveLowerBound( C );
    
    while bool do
        
      if IsZeroForObjects( p[ i ] ) then
        
        SetLowerBound( p, i );
        
        return p;
      
      fi;
      
      i := i - 1;
    
    od;
    
    return p;
    
end );

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
                [ IsBoundedChainOrCochainComplex, IsBool ],
  
  function( C, bool )
    local q;
    
    q := QuasiIsomorphismIntoInjectiveResolution( C );
    
    InjectiveResolution( C, bool );
    
    return q;

end );

#######################################
##
## injective resolutions of objects
##
#######################################

InstallMethod( InjectiveResolution,
       [ IsCapCategoryObject ],
function( obj )
  local func, C, cat, em, coker, em_coker, d; 
  
  if IsBoundedBelowCochainComplex( obj ) or IsBoundedAboveChainComplex( obj ) then 
    
    TryNextMethod();
  
  fi;
  
  cat := CapCategory( obj );
  
  if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
    
    Error( "It is not known whether the category has enough injectives or not" );
  
  fi;
  
  if not IsAbelianCategoryWithEnoughInjectives( cat ) then 
    
    Error( "The category must have enough injectives" );
  
  fi;
  
  func := function( mor )
        local k,p; 
        k := CokernelProjection( mor );
        p := MonomorphismIntoSomeInjectiveObject( Range( k ) );
        return PreCompose( k, p );
        end;
  
  em := MonomorphismIntoSomeInjectiveObject( obj );
  
  coker := CokernelProjection( em );
  
  em_coker := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
  
  d := PreCompose( coker, em_coker );
  
  C := CochainComplexWithInductivePositiveSide( d, func );
  
  return C;
  
end );


##
InstallMethod( InjectiveResolution,
       [ IsCapCategoryObject, IsBool ],
  function( M, bool )
    local p, i;
    
    if IsChainOrCochainComplex( M ) then
      
      TryNextMethod();
    
    fi;
    
    p := InjectiveResolution( M );
    
    if HasActiveUpperBound( p ) then
      
      return p;
      
    fi;
    
    i := 0;
    
    while bool do
       
      if IsZero( p[ i ] ) then
        
        SetUpperBound( p, i );
        
        return p;
        
      fi;
        
      i := i + 1;
      
      if IsZero( i mod 5000 ) then
        
        Error( "It seems that the object have infinite resolution; do you want me to continue trying? then return!\n" );
        
      fi;

    od;
    
    return p;
    
end );



# TODO
InstallMethod( MorphismBetweenInjectiveResolutions,
       [ IsCapCategoryMorphism ],
function( phi )
  local cat, P, Q, func, maps, temp;
  
  if IsChainOrCochainMorphism( phi ) then
    
    TryNextMethod( );
  
  fi;
  
  cat := CapCategory( phi );
  
  if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
    
    Error( "It is not known whether the category has enough injectives or not" );
  
  fi;
  
  if not IsAbelianCategoryWithEnoughProjectives( cat ) then 
  
     Error( "The category must have enough injectives" );
  
  fi;
  
  P := InjectiveResolution( Source( phi ) );
  
  Q := InjectiveResolution( Range( phi ) );
  
  temp := rec(  );
  
  func := function( i )
            local a, b, c;
            
            if i < 0 then
              c := ZeroMorphism( P[i], Q[i] );
            elif i = 0 then
              a := PreCompose( phi, MonomorphismIntoSomeInjectiveObject( Range( phi ) ) );
              b := MonomorphismIntoSomeInjectiveObject( Source( phi ) );
              c := InjectiveColift( b, a );
            else
              if IsBound( temp!.( i - 1 ) ) then
                a := CokernelColift( P^( i - 2 ), PreCompose( temp!.( i - 1 ), Q^( i - 1 )  ) );
              else
                a := CokernelColift( P^( i - 2 ), PreCompose( func( i - 1 ), Q^( i - 1 )  ) );
              fi;
              b := CokernelColift( P^( i - 2 ), P^( i - 1 ) );
              c := InjectiveColift( b, a );
            fi;
            temp!.( String( i ) ) := c;
            return c;
          end;
  
  maps := MapLazy( IntegersList, func, 1 );
  
  return CochainMorphism( P, Q, maps );

end );

##
InstallMethod( MorphismBetweenInjectiveResolutions,
       [ IsCapCategoryMorphism, IsBool ],
  function( phi, bool )
    local psi;
    
    psi := MorphismBetweenInjectiveResolutions( phi );
    
    InjectiveResolution( Source( phi ), bool );
    
    InjectiveResolution( Range( phi ), bool );
    
    return psi;
    
end );

BindGlobal( "HORSESHOE_HELPER",
  function( C )
    local u, v, t_u, P_u, t_v, P_v, d_v, d_u, t_u_plus_1, i, p, P;
    
    if not IsExact( C ) then
      
      Error( "The given chain complex should be a short exact sequence" );
      
    fi;
    
    u := ActiveLowerBound( C ) + 1;
    
    v := ActiveUpperBound( C ) - 1;
   
    if v - u > 2 then
      
      Error( "The given chain complex is longer than expected" );
      
    fi;
    
    if v - u < 2 then
      
      v := u + 2;
      
    fi;
    
    t_u := EpimorphismFromSomeProjectiveObject( C[ u ] );
    
    P_u := Source( t_u );
    
    t_v := EpimorphismFromSomeProjectiveObject( C[ v ] );
    
    P_v := Source( t_v );
    
    d_v := PreCompose( t_v, C ^ v );
    
    d_u := ProjectiveLift( t_u, C ^ ( u + 1 ) );
    
    t_u_plus_1 := UniversalMorphismFromDirectSum( [ P_u, P_v ], [ d_u, d_v ] );
    
    i := InjectionOfCofactorOfDirectSum( [ P_u, P_v ], 2 );
    
    p := ProjectionInFactorOfDirectSum( [ P_u, P_v ], 1 );
    
    P := ChainComplex( [ p, i ], u + 1 );
    
    return ChainMorphism( P, C, [ t_u, t_u_plus_1, t_v ], u );
    
end );

##
InstallMethod( MorphismFromHorseshoeResolution,
  [ IsBoundedChainComplex ],
  function( C )
    local func, ep, ker, ep_ker, d, D;
  
    func := function( mor )
            local k,p; 
            k := KernelEmbedding( mor );
            p := HORSESHOE_HELPER( Source( k ) );
            return PreCompose( p, k );
          end;

    ep := HORSESHOE_HELPER( C );

    ker := KernelEmbedding( ep );

    ep_ker := HORSESHOE_HELPER( Source( ker ) );

    d := PreCompose( ep_ker, ker );

    D := ChainComplexWithInductivePositiveSide( d, func );

    D := ShiftLazy( D, -1 );
    
    if IsPackageMarkedForLoading( "Bicomplexes", ">=0" ) = true then
      
      d := ValueGlobal( "HomologicalBicomplex" )( D );
      
      ValueGlobal( "SetAbove_Bound" )( d, ActiveUpperBound( C ) );
      
      ValueGlobal( "SetBelow_Bound" )( d, ActiveLowerBound( C ) );
      
    fi;
    
    d := ChainMorphism( D, StalkChainComplex( C, 0 ), [ ep ], 0 );
    
    SetHorseshoeResolution( C, D );
    
    return d;
    
end );

InstallMethod( HorseshoeResolution,
  [ IsBoundedChainComplex ],
  function( C )
  
    MorphismFromHorseshoeResolution( C );
  
    return HorseshoeResolution( C );
  
end );
 
InstallMethodWithCrispCache( CARTAN_HELPER,
  [ IsBoundedChainComplex ],
  function( C )
    local chains, cat, diffs, P, mors, map;
  
    chains := CapCategory( C );
    
    cat := UnderlyingCategory( chains );
  
    diffs := MapLazy( IntegersList,
      function( i )
        local iota_1, pi_1, T1, iota_2, pi_2, T2, iota_3, pi_3, T3;
        
        iota_1 := KernelEmbedding( C^i );
        
        pi_1 := CoastrictionToImage( C^i );
        
        T1 := HORSESHOE_HELPER( ChainComplex( [ pi_1, iota_1 ], 1 ) );
        
        iota_2 := KernelLift( C^( i - 1 ), ImageEmbedding( C ^ i ) );
        
        pi_2 := CokernelProjection( iota_2 );
        
        T2 := HORSESHOE_HELPER( ChainComplex( [ pi_2, iota_2 ], 1 ) );
        
        iota_3 := KernelEmbedding( C ^ ( i - 1 ) );
        
        pi_3 := CoastrictionToImage( C ^ ( i - 1 ) );
        
        T3 := HORSESHOE_HELPER( ChainComplex( [ pi_3, iota_3 ], 1 ) );
        
        return PreCompose( 
                      [
                      
                        Source( T1 )^( 1 ),
                        ProjectiveLift( T1[ 0 ], T2[ 2 ]  ),
                        Source( T2 )^( 2 ),
                        ProjectiveLift( T2[ 1 ], T3[ 2 ] ),
                        Source( T3 )^( 2 )
                      
                      ] );
        
      end, 1 );
    
      P := ChainComplex( cat, diffs );
      
      SetUpperBound( P, ActiveUpperBound( C ) );
      SetLowerBound( P, ActiveLowerBound( C ) );
      
      mors := MapLazy( IntegersList,
        function( i )
          local iota_1, pi_1, T1;
          
          iota_1 := KernelEmbedding( C^i );
        
          pi_1 := CoastrictionToImage( C^i );
        
          T1 := HORSESHOE_HELPER( ChainComplex( [ pi_1, iota_1 ], 1 ) );
          
          return T1[ 1 ];
          
        end, 1 );
      
      map := ChainMorphism( P, C, mors );
      
      return map;
    
end );

##
InstallMethodWithCrispCache( MorphismFromCartanResolution,
    [ IsBoundedChainComplex ],
  function( C )
    local func, ep, ker, ep_ker, d, D;
  
    func := function( mor )
            local k,p;
            
            k := KernelEmbedding( mor );
            
            p := CARTAN_HELPER( Source( k ) );
            
            return PreCompose( p, k );
            
          end;

    ep := CARTAN_HELPER( C );

    ker := KernelEmbedding( ep );

    ep_ker := CARTAN_HELPER( Source( ker ) );

    d := PreCompose( ep_ker, ker );

    D := ChainComplexWithInductivePositiveSide( d, func );

    D := ShiftLazy( D, -1 );
    
    if IsPackageMarkedForLoading( "Bicomplexes", ">=0" ) = true then
      
      d := ValueGlobal( "HomologicalBicomplex" )( D );
      
      ValueGlobal( "SetAbove_Bound" )( d, ActiveUpperBound( C ) );
      
      ValueGlobal( "SetBelow_Bound" )( d, ActiveLowerBound( C ) );
      
    fi;
    
    d := ChainMorphism( D, StalkChainComplex( C, 0 ), [ ep ], 0 );
    
    SetCartanResolution( C, D );
    
    return d;
    
end );

##
InstallMethod( CartanResolution,
  [ IsBoundedChainComplex ],
  function( C )
  
    MorphismFromCartanResolution( C );
  
    return CartanResolution( C );
  
end );
 



# version 2, much better than version 1 because it make use of
# the structure of Oysteins inductive lists.
# BUT: needs another look

# InstallMethod( QuasiIsomorphismFromProjectiveResolution,
#         [ IsBoundedAboveCochainComplex ],
# 
# function( C )
# local u, cat, proj, zero, inductive_list;
#  
# 
# if HasIsZeroForObjects( C ) and IsZeroForObjects( C ) then 
#     return UniversalMorphismFromZeroObject( C );
# fi;
# 
# cat := UnderlyingCategory( CapCategory( C ) );
# 
# if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
#    Error( "It is not known whether the underlying category has enough projectives or not" );
# fi;
# 
# if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then 
#    Error( "The underlying category must have enough projectives" );
# fi;
#  
# u := ActiveUpperBound( C );
# 
# # this is important
# if IsZeroForObjects( C[ u - 1 ] ) then
#     SetUpperBound( C, u - 1 );
#     return QuasiIsomorphismFromProjectiveResolution( C );
# fi;
# #
# 
# zero := ZeroObject( cat );
#  
# inductive_list := InductiveList( [ ZeroMorphism( zero, zero ), ZeroMorphism( zero, C[ u ] ) ],
# 
#    function( d )
#    local k, k1, m1, mor4, mor2, mor3, m2, m, mor1, ker, pk;
#    if not IsBound( inductive_list!.index ) then
#       k := u-1;
#    else
#       k := inductive_list!.index;
#    fi;
# 
#    k1 := d[ 1 ];
# 
#    m1 := DirectSumFunctorial( [ AdditiveInverse( k1 ), C^k ] );
# 
#    mor1 := ProjectionInFactorOfDirectSum( [ Source( k1 ), C[ k ] ], 1 );
# 
#    mor2 := d[ 2 ];
# 
#    mor3 := InjectionOfCofactorOfDirectSum( [ Range( k1 ), C[ k + 1 ] ], 2 );
# 
#    m2 := PreCompose( [ mor1, mor2, mor3 ] );
# 
#    m := m1 + m2;
# 
#    mor4 := ProjectionInFactorOfDirectSum( [ Source( k1 ), C[ k ] ], 2 );
# 
#    ker := KernelEmbedding( m );
# 
#    pk := EpimorphismFromSomeProjectiveObject( Source( ker ) );
# 
#    inductive_list!.index := k - 1;
# 
#    return [ PreCompose( [ pk, ker, mor1 ] ), PreCompose( [ pk, ker, mor4 ] ) ];
# 
#    end );
# 
# proj := CochainComplex( cat, MapLazy( IntegersList, function( j )
#   if j > u then
#      return ZeroMorphism( zero, zero );
#   else
#      return  inductive_list[ u - j + 1 ][ 1 ];
#   fi;
#   end, 1 ) );
# 
# SetUpperBound( proj, u );
# 
# return CochainMorphism( proj, C, MapLazy( IntegersList,   function( j )
#         if j > u then
#  return ZeroMorphism( zero, C[ j ] );
#         else
#         
#  return  (-1)^j*inductive_list[ u - j + 1 ][ 2 ];
#         fi;
#         end, 1 ) );
# 
# end );

##
# InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
#         [ IsBoundedBelowCochainComplex ],
# 
# function( C )
# local u, cat, inj, zero, inductive_list;
# 
# if HasIsZeroForObjects( C ) and IsZeroForObjects( C ) then 
#     return UniversalMorphismIntoZeroObject( C );
# fi;
# 
# cat := UnderlyingCategory( CapCategory( C ) );
# 
# if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
#    Error( "It is not known whether the underlying category has enough injectives or not" );
# fi;
# 
# if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then 
#    Error( "The underlying category must have enough injectives" );
# fi;
#  
# u := ActiveLowerBound( C );
# 
# if IsZeroForObjects( C[ u + 1 ] ) then 
#     SetLowerBound( C, u + 1 );
#     return QuasiIsomorphismIntoInjectiveResolution( C );
# fi;
# 
# zero := ZeroObject( cat );
#  
# inductive_list := InductiveList( [ ZeroMorphism( zero, zero ), ZeroMorphism( C[ u ], zero ) ],
#   function( l )
#   local k, k1, m1, mor4, mor2, mor3, m2, m, mor1, coker, pk;
# 
#      if not IsBound( inductive_list!.index ) then
# 
#         k := u + 1;
# 
#      else
# 
#         k := inductive_list!.index;
# 
#      fi;
# 
#      k1 := l[ 1 ];
# 
#      m1 := DirectSumFunctorial( [ AdditiveInverse( C^( k - 1 ) ), k1 ] );
# 
#      mor1 := ProjectionInFactorOfDirectSum( [ C[ k - 1 ], Source( k1 ) ], 1 );
# 
#      mor2 := l[ 2 ];
# 
#      mor3 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( k1 ) ], 2 );
# 
#      m2 := PreCompose( [ mor1, mor2, mor3 ] );
# 
#      m := AdditionForMorphisms( m1, m2 );
# 
#      mor4 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( k1 ) ], 1 );
# 
#      coker := CokernelProjection( m );
# 
#      pk := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
# 
#      inductive_list!.index := k + 1;
# 
#      return [ PostCompose( [ pk, coker, mor3 ] ), PostCompose( [ pk, coker, mor4 ] ) ];
# 
#   end );
# 
# inj := CochainComplex( cat, MapLazy( IntegersList,  function( j )
#   if j < u then
#      return ZeroMorphism( zero, zero );
#   else
#      return  inductive_list[ j - u + 2 ][ 1 ];
#   fi;
#   end, 1 ) );
# 
# SetLowerBound( inj, u );
# 
# return CochainMorphism( C, inj, MapLazy( IntegersList,    function( j )
#         if j <= u then
#  return ZeroMorphism( C[ j ], zero );
#         else
#  return  inductive_list[ j - u + 1 ][ 2 ];
#         fi;
#         end, 1 ) );
# 
# end );

# Here is categorical mathematical construction. It commented since there is more direct construction.
# version 0
# InstallMethod( QuasiIsomorphismFromProjectiveResolution, 
#[ IsBoundedAboveCochainComplex ], 
# function( C )
# local u, cat, proj, zero, inductive_list;
# 
# cat := UnderlyingCategory( CapCategory( C ) );
# 
# u := ActiveUpperBound( C );
# 
# zero := ZeroObject( cat );
# 
# inductive_list := MapLazy( IntegersList, function( k )
#   local current_mor, current_complex, cone, nat_inj, ker_k, mor_from_proj, injec_in_C;
#   if k >= u then
#      return [ ZeroMorphism( zero, zero ), ZeroMorphism( zero, C[ k ] ) ];
#   else
#      current_complex := CochainComplex( cat, MapLazy( inductive_list, function( j ) 
#    return j[ 1 ]; 
#end, 1 ) );
#      current_complex := BrutalTruncationBelow( current_complex, k );
#      current_mor := CochainMorphism( current_complex, C, MapLazy( IntegersList, function( j )
#      if j <= k then return ZeroMorphism( zero, C[ j ] );
#      else return inductive_list[ j ][ 2 ];
#      fi;
#      end, 1 ) );
#      cone := MappingCone( current_mor );
#      nat_inj := NaturalProjectionFromMappingCone( current_mor );
#      ker_k := CyclesAt( cone, k );
#      mor_from_proj := EpimorphismFromSomeProjectiveObject( Source( ker_k ) );
#      injec_in_C := ProjectionInFactorOfDirectSum( [ ShiftLazy( current_complex, 1 ), C ], 2 );
#      return [ PreCompose( [ mor_from_proj, ker_k, nat_inj[ k ] ] ), PreCompose( [ mor_from_proj, ker_k, injec_in_C[ k ] ] ) ];
#   fi;
#   end, 1 );
# 
# proj := CochainComplex( cat, MapLazy( inductive_list, function( j ) return j[ 1 ]; end, 1 ) );
# 
# SetUpperBound( proj, u );
# 
# return CochainMorphism( proj, C, MapLazy( inductive_list, function( j ) return j[ 2 ];end, 1 ) );
# 
# end );


