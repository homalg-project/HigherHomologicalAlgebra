# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
#########################
#
# Random methods
#
########################

##
## Interpretation of n: the matrix of the created random object has at most n rows and n cols.
##
ADD_RANDOM_GRADED_MODULE_PRESENTATION :=
  
  function( category, left_or_right )
    
    AddRandomObjectByInteger( category,
      
      function( C, n )
        local homalg_ring, nr_rows, nr_cols, mat;
        
        homalg_ring := category!.ring_for_representation_category;
        
        if n < 0 then
          
          return fail;
        
        fi;
        
        if n = 0 then
          
          return ZeroObject( C );
        
        else
          
          nr_rows := Random( [ 1 .. n ] );
          
          nr_cols := Random( [ 1 .. n ] );
        
        fi;
        
        if left_or_right = "left" then
          
          mat := homalg_ring!.random_matrix_for_left_presentation_func( nr_rows, nr_cols );
          
          return AsGradedLeftPresentation( mat[ 1 ], mat[ 3 ] );
        
        else
          
          mat := homalg_ring!.random_matrix_for_right_presentation_func( nr_rows, nr_cols );
          
          return AsGradedRightPresentation( mat[ 1 ], mat[ 2 ] );
        
        fi;
      
      end );
    
end;

##
## The number of relations of the range of the created morphism is n.
##
ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_SOURCE_LEFT :=
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddRandomMorphismWithFixedSourceByInteger( category,
    
      function( M, n )
        local m, u, U, generators_degrees_of_m, relations_degrees_of_m, generators_degrees_of_y, degrees_mat, y, m_y, generators_degrees_of_m_y, syz,
            generators_degrees_of_syz, some_degrees, some_mat, x;
       
        if n < 0 then
        
          return fail;
        
        fi;
        
        m := UnderlyingMatrix( M );
        
        if NrCols( m ) = 0 then # M is zero
        
          u := homalg_ring!.random_matrix_for_left_presentation_func( n, Random( [ 0 .. 5 ] ) );
          
          U := AsGradedLeftPresentation( u[ 1 ], u[ 3 ] );
          
          return ZeroMorphism( M, U );
        
        fi;
        
        # One can think of m as a morphism between free graded modules.
        # Now I need the degrees of the source of m:
        
        generators_degrees_of_m := GeneratorDegrees( M );
        
        relations_degrees_of_m := homalg_ring!.detect_relations_degrees_func( m, generators_degrees_of_m, "left" );
        
        generators_degrees_of_y := List( [ 1 .. n ], i -> Random( generators_degrees_of_m ) );
        
        degrees_mat := List( relations_degrees_of_m, i -> List( generators_degrees_of_y, j -> i - j ) );
        
        y := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_homogeneous_element_func( d ) ) );
        
        if NrRows( m ) * n = 0 then
          
          y := HomalgZeroMatrix( NrRows( m ), n, homalg_ring );
          
        else
          
          y := HomalgMatrix( y, NrRows( m ), n, homalg_ring );
          # Now AsGradedLeftPresentation( y, generators_degrees_of_y ) should be well-defined.
        fi;
        
        
        m_y := UnionOfColumns( m, y );
        
        generators_degrees_of_m_y := Concatenation( generators_degrees_of_m, generators_degrees_of_y );
        # Now AsGradedLeftPresentation( m_y, generators_degrees_of_m_y ) should be well-defined.
        
        syz := SyzygiesOfColumns( m_y );
        
        generators_degrees_of_syz := homalg_ring!.detect_generators_degrees_func( syz, generators_degrees_of_m_y, "left" );
        
        if generators_degrees_of_syz <> [  ] then
          
          some_degrees := List( [ 1 .. Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) ], i -> Random( generators_degrees_of_syz ) - Random( homalg_ring!.random_degrees ) );
        
        else
          
          some_degrees := [  ];
        
        fi;
        
        some_mat := homalg_ring!.random_matrix_between_free_left_presentations_func( generators_degrees_of_syz, some_degrees );
        
        syz := syz * some_mat;
        
        x := CertainRows( syz, [ 1 .. NrCols( m ) ] );
        
        u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
        
        U := AsGradedLeftPresentation( u, some_degrees );
        
        return GradedPresentationMorphism( M, x, U );
        
      end );
    
end;

##
## The number of generators of the source of the created morphism is n.
##
ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_RANGE_LEFT :=

  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddRandomMorphismWithFixedRangeByInteger( category,
    
      function( U, n )
        local u, m, M, generator_degrees_of_source, source, mat, generators_degrees_of_u, relations_degrees_of_u, relations_degrees_of_x, degrees_mat, x, x_u,
            relations_degrees_of_x_u, syz, relations_degrees_of_syz, some_degrees, some_mat;
        
        if n < 0 then
        
          return fail;
        
        fi;
        
        if n = 0 then
          
          return UniversalMorphismFromZeroObject( U );
        
        fi;
        
        u := UnderlyingMatrix( U );
        
        if NrCols( u ) = 0 then # U is zero
        
          m := homalg_ring!.random_matrix_for_left_presentation_func( 1, n );
        
          M := AsGradedLeftPresentation( m[ 1 ], m[ 3 ] );
        
          return ZeroMorphism( M, U );
        
        fi;
        
        if NrRows( u ) = 0 then
        
          generator_degrees_of_source := List( [ 1 .. n ], 
            i -> Random( GeneratorDegrees( U ) ) + Random( homalg_ring!.random_degrees  ) );
          
          source := GradedFreeLeftPresentation( n, homalg_ring, generator_degrees_of_source );
          
          mat := homalg_ring!.random_matrix_between_free_left_presentations_func( generator_degrees_of_source, GeneratorDegrees( U ) );
          
          return GradedPresentationMorphism( source, mat, U );
        
        fi;
        
        generators_degrees_of_u := GeneratorDegrees( U );
        
        relations_degrees_of_u := homalg_ring!.detect_relations_degrees_func( u, generators_degrees_of_u, "left" );
        
        relations_degrees_of_x := List( [ 1 .. n ], i -> Random( relations_degrees_of_u ) );
        
        degrees_mat := List( relations_degrees_of_x, i -> List( generators_degrees_of_u, j -> i - j ) );
        
        x := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_homogeneous_element_func( d ) ) );
        
        if NrCols( u ) = 0 then
          
          x := HomalgZeroMatrix( n, NrCols( u ), homalg_ring );
          
        else
        
          x := HomalgMatrix( x, n, NrCols( u ), homalg_ring );
        
        fi;
        
        x_u := UnionOfRows( x, u );
        # Now AsGradedLeftPresentation( x_u, GeneratorDegrees( U ) ) should be well-defined.
         
        relations_degrees_of_x_u := Concatenation( relations_degrees_of_x, relations_degrees_of_u );
        
        syz := SyzygiesOfRows( x_u );
        # Now AsGradedLeftPresentation( syz, relations_degrees_of_x_u ) should be well-defined
        
        relations_degrees_of_syz := homalg_ring!.detect_relations_degrees_func( syz, relations_degrees_of_x_u, "left" );
        
        if relations_degrees_of_syz <> [  ] then
          
          some_degrees := List( [ 1 .. Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) ], i -> Random( relations_degrees_of_syz ) + Random( homalg_ring!.random_degrees ) );
        
        else
          
          some_degrees := [  ];
        
        fi;
        
        some_mat := homalg_ring!.random_matrix_between_free_left_presentations_func( some_degrees, relations_degrees_of_syz );
        
        syz := some_mat * syz;
        
        m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
        
        M := AsGradedLeftPresentation( m, relations_degrees_of_x_u{ [ 1 .. NrRows( x ) ] } );
        
        return GradedPresentationMorphism( M, x, U );
        
      end );
    
end;

##
## The number of relations of the range of the created morphism is n.
##
ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_SOURCE_RIGHT :=
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddRandomMorphismWithFixedSourceByInteger( category,
    
      function( U, n )
        local u, m, M, generators_degrees_of_u, relations_degrees_of_u, generator_degrees_of_x, degrees_mat, x, x_u, generator_degrees_of_x_u, syz,
            generator_degrees_of_syz, some_degrees, some_mat, y;
       
        if n < 0 then
        
          return fail;
        
        fi;
        
        if n = 0 then
          
          return UniversalMorphismIntoZeroObject( U );
        
        fi;
        
        u := UnderlyingMatrix( U );
        
        if NrRows( u ) = 0 then # U is zero
          
          m := homalg_ring!.random_matrix_for_right_presentation_func( Random( [ 0 .. 5 ] ), n );
          
          M := AsGradedRightPresentation( m[ 1 ], m[ 2 ] );
          
          return ZeroMorphism( U, M );
          
        fi;

        generators_degrees_of_u := GeneratorDegrees( U );

        relations_degrees_of_u := homalg_ring!.detect_relations_degrees_func( u, generators_degrees_of_u, "right" );

        generator_degrees_of_x := List( [ 1 .. n ], i -> Random( generators_degrees_of_u ) );
        
        degrees_mat := List( generator_degrees_of_x, i -> List( relations_degrees_of_u, j -> j - i ) );
        
        x := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_homogeneous_element_func( d ) ) );
        
        if NrCols( u ) = 0 then
        
          x := HomalgZeroMatrix( n, NrCols( u ), homalg_ring );
        
        else
          
          x := HomalgMatrix( x, n, NrCols( u ), homalg_ring );
          # Now AsGradedRightPresentation( x, generator_degrees_of_x ) should be well-defined.

        fi;
        
        x_u := UnionOfRows( x, u );
        
        generator_degrees_of_x_u := Concatenation( generator_degrees_of_x, generators_degrees_of_u );
        # Now AsGradedRightPresentation( x_u, generator_degrees_of_x_u ) should be well-defined.
        
        syz := SyzygiesOfRows( x_u );

        generator_degrees_of_syz := homalg_ring!.detect_generators_degrees_func( syz, generator_degrees_of_x_u, "right" );
        # Now AsGradedRightPresentation( syz, generator_degrees_of_syz ) should be well-defined.
        
        if generator_degrees_of_syz <> [  ] then
          
          some_degrees := List( [ 1 .. Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) ], i -> Random( generator_degrees_of_syz ) + Random( homalg_ring!.random_degrees ) );

        else

          some_degrees := [  ];

        fi;

        some_mat := homalg_ring!.random_matrix_between_free_right_presentations_func( some_degrees, generator_degrees_of_syz );

        syz := some_mat * syz;

        m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
        
        y := CertainColumns( syz, [ NrRows( x ) + 1 .. NrCols( syz ) ] );
        
        M := AsGradedRightPresentation( m, some_degrees );
        
        return GradedPresentationMorphism( U, y, M );
        
    end );
    
end;

##
## The number of generators of the source of the created morphism is n.
##
ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_RANGE_RIGHT :=

  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddRandomMorphismWithFixedRangeByInteger( category,
    
      function( M, n )
        local m, u, U, generator_degrees_of_source, mat, generators_degrees_of_m, relations_degrees_of_m, relations_degrees_of_y, degrees_mat, y, m_y, 
            relations_degrees_of_m_y, syz, relations_degrees_of_syz, some_degrees, some_mat;
        
        if n < 0 then
        
          return fail;
        
        fi;
        
        m := UnderlyingMatrix( M );
        
        if NrRows( m ) = 0 then # M is zero
          
          u := homalg_ring!.random_matrix_for_right_presentation_func( n, 1 );
          
          U := AsGradedRightPresentation( u[ 1 ], u[ 2 ] );
          
          return ZeroMorphism( U, M );
        
        fi;
        
        if NrCols( m ) = 0 then
          
          generator_degrees_of_source := List( [ 1 .. n ],
                i -> Random( GeneratorDegrees( M ) ) + Random( homalg_ring!.random_degrees  ) );
          
          U := GradedFreeRightPresentation( n, homalg_ring, generator_degrees_of_source );
          
          mat := homalg_ring!.random_matrix_between_free_right_presentations_func( GeneratorDegrees( M ), generator_degrees_of_source );
          
          return GradedPresentationMorphism( U, mat, M );
        
        fi;
        
        generators_degrees_of_m := GeneratorDegrees( M );
        
        relations_degrees_of_m := homalg_ring!.detect_relations_degrees_func( m, generators_degrees_of_m, "right" );
        
        relations_degrees_of_y := List( [ 1 .. n ], i -> Random( relations_degrees_of_m ) );
        
        degrees_mat := List( generators_degrees_of_m, i -> List( relations_degrees_of_y, j -> j - i ) );
        
        y := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_homogeneous_element_func( d ) ) );
        
        if NrRows( m ) * n = 0 then
          
          y := HomalgZeroMatrix( NrRows( m ), n, homalg_ring );
        
        else
          
          y := HomalgMatrix( y, NrRows( m ), n, homalg_ring );
          # Now AsGradedRightPresentation( y, generators_degrees_of_m ) should be well-defined
        
        fi;
        
        m_y := UnionOfColumns( m, y );
        # Now AsGradedRightPresentation( m_y, generators_degrees_of_m ) should be well-defined.
        
        relations_degrees_of_m_y := Concatenation( relations_degrees_of_m, relations_degrees_of_y );
        
        syz := SyzygiesOfColumns( m_y );
        # Now AsGradedRightPresentation( syz, relations_degrees_of_m_y ) should be well-defined.
        
        relations_degrees_of_syz := homalg_ring!.detect_relations_degrees_func( syz, relations_degrees_of_m_y, "right" );
        
        if relations_degrees_of_syz <> [  ] then
          
          some_degrees := List( [ 1 .. Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) ], i -> Random( relations_degrees_of_syz ) + Random( homalg_ring!.random_degrees ) );
        
        else
          
          some_degrees := [  ];
        
        fi;
        
        some_mat := homalg_ring!.random_matrix_between_free_right_presentations_func( relations_degrees_of_syz, some_degrees );
        
        syz := syz * some_mat;
        
        u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
        
        U := AsGradedRightPresentation( u, relations_degrees_of_m_y{[ NrCols( m ) + 1 .. NrRows( syz ) ]} );
        
        return GradedPresentationMorphism( U, y, M );
      
      end );
      
end;

ADD_RRANDOM_METHODS_TO_GRADED_MODULE_PRESENTATIONS :=
  function( category, left_or_right )
    local S;

    S := category!.ring_for_representation_category;
    
    if not EnhanceHomalgGradedRingWithRandomFunctions( S ) = true then
       
      return;
      
    fi;
    
    if left_or_right = "left"  then
        
        ADD_RANDOM_GRADED_MODULE_PRESENTATION( category, "left" );
        
        ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_SOURCE_LEFT( category );
        
        ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_RANGE_LEFT( category );
        
    elif left_or_right = "right" then
        
        ADD_RANDOM_GRADED_MODULE_PRESENTATION( category, "right" );
        
        ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_SOURCE_RIGHT( category );
        
        ADD_RANDOM_GRADED_PRESENTATION_MORPHISM_WITH_FIXED_RANGE_RIGHT( category );
        
    fi;
     
end;

#####################################################
#
# Graded left presentations over exterior algebras
#
#####################################################

ADD_EXTRA_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA :=
  function( category )
    local R, r;
    
    R := category!.ring_for_representation_category;
    
    r := UnderlyingNonGradedRing( R );
    
    if HasIsFinalized( category ) then
        return;
    fi;
    
    SetIsAbelianCategoryWithEnoughInjectives( category, true );
    
    AddMonomorphismIntoSomeInjectiveObject( category, function ( obj )
          local ring, dual, nat, dual_obj, proj_cover, dual_proj_cover, obj_to_double_dual_obj;
          ring := UnderlyingHomalgRing( obj );
          dual := FunctorGradedDualLeft( ring );
          nat := NaturalTransformationFromIdentityToGradedDoubleDualLeft( ring );
          dual_obj := ApplyFunctor( dual, Opposite( obj ) );
          proj_cover := EpimorphismFromSomeProjectiveObject( dual_obj );
          dual_proj_cover := ApplyFunctor( dual, Opposite( proj_cover ) );
          obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
          return PreCompose( obj_to_double_dual_obj, dual_proj_cover );
      end );
    
    AddColift( category, function ( morphism1, morphism2 )
          local N, M, A, B, I, B_over_M, zero_mat, A_over_zero, sol, XX, morphism_1, morphism_2;
          morphism_1 := UnderlyingPresentationMorphism( morphism1 );
          morphism_2 := UnderlyingPresentationMorphism( morphism2 );
          I := UnderlyingMatrix( Range( morphism_2 ) );
          N := UnderlyingMatrix( Source( morphism_1 ) );
          M := UnderlyingMatrix( Range( morphism_1 ) );
          B := UnderlyingMatrix( morphism_1 );
          A := UnderlyingMatrix( morphism_2 );
          B_over_M := UnionOfRows( B, M );
          zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), HomalgRing( M ) );
          A_over_zero := UnionOfRows( A, zero_mat );
          sol := SolveTwoSidedEquationOverExteriorAlgebra( B_over_M, I, A_over_zero );
          if sol = fail then
              return fail;
          else
              return GradedPresentationMorphism( Range( morphism1 ), DecideZeroRows( sol[1], I ), Range( morphism2 ) );
          fi;
          return;
      end );
    
    AddLift( category, function ( morphism1, morphism2 )
          local P, N, M, A, B, l, basis_indices, Q, R_B, R_N, L_P, R_M, L_id_s, L_P_mod, morphism_1, morphism_2, A_deco, 
          A_deco_list, A_deco_list_vec, A_vec, mat1, mat2, A_vec_over_zero_vec, mat, sol, x, s, v;
          
          if not IsEqualForObjects( Range( morphism1 ), Range( morphism2 ) ) then
              Error( "Wrong input!" );
          fi;
          morphism_1 := UnderlyingPresentationMorphism( morphism1 );
          morphism_2 := UnderlyingPresentationMorphism( morphism2 );
          P := UnderlyingMatrix( Source( morphism_1 ) );
          N := UnderlyingMatrix( Range( morphism_1 ) );
          M := UnderlyingMatrix( Source( morphism_2 ) );
          A := UnderlyingMatrix( morphism_1 );
          B := UnderlyingMatrix( morphism_2 );
          l := Length( IndeterminatesOfExteriorRing( R ) );
          basis_indices := IndicesForBasisOfExteriorAlgebra( R );
          Q := CoefficientsRing( R );
          if IsZero( P ) then
              sol := RightDivide( A, UnionOfRows( B, N ) );
              if sol = fail then
                  return fail;
              else
                  return GradedPresentationMorphism( Source( morphism1 ), 
                     DecideZeroRows( CertainColumns( sol, [ 1 .. NrRows( B ) ] ), M ), Source( morphism2 ) );
              fi;
          fi;
          R_B := UnionOfRows( List( basis_indices, function ( u )
                    return KroneckerMat( Involution( Q * RightMagic( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) );
                end ) );
          if not IsZero( N ) then
              R_N := UnionOfRows( List( basis_indices, function ( u )
                        return KroneckerMat( Involution( Q * RightMagic( u, N ) ), HomalgIdentityMatrix( NrRows( A ), Q ) );
                    end ) );
          fi;
          L_P := UnionOfRows( List( basis_indices, function ( u )
                    return KroneckerMat( HomalgIdentityMatrix( NrColumns( M ), Q ), Q * LeftMagic( u, P ) );
                end ) );
          R_M := UnionOfRows( List( basis_indices, function ( u )
                    return KroneckerMat( Involution( Q * RightMagic( u, M ) ), HomalgIdentityMatrix( NrRows( P ), Q ) );
                end ) );
          L_id_s := UnionOfRows( List( basis_indices, function ( u )
                    return KroneckerMat( HomalgIdentityMatrix( NrRows( B ), Q ), 
                       Q * LeftMagic( u, HomalgIdentityMatrix( NrRows( A ), R ) ) );
                end ) );
          L_P_mod := L_P * Involution( L_id_s );
          A_deco := DecompositionOfHomalgMatrixOverExteriorAlgebra( A );
          A_deco_list := List( A_deco, function ( i )
                  return i[2];
              end );
          A_deco_list_vec := List( A_deco_list, function ( mat )
                  return UnionOfRows( List( [ 1 .. NrColumns( A ) ], function ( i )
                            return CertainColumns( mat, [ i ] );
                        end ) );
              end );
          A_vec := Q * UnionOfRows( A_deco_list_vec );
          if not IsZero( N ) then
              mat1 
               := UnionOfColumns( 
                 [ R_B, R_N, HomalgZeroMatrix( NrRows( A ) * NrColumns( A ) * 2 ^ l, NrRows( M ) * NrRows( P ) * 2 ^ l, Q ) 
                   ] );
              mat2 
               := UnionOfColumns( 
                 [ L_P_mod, HomalgZeroMatrix( NrRows( P ) * NrColumns( M ) * 2 ^ l, NrRows( N ) * NrColumns( P ) * 2 ^ l, Q 
                       ), R_M ] );
          else
              mat1 := UnionOfColumns( R_B, HomalgZeroMatrix( NrRows( A ) * NrColumns( A ) * 2 ^ l, 
                   NrRows( M ) * NrRows( P ) * 2 ^ l, Q ) );
              mat2 := UnionOfColumns( L_P_mod, R_M );
          fi;
          mat := UnionOfRows( mat1, mat2 );
          A_vec_over_zero_vec := UnionOfRows( A_vec, HomalgZeroMatrix( NrColumns( M ) * NrRows( P ) * 2 ^ l, 1, Q ) );
          sol := LeftDivide( mat, A_vec_over_zero_vec );
          if sol = fail then
              return fail;
          fi;
          s := NrColumns( P );
          v := NrColumns( M );
          x := CertainRows( sol, [ 1 .. s * v * 2 ^ l ] );
          x := UnionOfColumns( List( [ 1 .. v * 2 ^ l ], function ( i )
                    return CertainRows( x, [ (i - 1) * s + 1 .. i * s ] );
                end ) );
          x := Sum( List( [ 1 .. 2 ^ l ], function ( i )
                    return R * CertainColumns( x, [ ((i - 1) * v + 1) .. (i * v) ] ) * ElementOfBasisOfExteriorAlgebraGivenByIndices( basis_indices[i], R );
                end ) );
          return GradedPresentationMorphism( Source( morphism1 ), DecideZeroRows( x, M ), Source( morphism2 ) );
      end );
    
    AddIsSplitMonomorphism( category, function ( mor )
          local l;
          l := Colift( mor, IdentityMorphism( Source( mor ) ) );
          if l = fail then
              return false;
          else
              return true;
          fi;
          return;
      end );
    
    AddIsSplitEpimorphism( category, function ( mor )
          local l;
          l := Lift( IdentityMorphism( Range( mor ) ), mor );
          if l = fail then
              return false;
          else
              return true;
          fi;
          return;
      end );
    
    AddIsProjective( category, function ( obj )
          local cover, lift;
          if NrRows( UnderlyingMatrix( obj ) ) = 0 then
              return true;
          fi;
          cover := EpimorphismFromSomeProjectiveObject( obj );
          lift := Lift( IdentityMorphism( obj ), cover );
          if lift = fail then
              return false;
          fi;
          return true;
      end );
    
    AddIsInjective( category, IsProjective );
    
    return;
    
end;

###########################
#
# Categories constructors
#
###########################

##
InstallMethod( GradedLeftPresentations,
          [ IsHomalgGradedRing ],
          
  function( S )
    local finalize, random_methods, category;
    
    finalize := ValueOption( "FinalizeCategory" );
    
    random_methods := ValueOption( "GradedLeftPresentations_ToolsForHigherHomologicalAlgebra" );
    
    if random_methods = false then
      TryNextMethod( );
    fi;
    
    category := GradedLeftPresentations( S : FinalizeCategory := false, GradedLeftPresentations_ToolsForHigherHomologicalAlgebra := false );
    
    if HasIsExteriorRing( S ) and IsExteriorRing( S ) then
      
      ADD_EXTRA_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( category );
      
    fi;
    
    ADD_RRANDOM_METHODS_TO_GRADED_MODULE_PRESENTATIONS( category, "left" );
    
    if finalize <> false then
      
      Finalize( category );
      
    fi;
    
    return category;
    
end );

##
InstallMethod( GradedRightPresentations,
          [ IsHomalgGradedRing ],
          
  function( S )
    local finalize, random_methods, category;
    
    finalize := ValueOption( "FinalizeCategory" );
   
    random_methods := ValueOption( "GradedRightPresentations_ToolsForHigherHomologicalAlgebra" );
    
    if random_methods = false then
      TryNextMethod( );
    fi;
    
    category := GradedLeftPresentations( S : FinalizeCategory := false, GradedRightPresentations_ToolsForHigherHomologicalAlgebra := false );
    
    ADD_RRANDOM_METHODS_TO_GRADED_MODULE_PRESENTATIONS( category, "right" );
    
    if finalize <> false then
      
      Finalize( category );
      
    fi;
   
    return category;
    
end );


############################################
#
# old code that might still be usefull
#
############################################

#BindGlobal( "ADD_METHODS_TO_STABLE_CAT_OF_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA",
#
#function( category )
#local graded_colift_lift_in_stable_category;
#
#    graded_colift_lift_in_stable_category := function(alpha_, beta_, gamma_, delta_ )
#    local A, B, C, D, alpha, beta, gamma, delta, lambda, I, tau, J, R, l, basis_indices, Q, L_A, L_id_s, L_A_mod, R_C, L_alpha_mod, L_alpha, L_lambda,  
#    R_B_2, R_B_1, R_D, R_delta, L_tau, beta_deco, beta_vec, gamma_deco, gamma_vec, R_1, R_2, R_3, C_x, C_y, C_z, C_v, C_g, C_h, C_1, 
#    sol, s, v, XX, main_matrix, constants_matrix;
#    alpha := UnderlyingMatrix( alpha_);
#    beta := UnderlyingMatrix( beta_ );
#    gamma := UnderlyingMatrix( gamma_ );
#    delta := UnderlyingMatrix( delta_ );
#    A := UnderlyingMatrix(   Source( gamma_ ) );
#    B := UnderlyingMatrix(  Source( delta_ ) );
#    C := UnderlyingMatrix(  Source( alpha_ ) );
#    D := UnderlyingMatrix(  Range( gamma_ ) );
#    lambda := UnderlyingMatrix(  MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) );
#    I := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject(Source(alpha_))));
#    tau := UnderlyingMatrix( MonomorphismIntoSomeInjectiveObject( Source( gamma_)));
#    J := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject( Source( gamma_))));
#
#    # We need X,Y,Z,V,G, H such that
#    #
#    # A     * X                             + V*B                       = 0
#    # alpha * X      + lambda * Y + Z * B                               = beta
#    #  X    * delta                                   tau * G + H * D   = gamma
#
#    R := HomalgRing( A );
#    l := Length( IndeterminatesOfExteriorRing( R ) );
#    basis_indices := standard_list_of_basis_indices( R );
#    
#    Q := CoefficientsRing( R );
#    
#    # X
#    L_id_s := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrRows( delta ), Q ), Q*FLeft( u, HomalgIdentityMatrix( NrRows( tau ), R ) ) ) ), UnionOfRows );
#    L_A := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, A ) ) ), UnionOfRows );
#    L_A_mod :=  L_A* Involution( L_id_s );
#    L_alpha := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, alpha ) ) ), UnionOfRows );
#    L_alpha_mod :=  L_alpha* Involution( L_id_s );
#    R_delta := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, delta ) ), HomalgIdentityMatrix( NrRows( tau ), Q ) ) ), UnionOfRows );
#    
#    # Y
#    L_lambda := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, lambda ) ) ), UnionOfRows );
#    
#    # Z
#    R_B_2 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( alpha ), Q ) ) ), UnionOfRows );
#    
#    # V
#    R_B_1 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ), UnionOfRows );
#    
#    # G
#    L_tau := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( D ), Q ), Q*FLeft( u, tau ) ) ), UnionOfRows );
#
#    # H
#    R_D := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, D ) ), HomalgIdentityMatrix( NrRows( tau ), Q ) ) ), UnionOfRows );
#    
#    R_1 := NrRows( L_A_mod );
#    R_2 := NrRows( L_alpha_mod );
#    R_3 := NrRows( R_delta );
#    
#    C_x := NrColumns( L_A_mod );
#    C_y := NrColumns( L_lambda );
#    C_z := NrColumns( R_B_2 );
#    C_v := NrColumns( R_B_1 );
#    C_g := NrColumns( L_tau );
#    C_h := NrColumns( R_D );
#    C_1 := 1;
#
#    main_matrix := Iterated( 
#    [ 
#        Iterated( [ L_A_mod, HomalgZeroMatrix(R_1,C_y, Q), HomalgZeroMatrix(R_1,C_z, Q), R_B_1, HomalgZeroMatrix(R_1,C_g, Q), HomalgZeroMatrix(R_1,C_h, Q) ], UnionOfColumns ),
#        Iterated( [ L_alpha_mod, L_lambda,R_B_2, HomalgZeroMatrix(R_2,C_v, Q), HomalgZeroMatrix(R_2,C_g, Q), HomalgZeroMatrix(R_2,C_h, Q) ], UnionOfColumns ),
#        Iterated( [ R_delta, HomalgZeroMatrix(R_3,C_y, Q), HomalgZeroMatrix(R_3,C_z, Q), HomalgZeroMatrix(R_3,C_v, Q), L_tau, R_D ], UnionOfColumns )
#    ], UnionOfRows );
#
#    if IsZero( beta ) then
#        beta_vec := HomalgZeroMatrix( R_2, C_1, Q );
#    else
#        beta_deco := DecompositionOfHomalgMat( beta );
#    
#        beta_deco := List( beta_deco, i-> i[ 2 ] );
#
#        beta_deco := List( beta_deco, mat -> Iterated( List( [ 1..NrColumns( beta ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );
#
#        beta_vec := Q*Iterated( beta_deco, UnionOfRows );
#    fi;
#
#    if IsZero( gamma ) then 
#        gamma_vec := HomalgZeroMatrix( R_3, C_1, Q );
#    else
#
#        gamma_deco := DecompositionOfHomalgMat( gamma );
#   
#        gamma_deco := List( gamma_deco, i-> i[ 2 ] );
#
#        gamma_deco := List( gamma_deco, mat -> Iterated( List( [ 1..NrColumns( gamma ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );
#
#        gamma_vec := Q*Iterated( gamma_deco, UnionOfRows );
#    fi;
#
#    constants_matrix :=  Iterated( [ HomalgZeroMatrix(R_1, C_1, Q ), beta_vec, gamma_vec ], UnionOfRows );
#    
#    sol := LeftDivide( main_matrix, constants_matrix );
#    
#    if sol = fail then 
#      
#      return fail;
#     
#    fi;
#    
#    s := NrColumns( A );
#    
#    v := NrColumns( B );
#    
#    if v <> 0 then
#    
#    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
#    
#    XX := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );
#
#    XX := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );
#    
#    return GradedPresentationMorphism( Range( alpha_ ), DecideZeroRows( XX, B ), Range( beta_ ) );
#
#    else
#    
#    return ZeroMorphism(  Range( alpha_ ), Range( beta_ ) );
#    
#    fi;
#    
#end;
#
###
#
#AddLiftColift( category,
#    function( alpha, beta, gamma, delta )
#    local lift;
#    lift := graded_colift_lift_in_stable_category(
#            UnderlyingUnstableMorphism( alpha ),
#            UnderlyingUnstableMorphism( beta ),
#            UnderlyingUnstableMorphism( gamma ),
#            UnderlyingUnstableMorphism( delta )
#            );
#    if lift = fail then
#        return fail;
#    else
#        return AsStableMorphism( lift );
#    fi;
#
#    end );
#
### Since we have LiftColift, we automatically have Lifts & Colifts (see Derivations in Triangulated categories).
###
#AddIsSplitMonomorphism( category,
#    function( mor )
#    local l;
#    l := Colift( mor, IdentityMorphism( Source( mor ) ) );
#
#    if l = fail then
#        AddToReasons( "IsSplitMonomorphism: because the morphism can not be colifted to the identity morphism of the source" );
#        return false;
#    else
#        return true;
#    fi;
#
#end );
#
#AddIsSplitEpimorphism( category,
#    function( mor )
#    local l;
#    l := Lift( IdentityMorphism( Range( mor ) ), mor );
#
#    if l = fail then
#        AddToReasons( "IsSplitMonomorphism: because the morphism can not be lifted to the identity morphism of the Range" );
#        return false;
#    else
#        return true;
#    fi;
#
#end );
#
#AddInverseImmutable( category,
#    function( mor )
#    return Lift( IdentityMorphism( Range( mor ) ), mor );
#end );
#
#end );
#
#compute_degree_zero_part := 
#    function( M, N, f )
#    local mat, required_degrees;
#    mat := UnderlyingMatrix( f );
#    required_degrees := List( GeneratorDegrees( M ), i -> 
#                                    List( GeneratorDegrees( N ), j -> i - j ) );
#    mat := ReductionOfHomalgMatrix( mat, required_degrees );
#    return GradedPresentationMorphism(M,mat,N);
#end;
#
#nonBASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_LEFT_PRES_OVER_EXTERIOR_ALGEBRA := 
#    function( GM, GN )
#    local A, B, l, basis_indices, Q, M, N, N_, sN_, r,m,s,n,t,sN_t, basis_sN_t, basis, XX, XX_, X_, i, R;
#
#    R := UnderlyingHomalgRing( GM );
#    M := UnderlyingMatrix( GM );
#    N := UnderlyingMatrix( GN );
#
#    l := Length( IndeterminatesOfExteriorRing( R ) );
#    basis_indices := standard_list_of_basis_indices( R );
#
#    Q := CoefficientsRing( R ); 
#
#    N_ := Q*FF3( M, N );
#
#    if WithComments = true then
#        Print( "SyzygiesOfColumns on ", NrRows(N),"x", NrColumns(N)," homalg matrix\n" );
#    fi;
#
#    sN_ := SyzygiesOfColumns( N_ );
#
#        if WithComments = true then
#        Print( "done!\n" );
#    fi;
#
#    r := NrRows( M );
#    m := NrColumns( M );
#    s := NrColumns( N );
#    n := NrRows( N );
#
#    t := m*s*2^l;
#
#    sN_t := CertainRows( sN_, [ 1..t ] );
#    
#    if WithComments = true then
#        Print( "BasisOfColumns on ", NrRows(sN_t),"x", NrColumns(sN_t)," homalg matrix\n" );
#    fi;
#
#    basis_sN_t := BasisOfColumns( sN_t );
#    
#    if WithComments = true then
#        Print( "done!\n" );
#    fi;
#    
#    basis := [ ];
#
#    for i in [ 1 .. NrColumns( basis_sN_t ) ] do 
#        
#        XX := CertainColumns( basis_sN_t, [ i ] );
#
#        XX_ := Iterated( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ), UnionOfColumns )*R;
#
#        X_ := Sum( List( [ 1..2^l ], i-> ( CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* ring_element( basis_indices[ i ], R ) ) );
#
#        Add( basis, PresentationMorphism( AsLeftPresentation(M), DecideZeroRows(X_,N), AsLeftPresentation(N) ) );
#
#    od;
#
#return DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms(b) ) );
#
#end;
#
#decide := function( sigma, i, j, m, R )
#    local r;
#    r := Degree( ring_element( sigma, R ) );
#    if m[i][j] = r then return "*";fi;
#    return 0;
#end;
#
#graded_compute_coefficients := function( b, f )
#    local R, basis_indices, Q, A, B, C, vec, main_list, matrix, constant, M, N, sol;
#    
#    M := Source( f );
#    N := Range( f );
#
#    if not IsWellDefined( f ) then
#        return fail;
#    fi;
#    
#    R := UnderlyingHomalgRing( M );
#    basis_indices := standard_list_of_basis_indices( R );
#    Q := CoefficientsRing( R ); 
#    
#    A := List( b, UnderlyingMatrix );
#    B := UnderlyingMatrix( N );
#    C := UnderlyingMatrix( f );
#
#    vec := function( H ) return Iterated( List( [ 1 .. NrColumns( H ) ], i -> CertainColumns( H, [ i ] ) ), UnionOfRows ); end;
#
#    main_list := 
#        List( [ 1 .. Length( basis_indices) ], 
#        function( i ) 
#        local current_A, current_B, current_C, main;
#        current_A := List( A, a -> HomalgTransposedMat( DecompositionOfHomalgMat(a)[i][2]*Q ) );
#        current_B := HomalgTransposedMat( FRight( basis_indices[i], B )*Q );
#        current_C := HomalgTransposedMat( DecompositionOfHomalgMat(C)[i][2]*Q );
#        main := UnionOfColumns( Iterated( List( current_A, vec ), UnionOfColumns ), KroneckerMat( HomalgIdentityMatrix( NrColumns( current_C ), Q ), current_B ) ); 
#        return [ main, vec( current_C) ];
#        end );
#
#    matrix :=   Iterated( List( main_list, m -> m[ 1 ] ), UnionOfRows );
#    constant := Iterated( List( main_list, m -> m[ 2 ] ), UnionOfRows );
#    sol := LeftDivide( matrix, constant);
#    if sol = fail then 
#        return fail;
#    else
#        return EntriesOfHomalgMatrix( CertainRows( sol, [ 1..Length( b ) ] ) );
#    fi;
#end;
#
#graded_generators_of_external_hom := function( M_, N_ )
#    local R, basis_indices, M, N, degrees_of_M_, degrees_of_N_, degrees_of_M, degrees_of_N, required_degrees_X, required_degrees_Y,
#        degrees_of_sM, degrees_of_sN, Lx, Ly, Q, mat, x_positions, y_positions, all_positions, smat, r, m, s, n, t, smat_x,
#        basis_smat_x, generators, i, j, X_, XX, XX_, l;
#    
#    R := UnderlyingHomalgRing( M_ );
#    l := Length( IndeterminatesOfExteriorRing( R ) );
#    basis_indices := standard_list_of_basis_indices( R );
#
#    M := UnderlyingMatrix( M_ );
#    N := UnderlyingMatrix( N_ );
#    degrees_of_M_ := GeneratorDegrees( M_ );
#    degrees_of_N_ := GeneratorDegrees( N_ );
#
#    required_degrees_X := List( degrees_of_M_, i -> List( degrees_of_N_, j -> i - j ) );
#    
#    degrees_of_M := DegreesOfEntries( M );
#    degrees_of_sM := List( [ 1 .. NrRows( M ) ], i-> Minimum( List( [ 1.. NrColumns( M ) ], j -> degrees_of_M_[ j ] + degrees_of_M[ i ][ j ] ) ) );
#
#    degrees_of_N := DegreesOfEntries( N );
#    degrees_of_sN := List( [ 1 .. NrRows( N ) ], i-> Minimum( List( [ 1.. NrColumns( N ) ], j -> degrees_of_N_[ j ] + degrees_of_N[ i ][ j ] ) ) );
#
#    required_degrees_Y := List( degrees_of_sM, i -> List( degrees_of_sN, j -> i - j ) );
#
#    Lx := Concatenation( TransposedMat( Concatenation( List( basis_indices , sigma -> List( [ 1 .. Length( required_degrees_X ) ], 
#            i -> List( [ 1 .. Length( required_degrees_X[ 1 ] ) ], j -> decide( sigma, i, j, required_degrees_X, R ) ) ) ) ) ) );
#
#    Ly := Concatenation( Concatenation( List( List( basis_indices, sigma -> List( [ 1 .. Length( required_degrees_Y ) ], 
#            i -> List( [ 1 .. Length( required_degrees_Y[ 1 ] ) ], j -> decide( sigma, i, j, required_degrees_Y, R ) ) ) ), l -> TransposedMat( l ) ) ) );
#  
#    Q := CoefficientsRing( R ); 
#
#    mat := Q*FF3( M, N );
#
#    x_positions := Positions( Lx, "*" );
#    y_positions := Positions( Ly, "*" ) + Length( Lx );
#
#    all_positions := Concatenation( x_positions, y_positions );
#
#    mat := CertainColumns( mat, all_positions );
#
#    smat := SyzygiesOfColumns( mat );
#
#    if WithComments = true then
#        Print( "done!\n" );
#    fi;
#
#    r := NrRows( M );
#    m := NrColumns( M );
#    s := NrColumns( N );
#    n := NrRows( N );
#
#    t := m*s*2^l;
#
#    smat_x := CertainRows( smat, [ 1.. Length( x_positions ) ] );
#    
#    if WithComments = true then
#        Print( "BasisOfColumns on ", NrRows( smat_x ),"x", NrColumns( smat_x )," homalg matrix\n" );
#    fi;
#
#    basis_smat_x := BasisOfColumns( smat_x );
#    
#    if WithComments = true then
#        Print( "done!\n" );
#    fi;
#
#    generators := [ ];
#
#    for i in [ 1 .. NrColumns( basis_smat_x ) ] do 
#        
#        if WithComments = true then
#            Print( "constructing the ", i,"'th morphism out of", NrColumns( basis_smat_x )," morphisms\n" );
#        fi;
#        
#        XX := EntriesOfHomalgMatrix( CertainColumns( basis_smat_x, [ i ] ) );
#
#        XX := List( [ 1 .. Length( Lx ) ], 
#                        function( n )
#                        if n in x_positions then
#                        
#                            return XX[ Position( x_positions, n ) ];
#                        else
#                            return "0"/Q;
#                        fi;
#
#                        end );
#
#        XX := HomalgMatrix( XX, Length( XX ), 1, Q );
#
#        XX_ := Iterated( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ), UnionOfColumns );
#
#        X_ := Sum( List( [ 1..2^l ], i-> ( R*CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* ring_element( basis_indices[ i ], R ) ) );
#
#        Add( generators, GradedPresentationMorphism( M_, X_, N_ ) );
#
#    od;
#    
#    generators := DuplicateFreeList( Filtered( generators, b -> not IsZeroForMorphisms( b ) ) );
#
#    return generators;
#
#end;
#
#BASIS_OF_EXTERNAL_HOM_BETWEEN_GRADED_LEFT_PRES_OVER_EXTERIOR_ALGEBRA := function( M, N )
#    local generators, basis, i;
#    
#    generators := graded_generators_of_external_hom( M, N );
#    
#    if generators = [ ] then
#        return [ ];
#    fi;
#
#    basis := [ generators[ 1 ] ];
#    
#    if WithComments = true then
#        Print( "There is ", Length( generators ), " morphisms to filter!" );
#    fi;
#
#    for i in [ 2 .. Length( generators ) ] do
#
#        if WithComments = true then
#            Print( "i =", i, " out of ", Length( generators ), "\n" );
#        fi;
#
#        if graded_compute_coefficients( basis, generators[ i ] ) = fail then
#            Add( basis, generators[ i ] );
#        fi;
#    od;
#
#    return basis;
#end;
#
#is_reduced_graded_module := 
#    function( GM )
#    local hM, hF, R, F, G, b, fs, ls, ps, epi, degrees, duplicate_free_ps;
#    R := UnderlyingHomalgRing( GM );
#    F := GradedFreeLeftPresentation( 1, R, [ 0 ] );
#    hM := UnderlyingModule( AsPresentationInHomalg( GM ) );
#    hF := UnderlyingModule( AsPresentationInHomalg( F ) );
#    SetPositionOfTheDefaultPresentation(hM, 1);
#    SetPositionOfTheDefaultPresentation(hF, 1);
#    G := GetGenerators( Hom( hM, hF ) );
#    G := List( G, g -> g!.matrices.( "[ 1, 1 ]" )*R );
#    b := List( G, mat -> PresentationMorphism( UnderlyingPresentationObject(GM), mat, UnderlyingPresentationObject( F ) ) );
#    if not ForAny( b, IsEpimorphism ) then 
#        return true;
#    else
#        ps := PositionsProperty( b, IsEpimorphism );
#        fs := List( ps, p -> b[ p ] );
#        ls := List( fs, f -> EntriesOfHomalgMatrix( UnderlyingMatrix( f ) ) );
#        ps := List( ls, l -> PositionProperty( l, e -> Inverse( e ) <> fail ) );
#        duplicate_free_ps := DuplicateFreeList( ps );
#        fs := List( duplicate_free_ps, p -> fs[ Position(ps,p) ] );
#        degrees := List( duplicate_free_ps, p -> GeneratorDegrees( GM )[ p ] );
#        F := GradedFreeLeftPresentation( Length( degrees ), R, degrees );
#        epi := compute_degree_zero_part( GM, F, MorphismBetweenDirectSums( [ fs ] ) );
#        return [ false, Lift( IdentityMorphism( F ), epi ) ];
#    fi;
#end;

