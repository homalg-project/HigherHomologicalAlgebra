#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Resolutions
##
#############################################################################


# DeclareGlobalVariable( "ENOUGH_PROJECTIVES_INJECTIVES_METHODS" );
# 
# InstallValue( ENOUGH_PROJECTIVES_INJECTIVES_METHODS, rec( 
# 
# EpimorphismFromSomeProjectiveObject := rec( 
# 
# installation_name := "EpimorphismFromSomeProjectiveObject", 
# filter_list := [ "object" ],
# cache_name := "EpimorphismFromSomeProjectiveObject",
# return_type := "morphism",
# post_function := function( object, return_value )
#         SetIsEpimorphism( return_value, true );
#         end ),
# 
# MonomorphismIntoSomeInjectiveObject := rec(
# 
# installation_name := "MonomorphismIntoSomeInjectiveObject",
# filter_list := [ "object" ],
# cache_name := "MonomorphismIntoSomeInjectiveObject",
# return_type := "morphism",
# post_function := function( object, return_value )
#         SetIsMonomorphism( return_value, true );
#         end ),
# ) );
# 
# CAP_INTERNAL_ENHANCE_NAME_RECORD( ENOUGH_PROJECTIVES_INJECTIVES_METHODS );
# 
# CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( ENOUGH_PROJECTIVES_INJECTIVES_METHODS );

###############################
#
# Resolutions
#
###############################

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

# version 1
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
                [ IsBoundedAboveCochainComplex ],
 
function( C )
 local u, cat, proj, zero, list;
  
 cat := UnderlyingCategory( CapCategory( C ) );
 
 if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then
    Error( "It is not known whether the underlying category has enough projectives or not" );
 fi;
 
 if not HasIsAbelianCategoryWithEnoughProjectives( cat ) then 
    Error( "The underlying category must have enough projectives" );
 fi;
  
 u := ActiveUpperBound( C );
  
 zero := ZeroObject( cat );
  
 list := MapLazy( IntegersList, function( k )
   local k1, m1, mor4, mor2, mor3, m2, m, mor1, ker, pk;
 
   if k >= u then
 
      return [ ZeroMorphism( zero, zero ), ZeroMorphism( zero, C[ k ] ) ];
 
   else
 
      k1 := list[ k + 1 ][ 1 ];
 
      m1 := DirectSumFunctorial( [ AdditiveInverse( k1 ), C^k ] );
 
      mor1 := ProjectionInFactorOfDirectSum( [ Source( k1 ), C[ k ] ], 1 );
 
      mor2 := list[ k + 1 ][ 2 ];
 
      mor3 := InjectionOfCofactorOfDirectSum( [ Range( k1 ), C[ k + 1 ] ], 2 );
 
      m2 := PreCompose( [ mor1, mor2, mor3 ] );
 
      m := AdditionForMorphisms( m1, m2 );
 
      mor4 := ProjectionInFactorOfDirectSum( [ Source( k1 ), C[ k ] ], 2 );
 
      ker := KernelEmbedding( m );
 
      pk := EpimorphismFromSomeProjectiveObject( Source( ker ) );
 
      return [ PreCompose( [ pk, ker, mor1 ] ), PreCompose( [ pk, ker, mor4 ] ) ];
 
   fi;
 
   end, 1 );
 
 proj := CochainComplex( cat, MapLazy( list, function( j ) return j[ 1 ]; end, 1 ) );
 
 SetUpperBound( proj, u );
 
return CochainMorphism( proj, C, 
        MapLazy( IntegersList, 
            function( j ) 
            if j mod 2 = 0 then 
            return  list[ j ][ 2 ]; 
            else
            return AdditiveInverse( list[ j ][ 2 ] );
            fi;
            end, 1 ) );
 
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


InstallMethod( ProjectiveResolution,
      [ IsBoundedAboveCochainComplex ],
function( C )
return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
end );

## fix the bounds, try example where C is direct sum of stalks
#InstallMethod( ProjectiveResolutionWithBounds,
#      [ IsBoundedCochainComplex, IsInt ],
#function( C, m )
#local p, i;
#
#p := Source( QuasiIsomorphismFromProjectiveResolution( C ) );
#
#for i in [ m .. ActiveUpperBound( p ) - 1 ] do
#
#    if IsZeroForObjects( p[ ActiveUpperBound( p ) - 1 + m - i ] ) then 
#        SetLowerBound( p, ActiveUpperBound( p ) - 1 + m - i );
#        return p;
#    fi;
#od;
#Error( "It seems that the lower bound of the projective resolution is less than ", m );
#end );

InstallMethod( ProjectiveResolutionWithBounds,
        [ IsBoundedChainComplex, IsInt ],
    function( C, m )
    local p, i;
    
    if m < ActiveUpperBound( C ) then
	Error( "The second argument should be greater than the active upper bound of C" );
    fi;
    
    p := Source( QuasiIsomorphismFromProjectiveResolution( C ) );

    for i in [ ActiveUpperBound( C ) .. m ] do
        if IsZeroForObjects( p[ i ] ) then 
            SetUpperBound( p, i );
            return p;
        fi;
    od;

    Error( "It seems that the upper bound of the projective resolution is greater than ", m );

end );
    

InstallMethod( QuasiIsomorphismFromProjectiveResolution,
        [ IsBoundedBelowChainComplex ], 
function( C )
local cat, F, G, C1, quasi;

cat := UnderlyingCategory( CapCategory( C ) );

F := ChainToCochainComplexFunctor( ChainComplexCategory( cat ), CochainComplexCategory( cat ) );

G := CochainToChainComplexFunctor( CochainComplexCategory( cat ), ChainComplexCategory( cat ) );
    
C1 := ApplyFunctor( F, C );

quasi := QuasiIsomorphismFromProjectiveResolution( C1 );

return ApplyFunctor( G, quasi );

end );

InstallMethod( ProjectiveResolution,
      [ IsBoundedBelowChainComplex ],
function( C )
return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
end );


##############################
#
# Injective resolutions
#
##############################

# version 0
 InstallMethod( QuasiIsomorphismInInjectiveResolution,
[ IsBoundedBelowCochainComplex ],
 
 function( C )
 local u, cat, inj, zero, inductive_list;
  
 cat := UnderlyingCategory( CapCategory( C ) );
 
 if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then
    Error( "It is not known whether the underlying category has enough injectives or not" );
 fi;
 
 if not HasIsAbelianCategoryWithEnoughInjectives( cat ) then 
    Error( "The underlying category must have enough injectives" );
 fi;
  
 u := ActiveLowerBound( C );
  
 zero := ZeroObject( cat );
  
 inductive_list := MapLazy( IntegersList, function( k )
   local k1, m1, mor4, mor2, mor3, m2, m, mor1, coker, pk;
 
   if k <= u then
 
      return [ ZeroMorphism( zero, zero ), ZeroMorphism( C[ k ], zero ) ];
 
   else
 
      k1 := inductive_list[ k - 1 ][ 1 ];
 
      m1 := DirectSumFunctorial( [ AdditiveInverse( C^( k - 1 ) ), k1 ] );
 
      mor1 := ProjectionInFactorOfDirectSum( [ C[ k - 1 ], Source( k1 ) ], 1 );
 
      mor2 := inductive_list[ k - 1 ][ 2 ];
 
      mor3 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( k1 ) ], 2 );
 
      m2 := PreCompose( [ mor1, mor2, mor3 ] );
 
      m := AdditionForMorphisms( m1, m2 );
 
      mor4 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( k1 ) ], 1 );
 
      coker := CokernelProjection( m );
 
      pk := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
 
      return [ PostCompose( [ pk, coker, mor3 ] ), PostCompose( [ pk, coker, mor4 ] ) ];
 
   fi;
 
   end, 1 );
 
 inj := CochainComplex( cat, ShiftLazy( MapLazy( inductive_list, function( j ) return j[ 1 ]; end, 1 ), 1 ) );
 
 SetLowerBound( inj, u );
 
 return CochainMorphism( C, inj, MapLazy( inductive_list, function( j ) return j[ 2 ]; end, 1 ) );
 
 end );
 
##
# InstallMethod( QuasiIsomorphismInInjectiveResolution,
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
#     return QuasiIsomorphismInInjectiveResolution( C );
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

##
InstallMethod( QuasiIsomorphismInInjectiveResolution,
        [ IsBoundedAboveChainComplex ], 
function( C )
local cat, F, G, C1, quasi;

cat := UnderlyingCategory( CapCategory( C ) );

F := ChainToCochainComplexFunctor( ChainComplexCategory( cat ), CochainComplexCategory( cat ) );

G := CochainToChainComplexFunctor( CochainComplexCategory( cat ), ChainComplexCategory( cat ) );

C1 := ApplyFunctor( F, C );

quasi := QuasiIsomorphismInInjectiveResolution( C1 );

return ApplyFunctor( G, quasi );

end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedBelowCochainComplex ],
function( C )
return Range( QuasiIsomorphismInInjectiveResolution( C ) );
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedAboveChainComplex ],
function( C )
return Range( QuasiIsomorphismInInjectiveResolution( C ) );
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
InstallMethod( MorphismBetweenProjectiveResolutions,
       [ IsCapCategoryMorphism ],
function( phi )
  local cat, P, Q, func, maps, temp;

  if IsChainOrCochainMorphism( phi ) then
    
    Error( "Not yet implemented!" );
  
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


# TODO
InstallMethod( MorphismBetweenInjectiveResolutions,
       [ IsCapCategoryMorphism ],
function( phi )
  local cat, P, Q, func, maps, temp;

  if IsChainOrCochainMorphism( phi ) then
    
    Error( "Not yet implemented!" );
  
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
            Print( i );
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


