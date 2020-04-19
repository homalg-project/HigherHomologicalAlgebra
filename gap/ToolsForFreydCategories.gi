

##
InstallGlobalFunction( ADD_RANDOM_METHODS_TO_GRADED_ROWS,
  function( category )
    local S;
    
    S := UnderlyingGradedRing( category );
    
    ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS( S );
    
    ##
    AddRandomObjectByList( category,
      function( category, L )
        local degree_list;
        degree_list := List( [ 1 .. L[1] ], i -> [ Random( L[2] ), 1 ] );
        return GradedRow( degree_list, S );
    end );
    
    ##
    AddRandomMorphismWithFixedSourceByList( category,
      function( a, L )
        local degrees_a, degrees_b, b, mat;
        degrees_a := UnzipDegreeList( a );
        degrees_b := List( L, l -> [ l, 1 ] );
        b := GradedRow( degrees_b, S );
        degrees_b := UnzipDegreeList( b );
        mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
        return GradedRowOrColumnMorphism( a, mat, b );
    end );
    
    ##
    AddRandomMorphismWithFixedRangeByList( category,
      function( b, L )
        local degrees_a, degrees_b, a, mat;
        degrees_b := UnzipDegreeList( b );
        degrees_a := List( L, l -> [ l, 1 ] );
        a := GradedRow( degrees_a, S );
        degrees_a := UnzipDegreeList( a );
        mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
        return GradedRowOrColumnMorphism( a, mat, b );
    end );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByList( category,
      function( a, b, L )
        local degrees_a, degrees_b, mat;
        degrees_a := UnzipDegreeList( a );
        degrees_b := UnzipDegreeList( b );
        mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
        return GradedRowOrColumnMorphism( a, mat, b );
    end );
    
    ##
    AddRandomMorphismByList( category,
      function( category, L )
        local degrees_a, degrees_b, a, b, mat;
        degrees_a := List( [ 1 .. L[ 1 ] ], i -> [ Random( L[ 3 ] ), 1 ] );
        degrees_b := List( [ 1 .. L[ 2 ] ], i -> [ Random( L[ 4 ] ), 1 ] );
        a := GradedRow( degrees_a, S );
        b := GradedRow( degrees_b, S );
        degrees_a := UnzipDegreeList( a );
        degrees_b := UnzipDegreeList( b );
        mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
        return GradedRowOrColumnMorphism( a, mat, b );
    end );
    
    ##
    AddRandomObjectByInteger( category,
      function( category, n )
        local weights, degrees_list;
        
        weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
        Add( weights, Degree( One( S ) ) );
        weights := List( weights, HomalgElementToListOfIntegers );
        degrees_list := List( [ 1 .. n ], i -> Sum( List( [ 1 .. Random( [ 1 .. 4 ] ) ], j -> ( -1 ) ^ j * Random( weights ) ) ) );
        return RandomObjectByList( category, [ n, degrees_list ] );
    end );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
      function( a, b, n )
        return RandomMorphismWithFixedSourceAndRangeByList( a, b, [] );
    end );
    
    ##
    AddRandomMorphismWithFixedSourceByInteger( category,
      function( a, n )
        local degrees_a, weights, degrees_b, b;
  
        degrees_a := UnzipDegreeList( a );
        weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
        Add( weights, Degree( One( S ) ) );
        degrees_b := List( [ 1 .. n ], i -> [ Random( degrees_a ) + Sum( List( [ 1 .. Random( [ 1 .. 3 ] ) ], j -> Random( weights ) ) ), 1 ]  );
        b := GradedRow( degrees_b, S );
        return RandomMorphismWithFixedSourceAndRangeByInteger( a, b, 0 );
    end );
    
    ##
    AddRandomMorphismWithFixedRangeByInteger( category,
      function( b, n )
        local degrees_b, weights, degrees_a, a;
  
        degrees_b := UnzipDegreeList( b );
        weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
        Add( weights, Degree( One( S ) ) );
        degrees_a := List( [ 1 .. n ], i -> [ Random( degrees_b ) - Sum( List( [ 1 .. Random( [ 1 .. 3 ] ) ], j -> Random( weights ) ) ), 1 ]  );
        a := GradedRow( degrees_a, S );
        return RandomMorphismWithFixedSourceAndRangeByInteger( a, b, 0 );
    end );
   
end );

##
InstallMethodWithCrispCache( BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW,
          [ IsGradedRow ],
function( M )
  local S, G, dG, positions, L, mats, current_mat, i;
  
  if Rank( M ) = 0 then
    return [  ];
  fi;
  
  S := UnderlyingHomalgGradedRing( M );
  
  G := UnzipDegreeList( M );
  dG := DuplicateFreeList( G );
  dG := List( dG, d -> MONOMIALS_OF_DEGREE( S, d ) );
  
  positions := List( DuplicateFreeList( G ), d -> Positions( G, d ) );
  L := ListWithIdenticalEntries( Length( G ), 0 );
  List( [ 1 .. Length( dG ) ], i -> List( positions[ i ], function( p ) L[p] := dG[i]; return 0; end ) );
  
  mats := [  ];
  
  for i in [ 1 .. Length( L ) ] do
    
    current_mat := ListWithIdenticalEntries( Length( G ), [ Zero( S ) ] );
    
    current_mat[ i ] := L[ i ];
    
    if not IsZero( current_mat ) then
      
      mats := Concatenation( mats, Cartesian( current_mat ) );
    
    fi;
  
  od;
  
  return mats;

end );

##
InstallGlobalFunction( BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_ROWS,
  function( a, b )
    local S, degrees_a, degrees_b, degrees, hom_a_b, mats;

    S := UnderlyingHomalgGradedRing( a );
    
    degrees_a := UnzipDegreeList( a );

    degrees_b := UnzipDegreeList( b );

    degrees := Concatenation( List( degrees_a, a -> List( degrees_b, b -> -a + b ) ) );

    degrees := List( degrees, d -> [ d, 1 ] );
    
    hom_a_b := GradedRow( degrees, S );

    mats := BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW( hom_a_b );

    return List( mats, 
              mat -> GradedRowOrColumnMorphism( a, HomalgMatrix( mat, Rank( a ), Rank( b ), S ), b ) );

end );

##
InstallGlobalFunction( COEFFICIENTS_OF_MORPHISM_OF_GRADED_ROWS_WITH_GIVEN_BASIS_OF_EXTENRAL_HOM,
  function( phi, basis )
    local category, K, S, a, b, U, degrees_a, degrees_b, degrees, hom_a_b, mat, psi, B, A, sol, list_of_entries,
    position_of_non_zero_entry, current_coeff, current_coeff_mat, current_mono, position_in_basis,
    current_term, current_entry, j;
    
    category := CapCategory( phi );
    
    K := CommutativeRingOfLinearCategory( category );
   
    S := UnderlyingHomalgGradedRing( phi );

    a := Source( phi );
    
    b := Range( phi );
    
    if Rank( a ) = 0 or Rank( b ) = 0 then
      
      return [  ];
    
    fi;
    
    degrees_a := UnzipDegreeList( a );

    degrees_b := UnzipDegreeList( b );

    degrees := Concatenation( List( degrees_a, a -> List( degrees_b, b -> -a + b ) ) );

    degrees := List( degrees, d -> [ d, 1 ] );

    hom_a_b := GradedRow( degrees, S );
    
    A := UnderlyingHomalgMatrix( phi );

    list_of_entries := ShallowCopy( EntriesOfHomalgMatrix( A ) );

    B := BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW( hom_a_b );
    
    if B = [  ] then
      
      return [  ];

    fi;

    sol := ListWithIdenticalEntries( Length( B ), Zero( K) );
    
    # the run time depends on how many non-zero elements list_of_entries has.
    
    while PositionProperty( list_of_entries, a -> not IsZero( a ) ) <> fail do

      position_of_non_zero_entry := PositionProperty( list_of_entries, a -> not IsZero( a ) );
      current_entry := list_of_entries[ position_of_non_zero_entry ];
      current_coeff_mat := Coefficients( EvalRingElement( current_entry ) );
      
      for j in [ 1 .. NrRows( current_coeff_mat ) ] do
        
        current_coeff := MatElm( current_coeff_mat, j, 1 );
        current_mono := current_coeff_mat!.monomials[ j ]/S;
        current_term := current_coeff/S * current_mono;
        position_in_basis := PositionProperty( B, b -> b[ position_of_non_zero_entry ] = current_mono );
        sol[ position_in_basis ] := current_coeff/K;
        
      od;
      
      list_of_entries[ position_of_non_zero_entry ] := Zero( S );

    od;
    
    return sol;

end );

##
InstallMethod( CategoryOfGradedRows,
          [ IsHomalgGradedRing ],
          1000,
  function( S )
    local v, rows, r;
    
    v := ValueOption( "cogr_derived_cats" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
     
    rows := CategoryOfGradedRows( S : FinalizeCategory := false, cogr_derived_cats := false );
    
    SetUnderlyingCategoryOfRows( rows, CategoryOfRows( S ) );
    
    ADD_RANDOM_METHODS_TO_GRADED_ROWS( rows );
      
    ## Adding the external hom methods 
    AddBasisOfExternalHom( rows, BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_ROWS );
    
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( rows, COEFFICIENTS_OF_MORPHISM_OF_GRADED_ROWS_WITH_GIVEN_BASIS_OF_EXTENRAL_HOM );
    
    ## Defining rows as linear category
    SetIsLinearCategoryOverCommutativeRing( rows, true );
    
    SetCommutativeRingOfLinearCategory( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( rows,
      { r, phi } -> GradedRowOrColumnMorphism( Source( phi ), ( r / S ) * UnderlyingHomalgMatrix( phi ), Range( phi ) )
    );
    
    r := RandomTextColor( "" );
    
    rows!.Name := Concatenation( r[ 1 ], "Graded rows( ", r[ 2 ], String( S ), r[ 1 ], " )", r[ 2 ] );
    
    Finalize( rows );;
    
    # To derive a nice homomorphism structore on Freyd category of the rows
    SetIsProjective( DistinguishedObjectOfHomomorphismStructure( rows ), true );
  
    return rows;
    
end );

##
InstallMethod( FreydCategory,
          [ IsCapCategory ],
          1000,
  function( underlying_category )
    local v, freyd_category, r;
    
    v := ValueOption( "fc_derived_cats" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
    
    freyd_category := FREYD_CATEGORY( underlying_category : fc_derived_cats := false, FinalizeCategory := false );
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category )
        and IsLinearCategoryOverCommutativeRing( underlying_category )
          and HasCommutativeRingOfLinearCategory( underlying_category ) then
        
        SetIsLinearCategoryOverCommutativeRing( freyd_category, true );
        
        SetCommutativeRingOfLinearCategory( freyd_category, CommutativeRingOfLinearCategory( underlying_category ) );
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( freyd_category,
          { r, alpha } -> FreydCategoryMorphism(
                            Source( alpha ),
                            MultiplyWithElementOfCommutativeRingForMorphisms( r, MorphismDatum( alpha ) ),
                            Range( alpha )
                          )
        );
        
    fi;
    
    r := RandomTextColor( Name( underlying_category ) );
    
    freyd_category!.Name := Concatenation( r[ 1 ], "Freyd category( ", r[ 2 ], Name( underlying_category ), r[ 1 ], " )", r[ 2 ] );
   
    Finalize( freyd_category );
    
    return freyd_category;
    
end );

###########################################
#
# Related to product of projective spaces
#
###########################################

InstallGlobalFunction( ANNIHILATOR_OF_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS,
   
  function( o )
    local rm, m, ring, rows, freyd, free_rank_1, n, id, maps, mats, a, b;
    
    rm := RelationMorphism( o );
    
    m := UnderlyingHomalgMatrix( rm );
    
    ring := UnderlyingHomalgGradedRing( rm );
    
    rows := UnderlyingCategoryOfRows( UnderlyingCategory( CapCategory( o ) ) );
    
    freyd := FreydCategory( rows );
    
    free_rank_1 := AsFreydCategoryObject( 1 / rows );
    
    o := FreydCategoryObject( m / rows );
    
    n := NrCols( m );
    
    id := HomalgIdentityMatrix( n, ring );
    
    maps := List( [ 1 .. n ], i -> FreydCategoryMorphism( free_rank_1, CertainRows( id, [ i ] ) / rows, o ) );
    
    maps := List( maps, KernelEmbedding );
    
    mats := List( maps, map -> UnderlyingMatrix( MorphismDatum( map ) ) );
    
    if IsEmpty( mats ) then
      
      return HomalgIdentityMatrix( 1, ring );
      
    elif ForAny( mats, a -> NrRows( a ) = 0 ) then

      return HomalgZeroMatrix( 0, 1, ring );

    else
      
      a := mats[ 1 ];
      
      for b in mats{ [ 2 .. n ] } do
        
        a := SyzygiesOfRows( b, a ) * b;
        
      od;
      
      return a;

    fi;

end );

##
InstallGlobalFunction( IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS_IN_KERNEL_OF_SERRE_QUOTIENT,
  
  function( o )
    local S, irrelevant_ideal, ideal;
    
    S := UnderlyingGradedRing( UnderlyingCategory( CapCategory( o ) ) );
    
    irrelevant_ideal := S!.irrelevant_ideal;
    
    ideal := ANNIHILATOR_OF_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS( o );

    return IS_SOME_POWER_OF_IRRELEVANT_IDEAL_CONTAINED_IN_IDEAL_PPS( irrelevant_ideal, ideal );

end );

##
InstallMethod( CoherentSheavesOverProductOfProjectiveSpaces,
          [ IsHomalgGradedRing ],
  function( S )
    local freyd, sub_cat, coh, factors, r;
    
    freyd := FreydCategory( CategoryOfGradedRows( S ) );
    
    sub_cat := FullSubcategoryByMembershipFunction( freyd, IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PPS_IN_KERNEL_OF_SERRE_QUOTIENT );
    
    coh := freyd / sub_cat;
    
    factors := List( S!.projective_spaces, i -> Concatenation( "P^", String( i ) ) );
    
    factors := JoinStringsWithSeparator( factors, "x" );
    
    r := RandomTextColor( Name( freyd ) );
    
    coh!.Name := Concatenation( r[ 1 ], "Coherent sheaves( ", r[ 2 ], factors, " with Cox ring ", String( S ), r[ 1 ], " )", r[ 2 ] );
    
    return coh;
    
end );

##
InstallMethod( PullbackFunctorAlongProjectionOp,
          [ IsHomalgGradedRing, IsInt ],
function( S, i )
  local freyd_i, freyd, name, F;
  
  freyd_i := FreydCategory( CategoryOfGradedRows( S!.factor_rings[ i ] ) );
  
  freyd := FreydCategory( CategoryOfGradedRows( S ) );
  
  name := Concatenation( "Pullback functor along the projection onto ", String( i ), "-factor of product of projective spaces" );
  
  F := CapFunctor( name, freyd_i, freyd );
  
  AddObjectFunction( F,
    function( o )
      local rm, source_degs, new_source_degs, new_source, range_degs, new_range_degs, new_range, m, j;
       
      rm := RelationMorphism( o );
      
      source_degs := DegreeList( Source( rm ) );
      
      new_source_degs := List( [ 1 .. Size( source_degs ) ], j -> [ ShallowCopy( HomalgElementToListOfIntegers( Degree( One( S ) ) ) ), source_degs[ j ][ 2 ] ] );
      
      for j in [ 1 .. Size( source_degs ) ] do

        new_source_degs[ j ][ 1 ][ i ] := source_degs[ j ][ 1 ];

      od;
      
      new_source := GradedRow( new_source_degs, S );
      
      range_degs := DegreeList( Range( rm ) );
      
      new_range_degs := List( [ 1 .. Size( range_degs ) ], j -> [ ShallowCopy( HomalgElementToListOfIntegers( Degree( One( S ) ) ) ), range_degs[ j ][ 2 ] ] );
      
      for j in [ 1 .. Size( range_degs ) ] do

        new_range_degs[ j ][ 1 ][ i ] := range_degs[ j ][ 1 ];

      od;
      
      new_range := GradedRow( new_range_degs, S );
      
      m := UnderlyingHomalgMatrix( rm );
      
      m := GradedRowOrColumnMorphism( new_source, m * S, new_range );
      
      return FreydCategoryObject( m );

  end );

  AddMorphismFunction( F,

    function( s, alpha, r )
      local m;
      
      m := MorphismDatum( alpha );
      
      m := GradedRowOrColumnMorphism(
              Range( RelationMorphism( s ) ),
              UnderlyingHomalgMatrix( m ) * S,
              Range( RelationMorphism( r ) )
            );
      
      return FreydCategoryMorphism( s, m, r );

  end );

  return F;

end );


##
InstallOtherMethod( _WeakKernelEmbedding,
          [ IsGradedRowMorphism ],
  WeakKernelEmbedding
);

