# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled", function ( cat )
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := RangeCategoryOfHomomorphismStructure( UnderlyingCategory( cat_1 ) );
    deduped_7_1 := UnderlyingRing( deduped_8_1 );
    hoisted_6_1 := HomalgZeroMatrix( 0, 0, deduped_7_1 );
    hoisted_5_1 := HomalgZeroMatrix( 0, 1, deduped_7_1 );
    hoisted_4_1 := HomalgZeroMatrix( 1, 0, deduped_7_1 );
    hoisted_3_1 := CreateCapCategoryObjectWithAttributes( deduped_8_1, Dimension, 0 );
    hoisted_2_1 := CreateCapCategoryObjectWithAttributes( deduped_8_1, Dimension, 1 );
    hoisted_1_1 := deduped_8_1;
    return DgCochainComplex( RangeCategoryOfHomomorphismStructure( cat_1 ), AsZFunction( function ( i_2 )
              local morphism_attr_1_2, morphism_attr_2_2, morphism_attr_3_2;
              if i_2 = 0 then
                  morphism_attr_1_2 := hoisted_4_1;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_1_1, hoisted_2_1, hoisted_3_1, UnderlyingMatrix, morphism_attr_1_2 );
              elif i_2 = -1 then
                  morphism_attr_2_2 := hoisted_5_1;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_1_1, hoisted_3_1, hoisted_2_1, UnderlyingMatrix, morphism_attr_2_2 );
              else
                  morphism_attr_3_2 := hoisted_6_1;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_1_1, hoisted_3_1, hoisted_3_1, UnderlyingMatrix, morphism_attr_3_2 );
              fi;
              return;
          end ), 0, 0 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, hoisted_13_1, hoisted_14_1, hoisted_15_1, hoisted_16_1, hoisted_17_1, hoisted_18_1, hoisted_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1;
    deduped_29_1 := Range( beta_1 );
    deduped_28_1 := UnderlyingCategory( cat_1 );
    deduped_27_1 := Source( beta_1 );
    deduped_26_1 := Range( alpha_1 );
    deduped_25_1 := Source( alpha_1 );
    deduped_24_1 := DegreeOfDgComplexMorphism( beta_1 );
    deduped_23_1 := DegreeOfDgComplexMorphism( alpha_1 );
    deduped_22_1 := UnderlyingCategory( deduped_28_1 );
    deduped_21_1 := RangeCategoryOfHomomorphismStructure( deduped_28_1 );
    deduped_20_1 := BasisPathsByVertexIndex( deduped_22_1 );
    hoisted_19_1 := deduped_21_1;
    hoisted_18_1 := HomStructureOnBasisPaths( deduped_22_1 );
    hoisted_17_1 := deduped_20_1;
    hoisted_16_1 := UnderlyingRing( deduped_21_1 );
    hoisted_15_1 := deduped_27_1;
    hoisted_14_1 := deduped_26_1;
    hoisted_13_1 := UpperBoundOfDgComplex( deduped_27_1 );
    hoisted_12_1 := UpperBoundOfDgComplex( deduped_26_1 );
    hoisted_11_1 := LowerBoundOfDgComplex( deduped_27_1 );
    hoisted_10_1 := LowerBoundOfDgComplex( deduped_26_1 );
    hoisted_9_1 := List( deduped_20_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, Length );
        end );
    hoisted_8_1 := deduped_29_1;
    hoisted_7_1 := deduped_25_1;
    hoisted_6_1 := UpperBoundOfDgComplex( deduped_29_1 );
    hoisted_5_1 := UpperBoundOfDgComplex( deduped_25_1 );
    hoisted_4_1 := LowerBoundOfDgComplex( deduped_29_1 );
    hoisted_3_1 := deduped_24_1;
    hoisted_2_1 := deduped_23_1;
    hoisted_1_1 := LowerBoundOfDgComplex( deduped_25_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, DegreeOfDgComplexMorphism, deduped_23_1 + deduped_24_1, Morphisms, AsZFunction( function ( n_2 )
              local morphism_attr_1_2, hoisted_2_2, deduped_3_2;
              deduped_3_2 := [ Maximum( hoisted_4_1, hoisted_1_1 + n_2 + hoisted_2_1 + hoisted_3_1 ) .. Minimum( hoisted_6_1, hoisted_5_1 + n_2 + hoisted_2_1 + hoisted_3_1 ) ];
              hoisted_2_2 := deduped_3_2;
              morphism_attr_1_2 := UnionOfRows( hoisted_16_1, Sum( List( deduped_3_2, function ( logic_new_func_x_3 )
                          local hoisted_1_3;
                          hoisted_1_3 := ObjectList( hoisted_8_1[logic_new_func_x_3] );
                          return Sum( Concatenation( List( ObjectList( hoisted_7_1[logic_new_func_x_3 - n_2 - hoisted_2_1 - hoisted_3_1] ), function ( logic_new_func_x_4 )
                                      local hoisted_1_4;
                                      hoisted_1_4 := hoisted_9_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                      return List( hoisted_1_3, function ( logic_new_func_x_5 )
                                              return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                          end );
                                  end ) ) );
                      end ) ), List( [ Maximum( hoisted_11_1, hoisted_10_1 + n_2 ) .. Minimum( hoisted_13_1, hoisted_12_1 + n_2 ) ], function ( logic_new_func_x_3 )
                        local hoisted_1_3, hoisted_2_3, hoisted_3_3, hoisted_4_3, hoisted_5_3, hoisted_6_3, hoisted_7_3, hoisted_8_3, hoisted_9_3, hoisted_10_3, hoisted_11_3, hoisted_12_3, hoisted_13_3, hoisted_14_3, hoisted_15_3, hoisted_16_3, hoisted_17_3, hoisted_18_3, hoisted_19_3, hoisted_20_3, hoisted_21_3, hoisted_22_3, hoisted_23_3, deduped_24_3, deduped_25_3, deduped_26_3, deduped_27_3, deduped_28_3, deduped_29_3, deduped_30_3, deduped_31_3, deduped_32_3, deduped_33_3, deduped_34_3, deduped_35_3;
                        deduped_35_3 := beta_1[logic_new_func_x_3];
                        deduped_34_3 := logic_new_func_x_3 - n_2;
                        deduped_33_3 := MorphismMatrix( deduped_35_3 );
                        deduped_32_3 := ObjectList( Source( deduped_35_3 ) );
                        deduped_31_3 := alpha_1[deduped_34_3 - hoisted_2_1];
                        deduped_30_3 := ObjectList( Range( deduped_35_3 ) );
                        deduped_29_3 := MorphismMatrix( deduped_31_3 );
                        deduped_28_3 := ObjectList( Range( deduped_31_3 ) );
                        deduped_27_3 := ObjectList( Source( deduped_31_3 ) );
                        deduped_26_3 := [ 1 .. Length( deduped_28_3 ) ];
                        deduped_25_3 := [ 1 .. Length( deduped_27_3 ) ];
                        hoisted_1_3 := ObjectList( hoisted_15_1[logic_new_func_x_3] );
                        deduped_24_3 := Sum( Concatenation( List( ObjectList( hoisted_14_1[deduped_34_3] ), function ( logic_new_func_x_4 )
                                    local hoisted_1_4;
                                    hoisted_1_4 := hoisted_9_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                    return List( hoisted_1_3, function ( logic_new_func_x_5 )
                                            return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                        end );
                                end ) ) );
                        hoisted_23_3 := deduped_24_3;
                        hoisted_21_3 := deduped_25_3;
                        hoisted_20_3 := List( deduped_33_3, function ( logic_new_func_list_4 )
                                return List( logic_new_func_list_4, UnderlyingQuiverAlgebraElement );
                            end );
                        hoisted_19_3 := List( deduped_29_3, function ( logic_new_func_list_4 )
                                return List( logic_new_func_list_4, UnderlyingQuiverAlgebraElement );
                            end );
                        hoisted_18_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Range( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_17_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Source( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_16_3 := List( deduped_29_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Range( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_15_3 := List( deduped_29_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Source( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_14_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_5 ) );
                                    end );
                            end );
                        hoisted_13_3 := List( deduped_29_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_5 ) );
                                    end );
                            end );
                        hoisted_10_3 := [ 1 .. Length( deduped_30_3 ) ];
                        hoisted_9_3 := List( deduped_30_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_8_3 := List( deduped_27_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_11_3 := List( deduped_25_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_9_1[hoisted_8_3[logic_new_func_x_4]];
                                return List( hoisted_10_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4[hoisted_9_3[logic_new_func_x_5]];
                                    end );
                            end );
                        hoisted_12_3 := List( deduped_25_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_11_3[logic_new_func_x_4];
                                return Sum( List( hoisted_10_3, function ( logic_new_func_x_5 )
                                          return hoisted_1_4[logic_new_func_x_5];
                                      end ) );
                            end );
                        hoisted_6_3 := [ 1 .. Length( deduped_32_3 ) ];
                        hoisted_5_3 := List( deduped_32_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_4_3 := List( deduped_28_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_7_3 := List( deduped_26_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_9_1[hoisted_4_3[logic_new_func_x_4]];
                                return List( hoisted_6_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4[hoisted_5_3[logic_new_func_x_5]];
                                    end );
                            end );
                        hoisted_3_3 := deduped_30_3;
                        hoisted_22_3 := UnionOfRows( hoisted_16_1, Sum( Concatenation( List( deduped_27_3, function ( logic_new_func_x_4 )
                                      local hoisted_1_4;
                                      hoisted_1_4 := hoisted_9_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                      return List( hoisted_3_3, function ( logic_new_func_x_5 )
                                              return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                          end );
                                  end ) ) ), List( deduped_26_3, function ( logic_new_func_x_4 )
                                  local hoisted_1_4;
                                  hoisted_1_4 := hoisted_7_3[logic_new_func_x_4];
                                  return UnionOfColumns( hoisted_16_1, Sum( List( hoisted_6_3, function ( logic_new_func_x_5 )
                                              return hoisted_1_4[logic_new_func_x_5];
                                          end ) ), List( hoisted_21_3, function ( logic_new_func_x_5 )
                                            local hoisted_1_5, hoisted_2_5, hoisted_3_5, hoisted_4_5, hoisted_5_5, hoisted_6_5, deduped_7_5, deduped_8_5;
                                            deduped_8_5 := hoisted_16_3[logic_new_func_x_5][logic_new_func_x_4];
                                            deduped_7_5 := hoisted_15_3[logic_new_func_x_5][logic_new_func_x_4];
                                            hoisted_6_5 := [ 1 .. hoisted_9_1[deduped_7_5][deduped_8_5] ];
                                            hoisted_5_5 := deduped_7_5;
                                            hoisted_4_5 := hoisted_18_1[deduped_8_5];
                                            hoisted_3_5 := CoefficientsOfPaths( hoisted_17_1[deduped_7_5][deduped_8_5], hoisted_19_3[logic_new_func_x_5][logic_new_func_x_4] );
                                            hoisted_2_5 := hoisted_11_3[logic_new_func_x_5];
                                            hoisted_1_5 := hoisted_13_3[logic_new_func_x_5][logic_new_func_x_4];
                                            return UnionOfRows( hoisted_16_1, hoisted_12_3[logic_new_func_x_5], List( hoisted_6_3, function ( logic_new_func_x_6 )
                                                      local hoisted_1_6, hoisted_2_6, hoisted_3_6, hoisted_4_6, hoisted_5_6, hoisted_6_6, deduped_7_6;
                                                      deduped_7_6 := hoisted_1_4[logic_new_func_x_6];
                                                      hoisted_6_6 := hoisted_20_3[logic_new_func_x_6];
                                                      hoisted_5_6 := hoisted_18_3[logic_new_func_x_6];
                                                      hoisted_4_6 := hoisted_17_3[logic_new_func_x_6];
                                                      hoisted_3_6 := deduped_7_6;
                                                      hoisted_2_6 := hoisted_1_5 or deduped_7_6 = 0;
                                                      hoisted_1_6 := hoisted_14_3[logic_new_func_x_6];
                                                      return UnionOfColumns( hoisted_16_1, deduped_7_6, List( hoisted_10_3, function ( logic_new_func_x_7 )
                                                                local hoisted_1_7, hoisted_2_7, hoisted_3_7, deduped_4_7, deduped_5_7, deduped_6_7;
                                                                deduped_4_7 := hoisted_2_5[logic_new_func_x_7];
                                                                if hoisted_2_6 or (hoisted_1_6[logic_new_func_x_7] or deduped_4_7 = 0) then
                                                                    return HomalgZeroMatrix( hoisted_3_6, deduped_4_7, hoisted_16_1 );
                                                                else
                                                                    deduped_6_7 := hoisted_5_6[logic_new_func_x_7];
                                                                    deduped_5_7 := hoisted_4_6[logic_new_func_x_7];
                                                                    hoisted_3_7 := [ 1 .. hoisted_9_1[deduped_5_7][deduped_6_7] ];
                                                                    hoisted_2_7 := hoisted_4_5[deduped_5_7][hoisted_5_5][deduped_6_7];
                                                                    hoisted_1_7 := CoefficientsOfPaths( hoisted_17_1[deduped_5_7][deduped_6_7], hoisted_6_6[logic_new_func_x_7] );
                                                                    return HomalgMatrixListList( Sum( hoisted_6_5, function ( p_8 )
                                                                              local hoisted_1_8, hoisted_2_8;
                                                                              hoisted_2_8 := hoisted_2_7[p_8];
                                                                              hoisted_1_8 := hoisted_3_5[p_8];
                                                                              return Sum( hoisted_3_7, function ( q_9 )
                                                                                      return hoisted_1_8 * hoisted_1_7[q_9] * hoisted_2_8[q_9];
                                                                                  end );
                                                                          end ), hoisted_3_6, deduped_4_7, hoisted_16_1 );
                                                                fi;
                                                                return;
                                                            end ) );
                                                  end ) );
                                        end ) );
                              end ) );
                        hoisted_2_3 := logic_new_func_x_3 + hoisted_3_1;
                        return UnionOfColumns( hoisted_16_1, deduped_24_3, List( hoisted_2_2, function ( logic_new_func_x_4 )
                                  local hoisted_1_4;
                                  if logic_new_func_x_4 = hoisted_2_3 then
                                      return hoisted_22_3;
                                  else
                                      hoisted_1_4 := ObjectList( hoisted_8_1[logic_new_func_x_4] );
                                      return HomalgZeroMatrix( hoisted_23_3, Sum( Concatenation( List( ObjectList( hoisted_7_1[logic_new_func_x_4 - n_2 - hoisted_2_1 - hoisted_3_1] ), function ( logic_new_func_x_5 )
                                                    local hoisted_1_5;
                                                    hoisted_1_5 := hoisted_9_1[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                                    return List( hoisted_1_4, function ( logic_new_func_x_6 )
                                                            return hoisted_1_5[VertexIndex( UnderlyingVertex( logic_new_func_x_6 ) )];
                                                        end );
                                                end ) ) ), hoisted_16_1 );
                                  fi;
                                  return;
                              end ) );
                    end ) );
              return CreateCapCategoryMorphismWithAttributes( hoisted_19_1, CreateCapCategoryObjectWithAttributes( hoisted_19_1, Dimension, NumberRows( morphism_attr_1_2 ) ), CreateCapCategoryObjectWithAttributes( hoisted_19_1, Dimension, NumberColumns( morphism_attr_1_2 ) ), UnderlyingMatrix, morphism_attr_1_2 );
          end ), LowerBoundOfDgComplexMorphism, Minimum( LowerBoundOfDgComplex( source_1 ), LowerBoundOfDgComplex( range_1 ) ), UpperBoundOfDgComplexMorphism, Maximum( UpperBoundOfDgComplex( source_1 ), UpperBoundOfDgComplex( range_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := LowerBoundOfDgComplex( arg2_1 );
    deduped_18_1 := UpperBoundOfDgComplex( arg3_1 );
    deduped_17_1 := UpperBoundOfDgComplex( arg2_1 );
    deduped_16_1 := LowerBoundOfDgComplex( arg3_1 );
    deduped_15_1 := UnderlyingCategory( cat_1 );
    deduped_14_1 := RangeCategoryOfHomomorphismStructure( deduped_15_1 );
    deduped_13_1 := UnderlyingCategory( deduped_15_1 );
    deduped_12_1 := BasisPathsByVertexIndex( deduped_13_1 );
    deduped_11_1 := UnderlyingQuiverAlgebra( deduped_13_1 );
    hoisted_10_1 := deduped_14_1;
    hoisted_9_1 := HomStructureOnBasisPaths( deduped_13_1 );
    hoisted_8_1 := deduped_12_1;
    hoisted_7_1 := UnderlyingRing( deduped_14_1 );
    hoisted_6_1 := deduped_11_1;
    hoisted_5_1 := List( deduped_12_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, Length );
        end );
    hoisted_4_1 := deduped_18_1;
    hoisted_3_1 := deduped_17_1;
    hoisted_2_1 := deduped_16_1;
    hoisted_1_1 := deduped_19_1;
    return DgCochainComplex( RangeCategoryOfHomomorphismStructure( cat_1 ), AsZFunction( function ( n_2 )
              local morphism_attr_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2;
              deduped_6_2 := hoisted_3_1 + n_2;
              deduped_5_2 := hoisted_1_1 + n_2;
              deduped_4_2 := [ Maximum( hoisted_2_1, deduped_5_2 + 1 ) .. Minimum( hoisted_4_1, deduped_6_2 + 1 ) ];
              hoisted_3_2 := deduped_4_2;
              hoisted_2_2 := (-1) ^ (n_2 + 1);
              morphism_attr_1_2 := UnionOfRows( hoisted_7_1, Sum( List( deduped_4_2, function ( logic_new_func_x_3 )
                          local hoisted_1_3;
                          hoisted_1_3 := ObjectList( arg3_1[logic_new_func_x_3] );
                          return Sum( Concatenation( List( ObjectList( arg2_1[logic_new_func_x_3 - n_2 - 1] ), function ( logic_new_func_x_4 )
                                      local hoisted_1_4;
                                      hoisted_1_4 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                      return List( hoisted_1_3, function ( logic_new_func_x_5 )
                                              return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                          end );
                                  end ) ) );
                      end ) ), List( [ Maximum( hoisted_2_1, deduped_5_2 ) .. Minimum( hoisted_4_1, deduped_6_2 ) ], function ( logic_new_func_x_3 )
                        local hoisted_1_3, hoisted_2_3, hoisted_3_3, hoisted_4_3, hoisted_5_3, hoisted_6_3, hoisted_7_3, hoisted_8_3, hoisted_9_3, hoisted_10_3, hoisted_11_3, hoisted_12_3, hoisted_13_3, hoisted_14_3, hoisted_15_3, hoisted_16_3, hoisted_17_3, hoisted_18_3, hoisted_19_3, hoisted_20_3, hoisted_21_3, hoisted_22_3, hoisted_23_3, hoisted_24_3, hoisted_25_3, hoisted_26_3, hoisted_27_3, hoisted_28_3, hoisted_29_3, hoisted_30_3, hoisted_31_3, deduped_32_3, deduped_33_3, deduped_34_3, deduped_35_3, deduped_36_3, deduped_37_3, deduped_38_3, deduped_39_3, deduped_40_3, deduped_41_3;
                        deduped_41_3 := arg3_1 ^ logic_new_func_x_3;
                        deduped_40_3 := MorphismMatrix( deduped_41_3 );
                        deduped_39_3 := ObjectList( arg3_1[logic_new_func_x_3] );
                        deduped_38_3 := ObjectList( Source( deduped_41_3 ) );
                        deduped_37_3 := ObjectList( Range( deduped_41_3 ) );
                        deduped_36_3 := ObjectList( arg2_1[logic_new_func_x_3 - n_2] );
                        deduped_35_3 := [ 1 .. Length( deduped_39_3 ) ];
                        deduped_34_3 := ZeroImmutable( deduped_11_1 );
                        deduped_33_3 := [ 1 .. Length( deduped_36_3 ) ];
                        hoisted_1_3 := deduped_39_3;
                        deduped_32_3 := Sum( Concatenation( List( deduped_36_3, function ( logic_new_func_x_4 )
                                    local hoisted_1_4;
                                    hoisted_1_4 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                    return List( hoisted_1_3, function ( logic_new_func_x_5 )
                                            return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                        end );
                                end ) ) );
                        hoisted_31_3 := deduped_32_3;
                        hoisted_29_3 := List( deduped_40_3, function ( logic_new_func_list_4 )
                                return List( logic_new_func_list_4, UnderlyingQuiverAlgebraElement );
                            end );
                        hoisted_20_3 := deduped_33_3;
                        hoisted_19_3 := List( deduped_36_3, function ( logic_new_func_x_4 )
                                return QuiverVertexAsIdentityPath( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_28_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := PathAsAlgebraElement( hoisted_6_1, hoisted_19_3[logic_new_func_x_4] );
                                return List( hoisted_20_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return deduped_34_3;
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_27_3 := List( deduped_40_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Range( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_26_3 := List( deduped_40_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return VertexIndex( UnderlyingVertex( Source( logic_new_func_x_5 ) ) );
                                    end );
                            end );
                        hoisted_23_3 := deduped_36_3;
                        hoisted_25_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := VertexIndex( UnderlyingVertex( hoisted_23_3[logic_new_func_x_4] ) );
                                return List( hoisted_20_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return VertexIndex( UnderlyingVertex( hoisted_23_3[logic_new_func_x_5] ) );
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_24_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := VertexIndex( UnderlyingVertex( hoisted_23_3[logic_new_func_x_4] ) );
                                return List( hoisted_20_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4;
                                    end );
                            end );
                        hoisted_22_3 := List( deduped_40_3, function ( logic_new_func_x_4 )
                                return List( logic_new_func_x_4, function ( logic_new_func_x_5 )
                                        return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_5 ) );
                                    end );
                            end );
                        hoisted_21_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := IsZero( PathAsAlgebraElement( hoisted_6_1, hoisted_19_3[logic_new_func_x_4] ) );
                                return List( hoisted_20_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return true;
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_16_3 := [ 1 .. Length( deduped_37_3 ) ];
                        hoisted_15_3 := List( deduped_37_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_11_3 := List( deduped_36_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_17_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_5_1[hoisted_11_3[logic_new_func_x_4]];
                                return List( hoisted_16_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4[hoisted_15_3[logic_new_func_x_5]];
                                    end );
                            end );
                        hoisted_18_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_17_3[logic_new_func_x_4];
                                return Sum( List( hoisted_16_3, function ( logic_new_func_x_5 )
                                          return hoisted_1_4[logic_new_func_x_5];
                                      end ) );
                            end );
                        hoisted_13_3 := [ 1 .. Length( deduped_38_3 ) ];
                        hoisted_12_3 := List( deduped_38_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_14_3 := List( deduped_33_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := hoisted_5_1[hoisted_11_3[logic_new_func_x_4]];
                                return List( hoisted_13_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4[hoisted_12_3[logic_new_func_x_5]];
                                    end );
                            end );
                        hoisted_10_3 := deduped_37_3;
                        hoisted_30_3 := hoisted_2_2 * UnionOfRows( hoisted_7_1, Sum( Concatenation( List( deduped_36_3, function ( logic_new_func_x_4 )
                                        local hoisted_1_4;
                                        hoisted_1_4 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                        return List( hoisted_10_3, function ( logic_new_func_x_5 )
                                                return hoisted_1_4[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                            end );
                                    end ) ) ), List( deduped_33_3, function ( logic_new_func_x_4 )
                                    local hoisted_1_4;
                                    hoisted_1_4 := hoisted_14_3[logic_new_func_x_4];
                                    return UnionOfColumns( hoisted_7_1, Sum( List( hoisted_13_3, function ( logic_new_func_x_5 )
                                                return hoisted_1_4[logic_new_func_x_5];
                                            end ) ), List( hoisted_20_3, function ( logic_new_func_x_5 )
                                              local hoisted_1_5, hoisted_2_5, hoisted_3_5, hoisted_4_5, hoisted_5_5, hoisted_6_5, deduped_7_5, deduped_8_5;
                                              deduped_8_5 := hoisted_25_3[logic_new_func_x_5][logic_new_func_x_4];
                                              deduped_7_5 := hoisted_24_3[logic_new_func_x_5][logic_new_func_x_4];
                                              hoisted_6_5 := [ 1 .. hoisted_5_1[deduped_7_5][deduped_8_5] ];
                                              hoisted_5_5 := deduped_7_5;
                                              hoisted_4_5 := hoisted_9_1[deduped_8_5];
                                              hoisted_3_5 := CoefficientsOfPaths( hoisted_8_1[deduped_7_5][deduped_8_5], hoisted_28_3[logic_new_func_x_5][logic_new_func_x_4] );
                                              hoisted_2_5 := hoisted_17_3[logic_new_func_x_5];
                                              hoisted_1_5 := hoisted_21_3[logic_new_func_x_5][logic_new_func_x_4];
                                              return UnionOfRows( hoisted_7_1, hoisted_18_3[logic_new_func_x_5], List( hoisted_13_3, function ( logic_new_func_x_6 )
                                                        local hoisted_1_6, hoisted_2_6, hoisted_3_6, hoisted_4_6, hoisted_5_6, hoisted_6_6, deduped_7_6;
                                                        deduped_7_6 := hoisted_1_4[logic_new_func_x_6];
                                                        hoisted_6_6 := hoisted_29_3[logic_new_func_x_6];
                                                        hoisted_5_6 := hoisted_27_3[logic_new_func_x_6];
                                                        hoisted_4_6 := hoisted_26_3[logic_new_func_x_6];
                                                        hoisted_3_6 := deduped_7_6;
                                                        hoisted_2_6 := (hoisted_1_5 or deduped_7_6 = 0);
                                                        hoisted_1_6 := hoisted_22_3[logic_new_func_x_6];
                                                        return UnionOfColumns( hoisted_7_1, deduped_7_6, List( hoisted_16_3, function ( logic_new_func_x_7 )
                                                                  local hoisted_1_7, hoisted_2_7, hoisted_3_7, deduped_4_7, deduped_5_7, deduped_6_7;
                                                                  deduped_4_7 := hoisted_2_5[logic_new_func_x_7];
                                                                  if (hoisted_2_6 or (hoisted_1_6[logic_new_func_x_7] or deduped_4_7 = 0)) then
                                                                      return HomalgZeroMatrix( hoisted_3_6, deduped_4_7, hoisted_7_1 );
                                                                  else
                                                                      deduped_6_7 := hoisted_5_6[logic_new_func_x_7];
                                                                      deduped_5_7 := hoisted_4_6[logic_new_func_x_7];
                                                                      hoisted_3_7 := [ 1 .. hoisted_5_1[deduped_5_7][deduped_6_7] ];
                                                                      hoisted_2_7 := hoisted_4_5[deduped_5_7][hoisted_5_5][deduped_6_7];
                                                                      hoisted_1_7 := CoefficientsOfPaths( hoisted_8_1[deduped_5_7][deduped_6_7], hoisted_6_6[logic_new_func_x_7] );
                                                                      return HomalgMatrixListList( Sum( hoisted_6_5, function ( p_8 )
                                                                                local hoisted_1_8, hoisted_2_8;
                                                                                hoisted_2_8 := hoisted_2_7[p_8];
                                                                                hoisted_1_8 := hoisted_3_5[p_8];
                                                                                return Sum( hoisted_3_7, function ( q_9 )
                                                                                        return (hoisted_1_8 * hoisted_1_7[q_9] * hoisted_2_8[q_9]);
                                                                                    end );
                                                                            end ), hoisted_3_6, deduped_4_7, hoisted_7_1 );
                                                                  fi;
                                                                  return;
                                                              end ) );
                                                    end ) );
                                          end ) );
                                end ) );
                        hoisted_9_3 := logic_new_func_x_3 + 1;
                        hoisted_4_3 := List( deduped_39_3, function ( logic_new_func_x_4 )
                                return QuiverVertexAsIdentityPath( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        hoisted_3_3 := deduped_35_3;
                        hoisted_8_3 := List( deduped_35_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := PathAsAlgebraElement( hoisted_6_1, hoisted_4_3[logic_new_func_x_4] );
                                return List( hoisted_3_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return deduped_34_3;
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_7_3 := List( deduped_35_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := VertexIndex( UnderlyingVertex( hoisted_1_3[logic_new_func_x_4] ) );
                                return List( hoisted_3_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return VertexIndex( UnderlyingVertex( hoisted_1_3[logic_new_func_x_5] ) );
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_6_3 := List( deduped_35_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := VertexIndex( UnderlyingVertex( hoisted_1_3[logic_new_func_x_4] ) );
                                return List( hoisted_3_3, function ( logic_new_func_x_5 )
                                        return hoisted_1_4;
                                    end );
                            end );
                        hoisted_5_3 := List( deduped_35_3, function ( logic_new_func_x_4 )
                                local hoisted_1_4;
                                hoisted_1_4 := IsZero( PathAsAlgebraElement( hoisted_6_1, hoisted_4_3[logic_new_func_x_4] ) );
                                return List( hoisted_3_3, function ( logic_new_func_x_5 )
                                        if logic_new_func_x_4 = logic_new_func_x_5 then
                                            return hoisted_1_4;
                                        else
                                            return true;
                                        fi;
                                        return;
                                    end );
                            end );
                        hoisted_2_3 := List( deduped_39_3, function ( logic_new_func_x_4 )
                                return VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) );
                            end );
                        return UnionOfColumns( hoisted_7_1, deduped_32_3, List( hoisted_3_2, function ( logic_new_func_x_4 )
                                  local hoisted_1_4, hoisted_2_4, hoisted_3_4, hoisted_4_4, hoisted_5_4, hoisted_6_4, hoisted_7_4, hoisted_8_4, hoisted_9_4, hoisted_10_4, hoisted_11_4, deduped_12_4, deduped_13_4, deduped_14_4, deduped_15_4, deduped_16_4, deduped_17_4, deduped_18_4;
                                  deduped_18_4 := logic_new_func_x_4 - 1 - n_2;
                                  if logic_new_func_x_4 = logic_new_func_x_3 then
                                      deduped_17_4 := arg2_1 ^ deduped_18_4;
                                      deduped_16_4 := MorphismMatrix( deduped_17_4 );
                                      deduped_15_4 := ObjectList( Range( deduped_17_4 ) );
                                      deduped_14_4 := ObjectList( Source( deduped_17_4 ) );
                                      deduped_13_4 := [ 1 .. Length( deduped_14_4 ) ];
                                      deduped_12_4 := [ 1 .. Length( deduped_15_4 ) ];
                                      hoisted_10_4 := deduped_13_4;
                                      hoisted_9_4 := List( deduped_16_4, function ( logic_new_func_list_5 )
                                              return List( logic_new_func_list_5, UnderlyingQuiverAlgebraElement );
                                          end );
                                      hoisted_8_4 := List( deduped_16_4, function ( logic_new_func_x_5 )
                                              return List( logic_new_func_x_5, function ( logic_new_func_x_6 )
                                                      return VertexIndex( UnderlyingVertex( Range( logic_new_func_x_6 ) ) );
                                                  end );
                                          end );
                                      hoisted_7_4 := List( deduped_16_4, function ( logic_new_func_x_5 )
                                              return List( logic_new_func_x_5, function ( logic_new_func_x_6 )
                                                      return VertexIndex( UnderlyingVertex( Source( logic_new_func_x_6 ) ) );
                                                  end );
                                          end );
                                      hoisted_6_4 := List( deduped_16_4, function ( logic_new_func_x_5 )
                                              return List( logic_new_func_x_5, function ( logic_new_func_x_6 )
                                                      return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_6 ) );
                                                  end );
                                          end );
                                      hoisted_3_4 := List( deduped_14_4, function ( logic_new_func_x_5 )
                                              return VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) );
                                          end );
                                      hoisted_4_4 := List( deduped_13_4, function ( logic_new_func_x_5 )
                                              local hoisted_1_5;
                                              hoisted_1_5 := hoisted_5_1[hoisted_3_4[logic_new_func_x_5]];
                                              return List( hoisted_3_3, function ( logic_new_func_x_6 )
                                                      return hoisted_1_5[hoisted_2_3[logic_new_func_x_6]];
                                                  end );
                                          end );
                                      hoisted_5_4 := List( deduped_13_4, function ( logic_new_func_x_5 )
                                              local hoisted_1_5;
                                              hoisted_1_5 := hoisted_4_4[logic_new_func_x_5];
                                              return Sum( List( hoisted_3_3, function ( logic_new_func_x_6 )
                                                        return hoisted_1_5[logic_new_func_x_6];
                                                    end ) );
                                          end );
                                      hoisted_1_4 := List( deduped_15_4, function ( logic_new_func_x_5 )
                                              return VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) );
                                          end );
                                      hoisted_2_4 := List( deduped_12_4, function ( logic_new_func_x_5 )
                                              local hoisted_1_5;
                                              hoisted_1_5 := hoisted_5_1[hoisted_1_4[logic_new_func_x_5]];
                                              return List( hoisted_3_3, function ( logic_new_func_x_6 )
                                                      return hoisted_1_5[hoisted_2_3[logic_new_func_x_6]];
                                                  end );
                                          end );
                                      return UnionOfRows( hoisted_7_1, Sum( Concatenation( List( deduped_14_4, function ( logic_new_func_x_5 )
                                                    local hoisted_1_5;
                                                    hoisted_1_5 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                                    return List( hoisted_1_3, function ( logic_new_func_x_6 )
                                                            return hoisted_1_5[VertexIndex( UnderlyingVertex( logic_new_func_x_6 ) )];
                                                        end );
                                                end ) ) ), List( deduped_12_4, function ( logic_new_func_x_5 )
                                                local hoisted_1_5;
                                                hoisted_1_5 := hoisted_2_4[logic_new_func_x_5];
                                                return UnionOfColumns( hoisted_7_1, Sum( List( hoisted_3_3, function ( logic_new_func_x_6 )
                                                            return hoisted_1_5[logic_new_func_x_6];
                                                        end ) ), List( hoisted_10_4, function ( logic_new_func_x_6 )
                                                          local hoisted_1_6, hoisted_2_6, hoisted_3_6, hoisted_4_6, hoisted_5_6, hoisted_6_6, deduped_7_6, deduped_8_6;
                                                          deduped_8_6 := hoisted_8_4[logic_new_func_x_6][logic_new_func_x_5];
                                                          deduped_7_6 := hoisted_7_4[logic_new_func_x_6][logic_new_func_x_5];
                                                          hoisted_6_6 := [ 1 .. hoisted_5_1[deduped_7_6][deduped_8_6] ];
                                                          hoisted_5_6 := deduped_7_6;
                                                          hoisted_4_6 := hoisted_9_1[deduped_8_6];
                                                          hoisted_3_6 := CoefficientsOfPaths( hoisted_8_1[deduped_7_6][deduped_8_6], hoisted_9_4[logic_new_func_x_6][logic_new_func_x_5] );
                                                          hoisted_2_6 := hoisted_4_4[logic_new_func_x_6];
                                                          hoisted_1_6 := hoisted_6_4[logic_new_func_x_6][logic_new_func_x_5];
                                                          return UnionOfRows( hoisted_7_1, hoisted_5_4[logic_new_func_x_6], List( hoisted_3_3, function ( logic_new_func_x_7 )
                                                                    local hoisted_1_7, hoisted_2_7, hoisted_3_7, hoisted_4_7, hoisted_5_7, hoisted_6_7, deduped_7_7;
                                                                    deduped_7_7 := hoisted_1_5[logic_new_func_x_7];
                                                                    hoisted_6_7 := hoisted_8_3[logic_new_func_x_7];
                                                                    hoisted_5_7 := hoisted_7_3[logic_new_func_x_7];
                                                                    hoisted_4_7 := hoisted_6_3[logic_new_func_x_7];
                                                                    hoisted_3_7 := deduped_7_7;
                                                                    hoisted_2_7 := hoisted_1_6 or deduped_7_7 = 0;
                                                                    hoisted_1_7 := hoisted_5_3[logic_new_func_x_7];
                                                                    return UnionOfColumns( hoisted_7_1, deduped_7_7, List( hoisted_3_3, function ( logic_new_func_x_8 )
                                                                              local hoisted_1_8, hoisted_2_8, hoisted_3_8, deduped_4_8, deduped_5_8, deduped_6_8;
                                                                              deduped_4_8 := hoisted_2_6[logic_new_func_x_8];
                                                                              if hoisted_2_7 or (hoisted_1_7[logic_new_func_x_8] or deduped_4_8 = 0) then
                                                                                  return HomalgZeroMatrix( hoisted_3_7, deduped_4_8, hoisted_7_1 );
                                                                              else
                                                                                  deduped_6_8 := hoisted_5_7[logic_new_func_x_8];
                                                                                  deduped_5_8 := hoisted_4_7[logic_new_func_x_8];
                                                                                  hoisted_3_8 := [ 1 .. hoisted_5_1[deduped_5_8][deduped_6_8] ];
                                                                                  hoisted_2_8 := hoisted_4_6[deduped_5_8][hoisted_5_6][deduped_6_8];
                                                                                  hoisted_1_8 := CoefficientsOfPaths( hoisted_8_1[deduped_5_8][deduped_6_8], hoisted_6_7[logic_new_func_x_8] );
                                                                                  return HomalgMatrixListList( Sum( hoisted_6_6, function ( p_9 )
                                                                                            local hoisted_1_9, hoisted_2_9;
                                                                                            hoisted_2_9 := hoisted_2_8[p_9];
                                                                                            hoisted_1_9 := hoisted_3_6[p_9];
                                                                                            return Sum( hoisted_3_8, function ( q_10 )
                                                                                                    return hoisted_1_9 * hoisted_1_8[q_10] * hoisted_2_9[q_10];
                                                                                                end );
                                                                                        end ), hoisted_3_7, deduped_4_8, hoisted_7_1 );
                                                                              fi;
                                                                              return;
                                                                          end ) );
                                                                end ) );
                                                      end ) );
                                            end ) );
                                  elif logic_new_func_x_4 = hoisted_9_3 then
                                      return hoisted_30_3;
                                  else
                                      hoisted_11_4 := ObjectList( arg3_1[logic_new_func_x_4] );
                                      return HomalgZeroMatrix( hoisted_31_3, Sum( Concatenation( List( ObjectList( arg2_1[deduped_18_4] ), function ( logic_new_func_x_5 )
                                                    local hoisted_1_5;
                                                    hoisted_1_5 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_5 ) )];
                                                    return List( hoisted_11_4, function ( logic_new_func_x_6 )
                                                            return hoisted_1_5[VertexIndex( UnderlyingVertex( logic_new_func_x_6 ) )];
                                                        end );
                                                end ) ) ), hoisted_7_1 );
                                  fi;
                                  return;
                              end ) );
                    end ) );
              return CreateCapCategoryMorphismWithAttributes( hoisted_10_1, CreateCapCategoryObjectWithAttributes( hoisted_10_1, Dimension, NumberRows( morphism_attr_1_2 ) ), CreateCapCategoryObjectWithAttributes( hoisted_10_1, Dimension, NumberColumns( morphism_attr_1_2 ) ), UnderlyingMatrix, morphism_attr_1_2 );
          end ), deduped_16_1 - deduped_17_1, deduped_18_1 - deduped_19_1 );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingCategory( cat_1 );
    deduped_6_1 := UnderlyingCategory( deduped_7_1 );
    deduped_5_1 := UnderlyingQuiverAlgebra( deduped_6_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := ZeroImmutable( deduped_5_1 );
    hoisted_2_1 := deduped_6_1;
    hoisted_1_1 := deduped_5_1;
    return DgCochainComplexMorphism( a_1, a_1, 0, AsZFunction( function ( i_2 )
              local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2;
              deduped_6_2 := a_1[i_2];
              deduped_5_2 := ObjectList( deduped_6_2 );
              deduped_4_2 := [ 1 .. Length( deduped_5_2 ) ];
              hoisted_3_2 := deduped_4_2;
              hoisted_2_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                      return QuiverVertexAsIdentityPath( UnderlyingVertex( logic_new_func_x_3 ) );
                  end );
              hoisted_1_2 := deduped_5_2;
              return CreateCapCategoryMorphismWithAttributes( hoisted_4_1, deduped_6_2, deduped_6_2, MorphismMatrix, List( deduped_4_2, function ( i_3 )
                        local hoisted_1_3, hoisted_2_3, deduped_3_3;
                        deduped_3_3 := hoisted_1_2[i_3];
                        hoisted_2_3 := deduped_3_3;
                        hoisted_1_3 := CreateCapCategoryMorphismWithAttributes( hoisted_2_1, deduped_3_3, deduped_3_3, UnderlyingQuiverAlgebraElement, PathAsAlgebraElement( hoisted_1_1, hoisted_2_2[i_3] ) );
                        return List( hoisted_3_2, function ( j_4 )
                                if i_3 = j_4 then
                                    return hoisted_1_3;
                                else
                                    return CreateCapCategoryMorphismWithAttributes( hoisted_2_1, hoisted_2_3, hoisted_1_2[j_4], UnderlyingQuiverAlgebraElement, hoisted_3_1 );
                                fi;
                                return;
                            end );
                    end ) );
          end ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, hoisted_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1;
    deduped_24_1 := Source( alpha_1 );
    deduped_23_1 := Range( alpha_1 );
    deduped_22_1 := UnderlyingCategory( cat_1 );
    deduped_21_1 := DegreeOfDgComplexMorphism( alpha_1 );
    deduped_20_1 := RangeCategoryOfHomomorphismStructure( deduped_22_1 );
    deduped_19_1 := UnderlyingCategory( deduped_22_1 );
    deduped_18_1 := 0 + 1 - 1;
    deduped_17_1 := BasisPathsByVertexIndex( deduped_19_1 );
    deduped_16_1 := CreateCapCategoryObjectWithAttributes( deduped_20_1, Dimension, 1 );
    deduped_15_1 := UnderlyingRing( deduped_20_1 );
    deduped_14_1 := [ Maximum( LowerBoundOfDgComplex( deduped_23_1 ), LowerBoundOfDgComplex( deduped_24_1 ) + deduped_21_1 ) .. Minimum( UpperBoundOfDgComplex( deduped_23_1 ), UpperBoundOfDgComplex( deduped_24_1 ) + deduped_21_1 ) ];
    hoisted_7_1 := deduped_17_1;
    hoisted_6_1 := deduped_15_1;
    hoisted_5_1 := List( deduped_17_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, Length );
        end );
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_24_1;
    hoisted_2_1 := deduped_21_1;
    hoisted_13_1 := UnionOfRows( deduped_15_1, Sum( List( deduped_14_1, function ( logic_new_func_x_2 )
                local hoisted_1_2;
                hoisted_1_2 := ObjectList( hoisted_4_1[logic_new_func_x_2] );
                return Sum( Concatenation( List( ObjectList( hoisted_3_1[logic_new_func_x_2 - hoisted_2_1] ), function ( logic_new_func_x_3 )
                            local hoisted_1_3;
                            hoisted_1_3 := hoisted_5_1[VertexIndex( UnderlyingVertex( logic_new_func_x_3 ) )];
                            return List( hoisted_1_2, function ( logic_new_func_x_4 )
                                    return hoisted_1_3[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                                end );
                        end ) ) );
            end ) ), ListN( [ deduped_16_1 ], [ List( deduped_14_1, function ( logic_new_func_x_2 )
                    local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2;
                    deduped_6_2 := alpha_1[logic_new_func_x_2 - hoisted_2_1];
                    deduped_5_2 := MorphismMatrix( deduped_6_2 );
                    hoisted_4_2 := [ 1 .. Length( ObjectList( Range( deduped_6_2 ) ) ) ];
                    hoisted_3_2 := List( deduped_5_2, function ( logic_new_func_list_3 )
                            return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                        end );
                    hoisted_2_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                            return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                                    return VertexIndex( UnderlyingVertex( Range( logic_new_func_x_4 ) ) );
                                end );
                        end );
                    hoisted_1_2 := List( deduped_5_2, function ( logic_new_func_x_3 )
                            return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                                    return VertexIndex( UnderlyingVertex( Source( logic_new_func_x_4 ) ) );
                                end );
                        end );
                    return UnionOfColumns( hoisted_6_1, 1, List( [ 1 .. Length( ObjectList( Source( deduped_6_2 ) ) ) ], function ( logic_new_func_x_3 )
                              local hoisted_1_3, hoisted_2_3, hoisted_3_3;
                              hoisted_3_3 := hoisted_3_2[logic_new_func_x_3];
                              hoisted_2_3 := hoisted_2_2[logic_new_func_x_3];
                              hoisted_1_3 := hoisted_1_2[logic_new_func_x_3];
                              return UnionOfColumns( hoisted_6_1, 1, List( hoisted_4_2, function ( logic_new_func_x_4 )
                                        local deduped_1_4, deduped_2_4, deduped_3_4;
                                        deduped_3_4 := hoisted_2_3[logic_new_func_x_4];
                                        deduped_2_4 := hoisted_1_3[logic_new_func_x_4];
                                        deduped_1_4 := hoisted_5_1[deduped_2_4][deduped_3_4];
                                        if deduped_1_4 = 0 then
                                            return HomalgZeroMatrix( 1, deduped_1_4, hoisted_6_1 );
                                        else
                                            return HomalgMatrixListList( [ CoefficientsOfPaths( hoisted_7_1[deduped_2_4][deduped_3_4], hoisted_3_3[logic_new_func_x_4] ) ], 1, deduped_1_4, hoisted_6_1 );
                                        fi;
                                        return;
                                    end ) );
                          end ) );
                end ) ], function ( source_2, row_2 )
              return UnionOfColumns( hoisted_6_1, Dimension( source_2 ), row_2 );
          end ) );
    hoisted_12_1 := deduped_22_1;
    hoisted_11_1 := ZeroImmutable( UnderlyingQuiverAlgebra( deduped_19_1 ) );
    hoisted_10_1 := deduped_19_1;
    hoisted_9_1 := deduped_16_1;
    hoisted_8_1 := deduped_20_1;
    hoisted_1_1 := deduped_18_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, DegreeOfDgComplexMorphism, deduped_21_1, Morphisms, AsZFunction( function ( i_2 )
              local morphism_attr_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
              if i_2 >= 0 and i_2 <= hoisted_1_1 then
                  morphism_attr_1_2 := hoisted_13_1;
                  return [ CreateCapCategoryMorphismWithAttributes( hoisted_8_1, hoisted_9_1, CreateCapCategoryObjectWithAttributes( hoisted_8_1, Dimension, NumberColumns( morphism_attr_1_2 ) ), UnderlyingMatrix, morphism_attr_1_2 ) ][i_2 - 0 + 1];
              else
                  deduped_8_2 := source_1[i_2];
                  deduped_7_2 := ObjectList( deduped_8_2 );
                  deduped_6_2 := range_1[i_2 + hoisted_2_1];
                  deduped_5_2 := ObjectList( deduped_6_2 );
                  hoisted_4_2 := [ 1 .. Length( deduped_5_2 ) ];
                  hoisted_3_2 := deduped_5_2;
                  hoisted_2_2 := deduped_7_2;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_12_1, deduped_8_2, deduped_6_2, MorphismMatrix, List( [ 1 .. Length( deduped_7_2 ) ], function ( i_3 )
                            local hoisted_1_3;
                            hoisted_1_3 := hoisted_2_2[i_3];
                            return List( hoisted_4_2, function ( j_4 )
                                    return CreateCapCategoryMorphismWithAttributes( hoisted_10_1, hoisted_1_3, hoisted_3_2[j_4], UnderlyingQuiverAlgebraElement, hoisted_11_1 );
                                end );
                        end ) );
              fi;
              return;
          end ), LowerBoundOfDgComplexMorphism, 0, UpperBoundOfDgComplexMorphism, deduped_18_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, hoisted_13_1, hoisted_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1;
    deduped_24_1 := UnderlyingCategory( cat_1 );
    deduped_23_1 := DegreeOfDgComplexMorphism( arg4_1 );
    deduped_22_1 := UnderlyingCategory( deduped_24_1 );
    deduped_21_1 := BasisPathsByVertexIndex( deduped_22_1 );
    deduped_20_1 := UnderlyingQuiverAlgebra( deduped_22_1 );
    deduped_19_1 := [ Maximum( LowerBoundOfDgComplex( arg3_1 ), LowerBoundOfDgComplex( arg2_1 ) + deduped_23_1 ) .. Minimum( UpperBoundOfDgComplex( arg3_1 ), UpperBoundOfDgComplex( arg2_1 ) + deduped_23_1 ) ];
    deduped_18_1 := Length( deduped_19_1 );
    deduped_17_1 := [ 1 .. deduped_18_1 ];
    deduped_16_1 := deduped_19_1[1] - deduped_23_1;
    deduped_15_1 := deduped_16_1 + Length( deduped_17_1 ) - 1;
    hoisted_14_1 := ZeroImmutable( deduped_20_1 );
    hoisted_12_1 := deduped_24_1;
    hoisted_11_1 := deduped_22_1;
    hoisted_10_1 := deduped_20_1;
    hoisted_9_1 := deduped_21_1;
    hoisted_8_1 := UnderlyingMatrix( arg4_1[0] );
    hoisted_7_1 := deduped_18_1;
    hoisted_6_1 := UnderlyingRing( RangeCategoryOfHomomorphismStructure( deduped_24_1 ) );
    hoisted_4_1 := List( deduped_21_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, Length );
        end );
    hoisted_3_1 := deduped_23_1;
    hoisted_5_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local hoisted_1_2;
            hoisted_1_2 := ObjectList( arg3_1[logic_new_func_x_2] );
            return Sum( Concatenation( List( ObjectList( arg2_1[logic_new_func_x_2 - hoisted_3_1] ), function ( logic_new_func_x_3 )
                        local hoisted_1_3;
                        hoisted_1_3 := hoisted_4_1[VertexIndex( UnderlyingVertex( logic_new_func_x_3 ) )];
                        return List( hoisted_1_2, function ( logic_new_func_x_4 )
                                return hoisted_1_3[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                            end );
                    end ) ) );
        end );
    hoisted_13_1 := ListN( deduped_17_1, deduped_19_1, function ( i_2, j_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, hoisted_5_2, hoisted_6_2, hoisted_7_2, hoisted_8_2, hoisted_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2;
            deduped_16_2 := hoisted_5_1[i_2];
            deduped_15_2 := arg3_1[j_2];
            deduped_14_2 := ObjectList( deduped_15_2 );
            deduped_13_2 := arg2_1[j_2 - hoisted_3_1];
            deduped_12_2 := Length( deduped_14_2 );
            deduped_11_2 := ObjectList( deduped_13_2 );
            deduped_10_2 := [ 1 .. Length( deduped_11_2 ) ];
            hoisted_9_2 := List( deduped_14_2, function ( logic_new_func_x_3 )
                    return VertexIndex( UnderlyingVertex( logic_new_func_x_3 ) );
                end );
            hoisted_8_2 := List( deduped_11_2, function ( logic_new_func_x_3 )
                    return VertexIndex( UnderlyingVertex( logic_new_func_x_3 ) );
                end );
            hoisted_6_2 := [ 1 .. deduped_12_2 ];
            hoisted_5_2 := hoisted_8_1 * UnionOfRows( HomalgZeroMatrix( Sum( hoisted_5_1{[ 1 .. (i_2 - 1) ]} ), deduped_16_2, hoisted_6_1 ), HomalgIdentityMatrix( deduped_16_2, hoisted_6_1 ), HomalgZeroMatrix( Sum( hoisted_5_1{[ (i_2 + 1) .. hoisted_7_1 ]} ), deduped_16_2, hoisted_6_1 ) );
            hoisted_2_2 := deduped_14_2;
            hoisted_4_2 := Concatenation( List( deduped_11_2, function ( logic_new_func_x_3 )
                      local hoisted_1_3;
                      hoisted_1_3 := hoisted_4_1[VertexIndex( UnderlyingVertex( logic_new_func_x_3 ) )];
                      return List( hoisted_2_2, function ( logic_new_func_x_4 )
                              return hoisted_1_3[VertexIndex( UnderlyingVertex( logic_new_func_x_4 ) )];
                          end );
                  end ) );
            hoisted_3_2 := deduped_12_2;
            hoisted_7_2 := List( deduped_10_2, function ( logic_new_func_x_3 )
                    local hoisted_1_3;
                    hoisted_1_3 := hoisted_3_2 * (logic_new_func_x_3 - 1);
                    return List( hoisted_6_2, function ( logic_new_func_x_4 )
                            local deduped_1_4, deduped_2_4;
                            deduped_2_4 := hoisted_1_3 + logic_new_func_x_4;
                            deduped_1_4 := Sum( hoisted_4_2{[ 1 .. deduped_2_4 - 1 ]} ) + 1;
                            return EntriesOfHomalgMatrixAsListList( CertainColumns( hoisted_5_2, [ deduped_1_4 .. deduped_1_4 - 1 + hoisted_4_2[deduped_2_4] ] ) );
                        end );
                end );
            hoisted_1_2 := deduped_11_2;
            return CreateCapCategoryMorphismWithAttributes( hoisted_12_1, deduped_13_2, deduped_15_2, MorphismMatrix, List( deduped_10_2, function ( i_3 )
                      local hoisted_1_3, hoisted_2_3, hoisted_3_3;
                      hoisted_3_3 := hoisted_1_2[i_3];
                      hoisted_2_3 := hoisted_9_1[hoisted_8_2[i_3]];
                      hoisted_1_3 := hoisted_7_2[i_3];
                      return List( hoisted_6_2, function ( j_4 )
                              return CreateCapCategoryMorphismWithAttributes( hoisted_11_1, hoisted_3_3, hoisted_2_2[j_4], UnderlyingQuiverAlgebraElement, QuiverAlgebraElement( hoisted_10_1, hoisted_1_3[j_4][1], hoisted_2_3[hoisted_9_2[j_4]] ) );
                          end );
                  end ) );
        end );
    hoisted_2_1 := deduped_15_1;
    hoisted_1_1 := deduped_16_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, DegreeOfDgComplexMorphism, deduped_23_1, Morphisms, AsZFunction( function ( i_2 )
              local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2;
              if i_2 >= hoisted_1_1 and i_2 <= hoisted_2_1 then
                  return hoisted_13_1[i_2 - hoisted_1_1 + 1];
              else
                  deduped_7_2 := arg2_1[i_2];
                  deduped_6_2 := ObjectList( deduped_7_2 );
                  deduped_5_2 := arg3_1[i_2 + hoisted_3_1];
                  deduped_4_2 := ObjectList( deduped_5_2 );
                  hoisted_3_2 := [ 1 .. Length( deduped_4_2 ) ];
                  hoisted_2_2 := deduped_4_2;
                  hoisted_1_2 := deduped_6_2;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_12_1, deduped_7_2, deduped_5_2, MorphismMatrix, List( [ 1 .. Length( deduped_6_2 ) ], function ( i_3 )
                            local hoisted_1_3;
                            hoisted_1_3 := hoisted_1_2[i_3];
                            return List( hoisted_3_2, function ( j_4 )
                                    return CreateCapCategoryMorphismWithAttributes( hoisted_11_1, hoisted_1_3, hoisted_2_2[j_4], UnderlyingQuiverAlgebraElement, hoisted_14_1 );
                                end );
                        end ) );
              fi;
              return;
          end ), LowerBoundOfDgComplexMorphism, deduped_16_1, UpperBoundOfDgComplexMorphism, deduped_15_1 );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return DegreeOfDgComplexMorphism( arg2_1 ) = DegreeOfDgComplexMorphism( arg3_1 ) and ForAll( [ Minimum( LowerBoundOfDgComplexMorphism( arg2_1 ), LowerBoundOfDgComplexMorphism( arg3_1 ) ) .. Maximum( UpperBoundOfDgComplexMorphism( arg2_1 ), UpperBoundOfDgComplexMorphism( arg3_1 ) ) ], function ( i_2 )
              local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2;
              deduped_7_2 := arg3_1[i_2];
              deduped_6_2 := arg2_1[i_2];
              deduped_5_2 := Length( ObjectList( Range( deduped_6_2 ) ) );
              deduped_4_2 := Length( ObjectList( Source( deduped_6_2 ) ) );
              if deduped_4_2 <> Length( ObjectList( Source( deduped_7_2 ) ) ) then
                  return false;
              elif deduped_5_2 <> Length( ObjectList( Range( deduped_7_2 ) ) ) then
                  return false;
              elif (deduped_4_2 = 0 or deduped_5_2 = 0) then
                  return true;
              else
                  hoisted_3_2 := [ 1 .. deduped_5_2 ];
                  hoisted_2_2 := List( MorphismMatrix( deduped_7_2 ), function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  hoisted_1_2 := List( MorphismMatrix( deduped_6_2 ), function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  return ForAll( [ 1 .. deduped_4_2 ], function ( i_3 )
                          local hoisted_1_3, hoisted_2_3;
                          hoisted_2_3 := hoisted_2_2[i_3];
                          hoisted_1_3 := hoisted_1_2[i_3];
                          return ForAll( hoisted_3_2, function ( j_4 )
                                  return hoisted_1_3[j_4] = hoisted_2_3[j_4];
                              end );
                      end );
              fi;
              return;
          end );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return DegreeOfDgComplexMorphism( arg2_1 ) = DegreeOfDgComplexMorphism( arg3_1 ) and ForAll( [ Minimum( LowerBoundOfDgComplexMorphism( arg2_1 ), LowerBoundOfDgComplexMorphism( arg3_1 ) ) .. Maximum( UpperBoundOfDgComplexMorphism( arg2_1 ), UpperBoundOfDgComplexMorphism( arg3_1 ) ) ], function ( i_2 )
              local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2;
              deduped_7_2 := arg3_1[i_2];
              deduped_6_2 := arg2_1[i_2];
              deduped_5_2 := Length( ObjectList( Range( deduped_6_2 ) ) );
              deduped_4_2 := Length( ObjectList( Source( deduped_6_2 ) ) );
              if deduped_4_2 <> Length( ObjectList( Source( deduped_7_2 ) ) ) then
                  return false;
              elif deduped_5_2 <> Length( ObjectList( Range( deduped_7_2 ) ) ) then
                  return false;
              elif (deduped_4_2 = 0 or deduped_5_2 = 0) then
                  return true;
              else
                  hoisted_3_2 := [ 1 .. deduped_5_2 ];
                  hoisted_2_2 := List( MorphismMatrix( deduped_7_2 ), function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  hoisted_1_2 := List( MorphismMatrix( deduped_6_2 ), function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  return ForAll( [ 1 .. deduped_4_2 ], function ( i_3 )
                          local hoisted_1_3, hoisted_2_3;
                          hoisted_2_3 := hoisted_2_2[i_3];
                          hoisted_1_3 := hoisted_1_2[i_3];
                          return ForAll( hoisted_3_2, function ( j_4 )
                                  return hoisted_1_3[j_4] = hoisted_2_3[j_4];
                              end );
                      end );
              fi;
              return;
          end );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ForAll( [ Minimum( LowerBoundOfDgComplex( arg2_1 ), LowerBoundOfDgComplex( arg3_1 ) ) .. Maximum( UpperBoundOfDgComplex( arg2_1 ), UpperBoundOfDgComplex( arg3_1 ) ) ], function ( i_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, hoisted_5_2, hoisted_6_2, hoisted_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2, deduped_17_2, deduped_18_2, deduped_19_2;
            deduped_19_2 := arg3_1 ^ i_2;
            deduped_18_2 := arg2_1 ^ i_2;
            deduped_17_2 := ObjectList( Range( deduped_19_2 ) );
            deduped_16_2 := ObjectList( Range( deduped_18_2 ) );
            deduped_15_2 := ObjectList( Source( deduped_19_2 ) );
            deduped_14_2 := ObjectList( Source( deduped_18_2 ) );
            deduped_13_2 := Length( deduped_16_2 );
            deduped_12_2 := Length( deduped_14_2 );
            deduped_11_2 := [ 1 .. deduped_13_2 ];
            deduped_10_2 := [ 1 .. deduped_12_2 ];
            deduped_9_2 := deduped_13_2 <> Length( deduped_17_2 );
            deduped_8_2 := deduped_12_2 <> Length( deduped_15_2 );
            hoisted_4_2 := List( deduped_17_2, UnderlyingVertex );
            hoisted_3_2 := List( deduped_16_2, UnderlyingVertex );
            hoisted_2_2 := List( deduped_15_2, UnderlyingVertex );
            hoisted_1_2 := List( deduped_14_2, UnderlyingVertex );
            if function (  )
                        if deduped_8_2 then
                            return false;
                        else
                            return ForAll( deduped_10_2, function ( i_4 )
                                    return hoisted_1_2[i_4] = hoisted_2_2[i_4];
                                end );
                        fi;
                        return;
                    end(  ) and function (  )
                        if deduped_9_2 then
                            return false;
                        else
                            return ForAll( deduped_11_2, function ( i_4 )
                                    return hoisted_3_2[i_4] = hoisted_4_2[i_4];
                                end );
                        fi;
                        return;
                    end(  ) then
                hoisted_7_2 := deduped_11_2;
                hoisted_6_2 := List( MorphismMatrix( deduped_19_2 ), function ( logic_new_func_list_3 )
                        return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                    end );
                hoisted_5_2 := List( MorphismMatrix( deduped_18_2 ), function ( logic_new_func_list_3 )
                        return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                    end );
                return function (  )
                        if deduped_8_2 then
                            return false;
                        elif deduped_9_2 then
                            return false;
                        elif deduped_12_2 = 0 or deduped_13_2 = 0 then
                            return true;
                        else
                            return ForAll( deduped_10_2, function ( i_4 )
                                    local hoisted_1_4, hoisted_2_4;
                                    hoisted_2_4 := hoisted_6_2[i_4];
                                    hoisted_1_4 := hoisted_5_2[i_4];
                                    return ForAll( hoisted_7_2, function ( j_5 )
                                            return hoisted_1_4[j_5] = hoisted_2_4[j_5];
                                        end );
                                end );
                        fi;
                        return;
                    end(  );
            else
                return false;
            fi;
            return;
        end );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Range( arg2_1 );
    deduped_7_1 := Source( arg2_1 );
    deduped_6_1 := UnderlyingCategory( UnderlyingCategory( cat_1 ) );
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := DegreeOfDgComplexMorphism( arg2_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := UnderlyingQuiverAlgebra( deduped_6_1 );
    hoisted_1_1 := deduped_6_1;
    return ForAll( [ Minimum( LowerBoundOfDgComplex( deduped_7_1 ), LowerBoundOfDgComplex( deduped_8_1 ) ) .. Maximum( UpperBoundOfDgComplex( deduped_7_1 ), UpperBoundOfDgComplex( deduped_8_1 ) ) ], function ( i_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, hoisted_5_2, hoisted_6_2, hoisted_7_2, hoisted_8_2, hoisted_9_2, hoisted_10_2, hoisted_11_2, hoisted_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2, deduped_17_2, deduped_18_2, deduped_19_2, deduped_20_2, deduped_21_2, deduped_22_2;
            deduped_22_2 := arg2_1[i_2];
            deduped_21_2 := ObjectList( hoisted_3_1[i_2] );
            deduped_20_2 := MorphismMatrix( deduped_22_2 );
            deduped_19_2 := ObjectList( hoisted_5_1[i_2 + hoisted_4_1] );
            deduped_18_2 := ObjectList( Range( deduped_22_2 ) );
            deduped_17_2 := ObjectList( Source( deduped_22_2 ) );
            deduped_16_2 := Length( deduped_18_2 );
            deduped_15_2 := Length( deduped_17_2 );
            deduped_14_2 := [ 1 .. deduped_16_2 ];
            deduped_13_2 := [ 1 .. deduped_15_2 ];
            hoisted_12_2 := List( deduped_19_2, UnderlyingVertex );
            hoisted_11_2 := List( deduped_21_2, UnderlyingVertex );
            hoisted_10_2 := List( deduped_18_2, UnderlyingVertex );
            hoisted_9_2 := List( deduped_17_2, UnderlyingVertex );
            hoisted_8_2 := deduped_14_2;
            hoisted_7_2 := List( deduped_20_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return UnderlyingVertex( Range( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_6_2 := List( deduped_20_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return UnderlyingVertex( Source( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_5_2 := List( deduped_20_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return Paths( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_4_2 := List( deduped_20_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_3_2 := List( deduped_20_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return AlgebraOfElement( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_2_2 := List( deduped_20_2, function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, CapCategory );
                end );
            hoisted_1_2 := List( deduped_20_2, function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, IsCapCategoryMorphism );
                end );
            return function (  )
                        if IsMatrixObj( deduped_20_2 ) and not (deduped_15_2 = NumberRows( deduped_20_2 ) and deduped_16_2 = NumberColumns( deduped_20_2 )) then
                            return false;
                        elif not ForAll( deduped_13_2, function ( i_4 )
                                     local hoisted_1_4, hoisted_2_4, hoisted_3_4, hoisted_4_4, hoisted_5_4, hoisted_6_4, hoisted_7_4;
                                     hoisted_7_4 := hoisted_7_2[i_4];
                                     hoisted_6_4 := hoisted_6_2[i_4];
                                     hoisted_5_4 := hoisted_5_2[i_4];
                                     hoisted_4_4 := hoisted_4_2[i_4];
                                     hoisted_3_4 := hoisted_3_2[i_4];
                                     hoisted_2_4 := hoisted_2_2[i_4];
                                     hoisted_1_4 := hoisted_1_2[i_4];
                                     return ForAll( hoisted_8_2, function ( j_5 )
                                             local hoisted_1_5, hoisted_2_5, deduped_3_5;
                                             deduped_3_5 := hoisted_5_4[j_5];
                                             hoisted_2_5 := hoisted_7_4[j_5];
                                             hoisted_1_5 := hoisted_6_4[j_5];
                                             return (hoisted_1_4[j_5] and IS_IDENTICAL_OBJ( hoisted_1_1, hoisted_2_4[j_5] ) and function (  )
                                                       if not IS_IDENTICAL_OBJ( hoisted_3_4[j_5], hoisted_2_1 ) then
                                                           return false;
                                                       elif hoisted_4_4[j_5] then
                                                           return true;
                                                       elif not ForAll( deduped_3_5, function ( p_7 )
                                                                    return hoisted_1_5 = Source( p_7 );
                                                                end ) then
                                                           return false;
                                                       elif not ForAll( deduped_3_5, function ( p_7 )
                                                                    return hoisted_2_5 = Target( p_7 );
                                                                end ) then
                                                           return false;
                                                       else
                                                           return true;
                                                       fi;
                                                       return;
                                                   end(  ));
                                         end );
                                 end ) then
                            return false;
                        elif not ForAll( deduped_13_2, function ( i_4 )
                                     local hoisted_1_4, hoisted_2_4, hoisted_3_4;
                                     hoisted_3_4 := hoisted_7_2[i_4];
                                     hoisted_2_4 := hoisted_9_2[i_4];
                                     hoisted_1_4 := hoisted_6_2[i_4];
                                     return ForAll( hoisted_8_2, function ( j_5 )
                                             return (hoisted_1_4[j_5] = hoisted_2_4 and hoisted_3_4[j_5] = hoisted_10_2[j_5]);
                                         end );
                                 end ) then
                            return false;
                        else
                            return true;
                        fi;
                        return;
                    end(  ) and function (  )
                        if deduped_15_2 <> Length( deduped_21_2 ) then
                            return false;
                        else
                            return ForAll( deduped_13_2, function ( i_4 )
                                    return hoisted_9_2[i_4] = hoisted_11_2[i_4];
                                end );
                        fi;
                        return;
                    end(  ) and function (  )
                      if deduped_16_2 <> Length( deduped_19_2 ) then
                          return false;
                      else
                          return ForAll( deduped_14_2, function ( i_4 )
                                  return hoisted_10_2[i_4] = hoisted_12_2[i_4];
                              end );
                      fi;
                      return;
                  end(  );
        end );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingCategory( UnderlyingCategory( cat_1 ) );
    hoisted_2_1 := UnderlyingQuiverAlgebra( deduped_3_1 );
    hoisted_1_1 := deduped_3_1;
    return ForAll( [ LowerBoundOfDgComplex( arg2_1 ) .. UpperBoundOfDgComplex( arg2_1 ) ], function ( i_2 )
            local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, hoisted_5_2, hoisted_6_2, hoisted_7_2, hoisted_8_2, hoisted_9_2, hoisted_10_2, hoisted_11_2, hoisted_12_2, hoisted_13_2, hoisted_14_2, hoisted_15_2, hoisted_16_2, hoisted_17_2, deduped_18_2, deduped_19_2, deduped_20_2, deduped_21_2, deduped_22_2, deduped_23_2, deduped_24_2, deduped_25_2, deduped_26_2;
            deduped_26_2 := arg2_1 ^ i_2;
            deduped_25_2 := arg2_1 ^ (i_2 + 1);
            deduped_24_2 := MorphismMatrix( deduped_26_2 );
            deduped_23_2 := ObjectList( Range( deduped_26_2 ) );
            deduped_22_2 := ObjectList( Source( deduped_26_2 ) );
            deduped_21_2 := Length( deduped_23_2 );
            deduped_20_2 := Length( deduped_22_2 );
            deduped_19_2 := [ 1 .. deduped_20_2 ];
            deduped_18_2 := [ 1 .. Length( ObjectList( Range( deduped_25_2 ) ) ) ];
            hoisted_16_2 := deduped_18_2;
            hoisted_15_2 := List( MorphismMatrix( deduped_25_2 ), function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                end );
            hoisted_14_2 := List( deduped_24_2, function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                end );
            hoisted_8_2 := [ 1 .. deduped_21_2 ];
            hoisted_17_2 := List( deduped_19_2, function ( logic_new_func_x_3 )
                    local hoisted_1_3;
                    hoisted_1_3 := hoisted_14_2[logic_new_func_x_3];
                    return List( hoisted_16_2, function ( logic_new_func_x_4 )
                            return IsZero( Iterated( List( hoisted_8_2, function ( logic_new_func_x_5 )
                                        return hoisted_1_3[logic_new_func_x_5] * hoisted_15_2[logic_new_func_x_5][logic_new_func_x_4];
                                    end ), function ( alpha_5, beta_5 )
                                      return alpha_5 + beta_5;
                                  end ) );
                        end );
                end );
            hoisted_13_2 := ForAny( [ deduped_21_2, Length( ObjectList( Source( deduped_25_2 ) ) ) ], IsZero );
            hoisted_11_2 := List( deduped_18_2, function ( logic_new_func_x_3 )
                    return true;
                end );
            hoisted_12_2 := List( deduped_19_2, function ( logic_new_func_x_3 )
                    return hoisted_11_2;
                end );
            hoisted_10_2 := List( deduped_23_2, UnderlyingVertex );
            hoisted_9_2 := List( deduped_22_2, UnderlyingVertex );
            hoisted_7_2 := List( deduped_24_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return UnderlyingVertex( Range( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_6_2 := List( deduped_24_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return UnderlyingVertex( Source( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_5_2 := List( deduped_24_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return Paths( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_4_2 := List( deduped_24_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return IsZero( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_3_2 := List( deduped_24_2, function ( logic_new_func_x_3 )
                    return List( logic_new_func_x_3, function ( logic_new_func_x_4 )
                            return AlgebraOfElement( UnderlyingQuiverAlgebraElement( logic_new_func_x_4 ) );
                        end );
                end );
            hoisted_2_2 := List( deduped_24_2, function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, CapCategory );
                end );
            hoisted_1_2 := List( deduped_24_2, function ( logic_new_func_list_3 )
                    return List( logic_new_func_list_3, IsCapCategoryMorphism );
                end );
            return function (  )
                      if IsMatrixObj( deduped_24_2 ) and not (deduped_20_2 = NumberRows( deduped_24_2 ) and deduped_21_2 = NumberColumns( deduped_24_2 )) then
                          return false;
                      elif not ForAll( deduped_19_2, function ( i_4 )
                                   local hoisted_1_4, hoisted_2_4, hoisted_3_4, hoisted_4_4, hoisted_5_4, hoisted_6_4, hoisted_7_4;
                                   hoisted_7_4 := hoisted_7_2[i_4];
                                   hoisted_6_4 := hoisted_6_2[i_4];
                                   hoisted_5_4 := hoisted_5_2[i_4];
                                   hoisted_4_4 := hoisted_4_2[i_4];
                                   hoisted_3_4 := hoisted_3_2[i_4];
                                   hoisted_2_4 := hoisted_2_2[i_4];
                                   hoisted_1_4 := hoisted_1_2[i_4];
                                   return ForAll( hoisted_8_2, function ( j_5 )
                                           local hoisted_1_5, hoisted_2_5, deduped_3_5;
                                           deduped_3_5 := hoisted_5_4[j_5];
                                           hoisted_2_5 := hoisted_7_4[j_5];
                                           hoisted_1_5 := hoisted_6_4[j_5];
                                           return (hoisted_1_4[j_5] and IS_IDENTICAL_OBJ( hoisted_1_1, hoisted_2_4[j_5] ) and function (  )
                                                     if not IS_IDENTICAL_OBJ( hoisted_3_4[j_5], hoisted_2_1 ) then
                                                         return false;
                                                     elif hoisted_4_4[j_5] then
                                                         return true;
                                                     elif not ForAll( deduped_3_5, function ( p_7 )
                                                                  return hoisted_1_5 = Source( p_7 );
                                                              end ) then
                                                         return false;
                                                     elif not ForAll( deduped_3_5, function ( p_7 )
                                                                  return hoisted_2_5 = Target( p_7 );
                                                              end ) then
                                                         return false;
                                                     else
                                                         return true;
                                                     fi;
                                                     return;
                                                 end(  ));
                                       end );
                               end ) then
                          return false;
                      elif not ForAll( deduped_19_2, function ( i_4 )
                                   local hoisted_1_4, hoisted_2_4, hoisted_3_4;
                                   hoisted_3_4 := hoisted_7_2[i_4];
                                   hoisted_2_4 := hoisted_9_2[i_4];
                                   hoisted_1_4 := hoisted_6_2[i_4];
                                   return ForAll( hoisted_8_2, function ( j_5 )
                                           return (hoisted_1_4[j_5] = hoisted_2_4 and hoisted_3_4[j_5] = hoisted_10_2[j_5]);
                                       end );
                               end ) then
                          return false;
                      else
                          return true;
                      fi;
                      return;
                  end(  ) and ForAll( deduped_19_2, function ( i_3 )
                      local hoisted_1_3, hoisted_2_3;
                      hoisted_2_3 := hoisted_17_2[i_3];
                      hoisted_1_3 := hoisted_12_2[i_3];
                      return ForAll( hoisted_16_2, function ( j_4 )
                              if hoisted_13_2 then
                                  return hoisted_1_3[j_4];
                              else
                                  return hoisted_2_3[j_4];
                              fi;
                              return;
                          end );
                  end );
        end );
end
########
        
    , 100 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingCategory( cat_1 );
    deduped_6_1 := DegreeOfDgComplexMorphism( alpha_1 );
    deduped_5_1 := UnderlyingCategory( deduped_7_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := ZeroImmutable( UnderlyingQuiverAlgebra( deduped_5_1 ) );
    hoisted_2_1 := deduped_5_1;
    hoisted_1_1 := deduped_6_1;
    return DgCochainComplexMorphism( Source( alpha_1 ), Range( beta_1 ), deduped_6_1 + DegreeOfDgComplexMorphism( beta_1 ), AsZFunction( function ( i_2 )
              local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, hoisted_5_2, hoisted_6_2, hoisted_7_2, hoisted_8_2, hoisted_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2, deduped_17_2, deduped_18_2, deduped_19_2, deduped_20_2, deduped_21_2;
              deduped_21_2 := alpha_1[i_2];
              deduped_19_2 := Source( deduped_21_2 );
              deduped_18_2 := beta_1[i_2 + hoisted_1_1];
              deduped_16_2 := ObjectList( deduped_19_2 );
              deduped_15_2 := Range( deduped_18_2 );
              deduped_14_2 := ObjectList( deduped_15_2 );
              deduped_13_2 := Length( ObjectList( Range( deduped_21_2 ) ) );
              deduped_11_2 := [ 1 .. Length( deduped_16_2 ) ];
              hoisted_3_2 := [ 1 .. Length( deduped_14_2 ) ];
              if ForAny( [ deduped_13_2, Length( ObjectList( Source( deduped_18_2 ) ) ) ], IsZero ) then
                  hoisted_2_2 := deduped_14_2;
                  hoisted_1_2 := deduped_16_2;
                  return CreateCapCategoryMorphismWithAttributes( hoisted_4_1, deduped_19_2, deduped_15_2, MorphismMatrix, List( deduped_11_2, function ( i_3 )
                            local hoisted_1_3;
                            hoisted_1_3 := hoisted_1_2[i_3];
                            return List( hoisted_3_2, function ( j_4 )
                                    return CreateCapCategoryMorphismWithAttributes( hoisted_2_1, hoisted_1_3, hoisted_2_2[j_4], UnderlyingQuiverAlgebraElement, hoisted_3_1 );
                                end );
                        end ) );
              else
                  deduped_20_2 := MorphismMatrix( deduped_21_2 );
                  deduped_17_2 := MorphismMatrix( deduped_18_2 );
                  deduped_12_2 := [ 1 .. deduped_13_2 ];
                  deduped_10_2 := CAP_JIT_INCOMPLETE_LOGIC( deduped_12_2[1] );
                  hoisted_9_2 := deduped_12_2;
                  hoisted_8_2 := List( deduped_17_2, function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  hoisted_7_2 := List( deduped_20_2, function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, UnderlyingQuiverAlgebraElement );
                      end );
                  hoisted_6_2 := List( CAP_JIT_INCOMPLETE_LOGIC( deduped_17_2[deduped_10_2] ), Range );
                  hoisted_5_2 := deduped_10_2;
                  hoisted_4_2 := List( deduped_20_2, function ( logic_new_func_list_3 )
                          return List( logic_new_func_list_3, Source );
                      end );
                  return CreateCapCategoryMorphismWithAttributes( hoisted_4_1, deduped_19_2, deduped_15_2, MorphismMatrix, List( deduped_11_2, function ( i_3 )
                            local hoisted_1_3, hoisted_2_3;
                            hoisted_2_3 := hoisted_4_2[i_3][hoisted_5_2];
                            hoisted_1_3 := hoisted_7_2[i_3];
                            return List( hoisted_3_2, function ( j_4 )
                                    return CreateCapCategoryMorphismWithAttributes( hoisted_2_1, hoisted_2_3, hoisted_6_2[j_4], UnderlyingQuiverAlgebraElement, Iterated( List( hoisted_9_2, function ( logic_new_func_x_5 )
                                                return hoisted_1_3[logic_new_func_x_5] * hoisted_8_2[logic_new_func_x_5][j_4];
                                            end ), function ( alpha_5, beta_5 )
                                              return alpha_5 + beta_5;
                                          end ) );
                                end );
                        end ) );
              fi;
              return;
          end ) );
end
########
        
    , 100 );
    
end );

BindGlobal( "CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled", function ( Q, F )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( Q, F )
    return DgComplexesOfAdditiveClosureOfAlgebroid( Algebroid( F, CategoryOfRows( Q : FinalizeCategory := true ) : FinalizeCategory := true ) );
end;
        
        
    
    cat := category_constructor( Q, F : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
