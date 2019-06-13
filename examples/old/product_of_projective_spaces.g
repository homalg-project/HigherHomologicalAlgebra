LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "NConvex" );
LoadPackage( "BBGG" );
LoadPackage( "ExamplesForModelCategories" );

multi_linears := function( S )
  local weights, inds, l, cart_l, M, N, L, K;

  weights := Set( WeightsOfIndeterminates(S) );
  inds := List( weights, w -> Filtered( Indeterminates(S), ind -> Degree(ind)=w ) );
  l := List( inds, ind -> [ 1 .. Length( ind ) ] );
  cart_l := Cartesian( l );
  M := Length(l);
  N := Sum( List( l, Length ) );
  L := List( [ M .. N ], i -> Filtered( cart_l, l -> Sum(l) = i ) );
  K := List( L, l -> Sum( List( l, e -> Product( List( [ 1 .. M ], i -> inds[ i ][ e[ i ] ] ) ) ) ) );
  K := HomalgMatrix( K, S );
  return AsGradedLeftPresentation( K, [ Degree( One( S ) ) ] );
end;

basis_from_unit_to_graded_row := function( M )
  local S, weights, n, variables, G, dG, positions, L, mats, current_mat, U, i;

  S := UnderlyingHomalgGradedRing( M );
  weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
  n := Length( weights );
  variables := List( weights,  w -> Filtered( Indeterminates( S ), ind -> Degree( ind ) =   w ) );
  weights := List( weights, w -> 
               List( EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( w ) ) ), HomalgElementToInteger ) );
  
  G := UnzipDegreeList( M );
  G := List( G, UnderlyingMorphism );
  G := List( G, MatrixOfMap );
  G := List( G, EntriesOfHomalgMatrix );
  G := List( G, g -> List( g, HomalgElementToInteger ) );
  dG := DuplicateFreeList( G );
  dG := List( dG, g -> SolutionIntMat( weights, g ) );
  dG := List( dG, function( g )
                    if ForAny( g, i -> i < 0 ) then
                      return  [ [ Zero( S )  ] ];
                    fi;
                    return List( [ 1 .. n ], 
                             i -> List( UnorderedTuples( variables[ i ], g[ i ] ),
                                    l -> Product( l ) * One( S ) ) );
                  end );
  dG := List( dG, g ->
           Iterated( g, 
             function( l1, l2 )
               return ListX( l1, l2, \* );
             end ) );

  positions := List( DuplicateFreeList( G ), d -> Positions( G, d ) );
  L := ListWithIdenticalEntries( Length( G ), 0 );
  List( [ 1 .. Length( dG ) ], i -> List( positions[ i ], function( p ) L[p] := dG[i]; return 0; end ) );
  
  mats := [  ];

  for i in [ 1 .. Length( L ) ] do
    
    current_mat := ListWithIdenticalEntries( Length( G ), [ Zero( S ) ] );

    current_mat[ i ] := L[ i ];

    mats := Concatenation( mats, Cartesian( current_mat ) );

  od;

  U := TensorUnit( CapCategory( M ) );
  return List( mats, mat -> GradedRowOrColumnMorphism( U, HomalgMatrix( mat, Rank( U ), Rank( M ), S ), M ) );
end;

coeff_from_unit_to_graded_tow := function( phi )
  local category, S, K, U, B, A, sol;
  category := CapCategory( phi );
  S := UnderlyingHomalgGradedRing( phi );
  K := CoefficientsRing( S );
  U := TensorUnit( category );
  B := basis_from_unit_to_graded_row( Range( phi ) );
  B := UnionOfRows( List( B, UnderlyingHomalgMatrix) );
  A := UnderlyingHomalgMatrix( phi );
  # XB = A
  sol := RightDivide( A, B );
  sol := EntriesOfHomalgMatrix( sol );
  return List( sol, s -> s/K );
end;

basis_between_graded_rows := function( M, N )
  local hom_M_N, B;
  hom_M_N := InternalHomOnObjects( M, N );
  B := basis_from_unit_to_graded_row( hom_M_N );
  return List( B, mor -> InternalHomToTensorProductAdjunctionMap( M, N, mor) );
end;

generators_of_external_hom := function( M, N )
  local S, weights, n, MM, NN, H, HH, G, G_, positions, maps, matrices, G1, variables, G2, G3, L;

S := UnderlyingHomalgRing( M );
weights := Set( WeightsOfIndeterminates( S ) );
n := Length( weights );
MM := UnderlyingPresentationObject( M );
NN := UnderlyingPresentationObject( N );
H := InternalHomOnObjects( M, N );
HH := UnderlyingPresentationObject( H );
G := GeneratorDegrees( H );
G_ := List( G, g -> 
     List( 
     EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( g ) ) ),
     HomalgElementToInteger ) );

positions := PositionsProperty( G_, g -> ForAll( g, d -> d <= 0 ) );

G := G{positions};
maps := List( positions, p -> StandardGeneratorMorphism( HH, p ) );
maps := List( maps, map -> InternalHomToTensorProductAdjunctionMap( MM, NN, map ) );
matrices := List( maps, UnderlyingMatrix );
G := List( G, UnderlyingMorphism );
G := List( G, MatrixOfMap );
G := List( G, EntriesOfHomalgMatrix );
G := -List( G, g -> List( g, HomalgElementToInteger ) );
G1 := Set( G );

variables := List( weights,  w -> Filtered( Indeterminates( S ), ind -> Degree( ind ) = w ) );

weights := List( weights, w -> List( EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( w ) ) ), HomalgElementToInteger ) );

G2 := List( G1, g -> SolutionIntMat( weights, g ) );
G3 := List( G2, function( g )
return List( [ 1 .. n ], i -> List( UnorderedTuples( variables[i], g[i] ), l -> Product(l)*One(S) ) ); end );

G3 := List( G3, g ->
        Iterated( g, function( l1, l2 ) return ListX( l1, l2, \* ); end ) );

L := List( [ 1 .. Length(G) ], i -> matrices[i]*G3[ Position(G1, G[i]) ] );
L := Concatenation( L );
L := List( L, l -> GradedPresentationMorphism( M, l, N ) );
return L;
end;


emb_of_power_irr_ideal :=
  function( S, n )
    local F, irr, syz, func, entries, degrees, power;

    F := GradedFreeLeftPresentation( 1, S );
    irr := S!.irrelevant_ideal;
    syz := SyzygiesOfRows( irr );
    func := function( e )
              local ev, list_of_coeff, monomials;
              if IsZero( e ) then
                return e;
              fi;
              ev := EvalRingElement( e );
              list_of_coeff := EntriesOfHomalgMatrix( Coefficients( ev ) );
              list_of_coeff := List( list_of_coeff, c -> String(c)/S );
              monomials := List( Coefficients( ev )!.monomials, m -> String( m )/S );
              monomials := List( monomials, m -> m^n );
              return list_of_coeff * monomials;
            end;
    entries := EntriesOfHomalgMatrix( syz );
    entries := List( entries, func );
    syz := HomalgMatrix( entries, NrRows( syz ), NrCols( syz ), S );

    entries := EntriesOfHomalgMatrix( irr );
    entries := List( entries, e -> e^n );
    irr := HomalgMatrix( entries, NrRows( irr ), NrCols( irr ), S );
    degrees := ListWithIdenticalEntries( NrCols( syz ), Degree( MatElm( irr, 1, 1 ) ) );
    power := AsGradedLeftPresentation( syz, degrees );
    return GradedPresentationMorphism( power, irr,  F );
end;

# the embedding of B^n+1 in B^n, B^0 = S
emb_of_two_succ_powers_of_irr_ideal := function( S, n )
  local irr, H, a, b;
  if n = 0 then
    return emb_of_power_irr_ideal( S, 1 );
  fi;
  irr := EntriesOfHomalgMatrix( S!.irrelevant_ideal );
  H := HomalgDiagonalMatrix( irr );
  a := Source( emb_of_power_irr_ideal( S, n + 1 ) );
  b := Source( emb_of_power_irr_ideal( S, n ) );
  return GradedPresentationMorphism( a, H, b );
end;

ann := function( M )
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

end;

saturation_over_monomial := function( ideal, monomial )
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
 
end;

##
is_some_power_of_irrelevant_ideal_contained_in_ideal := function( irrelevant_ideal, ideal )
    local S, current_sat, monomial, monomials, list;

    S := HomalgRing( ideal );

    monomials := List( [ 1 .. NrRows( irrelevant_ideal ) ], i -> CertainRows( irrelevant_ideal, [ i ] ) );

    for monomial in monomials do

        current_sat := saturation_over_monomial( ideal, monomial );

        if not current_sat[ 3 ] then

          return false;

        fi;

    od;

    return true;

end;

##
sheafifies_to_zero := function( M )
    local S, ideal, irrelevant_ideal;

    irrelevant_ideal := UnderlyingHomalgRing( M )!.irrelevant_ideal;

    if IsZero( M ) then
      return true;
    fi;

    ideal := ann( M );
    
    if IsZero( ideal ) then
      return false;
    fi;

    return is_some_power_of_irrelevant_ideal_contained_in_ideal( irrelevant_ideal, ideal );

end;


test_sat_cochain :=
     function( M )
       local S, M_, U, U_, right_unitor, right_unitor_, t, maps, cat;

       S := UnderlyingHomalgRing( M );
       cat := GradedLeftPresentations( S );
 
       # We need the isomorphism M --> Hom(U,M)
 
       M_ := UnderlyingPresentationObject( M );
       
       U := TensorUnit( cat );
       U_ := UnderlyingPresentationObject( U );
 
       right_unitor := RightUnitorInverse( M );
       right_unitor_ := UnderlyingPresentationMorphism( right_unitor );
 
       t := TensorProductToInternalHomAdjunctionMap( M_, U_, right_unitor_ );
       if not IsIsomorphism( t ) then
         Error( "?" );
       fi;
 
       t := GradedPresentationMorphism( M, t, InternalHomOnObjects( U, M ) );
 
       maps := MapLazy( IntegersList, function( i )
 
                                        if i < -1 then
                                          
                                          return UniversalMorphismFromZeroObject( Source( maps[ i + 1 ] ) );
                                        
                                        elif i = -1 then
 
                                          return t;
 
                                        else
 
                                          return InternalHomOnMorphisms( emb_of_two_succ_powers_of_irr_ideal( S, i ), IdentityMorphism( M ) );
 
                                        fi; end, 1 );

         return maps;
end;

cox_ring_of_product_of_projective_spaces := function( L )
  local homalg_field, variables, variables_strings, factor_rings, weights, S, irrelevant_ideal, ring_maps;

  homalg_field := HomalgFieldOfRationalsInSingular(  );

  if Length( L ) > 7 then
    return fail;
  fi;

  variables := [ "x_", "y_", "z_", "s_", "t_", "u_", "w_" ];

  ring_maps := List( [ 1 .. Length( L ) ],
    k -> JoinStringsWithSeparator( Concatenation( List( [ 1 .. Length( L ) ],
        i -> List( [ 0 .. L[ i ] ], function( j )
                                      if i = k then

                                        return Concatenation( variables[ i ], String( j ) );

                                      else
                                        
                                        return "1";
                                      
                                      fi;

                                    end ) ) ), "," ) );

  variables_strings := List( [ 1 .. Length( L ) ], 
        i -> List( [ 0 .. L[ i ] ], j -> Concatenation( variables[ i ], String( j ) ) ) );
  variables := List( variables_strings, v -> JoinStringsWithSeparator(v,",") );
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
  ring_maps := List( [ 1 .. Length( L ) ], k -> HomalgMatrix( ring_maps[ k ], Sum( L ) + Length( L ), 1, S!.factor_rings[ k ]  ) );
  ring_maps := List( [ 1 .. Length( L ) ], k -> RingMap( ring_maps[ k ], S, S!.factor_rings[ k ] ) );
  S!.ring_maps := ring_maps;
  return S;
end;


S := 0; cat := 0; sub_cat := 0; coh := 0; sh := 0;
S_1 := 0; cat_1 := 0; coh_1 := 0; sh_1 := 0;
S_2 := 0; cat_2 := 0; coh_2 := 0; sh_2 := 0;

constructe_categories := function( product )
    local AQ_1, AQ_2;
    S := cox_ring_of_product_of_projective_spaces( product );
    cat := GradedLeftPresentations( S );
    sub_cat := FullSubcategoryByMembershipFunction( cat, sheafifies_to_zero );
    coh := cat / sub_cat;
    sh := CanonicalProjection( coh );


    # first factor
    S_1 := S!.factor_rings[ 1 ];
    PREPARE_CATEGORIES_OF_HOMALG_GRADED_POLYNOMIAL_RING( S_1 );
    cat_1 := GradedLeftPresentations( S_1 );
    coh_1 := CoherentSheavesOverProjectiveSpace( S_1 );
    sh_1 := CanonicalProjection( coh_1 );

    S_2 := S!.factor_rings[ 2 ];
    PREPARE_CATEGORIES_OF_HOMALG_GRADED_POLYNOMIAL_RING( S_2 );
    cat_2 := GradedLeftPresentations( S_2 );
    coh_2 := CoherentSheavesOverProjectiveSpace( S_2 );
    sh_2 := CanonicalProjection( coh_2 );

    Print( "S, cat, coh, sh\n" );
    Print( "S_1, cat_1, coh_1, sh_1\n" );
    Print( "S_2, cat_2, coh_2, sh_2\n" );

    return;
end;

euler_sequence := function( S )
  local L, w, Lw, d_m1, d_m2;
  L := LCochainFunctor( S );
  w := TwistedOmegaModule( KoszulDualRing( S ), 1 );
  Lw := ApplyFunctor( L, w );
  d_m1 := Lw^0;
  d_m2 := CokernelColift( Lw^-2, Lw^-1 );
  return CochainComplex( [ d_m2, d_m1 ], -2 );
end;

koszul_resolution_old := 
    function( S )
      local ind, K;
      ind := IndeterminatesOfPolynomialRing( S );
      K := AsGradedLeftPresentation( HomalgMatrix( ind, S ), [ 0 ] );
      K := ProjectiveResolution( K );
      SetLowerBound( K, - Length( ind ) - 1 );
      return K;
end;

koszul_syzygy_module_old :=
    function( S, k )
      return CokernelObject( koszul_resolution_old( S )^( -k - 2 ) );
end;

koszul_resolution :=
    function( S )
      local ind, n, L, C;

      ind := IndeterminatesOfPolynomialRing( S );
      n := Length( ind );
      L := List( Reversed( [ 1 .. n ] ), i -> UnderlyingMatrix( TwistedCotangentSheaf( S, i - 1 ) ) );
      Add( L, SyzygiesOfColumns( L[ n ] ) );

      L := List( [ 1 .. n + 1 ], i -> [ L[i], NrRows( L[i] ), NrCols( L[i] ), n-i+2 ] );
      L := List( L, l ->
                   GradedPresentationMorphism(
                     GradedFreeLeftPresentation( l[2],S, ListWithIdenticalEntries(l[2], l[4] ) ),
                     l[1],
                     GradedFreeLeftPresentation(l[3],S,ListWithIdenticalEntries(l[3],l[4]-1 )) 
                   )       
               );
      
      C := CochainComplex( L, - n - 1 );

      if not IsWellDefined( C ) then
        Error( "the created complex is not well-defined!\n" );
      fi;

      return C;
end;

p_i_star := function( S, i )
  local cat_i, cat, func;

  cat_i := GradedLeftPresentations( S!.factor_rings[ i ] );

  cat := GradedLeftPresentations( S );
  
  func := CapFunctor( Concatenation( String( i ), "-factor " ), cat_i, cat );

  AddObjectFunction( func,
    function( M )
      local generator_degrees, n, degrees, j;
    
      if not IsIdenticalObj( UnderlyingHomalgRing( M ), S!.factor_rings[ i ] ) then
        
        Error( "The given object is not defined over the expected ring.\n" );

      fi;

      generator_degrees := List( GeneratorDegrees( M ), HomalgElementToInteger );
      
      n := Length( S!.factor_rings );

      degrees := List( generator_degrees, g -> ListWithIdenticalEntries( n, 0 ) );

      for j in [ 1 .. Length( degrees ) ] do

        degrees[ j ][ i ] := generator_degrees[ j ];

      od;

      return AsGradedLeftPresentation( UnderlyingMatrix( M ) * S, degrees );

  end );

  AddMorphismFunction( func,

     function( source, f, range )

       return GradedPresentationMorphism( source, UnderlyingMatrix( f ) * S, range );

  end );

  return func;

end;

box_tensor_bifunctor := function( S )
    local cat, cats, prod_cats, n, F;

    cat := GradedLeftPresentations( S );
    cats := List( S!.factor_rings, GradedLeftPresentations );
    prod_cats := CallFuncList( Product, cats );
    n := Length( cats );
    F := CapFunctor( "Box tensor functor", prod_cats, cat );
    
    # M_1 x M_2 x ... x M_n -> M_1 ⊠ M_2 ⊠ ... ⊠ M_n
    AddObjectFunction( F,
        function( M )
          local L;
          L := List( [ 1 .. n ], i -> ApplyFunctor( p_i_star(S,i), M[ i ] ) );
          return Iterated( L, TensorProductOnObjects );
    end );
    
    # f_1 x f_2 x ... x f_n -> f_1 ⊠ f_2 ⊠ ... ⊠ f_n
    AddMorphismFunction( F,
        function( source, phi, range )
          local L;
          L := List( [ 1 .. n ], i -> ApplyFunctor( p_i_star(S,i), phi[ i ] ) );
          return Iterated( L, TensorProductOnMorphisms );
    end );

    return F;
end;

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

decompose_matrix :=
function( M )
  local S, n, L, dimensions, non_zeros, func;
  
  S := UnderlyingHomalgRing( M );
  n := Length( Indeterminates( S ) );
  L := List( [ 1 .. n-1 ], i -> UnderlyingMatrix( TwistedCotangentSheaf( S, i-1 ) ) );
  Add( L, SyzygiesOfColumns( L[ 1 ] ), 1 );
  dimensions := List( L, l -> [ NrRows( l ), NrCols( l ) ] );
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

end;

morphism_into_canonical_object := function( M )
  local mat, dec, S, syz, zero_sheaf, omega_00, n, L, sources, ranges, mor;
  
  if IsBound( M!.canonicalized ) and M!.canonicalized = true then
    return IdentityMorphism( M );
  fi;

  mat := UnderlyingMatrix( M );
  dec := decompose_matrix( M );
  if dec = [  ] then
    return UniversalMorphismIntoZeroObject( M );
  fi;
  
  S := UnderlyingHomalgRing( M );
  syz := SyzygiesOfColumns( UnderlyingMatrix( TwistedCotangentSheaf( S, 0 ) ) );
  zero_sheaf := AsGradedLeftPresentation( syz, [ 1 ] );
  omega_00 := GradedFreeLeftPresentation( 1, S, [ 0 ] );

  n := Length( dec );

  L := List( [ 1 .. n ], 
            function( i )

              if dec[ i ] = -1 then
                return UniversalMorphismIntoZeroObject( zero_sheaf );
              elif dec[ i ] = 0 then
                return GradedPresentationMorphism( TwistedCotangentSheaf( S, 0 ), syz, omega_00 );
              else
                return IdentityMorphism( TwistedCotangentSheaf( S, dec[ i ] ) );
              fi;
            end );

    sources := List( L, Source );
    ranges := List( L, Range );

    mor := List( [ 1 .. n ], i -> 
                List( [ 1 .. n ], function( j )
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

end;

canonicalize_functor := function( S )
  local cat, Can;

  cat := GradedLeftPresentations( S );
  Can := CapFunctor( "canonicalize direct sums of twisted cotangent sheaves", cat, cat );

  AddObjectFunction( Can,
    function( M )
      return Range( morphism_into_canonical_object( M ) );
    end );

  AddMorphismFunction( Can,
    function( source, phi, range )
      local s, r, psi;
      s := morphism_into_canonical_object( Source( phi ) );
      r := morphism_into_canonical_object( Range( phi ) );
      return Colift( s, PreCompose( phi, r ) );
    end );

  return Can;

end;

LFReplacement := function( cell )
  local S, B, Can;
  S := UnderlyingHomalgRing( cell );
  B := BeilinsonReplacement( cell );
  Can := canonicalize_functor( S );
  Can := ExtendFunctorToChainComplexCategoryFunctor( Can );
  B := ApplyFunctor( Can, B );
  return B;
end;

LF := function( S )
  local cat, chains, F;

  cat := GradedLeftPresentations( S );
  chains := ChainComplexCategory( cat );
  F := CapFunctor( "to be named", cat, chains );
  AddObjectFunction( F,
    function( M )
      return LFReplacement( M );
  end );

  AddMorphismFunction( F,
    function( source, phi, range )
      return LFReplacement( phi );
  end );

  return F;

end;


U_p1_p1_on_objects :=
  function( M )
    local m, S, G, M_1, M_2, LF_M_1, LF_M_2, ch_p_1_star, ch_p_2_star, L, summands;

    m := UnderlyingMatrix( M );
    S := HomalgRing( m );
    cat := GradedLeftPresentations( S );

    if NrRows( m ) <> 0 then

      Error( "Wrong input" );

    fi;
    
    G := GeneratorDegrees( M );
    
    if G = [  ] then

      return ZeroObject( cat );

    elif Length( G ) = 1 then
      
      G := List( G, g ->
             List( 
               EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( g ) ) ),
                 HomalgElementToInteger ) );

      M_1 := GradedFreeLeftPresentation( 1, S!.factor_rings[ 1 ], [ G[ 1 ][ 1 ] ] );
      M_2 := GradedFreeLeftPresentation( 1, S!.factor_rings[ 2 ], [ G[ 1 ][ 2 ] ] );

      LF_M_1 := ApplyFunctor( LF(S_1), M_1 );
      LF_M_2 := ApplyFunctor( LF(S_2), M_2 );

      ch_p_1_star := ExtendFunctorToChainComplexCategoryFunctor( p_i_star( S, 1 ) );
      ch_p_2_star := ExtendFunctorToChainComplexCategoryFunctor( p_i_star( S, 2 ) );

      M_1 := ApplyFunctor( ch_p_1_star, LF_M_1 );
      M_2 := ApplyFunctor( ch_p_2_star, LF_M_2 );

      return TensorProductOnObjects( M_1, M_2 );

    else

      summands := List( G, g -> GradedFreeLeftPresentation( 1, S, [ g ] ) );
      summands := List( summands, U_p1_p1_on_objects );
      return DirectSum( summands );

    fi;

end;

U_p1_p1_on_morphisms :=
  function( phi )
    local S, cat, M_1, M_2, m_1, m_2, mat, G_1, G_2, mats, 
      phi_1, phi_2, LF_phi_1, LF_phi_2, ch_p_1_star, ch_p_2_star, summands_1, summands_2, maps;

    S := UnderlyingHomalgRing( phi );
    cat := GradedLeftPresentations( S );

    M_1 := Source( phi );
    M_2 := Range( phi );

    m_1 := UnderlyingMatrix( M_1 );
    m_2 := UnderlyingMatrix( M_2 );

    mat := UnderlyingMatrix( phi );

    if NrRows( m_1 ) <> 0 or NrRows( m_2 ) <> 0 then

      Error( "Wrong input" );

    fi;
    
    G_1 := GeneratorDegrees( M_1 );
    G_2 := GeneratorDegrees( M_2 );

    if G_1 = [  ] or G_2 = [  ] then

      return fail;

    elif Length( G_1 ) = 1 and Length( G_2 ) = 1 then

      mats := List( S!.ring_maps, map -> Pullback( map, mat ) );

      G_1 := List( G_1, g ->
       List(
         EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( g ) ) ),
           HomalgElementToInteger ) );

      G_2 := List( G_2, g ->
       List(
        EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( g ) ) ),
           HomalgElementToInteger ) );

      phi_1 := GradedPresentationMorphism(
                GradedFreeLeftPresentation( 1, S!.factor_rings[ 1 ], [ G_1[ 1 ][ 1 ] ] ),
                mats[ 1 ],
                GradedFreeLeftPresentation( 1, S!.factor_rings[ 1 ], [ G_2[ 1 ][ 1 ] ] )
            );

      phi_2 := GradedPresentationMorphism(
                GradedFreeLeftPresentation( 1, S!.factor_rings[ 2 ], [ G_1[ 1 ][ 2 ] ] ),
                mats[ 2 ],
                GradedFreeLeftPresentation( 1, S!.factor_rings[ 2 ], [ G_2[ 1 ][ 2 ] ] )
            );

      LF_phi_1 := ApplyFunctor( LF(S_1), phi_1 );
      LF_phi_2 := ApplyFunctor( LF(S_2), phi_2 );

      ch_p_1_star := ExtendFunctorToChainComplexCategoryFunctor( p_i_star( S, 1 ) );
      ch_p_2_star := ExtendFunctorToChainComplexCategoryFunctor( p_i_star( S, 2 ) );

      phi_1 := ApplyFunctor( ch_p_1_star, LF_phi_1 );
      phi_2 := ApplyFunctor( ch_p_2_star, LF_phi_2 );

      return TensorProductOnMorphisms( phi_1, phi_2 );
    else

      summands_1 := List( G_1, g -> GradedFreeLeftPresentation( 1, S, [ g ] ) );
      summands_2 := List( G_2, g -> GradedFreeLeftPresentation( 1, S, [ g ] ) );
      maps := List( [ 1 .. Length( G_1 ) ], i -> 
                List( [ 1 .. Length( G_2 ) ], j -> 
                U_p1_p1_on_morphisms( 
                GradedPresentationMorphism( 
                summands_1[ i ],
                HomalgMatrix( [ MatElm( mat, i, j ) ], 1, 1, S ),
                summands_2[ j ] ) ) ) );
      return MorphismBetweenDirectSums( maps );

    fi;

end;

L := InputFromUser( "P^m_1 x ... x P^m_s, for L = " );
constructe_categories( L );

O := GradedFreeLeftPresentation( 1, S, [ [0,0] ] );
quit;
create_delta := function( S, i )
  local T, B, omega_ii, D, o_mi_p_1, delta;

  T := box_tensor_bifunctor(S);
  # We want the ordered basis of Hom( O(-i) ⊠ Ω^i(i), O(-i+1) ⊠ Ω^i(i) )
  B := BasisBetweenTwistedStructureSheaves( S!.factor_rings[1],-i,-i+1 );
  omega_ii := TwistedCotangentSheaf( S!.factor_rings[2], i );
  B := List( B, b -> Product( b, IdentityMorphism( omega_ii ) ) );
  B := List( B, b -> ApplyFunctor( T, b ) );
  # We want the ordered basis of Hom( O(-i+1) ⊠ Ω^i(i), O(-i+1) ⊠ Ω^i-1(i-1) )
  D := BasisBetweenTwistedCotangentSheaves( S!.factor_rings[2], i, i-1 );
  o_mi_p_1 := TwistedStructureSheaf( S!.factor_rings[1], -i + 1 );
  D := List( D, d -> Product( IdentityMorphism( o_mi_p_1 ), d ) );
  D := List( D, d -> ApplyFunctor( T, d ) );
  return Sum( ListN( B, D, PreCompose ) );

end;

diagonal_res := function( S, N )
  local koszul_res_2, lambda, L;

  # We want to canonical morphism from O(0) □ Ω^0(0) ---> O(0,0)
  koszul_res_2 := koszul_resolution( S!.factor_rings[2] );
  lambda := CokernelColift( koszul_res_2^-2, koszul_res_2^-1 );
  lambda := ApplyFunctor( p_i_star( S, 2 ), lambda );
  # lambda is isomorphism in coh
  
  L := List( [ -N .. -1 ], i -> create_delta( S, -i ) );
  L[N] := PreCompose( L[N], lambda );
  return CochainComplex( L, -N );

end;

N := InputFromUser( "P^N x P^N, for N = " );
constructe_categories( [N,N] );
C := diagonal_res( S, N );


#############################
N := 3;
constructe_categories( [N,N] );
homalg_field := CoefficientsRing( S );
S_x := GradedRing( homalg_field*Concatenation( "x_0..", String( N ) ) );
S_y := GradedRing( homalg_field*Concatenation( "y_0..", String( N ) ) );
cat_x := GradedLeftPresentations( S_x );
cat_y := GradedLeftPresentations( S_y );
koszul_res_x := koszul_resolution(S_x);
koszul_res_y := koszul_resolution(S_y);
iota := CokernelColift( koszul_res_y^-3, koszul_res_y^-2 )[ 1 ];
q_star_iota := ApplyFunctor( p_star(S_y,S,2), iota );
pi := CokernelProjection( koszul_res_x^-2 )[ 1 ];
p_star_pi := ApplyFunctor( p_star(S_x,S,1), pi );
q_star_iota_p_star_pi := PreCompose( q_star_iota, p_star_pi )[ [-1,0] ];

