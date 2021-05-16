# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
EnhancePackage( "GradedRingForHomalg" );
EnhancePackage( "MatricesForHomalg" );
EnhancePackage( "FreydCategoriesForCAP" );
EnhancePackage( "Algebroids" );

InstallMethod( MonomialsWithGivenDegreeOp,
          [ IsHomalgGradedRing, IsHomalgModuleElement ],
          
  function( S, degree )
    
    if ForAll( WeightsOfIndeterminates( S ), w -> w = 1 )
          or ForAll( WeightsOfIndeterminates( S ), w -> w = -1 ) then
          
        return EntriesOfHomalgMatrix( MonomialMatrix( HomalgElementToInteger( degree ), S ) );
        
    else
        
        TryNextMethod( );
        
    fi;
  
end );

##
BindGlobal( "BASIS_OF_GRADED_ROW",
  
  function( o )
    local S, G, mats, z, i, j;
    
    S := UnderlyingHomalgGradedRing( o );
    
    G := List( DegreeList( o ), d -> [ MonomialsWithGivenDegree( S, d[ 1 ] ), d[ 2 ] ] );
    G := Concatenation( List( G, d -> ListWithIdenticalEntries( d[ 2 ], d[ 1 ] ) ) );
    
    mats := [ ];
    
    z := ListWithIdenticalEntries( Rank( o ), Zero( S ) );
    
    for i in [ 1 .. Rank( o ) ] do
      for j in [ 1 .. Size( G[i] ) ] do
        z[i] := G[i,j];
        Add( mats, ShallowCopy( z ) );
        z[i] := Zero( S );
      od;
    od;
    
    return mats;
    
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
       
    ## Defining rows as linear category
    SetIsLinearCategoryOverCommutativeRing( rows, true );
    
    SetCommutativeRingOfLinearCategory( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( rows,
      { r, phi } -> GradedRowOrColumnMorphism( Source( phi ), ( r / S ) * UnderlyingHomalgMatrix( phi ), Range( phi ) )
    );
    
    r := RandomTextColor( "" );
    
    rows!.Name := Concatenation( r[ 1 ], "Graded rows( ", r[ 2 ], String( S ), r[ 1 ], " )", r[ 2 ] );
    
    if CanComputeMonomialsWithGivenDegreeForRing( S ) then
    
      ADD_RANDOM_METHODS_TO_GRADED_ROWS( rows );
    
      ## Adding the external hom methods 
      AddBasisOfExternalHom( rows,
      
        function( a, b )
          local S, degrees_a, degrees_b, degrees, hom_a_b, mats;
          
          S := UnderlyingHomalgGradedRing( a );
          
          degrees_a := UnzipDegreeList( a );
          
          degrees_b := UnzipDegreeList( b );
          
          degrees := CollectEntries( Concatenation( List( degrees_a, a -> List( degrees_b, b -> b - a ) ) ) );
          
          hom_a_b := GradedRow( degrees, S );
          
          mats := BASIS_OF_GRADED_ROW( hom_a_b );
          
          return List( mats, 
                    mat -> GradedRowOrColumnMorphism(
                                a,
                                HomalgMatrix( mat, Rank( a ), Rank( b ), S ),
                                b
                              )
                  );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( rows,
        
        { phi, B } -> CoefficientsOfMorphism( phi )
      );
      
      ##
      InstallMethod( CoefficientsOfMorphism,
                [ IsGradedRowOrColumnMorphism and MorphismFilter( rows ) ],
                
        function( phi )
          local K, degrees_s, degrees_r, degrees, hom_s_r, B, sol, positions, coeff, mon, position_in_basis, p, j;
          
          K := CommutativeRingOfLinearCategory( rows );
          
          degrees_s := UnzipDegreeList( Source( phi ) );
          
          degrees_r := UnzipDegreeList( Range( phi ) );
          
          degrees := CollectEntries( Concatenation( List( degrees_s, a -> List( degrees_r, b -> b - a ) ) ) );
          
          hom_s_r := GradedRow( degrees, UnderlyingHomalgGradedRing( phi ) );
          
          B := BASIS_OF_GRADED_ROW( hom_s_r );

          phi := UnderlyingHomalgMatrix( phi );
          
          phi := EntriesOfHomalgMatrix( phi );
                    
          if B = [  ] then
            
            return [  ];
            
          fi;
          
          sol := ListWithIdenticalEntries( Length( B ), Zero( K) );
          
          # the run time depends on the number of monomials in phi
          
          positions := PositionsProperty( phi, e -> not IsZero( e ) );
          
          for p in positions do
            
            mon := MonomialsOfGradedRingElement( phi[ p ] );
            
            coeff := CoefficientsOfGradedRingElement( phi[ p ] );
            
            for j in [ 1 .. Size( coeff ) ] do
              
              position_in_basis := PositionProperty( B, b -> b[ p ] = mon[ j ] );
              sol[ position_in_basis ] := coeff[ j ] / K;
              
            od;
            
          od;
          
          return sol;
         
      end );
       
    fi;
    
    Finalize( rows );;
        
    return rows;
    
end );

##
InstallMethod( IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne,
          [ IsCategoryOfGradedRows ],
  function( rows )
    local S, full, add_full, name, F;
    
    S := UnderlyingGradedRing( rows );
    
    full := FullSubcategoryGeneratedByGradedRowsOfRankOne( S );
    
    add_full := AdditiveClosure( full );
    
    name := "Isomorphism from category of graded rows to additive closure of full subcategory of graded rows of rank 1";
    
    F := CapFunctor( name, rows, add_full );
    
    AddObjectFunction( F,
      function( a )
        local degs;
        
        degs := UnzipDegreeList( a );
        
        if IsEmpty( degs ) then
          
          return ZeroObject( add_full );
          
        else
          
          return List( degs, d -> GradedRow( [ [ d, 1 ] ], S ) / full ) / add_full;
          
        fi;
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local m, s_list, r_list;
        
        m := UnderlyingHomalgMatrix( alpha );
        
        s_list := ObjectList( s );
        
        r_list := ObjectList( r );
        
        m := List( [ 1 .. Size( s_list ) ],
                i -> List( [ 1 .. Size( r_list ) ],
                  j -> GradedRowOrColumnMorphism(
                              UnderlyingCell( s_list[i] ),
                              CertainRows( CertainColumns( m, [ j ] ), [ i ] ),
                              UnderlyingCell( r_list[j] )
                            ) / full
                         )
                   );
        
        return AdditiveClosureMorphism( s, m, r );
        
    end );
    
    return F;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByGradedRowsOfRankOne,
          [ IsHomalgGradedRing ],
  
  function( S )
    local rows, r, name, full, FinalizeCategory;
    
    rows := CategoryOfGradedRows( S );
    
    r := RandomTextColor( Name( rows ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory( ", r[ 2 ], Name( rows ), r[ 1 ], " generated by objects of rank one", r[ 2 ] );
    
    full := FullSubcategory( rows, name : FinalizeCategory := false );
    
    AddIsWellDefinedForObjects( full,
      a -> IsWellDefinedForObjects( UnderlyingCell( a ) ) and Rank( UnderlyingCell( a ) ) = 1
    );
    
    AddIsWellDefinedForMorphisms( full,
      a -> IsWellDefinedForMorphisms( UnderlyingCell( a ) )
              and Rank( UnderlyingCell( Source( a ) ) ) = 1
                and Rank( UnderlyingCell( Range( a ) ) ) = 1
    );
    
    Finalize( full );
    
    return full;
    
end );

##
BindGlobal( "SET_INTERPRETATION_ISOMORPHISM_FROM_AND_TO_ALGEBROID",
  function( S )
    local omegas, algebra_1, algebroid_1, algebra_2, algebroid_2, I1, I2, algebroid, I;
    
    if not IsBound( S!.factor_rings ) or Length( S!.factor_rings ) <> 2 then
      
      TryNextMethod( );
      
    fi;
    
    omegas := FullSubcategoryGeneratedByBoxProductOfTwistedCotangentModules( S );
    
    algebra_1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 1 ] );
    
    algebroid_1 := Algebroid( algebra_1 );
    
    algebra_2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 2 ] );
    
    algebroid_2 := Algebroid( algebra_2 );
    
    I1 := InterpretationIsomorphismFromAlgebroid( algebroid_1 );
    
    I2 := InterpretationIsomorphismFromAlgebroid( algebroid_2 );
    
    algebroid := TensorProductOnObjects( algebroid_1, algebroid_2 );
    
    if not HasInterpretationIsomorphismFromAlgebroid( algebroid ) then
      
      I := IsomorphismFromTensorProductOfAlgebroidsOntoBoxProductOfFullSubcategories( I1, I2, omegas );
      
      if not IsIdenticalObj( algebroid, SourceOfFunctor( I ) ) then
        Error( "Unexpected error happend, please report this!\n" );
      fi;
     
      SetInterpretationIsomorphismFromAlgebroid( algebroid, I );
      
    fi;
    
    if not HasInterpretationIsomorphismOntoAlgebroid( algebroid ) then
      
      I := IsomorphismFromBoxProductOfFullSubcategoriesOntoTensorProductOfAlgebroids( I1, I2, omegas );
      
      if not IsIdenticalObj( algebroid, RangeOfFunctor( I ) ) then
        Error( "Unexpected error happend, please report this!\n" );
      fi;
      
      SetInterpretationIsomorphismOntoAlgebroid( algebroid, I );
      
    fi;
    
end );

##
BindGlobal( "BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_ALGEBROID",

  function( S )
    local full, A1, A2, Ho_A, ring, B1, B2, name, B, func_on_objects, func_on_morphisms;
    
    SET_INTERPRETATION_ISOMORPHISM_FROM_AND_TO_ALGEBROID( S );
    
    full := FullSubcategoryGeneratedByGradedRowsOfRankOne( S );
    
    A1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 1 ] );
    
    A1 := Algebroid( A1 );
    
    A2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 2 ] );
    
    A2 := Algebroid( A2 );
    
    Ho_A := HomotopyCategory( AdditiveClosure( TensorProductOnObjects( A1, A2 ) ) );
    
    ring := CommutativeRingOfLinearCategory( Ho_A );
    
    B1 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 1 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S!.factor_rings[ 1 ] )
            );
    
    B2 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 2 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S!.factor_rings[ 2 ] )
            );
    
    name := "Beilinson functor on product of projective spaces onto homotopy category of tensor product of algebroids";
    
    B := CapFunctor( name, full, Ho_A );
    
    func_on_objects :=
      function( a )
        local degs;
        
        degs := HomalgElementToListOfIntegers( DegreeList( UnderlyingCell( a ) )[ 1 ][ 1 ] );
        
        a := ListN( degs, S!.factor_rings, { deg, ring } -> GradedRow( [ [ [ deg ], 1 ] ], ring ) );
        
        return BoxProduct( B1( a[ 1 ] ), B2( a[ 2 ] ), Ho_A );
    
      end;
    
    func_on_morphisms :=
      function( alpha )
        local s, r;
        
        s := func_on_objects( Source( alpha ) );
        
        r := func_on_objects( Range( alpha ) );
        
        alpha := DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces( UnderlyingCell( alpha ) );
        
        if IsEmpty( alpha ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return Sum( List( alpha, l -> ( l[ 1 ] / ring ) * BoxProduct( B1( l[ 2 ][ 1 ] ), B2( l[ 2 ][ 2 ] ), Ho_A ) ) );
          
        fi;
        
      end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, Ho_A, func_on_objects, func_on_morphisms );
    
end );

##
BindGlobal( "BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_QUIVER_ROWS",

  function( S )
    local full, A1, A2, Ho_QRows, ring, B1, B2, name, B, func_on_objects, func_on_morphisms;
    
    SET_INTERPRETATION_ISOMORPHISM_FROM_AND_TO_ALGEBROID( S );
    
    full := FullSubcategoryGeneratedByGradedRowsOfRankOne( S );
    
    A1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 1 ] );
    
    A2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[ 2 ] );
    
    Ho_QRows := HomotopyCategory( QuiverRows( TensorProductOfAlgebras( A1, A2 ) ) );
    
    ring := CommutativeRingOfLinearCategory( Ho_QRows );
    
    B1 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 1 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S!.factor_rings[ 1 ] )
            );
    
    B2 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 2 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S!.factor_rings[ 2 ] )
            );
    
    name := "Beilinson functor on product of projective spaces onto homotopy category of quiver rows";
    
    B := CapFunctor( name, full, Ho_QRows );
    
    func_on_objects :=
      function( a )
        local degs;
        
        degs := HomalgElementToListOfIntegers( DegreeList( UnderlyingCell( a ) )[ 1 ][ 1 ] );
        
        a := ListN( degs, S!.factor_rings, { deg, ring } -> GradedRow( [ [ [ deg ], 1 ] ], ring ) );
        
        return BoxProduct( B1( a[ 1 ] ), B2( a[ 2 ] ), Ho_QRows );
    
      end;
    
    func_on_morphisms :=
      function( alpha )
        local s, r;
        
        s := func_on_objects( Source( alpha ) );
        
        r := func_on_objects( Range( alpha ) );
        
        alpha := DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces( UnderlyingCell( alpha ) );
        
        if IsEmpty( alpha ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return Sum( List( alpha, l -> ( l[ 1 ] / ring ) * BoxProduct( B1( l[ 2 ][ 1 ] ), B2( l[ 2 ][ 2 ] ), Ho_QRows ) ) );
          
        fi;
        
      end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, Ho_QRows, func_on_objects, func_on_morphisms );
    
end );

##
BindGlobal( "BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_BOX_PRODUCT_OF_OMEGAS",

  function( S )
    local full, freyd, ring, B1, B2, omegas_1, omegas_2, omegas, Ho_omegas, name, B, func_on_objects, func_on_morphisms;
    
    full := FullSubcategoryGeneratedByGradedRowsOfRankOne( S );
    
    freyd := FreydCategory( CategoryOfGradedRows( S ) );
    
    ring := CommutativeRingOfLinearCategory( freyd );
    
    B1 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 1 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules( S!.factor_rings[ 1 ] )
            );
    
    B2 := PreCompose(
              EmbeddingFunctorIntoFreydCategory( CategoryOfGradedRows( S!.factor_rings[ 2 ] ) ),
              BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules( S!.factor_rings[ 2 ] )
            );
    
    omegas_1 := UnderlyingCategory( DefiningCategory( RangeOfFunctor( B1 ) ) );
    
    omegas_2 := UnderlyingCategory( DefiningCategory( RangeOfFunctor( B2 ) ) );
    
    omegas := BoxProduct( omegas_1, omegas_2, freyd );
    
    Ho_omegas := HomotopyCategory( AdditiveClosure( omegas ) );
    
    name := "Beilinson functor on product of projective spaces onto homotopy category of additive closure of box product of twisted cotangent modules";
    
    B := CapFunctor( name, full, Ho_omegas );
    
    func_on_objects :=
      function( a )
        local degs;
        
        degs := HomalgElementToListOfIntegers( DegreeList( UnderlyingCell( a ) )[ 1 ][ 1 ] );
        
        a := ListN( degs, S!.factor_rings, { deg, ring } -> GradedRow( [ [ [ deg ], 1 ] ], ring ) );
        
        return BoxProduct( B1( a[ 1 ] ), B2( a[ 2 ] ), Ho_omegas );
    
      end;
    
    func_on_morphisms :=
      function( alpha )
        local s, r;
        
        s := func_on_objects( Source( alpha ) );
        
        r := func_on_objects( Range( alpha ) );
        
        alpha := DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces( UnderlyingCell( alpha ) );
        
        if IsEmpty( alpha ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return Sum( List( alpha, l -> ( l[ 1 ] / ring ) * BoxProduct( B1( l[ 2 ][ 1 ] ), B2( l[ 2 ][ 2 ] ), Ho_omegas ) ) );
          
        fi;
        
      end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, Ho_omegas, func_on_objects, func_on_morphisms );
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows,
          [ IsHomalgGradedRing ],
  function( S )
    local rows, B, I;
    
    if not IsBound( S!.factor_rings ) or Length( S!.factor_rings ) <> 2 then
      TryNextMethod( );
    fi;
    
    rows := CategoryOfGradedRows( S );
    
    B := BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_QUIVER_ROWS( S );
    
    B := ExtendFunctorToAdditiveClosureOfSource( B );
    
    I := IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne( rows );
    
    I := PreCompose( I, B );
    
    I!.Name := "Cotangent Beilinson functor";
     
    return I;
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid,
          [ IsHomalgGradedRing ],
  function( S )
    local rows, B, I;
    
    if not IsBound( S!.factor_rings ) or Length( S!.factor_rings ) <> 2 then
      TryNextMethod( );
    fi;
    
    rows := CategoryOfGradedRows( S );
    
    B := BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_ALGEBROID( S );
    
    B := ExtendFunctorToAdditiveClosureOfSource( B );
    
    I := IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne( rows );
    
    I := PreCompose( I, B );
    
    I!.Name := "Cotangent Beilinson functor";
    
    return I;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByBoxProductOfTwistedCotangentModules,
          [ IsHomalgGradedRing ],
  function( S )
    local freyd, B1, B2, omegas_1, omegas_2;
    
    if not IsBound( S!.factor_rings ) and Size( S!.factor_rings ) = 2 then
      TryNextMethod( );
    fi;
    
    freyd := FreydCategory( CategoryOfGradedRows( S ) );
    
    B1 := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules( S!.factor_rings[ 1 ] );
    
    B2 := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules( S!.factor_rings[ 2 ] );
    
    omegas_1 := UnderlyingCategory( DefiningCategory( RangeOfFunctor( B1 ) ) );
    
    omegas_2 := UnderlyingCategory( DefiningCategory( RangeOfFunctor( B2 ) ) );
    
    return BoxProduct( omegas_1, omegas_2, freyd );
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfBoxProductOfTwistedCotangentModules,
          [ IsHomalgGradedRing ],
  function( S )
    local rows, B, I;
    
    if not IsBound( S!.factor_rings ) or Length( S!.factor_rings ) <> 2 then
      TryNextMethod( );
    fi;
    
    rows := CategoryOfGradedRows( S );
    
    B := BEILINSON_EXPERIMENTAL_ON_GRADED_ROWS_OF_RANK_ONE_ONTO_BOX_PRODUCT_OF_OMEGAS( S );
    
    B := ExtendFunctorToAdditiveClosureOfSource( B );
    
    I := IsomorphismOntoAdditiveClosureOfFullSubcategoryGeneratedByGradedRowsOfRankOne( rows );
    
    I := PreCompose( I, B );
    
    I!.Name := "Cotangent Beilinson functor";
    
    return I;
    
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
InstallGlobalFunction( IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PS_IN_KERNEL_OF_SERRE_QUOTIENT,
  
  function( o )
    local freyd, rows, S;
    
    freyd := CapCategory( o );
    
    rows := UnderlyingCategory( freyd );
    
    S := UnderlyingGradedRing( rows );
    
    o := ApplyFunctor( EquivalenceFromFreydCategoryOfGradedRowsOntoGradedLeftPresentations( S ), o );
    
    return IsZero( HilbertPolynomial( AsPresentationInHomalg( o ) ) );
    
end );

##
InstallMethod( CoherentSheavesOverProjectiveSpace,
          [ IsHomalgGradedRing ],
          1000,
  function( S )
    local freyd, sub_cat, coh, factor, r;
    
    freyd := FreydCategory( CategoryOfGradedRows( S ) );
    
    sub_cat := FullSubcategoryByMembershipFunction( freyd, IS_FREYD_CATEGORY_OBJECT_OF_COX_RING_OF_PS_IN_KERNEL_OF_SERRE_QUOTIENT );
    
    coh := freyd / sub_cat;
    
    factor := Concatenation( "P^", String( Size( Indeterminates( S ) ) - 1 ) );
    
    r := RandomTextColor( Name( freyd ) );
    
    coh!.Name := Concatenation( r[ 1 ], "Coherent sheaves( ", r[ 2 ], factor, " with Cox ring ", String( S ), r[ 1 ], " )", r[ 2 ] );
    
    return coh;
    
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
InstallMethod( PullbackFunctorAlongProjectionIntoFreydCategoryOp,
          [ IsHomalgGradedRing, IsInt ],
function( S, i )
  local freyd_i, freyd, name, F;
  
  freyd_i := FreydCategory( CategoryOfGradedRows( S!.factor_rings[ i ] ) );
  
  freyd := FreydCategory( CategoryOfGradedRows( S ) );
  
  name := Concatenation( "Pullback functor along the projection onto ", String( i ), "-factor of Cox product of product of projective spaces" );
  
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
InstallMethod( PullbackFunctorAlongProjectionIntoGradedRowsOp,
          [ IsHomalgGradedRing, IsInt ],
function( S, i )
  local rows_i, rows, name, F;
  
  rows_i := CategoryOfGradedRows( S!.factor_rings[ i ] );
  
  rows := CategoryOfGradedRows( S );
  
  name := Concatenation( "Pullback functor along the projection onto ", String( i ), "-factor of Cox ring of product of projective spaces" );
  
  F := CapFunctor( name, rows_i, rows );
  
  AddObjectFunction( F,
    function( o )
      local source_degs, new_source_degs, j;
      
      source_degs := DegreeList( o );
      
      new_source_degs := List( [ 1 .. Size( source_degs ) ], j -> [ ShallowCopy( HomalgElementToListOfIntegers( Degree( One( S ) ) ) ), source_degs[ j ][ 2 ] ] );
      
      for j in [ 1 .. Size( source_degs ) ] do

        new_source_degs[ j ][ 1 ][ i ] := source_degs[ j ][ 1 ];

      od;
      
      return GradedRow( new_source_degs, S );
      
  end );
  
  AddMorphismFunction( F,
    
    function( s, alpha, r )
      
      return GradedRowOrColumnMorphism(
                  s,
                  UnderlyingHomalgMatrix( alpha ) * S,
                  r
                );
                
  end );

  return F;

end );

##
InstallMethod( EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsOntoGradedRows,
          [ IsFreydCategory ],
          
  function( freyd )
    local rows, S, full, name, F;
    
    rows := UnderlyingCategory( freyd );
    
    if not IsCategoryOfGradedRows( rows ) then
      TryNextMethod( );
    fi;
    
    S := UnderlyingGradedRing( rows );
    
    full := FullSubcategoryGeneratedByProjectiveObjects( freyd );
    
    name := "Equivalence functor from canonical projective objects in Freyd category onto category of graded rows";
    
    F := CapFunctor( name, full, rows );
    
    AddObjectFunction( F,
    
      function( o )
        
        o := UnderlyingCell( o );
        
        o := RelationMorphism( o );
        
        if not Rank( Source( o ) ) = 0 then
          
          Error( "Wrong input!\n" );
          
        fi;
        
        return Range( o );
        
    end );
    
    AddMorphismFunction( F,
      
      function( s, alpha, r )
        
        return MorphismDatum( UnderlyingCell( alpha ) );
        
    end );
    
    return F;
    
end );

##
InstallOtherMethod( _WeakKernelEmbedding,
          [ IsGradedRowMorphism ],
  WeakKernelEmbedding
);

##
InstallMethod( DecomposeMorphismBetweenGradedRowsOfRankOneOverCoxRingOfProductOfProjectiveSpaces,
          [ IsGradedRowMorphism ],
  function( alpha )
    local S, source_degs, sources, range_degs, ranges, inds, e, coeffs, monomials, morphisms;
    
    if not Rank( Source( alpha ) ) = 1 and Rank( Range( alpha ) ) = 1 then
      Error( "Wrong input!\n" );
    fi;
    
    S := UnderlyingHomalgGradedRing( alpha );
    
    if not IsBound( S!.factor_rings ) then
      Error( "Wrong input!\n" );
    fi;
    
    e := UnderlyingHomalgMatrix( alpha )[ 1, 1 ];
    
    coeffs := CoefficientsOfGradedRingElement( e );
    
    if IsEmpty( coeffs ) then
      return [ ];
    fi;
    
    source_degs := HomalgElementToListOfIntegers( DegreeList( Source( alpha ) )[ 1 ][ 1 ] );
    
    sources := ListN( source_degs, S!.factor_rings, { deg, ring } -> GradedRow( [ [ [ deg ], 1 ] ], ring ) );
    
    range_degs := HomalgElementToListOfIntegers( DegreeList( Range( alpha ) )[ 1 ][ 1 ] );
    
    ranges := ListN( range_degs, S!.factor_rings, { deg, ring } -> GradedRow( [ [ [ deg ], 1 ] ], ring ) );
    
    if IsEndomorphism( alpha ) then
      
      return [ [ coeffs[ 1 ], List( sources, IdentityMorphism ) ] ];
      
    fi;
    
    inds := List( S!.factor_rings, ring -> List( Indeterminates( ring ), String ) );
    
    monomials := MonomialsOfGradedRingElement( e );
    
    monomials := List( monomials, m -> SplitString( String( m ), "*" ) );
    
    morphisms := List( monomials,
                  m -> ListN( sources, ranges, inds, S!.factor_rings,
                      function( source, range, ind, ring )
                        local s;
                        
                        s := JoinStringsWithSeparator( Filtered( m, s -> ForAny( ind, x -> PositionSublist( s, x ) <> fail ) ), "*" );
                        
                        if s = "" then
                          s := "1";
                        fi;
                        
                        return GradedRowOrColumnMorphism(
                                    source,
                                    HomalgMatrix( s, 1, 1, ring ),
                                    range
                                );
                      end )
                    );
                    
    return ListN( coeffs, morphisms, { c, m } -> [ c, m ] );
    
end );

##
InstallMethod( BoxProduct,
          [ IsList, IsFreydCategory ],
  function( cells, freyd_category )
    local rows, S, F;
    
    rows := UnderlyingCategory( freyd_category );
    
    S := UnderlyingGradedRing( rows );
    
    if not IsBound( S!.factor_rings ) then
      Error( "The given ring should be a Cox ring of product of projective spaces" );
    fi;
    
    F := List( [ 1 .. Size( S!.factor_rings ) ], i -> PullbackFunctorAlongProjectionIntoFreydCategory( S, i ) );
    
    cells := ListN( F, cells, ApplyFunctor );
    
    return TensorProduct( cells );
    
end );

##
InstallMethod( BoxProduct,
          [ IsList, IsCategoryOfGradedRows ],
  function( cells, rows )
    local S, F;
    
    S := UnderlyingGradedRing( rows );
    
    if not IsBound( S!.factor_rings ) then
      Error( "The given ring should be a Cox ring of product of projective spaces" );
    fi;
    
    F := List( [ 1 .. Size( S!.factor_rings ) ], i -> PullbackFunctorAlongProjectionIntoGradedRows( S, i ) );
    
    cells := ListN( F, cells, ApplyFunctor );
    
    return TensorProduct( cells );
    
end );

##
InstallMethod( BoxProduct,
          [ IsList, IsCapFullSubcategory ],
  
  { cells, full } -> BoxProduct( List( cells, UnderlyingCell ), AmbientCategory( full ) ) / full
);

##
InstallOtherMethod( BoxProduct,
          [ IsFreydCategoryObject, IsFreydCategoryObject, IsFreydCategory ],
  { a, b, freyd_category } -> BoxProduct( [ a, b ], freyd_category )
);

##
InstallOtherMethod( BoxProduct,
          [ IsFreydCategoryMorphism, IsFreydCategoryMorphism, IsFreydCategory ],
  { alpha, beta, freyd_category } -> BoxProduct( [ alpha, beta ], freyd_category )
);

##
InstallOtherMethod( BoxProduct,
          [ IsGradedRow, IsGradedRow, IsCategoryOfGradedRows ],
  { a, b, rows } -> BoxProduct( [ a, b ], rows )
);

##
InstallOtherMethod( BoxProduct,
          [ IsGradedRowMorphism, IsGradedRowMorphism, IsCategoryOfGradedRows ],
  { alpha, beta, rows } -> BoxProduct( [ alpha, beta ], rows )
);

##
InstallOtherMethod( BoxProduct,
          [ IsCapCategoryCellInAFullSubcategory, IsCapCategoryCellInAFullSubcategory, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  { c_1, c_2, full } -> BoxProduct( [ c_1, c_2 ], full )
);

##
InstallOtherMethod( BoxProduct,
          [ IsGradedRow, IsGradedRow, IsFreydCategory ],
  { a, b, freyd_category } -> AsFreydCategoryObject( BoxProduct( [ a, b ], UnderlyingCategory( freyd_category ) ) )
);

##
InstallOtherMethod( BoxProduct,
          [ IsGradedRowMorphism, IsGradedRowMorphism, IsFreydCategory ],
  { alpha, beta, freyd_category } -> AsFreydCategoryMorphism( BoxProduct( [ alpha, beta ], UnderlyingCategory( freyd_category ) ) )
);

##
InstallMethod( BoxProduct,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapCategory ],
  function( full_1, full_2, category )
    local objects_1, objects_2, objects;
    
    objects_1 := List( SetOfKnownObjects( full_1 ), UnderlyingCell );
    
    objects_2 := List( SetOfKnownObjects( full_2 ), UnderlyingCell );
    
    objects := ListX( objects_1, objects_2, { o1, o2 } -> BoxProduct( o1, o2, category ) );
    
    return FullSubcategoryGeneratedByListOfObjects( objects );
    
end );

################################
#
# Random methods
#
################################

## These random methods should be removed as soon as the following PR has been merged to CAP
## https://github.com/homalg-project/CAP_project/pull/479

#####################
##
## Graded Rows
##
#####################

##
InstallGlobalFunction( ADD_RANDOM_METHODS_TO_GRADED_ROWS,
  function( category )
    local S;
    
    S := UnderlyingGradedRing( category );
    
    EnhanceHomalgGradedRingWithRandomFunctions( S );
    
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

####################################
##
## Temp View methods for Quiver rows cells
##
####################################

##
InstallMethod( Display,
            [ IsQuiverRowsObject ],
  function( object )
    local L, o;
  
    L := ListOfQuiverVertices( object );
    
    L := List( L, l -> ListWithIdenticalEntries( l[ 2 ], l[ 1 ] ) );
    
    L := Concatenation( L );
    
    Print( "An object in ", Name( CapCategory( object ) ), " defined by ", Size( L ), " vertices:\n" );
    
    for o in L do
      
      Print( "\n<(", String( o ), ")>" );
      
    od;
    
end );

##
InstallMethod( Display,
            [ IsQuiverRowsMorphism ],
  function( morphism )
    local mat, i, j;
    
    Print( "A morphism in ", Name( CapCategory( morphism ) ),
              " defined by the following ", NrRows( morphism ), " x ", NrColumns( morphism ),
                " matrix of quiver algebra elements:\n"
            );
    
    mat := MorphismMatrix( morphism );
     
    for i in [ 1 .. NrRows( morphism ) ] do
      
      for j in [ 1 .. NrColumns( morphism ) ] do
        
        Print( "\n[", i, ",", j, "]: " );
        Print( String( mat[ i, j ] ) );
        
      od;
      
    od;
    
end );

##
InstallMethod( Display,
            [ IsGradedRow ],
            
  function( object )
    local degrees, s, vs, degree;
    
    Print( Concatenation( "An object in ",
                          Name( CapCategory( object ) ),
                          " with rank ", String( RankOfObject( object ) ),
                          " and degrees: \n" ) 
                        );
    
    degrees := DegreeList( object );
    
    for degree in degrees do
      
      if degree[ 2 ] > 1 then
        s := Concatenation( "^", String( degree[ 2 ] ) );
      else
        s := "";
      fi;
      
      vs := ViewString( degree[ 1 ] );
      
      #if vs[ 1 ] = "(" then
      
          Display( Concatenation( "<", ViewString( degree[ 1 ] ), ">", s ) );
          
      #else
      
          #Display( Concatenation( "<(", ViewString( degree[ 1 ] ), ")>", s ) );
      
      #fi;
      
    od;
     
end );

##
InstallMethod( DisplayCapCategoryCell,
          [ IsGradedRowOrColumnMorphism ],
  function( alpha )
    
    # mapping matrix
    Display( UnderlyingHomalgMatrix( alpha ) );
    
    # general information on morphism
    Print( Concatenation( "\n", StringMutable( alpha ), " defined by the above matrix\n" ) );

end );


##
InstallMethod( DisplayCapCategoryCell,
          [ IsFreydCategoryMorphism ],
  function( alpha )
    
    # mapping matrix
    Display( MorphismDatum( alpha ) );
    
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    
    # general information on morphism
    Display( Concatenation( StringMutable( alpha ), " defined by the above morphism datum" ) );

end );
