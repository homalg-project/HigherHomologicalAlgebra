
BindGlobal( "ANNIHILATOR_OF_GRADED_MODULE_OVER_COX_RING_OF_PPS",
            
  function( M )
    local mat, S, F, n, Id, L, ann, f, g;
    
    mat := UnderlyingMatrix( M );
    
    S := UnderlyingHomalgRing( M );
    
    F := FreeLeftPresentation( 1, S );
    
    n := NrCols( mat );
    
    Id := HomalgIdentityMatrix( n, S );
    
    L := List( [ 1 .. n ], i -> CertainRows( Id, [ i ] ) );
    
    L := List( L, l -> PresentationMorphism( F, l, UnderlyingPresentationObject( M ) ) );
    
    ann := List( L, KernelEmbedding );
    
    ann := List( ann, UnderlyingMatrix );

    if ForAny( ann, a -> NrRows( a ) = 0 ) then

      return HomalgZeroMatrix( 0, 1, S );

    else
      
      f := ann[ 1 ];
      
      for g in ann{ [ 2 .. n ] } do
        
        f := SyzygiesOfRows( g, f ) * g;
        
      od;
      
      return f;

    fi;

end );

##
BindGlobal( "SATURATION_OVER_MONOMIAL_PPS",
  function( ideal, monomial )
    
    local S, i, ideal_as_left_module, current_monomial, intersection, entries, current_left_module, ring;
    
    S := HomalgRing( ideal );

    i := 1;
    
    ideal_as_left_module := LeftSubmodule( EntriesOfHomalgMatrix( ideal ), S );
    
    ring := LeftSubmodule( "1", S );

    while true do
      
      current_monomial := monomial^i;
      
      intersection := SyzygiesOfRows( current_monomial, ideal ) * current_monomial;
      
      entries := List( EntriesOfHomalgMatrix( intersection  ), e -> e/MatElm( current_monomial, 1, 1 ) );
      
      current_left_module := LeftSubmodule( entries, S );
      
      if ideal_as_left_module = current_left_module then
        
        return [ i - 1, current_left_module, ( One( S ) in entries ) or current_left_module = ring ];
        
      else
        
        ideal_as_left_module := current_left_module;
        
        i := i + 1;
        
      fi;
      
    od;
 
end );

##
BindGlobal( "IS_SOME_POWER_OF_IRRELEVANT_IDEAL_CONTAINED_IN_IDEAL_PPS",
  
  function( irrelevant_ideal, ideal )
    local S, current_sat, monomial, monomials, list;

    S := HomalgRing( ideal );

    monomials := List( [ 1 .. NrRows( irrelevant_ideal ) ], i -> CertainRows( irrelevant_ideal, [ i ] ) );

    for monomial in monomials do

        current_sat := SATURATION_OVER_MONOMIAL_PPS( ideal, monomial );

        if not current_sat[ 3 ] then

          return false;

        fi;

    od;

    return true;

end );

##
BindGlobal( "IS_ZERO_SHEAF_OVER_Pm_x_Pn",

  function( M )
    local S, ideal, irrelevant_ideal;
    
    irrelevant_ideal := UnderlyingHomalgRing( M )!.irrelevant_ideal;
    
    ideal := ANNIHILATOR_OF_GRADED_MODULE_OVER_COX_RING_OF_PPS( M );
    
    return IS_SOME_POWER_OF_IRRELEVANT_IDEAL_CONTAINED_IN_IDEAL_PPS( irrelevant_ideal, ideal );
    
end );

##
InstallMethod( CoxRingForProductOfProjectiveSpaces,
          [ IsRationalsForHomalg, IsList ],
  function( homalg_field, L )
    local variables, variables_strings, factor_rings, weights, S, irrelevant_ideal;

    if Length( L ) > 7 then
      return fail;
    fi;

    variables := [ "x", "y", "z", "s", "t", "u", "w" ];
    
    variables_strings := List( [ 1 .. Length( L ) ], 
          i -> List( [ 0 .. L[ i ] ], j -> Concatenation( variables[ i ], String( j ) ) ) );
    
    variables := List( variables_strings, v -> JoinStringsWithSeparator( v, "," ) );
    
    factor_rings := List( variables, v -> GradedRing( homalg_field * v ) );
    
    weights := IdentityMat( Length( L ) );
    
    weights := List( [ 1 .. Length( L ) ], i -> List( [ 0 .. L[ i ] ], j -> weights[ i ] ) );
    
    weights := Concatenation( weights );
    
    variables := JoinStringsWithSeparator( variables, "," );
    
    S := GradedRing( homalg_field * variables );
    
    List( factor_rings, WeightsOfIndeterminates );
    
    S!.factor_rings := factor_rings;
    
    SetWeightsOfIndeterminates( S, weights );
    
    variables := List( variables_strings, V -> List( V, v -> v/S ) );
    
    irrelevant_ideal := Iterated( variables, function( V1, V2 ) return ListX( V1, V2, \* ); end );
    
    S!.irrelevant_ideal := HomalgMatrix( irrelevant_ideal, Length( irrelevant_ideal ), 1, S );
    
    S!.projective_spaces := L;
    
    return S;
    
end );

##
InstallMethod( KoszulChainComplexOp,
          [ IsHomalgGradedRing, IsInt ],
  function( S, n )
    local ind, K, rank_one, add_rank_one, ch_add_ranke_one, l, u, diffs;
      
      ind := IndeterminatesOfPolynomialRing( S );
      
      K := AsGradedLeftPresentation( HomalgMatrix( ind, S ), [ -n ] );
      
      K := ProjectiveChainResolution( K, true );
      
      rank_one := FullSubcategoryGeneratedByGradedFreeModulesOfRankOne( S );
      
      add_rank_one := AdditiveClosure( rank_one );
      
      ch_add_ranke_one := ChainComplexCategory( add_rank_one );
      
      l := ActiveLowerBound( K );
      
      u := ActiveUpperBound( K );
      
      diffs := List( [ l + 1 .. u ],
        function( i )
          local source, range, mat;
          
          source := List( GeneratorDegrees( Source( K^i ) ), degree -> GradedFreeLeftPresentation( 1, S, [ degree ] ) );
          
          if IsEmpty( source ) then
            
            source := ZeroObject( add_rank_one );
            
          else
            
            source := List( source, o -> o / rank_one ) / add_rank_one;
          
          fi;
          
          range := List( GeneratorDegrees( Range( K^i ) ), degree -> GradedFreeLeftPresentation( 1, S, [ degree ] ) );
    
          if IsEmpty( range ) then
            
            range := ZeroObject( add_rank_one );
            
          else
            
            range := List( range, o -> o / rank_one ) / add_rank_one;
            
          fi;
          
          mat := UnderlyingMatrix( K^i );
          
          mat := List( [ 1 .. Size( ObjectList( source ) ) ],
                  u -> List( [ 1 .. Size( ObjectList( range ) ) ],
                        v -> GradedPresentationMorphism(
                                UnderlyingCell( source[u] ),
                                HomalgMatrix( [ [ mat[ u, v ] ] ], 1, 1, S ),
                                UnderlyingCell( range[ v ] )
                              ) / rank_one
                           )
                       );
          
          return AdditiveClosureMorphism( source, mat, range );
          
        end );
      
      return ChainComplex( diffs, l + 1 );
      
end );

#
#euler_sequence := function( S )
#  local L, w, Lw, d_m1, d_m2;
#  L := LCochainFunctor( S );
#  w := TwistedOmegaModule( KoszulDualRing( S ), 1 );
#  Lw := ApplyFunctor( L, w );
#  d_m1 := Lw^0;
#  d_m2 := CokernelColift( Lw^-2, Lw^-1 );
#  return CochainComplex( [ d_m2, d_m1 ], -2 );
#end;
#
#
#koszul_syzygy_module_old :=
#    function( S, k )
#      return CokernelObject( koszul_resolution_old( S )^( -k - 2 ) );
#end;
#
#koszul_resolution :=
#    function( S )
#      local ind, n, L, C;
#
#      ind := IndeterminatesOfPolynomialRing( S );
#      n := Length( ind );
#      L := List( Reversed( [ 1 .. n ] ), i -> UnderlyingMatrix( TwistedCotangentSheaf( S, i - 1 ) ) );
#      Add( L, SyzygiesOfColumns( L[ n ] ) );
#
#      L := List( [ 1 .. n + 1 ], i -> [ L[i], NrRows( L[i] ), NrCols( L[i] ), n-i+2 ] );
#      L := List( L, l ->
#                   GradedPresentationMorphism(
#                     GradedFreeLeftPresentation( l[2],S, ListWithIdenticalEntries(l[2], l[4] ) ),
#                     l[1],
#                     GradedFreeLeftPresentation(l[3],S,ListWithIdenticalEntries(l[3],l[4]-1 )) 
#                   )       
#               );
#      
#      C := CochainComplex( L, - n - 1 );
#
#      if not IsWellDefined( C ) then
#        Error( "the created complex is not well-defined!\n" );
#      fi;
#
#      return C;
#end;
#

#
#m := InputFromUser( "P^m x P^n, for m = " );
#n := InputFromUser( "and n = " );
#L := Cartesian( [ 0 .. m ], [ 0 .. n ] );
#L := List( L, l -> Concatenation( "Z_", String( l[ 1 ] ), String( l[ 2 ] ) ) );
#constructe_categories( [m,n] );
# A := GradedRing( HomalgFieldOfRationalsInSingular()*JoinStringsWithSeparator(L,",") );
#WeightsOfIndeterminates( A );
#
#
#quit;
#create_delta := function( S, i )
#  local T, B, omega_ii, D, o_mi_p_1, delta;
#
#  T := box_tensor_bifunctor(S);
#  # We want the ordered basis of Hom( O(-i) ⊠ Ω^i(i), O(-i+1) ⊠ Ω^i(i) )
#  B := BasisBetweenTwistedStructureSheaves( S!.factor_rings[1],-i,-i+1 );
#  omega_ii := TwistedCotangentSheaf( S!.factor_rings[2], i );
#  B := List( B, b -> Product( b, IdentityMorphism( omega_ii ) ) );
#  B := List( B, b -> ApplyFunctor( T, b ) );
#  # We want the ordered basis of Hom( O(-i+1) ⊠ Ω^i(i), O(-i+1) ⊠ Ω^i-1(i-1) )
#  D := BasisBetweenTwistedCotangentSheaves( S!.factor_rings[2], i, i-1 );
#  o_mi_p_1 := TwistedStructureSheaf( S!.factor_rings[1], -i + 1 );
#  D := List( D, d -> Product( IdentityMorphism( o_mi_p_1 ), d ) );
#  D := List( D, d -> ApplyFunctor( T, d ) );
#  return Sum( ListN( B, D, PreCompose ) );
#
#end;
#
#diagonal_res := function( S, N )
#  local koszul_res_2, lambda, L;
#
#  # We want to canonical morphism from O(0) □ Ω^0(0) ---> O(0,0)
#  koszul_res_2 := koszul_resolution( S!.factor_rings[2] );
#  lambda := CokernelColift( koszul_res_2^-2, koszul_res_2^-1 );
#  lambda := ApplyFunctor( p_i_star( S, 2 ), lambda );
#  # lambda is isomorphism in coh
#  
#  L := List( [ -N .. -1 ], i -> create_delta( S, -i ) );
#  L[N] := PreCompose( L[N], lambda );
#  return CochainComplex( L, -N );
#
#end;
#
#N := InputFromUser( "P^N x P^N, for N = " );
# constructe_categories( [N,N] );
# C := diagonal_res( S, N );
#
#
##############################
#N := 3;
#constructe_categories( [N,N] );
#homalg_field := CoefficientsRing( S );
#S_x := GradedRing( homalg_field*Concatenation( "x_0..", String( N ) ) );
#S_y := GradedRing( homalg_field*Concatenation( "y_0..", String( N ) ) );
#cat_x := GradedLeftPresentations( S_x );
#cat_y := GradedLeftPresentations( S_y );
#koszul_res_x := koszul_resolution(S_x);
#koszul_res_y := koszul_resolution(S_y);
#iota := CokernelColift( koszul_res_y^-3, koszul_res_y^-2 )[ 1 ];
#q_star_iota := ApplyFunctor( p_star(S_y,S,2), iota );
#pi := CokernelProjection( koszul_res_x^-2 )[ 1 ];
#p_star_pi := ApplyFunctor( p_star(S_x,S,1), pi );
#q_star_iota_p_star_pi := PreCompose( q_star_iota, p_star_pi )[ [-1,0] ];

