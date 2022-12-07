# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations

#
# Following Section 4.4. in https://dspace.ub.uni-siegen.de/handle/ubsi/2232
#

BindGlobal( "_complexes_DistinguishedObjectOfHomomorphismStructure",
  
  FunctionWithCache(
    function ( ch_cat )
      local cat, range_cat, ch_range_cat;
      
      cat := UnderlyingCategory( ch_cat );
      
      range_cat := RangeCategoryOfHomomorphismStructure( cat );
      
      ch_range_cat := ComplexesCategoryByCochains( range_cat );
      
      return CreateComplex( ch_range_cat, DistinguishedObjectOfHomomorphismStructure( cat ), 0 );
    
end ) );

BindGlobal( "_complexes_HomomorphismStructureOnObjects",
  function ( ch_cat, B, C )
    local cat, range_cat, ch_range_cat, l_B, l_C, u_B, u_C, diagrams, objs, diffs;
    
    cat := UnderlyingCategory( ch_cat );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    ch_range_cat := ComplexesCategoryByCochains( range_cat );
    
    l_B := LowerBound( B );
    u_B := UpperBound( B );
    
    l_C := LowerBound( C );
    u_C := UpperBound( C );
    
    diagrams := AsZFunction( n -> List( [ Maximum( l_C, l_B + n ) .. Minimum( u_C, u_B + n ) ], j -> HomomorphismStructureOnObjects( cat, B[j-n], C[j] ) ) );
    
    objs := ApplyMap( diagrams, diagram -> DirectSum( range_cat, diagram ) );
    
    diffs :=
        AsZFunction(
          function ( n )
            local l_BC, u_BC, p_BC, q_BC, diagram_S, diagram_R, matrix;
            
            l_BC := Maximum( l_C, l_B + n );
            u_BC := Minimum( u_C, u_B + n );
            
            p_BC := Maximum( l_C, l_B + n + 1 );
            q_BC := Minimum( u_C, u_B + n + 1 );
            
            diagram_S := diagrams[n];
            diagram_R := diagrams[n+1];
            
            matrix :=
                ListN( [ 1 .. u_BC - l_BC + 1 ], [ l_BC .. u_BC ],
                    { index_j, j } -> ListN( [ 1 .. q_BC - p_BC + 1 ], [ p_BC .. q_BC ],
                        function ( index_i, i )
                            
                            if i = j then
                                return HomomorphismStructureOnMorphismsWithGivenObjects( cat, diagram_S[index_j], B^(i-1-n), IdentityMorphism( cat, C[j] ), diagram_R[index_i] );
                            elif i = j + 1 then
                                return (-1)^(n+1) * HomomorphismStructureOnMorphismsWithGivenObjects( cat, diagram_S[index_j], IdentityMorphism( cat, B[j-n] ), C^j, diagram_R[index_i] );
                            else
                                return ZeroMorphism( range_cat, diagram_S[index_j], diagram_R[index_i] );
                            fi;
                            
                        end ) );
            
            return MorphismBetweenDirectSumsWithGivenDirectSums( range_cat, objs[n], diagram_S, matrix, diagram_R, objs[n+1] );
            
          end );
    
    return CreateComplex( ch_range_cat, objs, diffs, l_C - u_B, u_C - l_B );
    
end );
    
#     phi
# A -------> B
#
#
# D <------- C
#     psi
#
# returns a morphism H(phi,psi):H(B,C)->H(A,D)
    
BindGlobal( "_complexes_HomomorphismStructureOnMorphismsWithGivenObjects",
  
  function ( ch_cat, hom_BC, phi, psi, hom_AD )
    local cat, range_cat, ch_range_cat, A, B, C, D, l_phi, u_phi, l_psi, u_psi, l_A, u_A, l_B, u_B, l_C, u_C, l_D, u_D, morphisms;
    
    cat := UnderlyingCategory( ch_cat );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    ch_range_cat := ComplexesCategoryByCochains( range_cat );
    
    l_phi := LowerBound( phi );
    u_phi := UpperBound( phi );
    
    l_psi := LowerBound( psi );
    u_psi := UpperBound( psi );
    
    A := Source( phi );
    l_A := LowerBound( A );
    u_A := UpperBound( A );
    
    B := Range( phi );
    l_B := LowerBound( B );
    u_B := UpperBound( B );
    
    C := Source( psi );
    l_C := LowerBound( C );
    u_C := UpperBound( C );
    
    D := Range( psi );
    l_D := LowerBound( D );
    u_D := UpperBound( D );
    
    morphisms :=
        AsZFunction(
          function ( n )
            local l_BC, u_BC, l_AD, u_AD, diagram_S, diagram_R, matrix;
            
            l_BC := Maximum( l_C, l_B + n );
            u_BC := Minimum( u_C, u_B + n );
            
            l_AD := Maximum( l_D, l_A + n );
            u_AD := Minimum( u_D, u_A + n );
            
            if HasBaseZFunctions( Objects( hom_BC ) ) then
              diagram_S := BaseZFunctions( Objects( hom_BC ) )[1][n];
            else
              diagram_S := List( [ l_BC .. u_BC ], j -> HomomorphismStructureOnObjects( cat, B[j-n], C[j] ) );
            fi;
            
            if HasBaseZFunctions( Objects( hom_AD ) ) then
              diagram_R := BaseZFunctions( Objects( hom_AD ) )[1][n];
            else
              diagram_R := List( [ l_AD .. u_AD ], i -> HomomorphismStructureOnObjects( cat, A[i-n], D[i] ) );
            fi;
            
            matrix :=
              ListN( [ 1 .. u_BC - l_BC + 1 ], [ l_BC .. u_BC ],
                  { index_j, j } -> ListN( [ 1 .. u_AD - l_AD + 1 ], [ l_AD .. u_AD ],
                        function ( index_i, i )
                            
                            if i = j then
                                return HomomorphismStructureOnMorphismsWithGivenObjects( cat, diagram_S[index_j], phi[j-n], psi[j], diagram_R[index_i] );
                            else
                                return ZeroMorphism( range_cat, diagram_S[index_j], diagram_R[index_i] );
                            fi;
                            
                        end ) );
                        
            return MorphismBetweenDirectSumsWithGivenDirectSums( range_cat, hom_BC[n], diagram_S, matrix, diagram_R, hom_AD[n] );
            
        end );
        
    return CreateComplexMorphism( ch_range_cat, hom_BC, hom_AD, morphisms, l_psi - u_phi, u_psi - l_phi );
    
end );

BindGlobal( "_complexes_HomomorphismStructureOnMorphisms",
  
  function ( ch_cat, phi, psi )
    local hom_BC, hom_AD;
    
    hom_BC := _complexes_HomomorphismStructureOnObjects( ch_cat, Range( phi ), Source( psi ) );
    
    hom_AD := _complexes_HomomorphismStructureOnObjects( ch_cat, Source( phi ), Range( psi ) );
    
    return _complexes_HomomorphismStructureOnMorphismsWithGivenObjects( ch_cat, hom_BC, phi, psi, hom_AD );
    
end );

##
BindGlobal( "_complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
  
  function ( ch_cat, distinguished_object, alpha, hom_BC )
    local cat, range_cat, ch_range_cat, B, C, l_BC, u_BC, diagram_S, diagram_R, matrix, ell;
    
    cat := UnderlyingCategory( ch_cat );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    ch_range_cat := ComplexesCategoryByCochains( range_cat );
    
    B := Source( alpha );
    C := Range( alpha );
    
    l_BC := Maximum( LowerBound( B ), LowerBound( C ) );
    u_BC := Minimum( UpperBound( B ), UpperBound( C ) );
    
    diagram_S := [ distinguished_object[0] ];
    
    if HasBaseZFunctions( Objects( hom_BC ) ) then
      diagram_R := BaseZFunctions( Objects( hom_BC ) )[1][0];
    else
      diagram_R := List( [ l_BC .. u_BC ], j -> HomomorphismStructureOnObjects( cat, B[j], C[j] ) );
    fi;
    
    matrix := [ ListN( [ 1 .. u_BC - l_BC + 1 ], [ l_BC .. u_BC ],
                  { index_j, j } -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat, distinguished_object[0], alpha[j], diagram_R[index_j] ) ) ];
    
    ell := MorphismBetweenDirectSumsWithGivenDirectSums( range_cat, distinguished_object[0], diagram_S, matrix, diagram_R, hom_BC[0] );
    
    return CreateComplexMorphism( ch_range_cat, distinguished_object, hom_BC, [ ell ], 0 );
    
end );

##
BindGlobal( "_complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
  
  function( ch_cat, alpha )
    local distinguished_object, hom_BC;
    
    distinguished_object := _complexes_DistinguishedObjectOfHomomorphismStructure( ch_cat );
    
    hom_BC := _complexes_HomomorphismStructureOnObjects( ch_cat, Source( alpha ), Range( alpha ) );
    
    return _complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( ch_cat, distinguished_object, alpha, hom_BC );
    
end );

##
BindGlobal( "_complexes_InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
  
  function ( ch_cat, B, C, ell )
    local cat, range_cat, l_BC, u_BC, hom_BC, diagram_R, morphisms;
    
    cat := UnderlyingCategory( ch_cat );
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    l_BC := Maximum( LowerBound( B ), LowerBound( C ) );
    u_BC := Minimum( UpperBound( B ), UpperBound( C ) );
    
    hom_BC := Range( ell );
    
    if HasBaseZFunctions( Objects( hom_BC ) ) then
      diagram_R := BaseZFunctions( Objects( hom_BC ) )[1][0];
    else
      diagram_R := List( [ l_BC .. u_BC ], j -> HomomorphismStructureOnObjects( cat, B[j], C[j] ) );
    fi;
    
    morphisms := ListN( [ 1 .. u_BC - l_BC + 1 ], [ l_BC .. u_BC ],
                    { index_j, j } -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                                        cat,
                                        B[j],
                                        C[j],
                                        PreCompose( range_cat, ell[0], ProjectionInFactorOfDirectSumWithGivenDirectSum( range_cat, diagram_R, index_j, hom_BC[0] ) ) ) );
    
    return CreateComplexMorphism( ch_cat, B, C, morphisms, l_BC );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_COCHAIN_COMPLEX_CATEGORY,
  function ( ch_cat )
    local cat, range_cat, ch_range_cat, name, category_constructor, as_object_in_abelian_category, as_morphism_in_abelian_category, unwrap_morphism_in_abelian_category,
          can_be_equipped_with_hom_structure_over_abelian_category;
    
    cat := UnderlyingCategory( ch_cat );
    
    if not HasRangeCategoryOfHomomorphismStructure( cat ) then
      Error( "the underlying category must be equipped with a Hom-Structure\n" );
    fi;
     
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    can_be_equipped_with_hom_structure_over_abelian_category := false;
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      category_constructor := IdFunc;
      as_object_in_abelian_category := IdFunc;
      as_morphism_in_abelian_category := IdFunc;
      unwrap_morphism_in_abelian_category := IdFunc;
      
      can_be_equipped_with_hom_structure_over_abelian_category := true;
      
    elif IsBound( IsCategoryOfRows ) and ValueGlobal( "IsCategoryOfRows" )( range_cat ) then
      
      category_constructor := ValueGlobal( "FreydCategory" );
      as_object_in_abelian_category := ValueGlobal( "AsFreydCategoryObject" );
      as_morphism_in_abelian_category := ValueGlobal( "AsFreydCategoryMorphism" );
      unwrap_morphism_in_abelian_category := ValueGlobal( "MorphismDatum" );
      
      can_be_equipped_with_hom_structure_over_abelian_category := true;
      
    fi;
    
    if can_be_equipped_with_hom_structure_over_abelian_category then
      
      ch_cat!.hom_structure_helper_functions :=
        rec(  category_constructor := category_constructor,
              as_object_in_abelian_category := as_object_in_abelian_category,
              as_morphism_in_abelian_category := as_morphism_in_abelian_category,
              unwrap_morphism_in_abelian_category := unwrap_morphism_in_abelian_category );
      
      range_cat := category_constructor( range_cat );
      
      SetIsEquippedWithHomomorphismStructure( ch_cat, true );
      
      SetRangeCategoryOfHomomorphismStructure( ch_cat, range_cat );
      
      AddDistinguishedObjectOfHomomorphismStructure( ch_cat,
        
        ch_cat -> as_object_in_abelian_category( _complexes_DistinguishedObjectOfHomomorphismStructure( ch_cat )[0] )
      );
      
      AddHomomorphismStructureOnObjects( ch_cat,
        
        function ( ch_cat, B, C )
          
          return KernelObject( range_cat, as_morphism_in_abelian_category( _complexes_HomomorphismStructureOnObjects( ch_cat, B, C )^0 ) );
          
      end );
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( ch_cat,
        
        function ( ch_cat, hom_BC, phi, psi, hom_AD )
          local hom_phi_psi;
          
          hom_phi_psi := _complexes_HomomorphismStructureOnMorphisms( ch_cat, phi, psi );
          
          return KernelObjectFunctorialWithGivenKernelObjects(
                        range_cat,
                        hom_BC,
                        as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ),
                        as_morphism_in_abelian_category( hom_phi_psi[0] ),
                        as_morphism_in_abelian_category( Range( hom_phi_psi )^0 ),
                        hom_AD );
          
      end );
      
      AddHomomorphismStructureOnMorphisms( ch_cat,
        
        function ( ch_cat, phi, psi )
          local hom_phi_psi;
          
          hom_phi_psi := _complexes_HomomorphismStructureOnMorphisms( ch_cat, phi, psi );
           
          return KernelObjectFunctorial(
                        range_cat,
                        as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ),
                        as_morphism_in_abelian_category( hom_phi_psi[0] ),
                        as_morphism_in_abelian_category( Range( hom_phi_psi )^0 ) );
          
      end );
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ch_cat,
        
        function ( ch_cat, phi )
          local distinguished_object, hom_BC, ell;
          
          distinguished_object := _complexes_DistinguishedObjectOfHomomorphismStructure( ch_cat );
          
          hom_BC := _complexes_HomomorphismStructureOnObjects( ch_cat, Source( phi ), Range( phi ) );
          
          ell := _complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( ch_cat, distinguished_object, phi, hom_BC );
          
          return LiftAlongMonomorphism(
                        range_cat,
                        KernelEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^0 ) ),
                        as_morphism_in_abelian_category( ell[0] ) );
          
      end );
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat,
        function ( ch_cat, B, C, ell )
          local distinguished_object, hom_BC;
          
          distinguished_object := _complexes_DistinguishedObjectOfHomomorphismStructure( ch_cat );
          
          hom_BC := _complexes_HomomorphismStructureOnObjects( ch_cat, B, C );
          
          ell := unwrap_morphism_in_abelian_category( PreCompose( range_cat, ell, KernelEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^0 ) ) ) );
          
          ell := CreateComplexMorphism( distinguished_object, hom_BC, [ ell ], 0 );
          
          return _complexes_InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat, B, C, ell );
          
      end );
      
    else
      
      if IsIdenticalObj( cat, range_cat ) then
        ch_range_cat := ch_cat;
      else
        ch_range_cat := ComplexesCategoryByCochains( range_cat );
      fi;
      
      SetIsEquippedWithHomomorphismStructure( ch_cat, true );
      
      SetRangeCategoryOfHomomorphismStructure( ch_cat, ch_range_cat );
      
      for name in [ "DistinguishedObjectOfHomomorphismStructure",
                    "HomomorphismStructureOnObjects",
                    "HomomorphismStructureOnMorphisms",
                    "HomomorphismStructureOnMorphismsWithGivenObjects",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                    "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ] do
        
        ValueGlobal( Concatenation( "Add", name ) )( ch_cat, EvalString( Concatenation( "_complexes_", name ) ) );
      
      od;
      
    fi;
    
end );

