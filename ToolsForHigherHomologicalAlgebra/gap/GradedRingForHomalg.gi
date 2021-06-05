# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
## These methods should be updated & moved sometime in the future to RingsForHomalg
    
##
InstallMethod( EnhanceHomalgGradedRingWithRandomFunctions,
          [ IsHomalgGradedRing ],
          
  function( S )
    local R, D, indeterminates, degrees_of_indeterminates, random_matrix_between_free_left_or_right_presentations_func,
      random_matrix_for_left_or_right_presentation_func, auxiliary_degree_func, auxiliary_sum_of_degrees_func,
      random_homogeneous_element_func, detect_generators_degrees_func, detect_relations_degrees_func;
             
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
          return
            function( degrees_1, degrees_2 )
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
            
        end;
      
      random_matrix_for_left_or_right_presentation_func :=
        function( random_matrix_between_free_left_or_right_presentations_func )
          return
            function( m, n  )
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
      
      detect_relations_degrees_func :=
        function( m, generators_degrees, left_or_right )
          local degrees_of_entries, relations_degrees;
          
          if left_or_right = "left" then
            
            degrees_of_entries := List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) );
            
          else
            
            degrees_of_entries := TransposedMat( List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) ) );
          
          fi;
          
          relations_degrees := List( degrees_of_entries, L -> ListN( generators_degrees, L, S!.auxiliary_sum_of_degrees_func ) );
          
          relations_degrees := List( relations_degrees, L -> Set( Filtered( L, d -> d <> fail )  ) );
          
          relations_degrees :=
            List( relations_degrees,
              function( L )
                if L = [  ] then
                  return Degree( One( S ) );
                else
                  return L[ 1 ]; # if m defines a well-defined presentation then at this moment Length( L ) should be 1.
                fi;
              end );
        
          return relations_degrees;
      
      end;
      
      detect_generators_degrees_func :=
        function( m, relations_degrees, left_or_right )
          local degrees_of_entries, generators_degrees;
          
          if left_or_right = "left" then
            
            degrees_of_entries := TransposedMat( List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) ) );
            
          else
            
            degrees_of_entries := List( EntriesOfHomalgMatrixAsListList( m ), L -> List( L, S!.auxiliary_degree_func ) );
            
          fi;
          
          generators_degrees := List( degrees_of_entries, L -> ListN( -relations_degrees, L, S!.auxiliary_sum_of_degrees_func ) );
          
          generators_degrees := -List( generators_degrees, L -> Set( Filtered( L, d -> d <> fail )  ) );
          
          generators_degrees := List( generators_degrees,
            function( L )
              if L = [  ] then
                return Degree( One( S ) );
              else
                return L[ 1 ]; # if m defines a well-defined presentation then at this moment Length( L ) should be 1.
              fi;
            end );
        
          return generators_degrees;
      
      end;
      
      if ( Rank( DegreeGroup( S ) ) = 1 and
            ( IsSubset( Set( [ 0, 1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) or
                IsSubset( Set( [ 0, -1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) ) ) then
        
        random_homogeneous_element_func :=
          function( degree )
            local mat, p, coeffs, r, l1, l2;
            
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
          
      elif IsPackageMarkedForLoading( "NConvex", "2019.02.02" ) then
        
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
    
end );
 
##
InstallMethod( CoefficientsOfGradedRingElement,
      [ IsHomalgGradedRingElement ],
  e -> EntriesOfHomalgMatrix( Coefficients( e ) ) 
);

##
InstallMethod( MonomialsOfGradedRingElement,
      [ IsHomalgGradedRingElement ],
  e -> Coefficients( e )!.monomials
);

##
InstallMethod( HomalgElementToListOfIntegers,
      [ IsHomalgElement ],
  function( degree )
    local new_degree;
    
    new_degree := UnderlyingMorphism( degree );
    
    new_degree := MatrixOfMap( new_degree );
    
    new_degree := EntriesOfHomalgMatrix( new_degree );
    
    return List( new_degree, HomalgElementToInteger );
    
  end );
      

