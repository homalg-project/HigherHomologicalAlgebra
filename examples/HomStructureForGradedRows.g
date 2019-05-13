ReadPackage( "StableCategoriesForCAP", "/examples/ADD_HOMOMORPHISM_STRUCTURE_TO_CAREGORY_OVER_MATRIX_CATEGORY.g" );

LoadPackage( "4ti2Interface" );
#LoadPackage( "NConvex" );
LoadPackage( "Frey" );

DeclareOperation( "HomalgElementToListOfIntegers", [ IsHomalgModuleElement ] );

InstallMethod( HomalgElementToListOfIntegers,
            [ IsHomalgModuleElement ],
  function( degree )
    local new_degree;
    
    new_degree := UnderlyingMorphism( degree );
    
    new_degree := MatrixOfMap( new_degree );
    
    new_degree := EntriesOfHomalgMatrix( new_degree );
    
    return List( new_degree, HomalgElementToInteger );
    
end );

DeclareOperation( "MONOMIALS_IN_GRADED_RING_WITH_FIXED_DEGREE", [ IsHomalgGradedRing, IsHomalgModuleElement ] );

InstallMethodWithCrispCache( MONOMIALS_IN_GRADED_RING_WITH_FIXED_DEGREE,
  [ IsHomalgGradedRing, IsHomalgModuleElement ],
  function( S, degree )
    local new_degree, indeterminates, weights_of_indeterminates, D, solutions;
    
    new_degree := UnderlyingMorphism( degree );
    new_degree := MatrixOfMap( new_degree );
    new_degree := EntriesOfHomalgMatrix( new_degree );
    new_degree := List( new_degree, HomalgElementToInteger );
    
    indeterminates := Indeterminates( S );
    weights_of_indeterminates := WeightsOfIndeterminates( S );
    D := List( weights_of_indeterminates, UnderlyingMorphism );
    D := List( D, d -> MatrixOfMap( d ) );
    D := Involution( UnionOfRows( D ) );
    D := EntriesOfHomalgMatrixAsListList( D );
 
    solutions := 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant( D, new_degree, [], [] )[ 1 ];
    solutions := List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );

    if HasIsExteriorRing( S ) and IsExteriorRing( S ) then

      solutions := Filtered( solutions, sol -> not IsZero( sol ) );

    fi;

    return  solutions;

end );



DeclareOperation( "BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW", [ IsGradedRow ] );

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
  dG := List( dG, d -> MONOMIALS_IN_GRADED_RING_WITH_FIXED_DEGREE( S, d ) );
  
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

#
InstallMethodWithCrispCache( BasisOfExternalHom,
            [ IsGradedRowOrColumn, IsGradedRowOrColumn ],
  function( a, b )
    local S, degrees_a, degrees_b, degrees, hom_a_b, mats;

    S := UnderlyingHomalgGradedRing( a );
    
    degrees_a := UnzipDegreeList( a );

    degrees_b := UnzipDegreeList( b );

    degrees := Concatenation( List( degrees_a, a -> List( degrees_b, b -> -a + b ) ) );

    degrees := List( degrees, d -> [ d, 1 ] );
    
    # This is the same as the internal hom, but this works for all graded rows.
    hom_a_b := GradedRow( degrees, S );

    mats := BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW( hom_a_b );

    return List( mats, mat -> GradedRowOrColumnMorphism( a, HomalgMatrix( mat, Rank( a ), Rank( b ), S ), b ) );

end );

##
InstallMethod( CoefficientsOfLinearMorphism,
            [ IsGradedRowOrColumnMorphism ],
  function( phi )
    local category, K, S, a, b, U, degrees_a, degrees_b, degrees, hom_a_b, mat, psi, B, A, sol, list_of_entries,
    position_of_non_zero_entry, current_coeff, current_coeff_mat, current_mono, position_in_basis,
    current_term, current_entry, j;
    
    category := CapCategory( phi );
    
    K := FieldForHomomorphismStructure( category );
   
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
    
    # XB = A
    # RightDivide takes a lot time to send the matrix to singular and then to solve it
    # or I fall in recursion trap, because of call of union of rows or cols.

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
InstallMethod( MultiplyWithElementInFieldForHomomorphismStructure,
            [ IsMultiplicativeElement, IsGradedRowOrColumnMorphism ],
  function( e, alpha )
    local S, mat;
    
    S := UnderlyingHomalgGradedRing( alpha );
    
    mat := e/S * UnderlyingHomalgMatrix( alpha );
    
    return GradedRowOrColumnMorphism( Source( alpha ), mat, Range( alpha ) );
    
end );

#S := GradedRing( HomalgFieldOfRationalsInSingular(  )*"x_0,x_1,x_2,x_3,x_4" );
#weights := InputFromUser( "weights?" );
#SetWeightsOfIndeterminates( S, weights );
#rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
#SetFieldForHomomorphismStructure( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
#AddHomomorphismStructureOnCategory( rows );
#Finalize( rows );

TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS2 :=
    
    function( S )
      local R, D, indeterminates, degrees_of_indeterminates, random_matrix_between_free_left_or_right_presentations_func,
        random_matrix_for_left_or_right_presentation_func, auxiliary_degree_func, auxiliary_sum_of_degrees_func,
        random_homogeneous_element_func, detect_generators_degrees_func, detect_relations_degrees_func;
      
      if not IsHomalgGradedRing( S ) then
      
        return false;
      
      fi;
      
      if IsBound( S!.random_homogeneous_element_func ) and
           IsBound( S!.random_matrix_between_free_left_presentations_func ) and
             IsBound( S!.random_matrix_for_left_presentation_func ) then
             
             return true;
             
      fi;
      
      R := UnderlyingNonGradedRing( S );
      
      if HasIndeterminatesOfPolynomialRing( R ) or
         HasIndeterminatesOfExteriorRing( R ) or
         ( IsHomalgResidueClassRingRep( R ) and
           ( HasIndeterminatesOfPolynomialRing( AmbientRing( R ) ) or HasIndeterminatesOfExteriorRing(  AmbientRing( R ) ) ) ) then
        
        indeterminates := Indeterminates( S );
        
        degrees_of_indeterminates := List( indeterminates, Degree );
        
        random_matrix_between_free_left_or_right_presentations_func :=
          function( left_or_right )
            local func;
            
            func := function( degrees_1, degrees_2 )
                      local mat;
                      
                      if left_or_right = "left" then
                        
                        mat := List( degrees_1,
                             i -> List( degrees_2,
                             j -> S!.random_homogeneous_element_func( i - j ) ) );
                      
                      else
                        
                        mat := List( degrees_1,
                             i -> List( degrees_2,
                             j -> S!.random_homogeneous_element_func( j - i ) ) );
                      
                      fi;
                      
                      if Length( degrees_1 ) * Length( degrees_2 ) = 0 then
                        
                        return HomalgZeroMatrix( Length( degrees_1 ), Length( degrees_2 ), S );
                      
                      else
                        
                        return HomalgMatrix( mat, S );
                      
                      fi;
                    
                    end;
            
            return func;
          
          end;
        
        random_matrix_for_left_or_right_presentation_func :=
          function( random_matrix_between_free_left_or_right_presentations_func )
            local func;
            
            func := function( m, n  )
              local D, L, K;
              
              D := S!.random_degrees;
              
              L := List( [ 1 .. m ], i -> Random( D ) );
              
              K := List( [ 1 .. n ], i -> Random( D ) );
              
              if m * n = 0 then
                
                return [ HomalgZeroMatrix( m, n, S ), L, K ];
              
              else
                
                return [ random_matrix_between_free_left_or_right_presentations_func( L, K ), L, K ];
              
              fi;
            
            end;
            
            return func;
          
          end;
        
        auxiliary_degree_func :=
          function( e )
            
            if IsZero( e ) then
              
              return fail;
            
            else
              
              return Degree( e );
            
            fi;
        
        end;
        
        auxiliary_sum_of_degrees_func :=
          function( d1, d2 )
            
            if d1 = fail or d2 = fail then
              
              return fail;
            
            else
              
              return d1 + d2;
            
            fi;
        
        end;
        
        detect_relations_degrees_func := function( m, generators_degrees, left_or_right )
          local degrees_of_entries, relations_degrees;
          
          if left_or_right = "left" then
            
            degrees_of_entries := List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) );
          
          else
            
            degrees_of_entries := TransposedMat( List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) ) );
          
          fi;
          
          relations_degrees := List( degrees_of_entries, L -> ListN( generators_degrees, L, S!.auxiliary_sum_of_degrees_func ) );
          
          relations_degrees := List( relations_degrees, L -> Set( Filtered( L, d -> d <> fail )  ) );
          
          relations_degrees := List( relations_degrees, function( L )
                                                          if L = [  ] then
                                                            return Degree( One( S ) );
                                                          else
                                                            return L[ 1 ]; # if m defines a well-defined presentation then at this moment Length( L ) should be 1.
                                                          fi;
                                                        end );
          
          return relations_degrees;
        
        end;
        
        detect_generators_degrees_func := function( m, relations_degrees, left_or_right )
          local degrees_of_entries, generators_degrees;
        
          if left_or_right = "left" then
            
            degrees_of_entries := TransposedMat( List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) ) );
          
          else
            
            degrees_of_entries := List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) );
          
          fi;
          
          generators_degrees := List( degrees_of_entries, L -> ListN( -relations_degrees, L, S!.auxiliary_sum_of_degrees_func ) );
          
          generators_degrees := -List( generators_degrees, L -> Set( Filtered( L, d -> d <> fail )  ) );
          
          generators_degrees := List( generators_degrees, function( L )
                                                            if L = [  ] then
                                                              return Degree( One( S ) );
                                                            else
                                                              return L[ 1 ]; # if m defines a well-defined presentation then at this moment Length( L ) should be 1.
                                                            fi;
                                                          end );
          
          return generators_degrees;
        
        end;
        
        if  ( Rank( DegreeGroup( S ) ) = 1 and
                ( IsSubset( Set( [ 0, 1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) or
                    IsSubset( Set( [ 0, -1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) ) ) then
          
          random_homogeneous_element_func :=
            function( degree )
              local mat, p, coeffs, r, l1, l2;
              
              # To use the command RandomMatrixBetweenGradedFreeLeftModules, all degrees of the indeterminates should be contained in {0,1} or {0,-1}.
              mat := RandomMatrixBetweenGradedFreeLeftModules( [ degree ], [ 0 ], S );
              
              p := MatElm( mat, 1, 1 );
              
              if IsZero( p ) then
                
                return p;
              
              fi;
              
              p := EvalRingElement( p );
              
              coeffs := Coefficients( p );
              
              r := Random( [ 1, 1, Minimum( 2, NrRows( coeffs ) ) ] );
              
              l1 := EntriesOfHomalgMatrix( coeffs ){ [ 1 .. r ] };
              
              l2 := coeffs!.monomials{ [ 1 .. r ] };
              
              return ( l1*l2 )/S;
            
            end;
            
            D := Set( List( Indeterminates( S ), Degree ) );
            
            D := ShallowCopy( Combinations( Concatenation( D, D ) ) );
            
            Remove( D, 1 );
            
            S!.random_degrees := Set( Concatenation( List( D, Sum ), [ Degree( One( S ) ), Degree( Zero( S ) ) ] ) );
            
            S!.auxiliary_degree_func := auxiliary_degree_func;
            
            S!.auxiliary_sum_of_degrees_func := auxiliary_sum_of_degrees_func;
            
            S!.detect_generators_degrees_func := detect_generators_degrees_func;
            
            S!.detect_relations_degrees_func := detect_relations_degrees_func;
            
            S!.random_homogeneous_element_func := random_homogeneous_element_func;
            
            S!.random_matrix_between_free_left_presentations_func :=
                random_matrix_between_free_left_or_right_presentations_func( "left" );
            
            S!.random_matrix_between_free_right_presentations_func :=
                random_matrix_between_free_left_or_right_presentations_func( "right" );
            
            S!.random_matrix_for_left_presentation_func := 
                random_matrix_for_left_or_right_presentation_func( S!.random_matrix_between_free_left_presentations_func );
            
            S!.random_matrix_for_right_presentation_func :=
                random_matrix_for_left_or_right_presentation_func( S!.random_matrix_between_free_right_presentations_func );
            
            return true;
        
        elif IsPackageMarkedForLoading( "NConvex", "2019.02.02" ) or 
                  ( IsPackageMarkedForLoading( "Convex", "2017.09.02" ) and IsPackageMarkedForLoading( "PolymakeInterface", "2018.09.25" ) ) then
          
          random_homogeneous_element_func :=
            function( degree )
              local A, B, D, d, dD, ID, P, G, M;
              
              A := DegreeGroup( S );
              
              B := HomalgRing( A );
              
              D := List( degrees_of_indeterminates, UnderlyingMorphism );
              
              D := List( D, d -> MatrixOfMap( d ) );
              
              D := Involution( UnionOfRows( D ) );
              
              d := Involution( MatrixOfMap( UnderlyingMorphism( degree ) ) );
              
              dD := UnionOfColumns( -d, D );
              
              dD := UnionOfRows( dD, -dD );
              
              # We need a positive integral solution to system of inequalities dD, hence we add extra inequalities (ID).
              ID := UnionOfColumns( HomalgZeroMatrix( NrCols( D ), 1, B ), HomalgIdentityMatrix( NrCols( D ), B ) );
              
              # Now all we need is an integral solution to the following system of inequalities.
              D := UnionOfRows( dD, ID );
              
              D := EntriesOfHomalgMatrixAsListList( D );
              
              D := List( D, d -> List( d, e -> HomalgElementToInteger( e ) ) );
              
              P := ValueGlobal( "PolyhedronByInequalities" )( D );
              
              G := ValueGlobal( "LatticePointsGenerators" )( P );
              
              if G[ 1 ] = [  ] then
                
                return Zero( S );
              
              else
                
                if G[ 2 ] <> [  ] or G[ 3 ] <> [  ] then
                  
                  M := List( [ 1 .. Random( [ 1, 2, 3 ] ) ], 
                         i -> Random( G[ 1 ] ) + Random( [ Zero( B ), One( B ) ] ) * Random( Concatenation( G[ 2 ], G[ 3 ], -G[ 3 ] ) ) );
                
                else
                  
                  M := List( [ 1 .. Random( [ 1, 2, 3 ] ) ], i -> Random( G[ 1 ] ) );
                
                fi;
                
                P := List( M, m -> Product( List( [ 1 .. Length( indeterminates ) ], i -> indeterminates[ i ] ^ m[ i ] ) ) );
                
                return Sum( List( P, p -> Random( [ -10 .. 10 ] ) * One( S ) * p ) );
              
              fi;
            
            end;
            
            D := Set( List( Indeterminates( S ), Degree ) );
            
            D := ShallowCopy( Combinations( Concatenation( D, D ) ) );
            
            Remove( D, 1 );
            
            S!.random_degrees := Set( Concatenation( List( D, Sum ), [ Degree( One( S ) ), Degree( Zero( S ) ) ] ) );
            
            S!.auxiliary_degree_func := auxiliary_degree_func;
            
            S!.auxiliary_sum_of_degrees_func := auxiliary_sum_of_degrees_func;
            
            S!.detect_generators_degrees_func := detect_generators_degrees_func;
            
            S!.detect_relations_degrees_func := detect_relations_degrees_func;
            
            S!.random_homogeneous_element_func := random_homogeneous_element_func;
            
            S!.random_matrix_between_free_left_presentations_func :=
                random_matrix_between_free_left_or_right_presentations_func( "left" );
            
            S!.random_matrix_between_free_right_presentations_func :=
                random_matrix_between_free_left_or_right_presentations_func( "right" );
            
            S!.random_matrix_for_left_presentation_func := 
                random_matrix_for_left_or_right_presentation_func( S!.random_matrix_between_free_left_presentations_func );
            
            S!.random_matrix_for_right_presentation_func :=
                random_matrix_for_left_or_right_presentation_func( S!.random_matrix_between_free_right_presentations_func );
            
            return true;
        
        else
            
            return false;
        
        fi;
      
      else
        
        return false;
      
      fi;
    
end;

TRY_TO_ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS2 :=
  function( R )
    local random_element_func, random_matrix_func;
    
    if IsBound( R!.random_element_func ) and IsBound( R!.random_matrix_func ) then
      
      return true;
    
    fi;
    
    if ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or 
        ( HasIsExteriorRing( R ) and IsExteriorRing( R ) ) then
      
      random_element_func :=
        function(  )
             local ind, n, l1, l2;
             
             ind := Concatenation(  [ One( R ) ], Indeterminates( R ), Indeterminates( R ) );
             
             n := Random( [ 1, 1, 1, 2, 2, 3 ] );
             
             l1 := List( [ 1 .. n ], i -> Product( Random( Combinations( ind, i ) ) ) );
             
             l2 := List( [ 1 .. n ], i -> Random( [ -2, -1, -1, 0, 1, 1, 2 ] ) * One( R ) );
             
             return l1 * l2;
        
        end;
        
      R!.random_element_func := random_element_func;
    
    elif ( HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) ) or
          ( HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) ) then
      
      random_element_func :=
        function( )
          
          return Random( [ -20 .. 20 ] )*One( R );
        
        end;
      
      R!.random_element_func := random_element_func;
    
    elif HasAmbientRing( R ) and IsBound( AmbientRing( R )!.random_element_func ) then
    
      random_element_func :=
        function( )
          
          return AmbientRing( R )!.random_element_func(  )/R;
        
        end;
      
      R!.random_element_func := random_element_func;
     
     fi;
     
     random_matrix_func :=
        function( m, n )
          local L;
          
          if m * n = 0 then
            
            return HomalgZeroMatrix( m, n, R );
          
          else
            
            L := List( [ 1 .. m ], i -> List( [ 1 .. n ], j -> R!.random_element_func(  ) ) );
            
            return HomalgMatrix( L, m, n, R );
          
          fi;
        
        end;
     
     if IsBound( R!.random_element_func ) then
       
       R!.random_matrix_func := random_matrix_func;
       
       return true;
     
     else
       
       return false;
     
     fi;
    
end;

AddRandomMethodsToGradedRows := function( category )
  local S;
  
  S := category!.homalg_graded_ring_for_category_of_graded_rows;
  
  AddRandomObjectByList( category,
    function( category, L )
      local degree_list;
      degree_list := List( [ 1 .. L[1] ], i -> [ Random( L[2] ), 1 ] );
      return GradedRow( degree_list, S );
  end );
  
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
  
  AddRandomMorphismWithFixedSourceAndRangeByList( category,
    function( a, b, L )
      local degrees_a, degrees_b, mat;
      degrees_a := UnzipDegreeList( a );
      degrees_b := UnzipDegreeList( b );
      mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
      return GradedRowOrColumnMorphism( a, mat, b );
    end );
  
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

  AddRandomObjectByInteger( category,
    function( category, n )
      local weights, degrees_list;
    
      weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
      Add( weights, Degree( One( S ) ) );
      weights := List( weights, HomalgElementToListOfIntegers );
      degrees_list := List( [ 1 .. n ], i -> Sum( List( [ 1 .. Random( [ 1 .. 4 ] ) ], j -> Random( weights ) ) ) );
      return RandomObjectByList( category, [ n, degrees_list ] );
    end );
  
  AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
    function( a, b, n )
      return RandomMorphismWithFixedSourceAndRangeByList( a, b, [] );
    end );
  
  AddRandomMorphismWithFixedSourceByInteger( category,
    function( a, n )
      local degrees_a, weights, degrees_b, b;
        
      degrees_a := UnzipDegreeList( a );
      weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
      Add( weights, Degree( One( S ) ) );
      degrees_b := List( [ 1 .. n ], i -> [ Random( weights ) + Sum( List( [ 1 .. Random( [ 1 .. 3 ] ) ], j -> Random( weights ) ) ), 1 ]  );
      b := GradedRow( degrees_b, S );
      return RandomMorphismWithFixedSourceAndRangeByInteger( a, b, 0 );
    end );
    
end;

AddRandomMethodsToRows := function( category )
  local R;
  
  R := category!.UnderlyingRing;
  
  TRY_TO_ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS2( R );
  
  AddRandomObjectByList( category,
    function( category, L )
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      return CategoryOfRowsObject( Random( L ), category ); 
      
    end );
  
  AddRandomMorphismWithFixedSourceByList( category,
    function( a, L )
      local r, mat, b;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
     
      r := Random( L );
      
      mat := R!.random_matrix_func( RankOfObject( a ), r );
      
      b := CategoryOfRowsObject( r, category );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
  
  AddRandomMorphismWithFixedRangeByList( category,
    function( b, L )
      local r, mat, a;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
     
      r := Random( L );
      
      mat := R!.random_matrix_func( r, RankOfObject( b ) );
      
      a := CategoryOfRowsObject( r, category );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
   
  AddRandomMorphismWithFixedSourceAndRangeByList( category,
    function( a, b, L )
      local mat;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      mat := R!.random_matrix_func( RankOfObject( a ), RankOfObject( b ) );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
  
  AddRandomMorphismByList( category,
    function( category, L )
      local r1, r2, a, b, mat;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      r1 := Random( L );
      
      r2 := Random( L );
      
      a := CategoryOfRowsObject( r1, category );

      b := CategoryOfRowsObject( r2, category );

      mat := R!.random_matrix_func( r1, r2 );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
    end );


end;
