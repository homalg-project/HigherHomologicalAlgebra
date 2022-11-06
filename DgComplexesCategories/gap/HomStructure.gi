# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

##
InstallGlobalFunction( ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_DG_COCHAIN_COMPLEX_CATEGORY,
  function ( dgCh_cat )
    local cat, range_cat, dgCh_range_cat;
    
    cat := UnderlyingCategory( dgCh_cat );
    
    if not HasRangeCategoryOfHomomorphismStructure( cat ) then
      return;
    fi;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    # recursion depth trap :)
    if IsIdenticalObj( cat, range_cat ) then
        return;
    fi;
    
    dgCh_range_cat := DgCochainComplexCategory( range_cat );
    
    SetIsEquippedWithHomomorphismStructure( dgCh_cat, true );
    
    SetRangeCategoryOfHomomorphismStructure( dgCh_cat, dgCh_range_cat );
    
    AddDistinguishedObjectOfHomomorphismStructure( dgCh_cat,
      function( dgCh_cat )
        local cat, range_cat, dgCh_range_cat, distinguished_object, diffs;
        
        cat := UnderlyingCategory( dgCh_cat );
        
        range_cat := RangeCategoryOfHomomorphismStructure( cat );
        
        dgCh_range_cat := RangeCategoryOfHomomorphismStructure( dgCh_cat );
        
        distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
        
        diffs := AsZFunction(
                    function( i )
                      if i = 0 then
                        return UniversalMorphismIntoZeroObject( range_cat, distinguished_object );
                      elif i = -1 then
                        return UniversalMorphismFromZeroObject( range_cat, distinguished_object );
                      else
                        return ZeroObjectFunctorial( range_cat );
                      fi;
                    end );
        
        return DgCochainComplex( dgCh_range_cat, diffs, 0, 0 );
        
    end );
    
    AddHomomorphismStructureOnObjects( dgCh_cat,
      function ( dgCh_cat, B, C )
        local cat, range_cat, dgCh_range_cat, l_B, l_C, u_B, u_C, diffs;
        
        cat := UnderlyingCategory( dgCh_cat );
        
        range_cat := RangeCategoryOfHomomorphismStructure( cat );
        
        dgCh_range_cat := RangeCategoryOfHomomorphismStructure( dgCh_cat );
        
        l_B := LowerBoundOfDgComplex( B );
        u_B := UpperBoundOfDgComplex( B );
        
        l_C := LowerBoundOfDgComplex( C );
        u_C := UpperBoundOfDgComplex( C );
        
        diffs :=
            AsZFunction(
              function( n )
                local diagram_S, diagram_R, matrix;
                
                diagram_S := List( [ Maximum( l_C, l_B + n ) .. Minimum( u_C, u_B + n ) ],
                                j -> HomomorphismStructureOnObjects( cat, B[j-n], C[j] ) );

                diagram_R := List( [ Maximum( l_C, l_B + n + 1 ) .. Minimum( u_C, u_B + n + 1 ) ],
                                i -> HomomorphismStructureOnObjects( cat, B[i-n-1], C[i] ) );
                
                matrix :=
                    List( [ Maximum( l_C, l_B + n ) .. Minimum( u_C, u_B + n ) ],
                        j -> List( [ Maximum( l_C, l_B + n + 1 ) .. Minimum( u_C, u_B + n + 1) ], 
                            function( i )
                                
                                if i = j then
                                    return HomomorphismStructureOnMorphisms( cat, B^(i-1-n), IdentityMorphism( cat, C[j] ) );
                                elif i = j + 1 then
                                    return (-1)^(n+1) * HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, B[j-n] ), C^j );
                                else
                                    return ZeroMorphism(
                                              range_cat,
                                              HomomorphismStructureOnObjects( cat, B[j-n], C[j] ),
                                              HomomorphismStructureOnObjects( cat, B[i-1-n], C[i] )
                                            );
                                fi;
                                
                            end ) );
                            
                return MorphismBetweenDirectSums( range_cat, diagram_S, matrix, diagram_R );
                
              end );
        
        return DgCochainComplex( dgCh_range_cat, diffs, l_C - u_B, u_C - l_B );
        
      end );
    
    #     phi
    # A -------> B
    #
    #
    # D <------- C
    #     psi
    #
    # Outputs a morphism H(phi,psi):H(B,C)->H(A,D) of degree Degree(phi)+Degree(psi)
    #
    AddHomomorphismStructureOnMorphismsWithGivenObjects( dgCh_cat,
      function( dgCh_cat, S, phi, psi, R )
        local cat, range_cat, dgCh_range_cat, A, B, C, D, l_A, u_A, l_B, u_B, l_C, u_C, l_D, u_D, degree_phi, degree_psi, morphisms;
        
        cat := UnderlyingCategory( dgCh_cat );
        
        range_cat := RangeCategoryOfHomomorphismStructure( cat );
        dgCh_range_cat := DgCochainComplexCategory( range_cat );
        
        A := Source( phi );
        l_A := LowerBoundOfDgComplex( A );
        u_A := UpperBoundOfDgComplex( A );
        
        B := Range( phi );
        l_B := LowerBoundOfDgComplex( B );
        u_B := UpperBoundOfDgComplex( B );
        
        C := Source( psi );
        l_C := LowerBoundOfDgComplex( C );
        u_C := UpperBoundOfDgComplex( C );
        
        D := Range( psi );
        l_D := LowerBoundOfDgComplex( D );
        u_D := UpperBoundOfDgComplex( D );
        
        degree_phi := DegreeOfDgComplexMorphism( phi );
        degree_psi := DegreeOfDgComplexMorphism( psi );
        
        morphisms :=
            AsZFunction(
              function( n )
                local diagram_S, diagram_R, maps;
                
                diagram_S := List( [ Maximum( l_C, l_B + n ) .. Minimum( u_C, u_B + n ) ],
                                        j -> HomomorphismStructureOnObjects( cat, B[j-n], C[j] ) );
                                        
                diagram_R := List( [ Maximum( l_D, l_A + n + degree_phi + degree_psi ) .. Minimum( u_D, u_A + n + degree_phi + degree_psi) ],
                                        i -> HomomorphismStructureOnObjects( cat, A[i - n - degree_phi - degree_psi], D[i] ) );
                
                maps :=
                  List( [ Maximum( l_C, l_B + n ) .. Minimum( u_C, u_B + n ) ],
                        j -> List( [ Maximum( l_D, l_A + n + degree_phi + degree_psi ) .. Minimum( u_D, u_A + n + degree_phi + degree_psi) ],
                            function( i )
                                
                                if i = j + degree_psi then
                                    return HomomorphismStructureOnMorphisms( cat, phi[j-n-degree_phi], psi[j] );
                                else
                                    return ZeroMorphism(
                                              range_cat,
                                              HomomorphismStructureOnObjects( cat, B[j-n], C[j] ),
                                              HomomorphismStructureOnObjects( cat, A[i - n - degree_phi - degree_psi], D[i] )
                                            );
                                fi;
                                
                            end ) );
                            
                return MorphismBetweenDirectSums( range_cat, diagram_S, maps, diagram_R );
                
            end );
            
        return DgCochainComplexMorphism( dgCh_cat, S, R, Pair( degree_phi + degree_psi, morphisms ) );
    
      end );
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( dgCh_cat,
        function ( dgCh_cat, distinguished_object, alpha, H_BC )
          local cat, range_cat, B, l_B, u_B, C, l_C, u_C, degree_alpha, diagram_S, diagram_R, matrix;
          
          cat := UnderlyingCategory( dgCh_cat );
          range_cat := RangeCategoryOfHomomorphismStructure( cat );
          
          B := Source( alpha );
          l_B := LowerBoundOfDgComplex( B );
          u_B := UpperBoundOfDgComplex( B );

          C := Range( alpha );
          l_C := LowerBoundOfDgComplex( C );
          u_C := UpperBoundOfDgComplex( C );
          
          degree_alpha := DegreeOfDgComplexMorphism( alpha );
          
          diagram_S := [ DistinguishedObjectOfHomomorphismStructure( cat ) ];
          diagram_R := List( [ Maximum( l_C, l_B + degree_alpha ) .. Minimum( u_C, u_B + degree_alpha ) ],
                        j -> HomomorphismStructureOnObjects( cat, B[j - degree_alpha], C[j] ) );
          
          matrix := [ List( [ Maximum( l_C, l_B + degree_alpha ) .. Minimum( u_C, u_B + degree_alpha ) ],
                      j -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha[j - degree_alpha] ) ) ];
          
          return DgCochainComplexMorphism(
                        dgCh_range_cat,
                        distinguished_object,
                        H_BC,
                        degree_alpha,
                        [ MorphismBetweenDirectSums( range_cat, diagram_S, matrix, diagram_R ) ],
                        0
                    );
      
      end );
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( dgCh_cat,
        
        function ( dgCh_cat, B, C, eta )
          local cat, range_cat, l_B, u_B, l_C, u_C, degree_eta, indices, diagram, maps;
          
          cat := UnderlyingCategory( dgCh_cat );
          range_cat := RangeCategoryOfHomomorphismStructure( cat );
          
          l_B := LowerBoundOfDgComplex( B );
          u_B := UpperBoundOfDgComplex( B );
          
          l_C := LowerBoundOfDgComplex( C );
          u_C := UpperBoundOfDgComplex( C );
          
          degree_eta := DegreeOfDgComplexMorphism( eta );
          
          indices := [ Maximum( l_C, l_B + degree_eta ) .. Minimum( u_C, u_B + degree_eta ) ];
          
          diagram := List( indices, j -> HomomorphismStructureOnObjects( cat, B[j - degree_eta], C[j] ) );
          
          maps := ListN( [ 1 .. Length( indices ) ], indices,
                    { i, j } -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                                        cat,
                                        B[j - degree_eta],
                                        C[j],
                                        PreCompose( range_cat, eta[ 0 ], ProjectionInFactorOfDirectSum( range_cat, diagram, i ) )
                                      ) );
          
          return DgCochainComplexMorphism(
                        dgCh_cat,
                        B,
                        C,
                        degree_eta,
                        maps,
                        indices[ 1 ] - degree_eta
                    );
      
      end );
      
end );
