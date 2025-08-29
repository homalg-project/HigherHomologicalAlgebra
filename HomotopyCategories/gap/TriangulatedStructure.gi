# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################

InstallGlobalFunction( ADD_FUNCTIONS_OF_TRIANGULATED_STRUCTURE_TO_HOMOTOPY_CATEGORY,

function ( homotopy_cat )
  local cat, complex_cat, sign;
  
  SetIsTriangulatedCategory( homotopy_cat, true );
  
  cat := DefiningCategory( homotopy_cat );
  
  complex_cat := AmbientCategory( homotopy_cat );
  
  if IsComplexesCategoryByChains( complex_cat ) then
      sign := -1;
  else
      sign := 1;
  fi;
  
  ##
  AddShiftOfObjectByInteger( homotopy_cat,
    function ( homotopy_cat, C, n )
      local objs, diffs;
      
      objs := ApplyShift( Objects( C ), sign * n );
      
      diffs := ApplyShift( ApplyMap( Differentials( C ), delta -> (-1)^n * delta ), sign * n );
      
      return CreateComplex( homotopy_cat, [ objs, diffs, LowerBound( C ) - n * sign, UpperBound( C ) - n * sign ] );
      
  end );
  
  ##
  AddShiftOfMorphismByIntegerWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, n, r )
      local morphisms;
      
      morphisms := ApplyShift( Morphisms( alpha ), sign * n );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ##
  AddStandardConeObject( homotopy_cat,
    function ( homotopy_cat, alpha )
      local B, C, objs, diffs;
      
      B := Source( alpha );
      C := Range( alpha );
      
      objs := AsZFunction( i -> DirectSum( cat, [ B[i+sign], C[i] ] ) );
      
      diffs := AsZFunction(
                  i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                          objs[i],
                          [ B[i+sign], C[i] ],
                          [ [ AdditiveInverseForMorphisms( cat, B^(i+sign) ), alpha[i+sign] ], [ ZeroMorphism( cat, C[i], B[i+2*sign] ), C^i ] ],
                          [ B[i+1+sign], C[i+1] ],
                          objs[i+1] ) );
      
      return CreateComplex( homotopy_cat, [ objs, diffs, Minimum( LowerBound( B ) - sign, LowerBound( C ) ), Maximum( UpperBound( B ) - sign, UpperBound( C ) ) ] );
      
  end );
  
  ##
  AddMorphismIntoStandardConeObjectWithGivenStandardConeObject( homotopy_cat,
    function ( homotopy_cat, alpha, standard_cone )
      local B, C, morphisms;
      
      B := Source( alpha );
      C := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
                              [ B[i+sign], C[i] ],
                              C[i],
                              [ ZeroMorphism( cat, C[i], B[i+sign] ), IdentityMorphism( cat, C[i] ) ],
                              standard_cone[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, C, morphisms, standard_cone );
      
  end );
  
  ##
  AddMorphismFromStandardConeObjectWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, standard_cone, alpha, r )
      local B, C, morphisms;
      
      B := Source( alpha );
      C := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
                              [ B[i+sign], C[i] ],
                              r[i], # equals to B[i+sign]
                              [ IdentityMorphism( cat, B[i+sign] ), ZeroMorphism( cat, C[i], B[i+sign] ) ],
                              standard_cone[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, standard_cone, morphisms, r );
      
  end );
  
  ##
  AddMorphismFromStandardConeObject( homotopy_cat,
    { homotopy_cat, alpha } -> MorphismFromStandardConeObjectWithGivenObjects( homotopy_cat,
                                          StandardConeObject( homotopy_cat, alpha ),
                                          alpha,
                                          ShiftOfObject( homotopy_cat, Source( alpha ) ) ) );

  #   A ----- α ----> B ----------> C(α) -----> ΣA
  #   |               |              |           |
  #   | μ             | ν            ?           | Σμ
  #   |               |              |           |
  #   v               v              v           v
  #   C ---- β -----> D ---------> C(β)  ----->  ΣC

  ##
  AddMorphismBetweenStandardConeObjectsWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, quadruple, r )
      local alpha, mu, nu, beta, w, morphisms;
      
      alpha := quadruple[1];
      mu := quadruple[2];
      nu := quadruple[3];
      beta := quadruple[4];
      
      w := WitnessForBeingHomotopicToZeroMorphism( SubtractionForMorphisms( homotopy_cat, PreCompose( homotopy_cat, alpha, nu ), PreCompose( homotopy_cat, mu, beta ) ) );
      
      morphisms := AsZFunction(
                      i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              s[i],
                              [ Source( alpha )[i+sign], Range( alpha )[i] ],
                              [ [ mu[i+sign]                                               , w[i+sign] ],
                                [ ZeroMorphism( cat, Source( nu )[i], Range( mu )[i+sign] ), nu[i]  ] ],
                              [ Source( beta )[i+sign], Range( beta )[i]   ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ##
  AddWitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, r )
      local A, B, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
                              [ B[i+sign], A[i+sign], B[i] ],
                              s[i], # is equal to A[i+sign]
                              [ AdditiveInverseForMorphisms( cat, alpha[i+sign] ), IdentityMorphism( cat, A[i+sign] ), ZeroMorphism( cat, A[i+sign], B[i] ) ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, r )
      local A, B, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
                              [ B[i+sign], A[i+sign], B[i] ],
                              r[i], # is equal to A[i+sign]
                              [ ZeroMorphism( cat, B[i+sign], A[i+sign] ), IdentityMorphism( cat, A[i+sign] ), ZeroMorphism( cat, B[i], A[i+sign] ) ],
                              s[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ##
  AddWitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, r )
      local A, B, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
                              [ A[i+sign], B[i], A[i] ],
                              s[i], # is equal to B[i]
                              [ ZeroMorphism( cat, B[i], A[i+sign] ), IdentityMorphism( cat, B[i] ), ZeroMorphism( cat, B[i], A[i] ) ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, r )
      local A, B, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      
      morphisms := AsZFunction(
                      i -> UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
                              [ A[i+sign], B[i], A[i] ],
                              r[i], # is equal to B[i]
                              [ ZeroMorphism( cat, A[i+sign], B[i] ), IdentityMorphism( cat, B[i] ), alpha[i] ],
                              s[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ##
  AddDomainMorphismByOctahedralAxiomWithGivenObjects( homotopy_cat,
    
    { homotopy_cat, s, alpha, beta, gamma, r } -> MorphismBetweenStandardConeObjectsWithGivenObjects( homotopy_cat,
                                                      s,
                                                      [ alpha, IdentityMorphism( homotopy_cat, Source( alpha ) ), beta, gamma ],
                                                      r ) );
  
  ##
  AddMorphismIntoConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
    function( homotopy_cat, s, alpha, beta, gamma, r )
      local A, B, C, w, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      C := Range( beta );
      
      w := WitnessForBeingHomotopicToZeroMorphism( SubtractionForMorphisms( homotopy_cat, PreCompose( homotopy_cat, alpha, beta ), gamma ) );
      
      morphisms := AsZFunction(
                      i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              s[i],
                              [ A[i+sign], C[i] ],
                              [ [ alpha[i+sign], -w[i+sign] ],
                                [ ZeroMorphism( cat, C[i], B[i+sign] ), IdentityMorphism( cat, C[i] ) ] ],
                              [ B[i+sign], C[i] ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ## Can be derived, but here is a direct implementation
  ##
  AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, beta, gamma, r )
      local A, B, C, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      C := Range( beta );
      
      morphisms := AsZFunction(
                      i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              s[i],
                              [ B[i+sign], C[i] ],
                              [ [ ZeroMorphism( cat, B[i+sign], A[i+2*sign] ), IdentityMorphism( cat, B[i+sign] ) ],
                                [ ZeroMorphism( cat, C[i], A[i+2*sign] ), ZeroMorphism( cat, C[i], B[i+sign] ) ] ],
                              [ A[i+2*sign], B[i+sign] ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
  ##
  AddWitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, beta, gamma, r )
      local A, B, C, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      C := Range( beta );
      
      morphisms := AsZFunction(
                      i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              s[i],
                              [ B[i+sign ], C[i] ],
                              [ [ ZeroMorphism( cat, B[i+sign ], A[i+2*sign] ), IdentityMorphism( cat, B[i+sign] ), ZeroMorphism( cat, B[i+sign], A[i+sign] ), ZeroMorphism( cat, B[i+sign], C[i] ) ],
                                [ ZeroMorphism( cat, C[i] , A[i+2*sign] ), ZeroMorphism( cat, C[i], B[i+sign] ), ZeroMorphism( cat, C[i], A[i+sign] ), IdentityMorphism( cat, C[i] )       ] ],
                              [ A[i+2*sign], B[i+sign], A[i+sign], C[i] ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
    function ( homotopy_cat, s, alpha, beta, gamma, r )
      local A, B, C, w, morphisms;
      
      A := Source( alpha );
      B := Range( alpha );
      C := Range( beta );
      
      w := WitnessForBeingHomotopicToZeroMorphism( SubtractionForMorphisms( homotopy_cat, PreCompose( homotopy_cat, alpha, beta ), gamma ) );
      
      morphisms := AsZFunction(
                      i -> MorphismBetweenDirectSumsWithGivenDirectSums(
                              s[i],
                              [ A[i+2*sign], B[i+sign], A[i+sign], C[i] ],
                              [ [ ZeroMorphism( cat, A[i+2*sign], B[i+sign] ), ZeroMorphism( cat, A[i+2*sign], C[i] ) ],
                                [ IdentityMorphism( cat, B[i+sign] ), ZeroMorphism( cat, B[i+sign], C[i] ) ],
                                [ alpha[i+sign], -w[i+sign] ],
                                [ ZeroMorphism( cat, C[i], B[i+sign] ), IdentityMorphism( cat, C[i] ) ] ],
                              [ B[i+sign], C[i] ],
                              r[i] ) );
      
      return CreateComplexMorphism( homotopy_cat, s, morphisms, r );
      
  end );
  
end );
