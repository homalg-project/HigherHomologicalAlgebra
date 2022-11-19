# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#

##
InstallGlobalFunction( ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_HOMOTOPY_CATEGORY_BY_COCHAINS,
  function ( homotopy_category )
    local cat, range_cat, ch_range_cat, name, category_constructor, as_object_in_abelian_category, as_morphism_in_abelian_category, unwrap_morphism_in_abelian_category,
          can_be_equipped_with_hom_structure_over_abelian_category;
    
    cat := DefiningCategory( homotopy_category );
    
    if not HasRangeCategoryOfHomomorphismStructure( cat ) then
      Error( "the defining category of ", Name( homotopy_category ), " must be equipped with a Hom-Structure\n" );
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
      
      homotopy_category!.hom_structure_helper_functions :=
        rec(  category_constructor := category_constructor,
              as_object_in_abelian_category := as_object_in_abelian_category,
              as_morphism_in_abelian_category := as_morphism_in_abelian_category,
              unwrap_morphism_in_abelian_category := unwrap_morphism_in_abelian_category );
      
      range_cat := category_constructor( range_cat );
      
      SetIsEquippedWithHomomorphismStructure( homotopy_category, true );
      
      SetRangeCategoryOfHomomorphismStructure( homotopy_category, range_cat );
      
      AddDistinguishedObjectOfHomomorphismStructure( homotopy_category,
        
        homotopy_category -> as_object_in_abelian_category( _complexes_DistinguishedObjectOfHomomorphismStructure( homotopy_category )[0] )
      );
      
      AddHomomorphismStructureOnObjects( homotopy_category,
        
        function ( homotopy_category, B, C )
          local hom_BC;
          
          hom_BC := _complexes_HomomorphismStructureOnObjects( UnderlyingCategory( homotopy_category ), UnderlyingCell( B ), UnderlyingCell( C ) );
          
          return CokernelObject(
                        range_cat,
                        LiftAlongMonomorphism(
                          range_cat,
                          KernelEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^0 ) ),
                          ImageEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^-1 ) ) ) );
          
      end );
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( homotopy_category,
        
        function ( homotopy_category, hom_BC, phi, psi, hom_AD )
          local hom_phi_psi;
          
          hom_phi_psi := _complexes_HomomorphismStructureOnMorphisms( UnderlyingCategory( homotopy_category ), UnderlyingCell( phi ), UnderlyingCell( psi ) );
          
          return CokernelObjectFunctorialWithGivenCokernelObjects(
                        range_cat,
                        hom_BC,
                        LiftAlongMonomorphism(
                            range_cat,
                            KernelEmbedding( range_cat, as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ) ),
                            ImageEmbedding( range_cat, as_morphism_in_abelian_category( Source( hom_phi_psi )^-1 ) ) ),
                        KernelObjectFunctorial(
                            range_cat,
                            as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ),
                            as_morphism_in_abelian_category( hom_phi_psi[0] ),
                            as_morphism_in_abelian_category( Range( hom_phi_psi  )^0 ) ),
                        LiftAlongMonomorphism(
                            range_cat,
                            KernelEmbedding( range_cat, as_morphism_in_abelian_category( Range( hom_phi_psi )^0 ) ),
                            ImageEmbedding( range_cat, as_morphism_in_abelian_category( Range( hom_phi_psi )^-1 ) ) ),
                        hom_AD );
          
      end );
      
      AddHomomorphismStructureOnMorphisms( homotopy_category,
        
        function ( homotopy_category, phi, psi )
          local hom_phi_psi;
          
          hom_phi_psi := _complexes_HomomorphismStructureOnMorphisms( UnderlyingCategory( homotopy_category ), UnderlyingCell( phi ), UnderlyingCell( psi ) );
           
          return CokernelObjectFunctorial(
                        range_cat,
                        LiftAlongMonomorphism(
                            range_cat,
                            KernelEmbedding( range_cat, as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ) ),
                            ImageEmbedding( range_cat, as_morphism_in_abelian_category( Source( hom_phi_psi )^-1 ) ) ),
                        KernelObjectFunctorial(
                            range_cat,
                            as_morphism_in_abelian_category( Source( hom_phi_psi )^0 ),
                            as_morphism_in_abelian_category( hom_phi_psi[0] ),
                            as_morphism_in_abelian_category( Range( hom_phi_psi  )^0 ) ),
                        LiftAlongMonomorphism(
                            range_cat,
                            KernelEmbedding( range_cat, as_morphism_in_abelian_category( Range( hom_phi_psi )^0 ) ),
                            ImageEmbedding( range_cat, as_morphism_in_abelian_category( Range( hom_phi_psi )^-1 ) ) ) );
      
      end );
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( homotopy_category,
        
        function ( homotopy_category, phi )
          local ell, hom_BC, iota;
          
          ell := _complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( UnderlyingCategory( homotopy_category ), UnderlyingCell( phi ) );
          
          hom_BC := Range( ell );
          
          iota := KernelEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^0 ) );
          
          return PreCompose(
                    range_cat,
                    LiftAlongMonomorphism(
                        range_cat,
                        iota,
                        as_morphism_in_abelian_category( ell[0] ) ),
                    CokernelProjection(
                        range_cat,
                        LiftAlongMonomorphism(
                          range_cat,
                          iota,
                          ImageEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^-1 ) ) ) ) );
     
      end );
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( homotopy_category,
        function ( homotopy_category, B, C, ell )
          local distinguished_object, hom_BC, iota;
          
          distinguished_object := _complexes_DistinguishedObjectOfHomomorphismStructure( UnderlyingCategory( homotopy_category ) );
          
          hom_BC := _complexes_HomomorphismStructureOnObjects( UnderlyingCategory( homotopy_category ), UnderlyingCell( B ), UnderlyingCell( C ) );
          
          iota := KernelEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^0 ) );
          
          ell := ProjectiveLift(
                    range_cat,
                    ell,
                    CokernelProjection(
                        range_cat,
                        LiftAlongMonomorphism(
                          range_cat,
                          iota,
                          ImageEmbedding( range_cat, as_morphism_in_abelian_category( hom_BC^-1 ) ) ) ) );
          
          ell := CreateComplexMorphism( distinguished_object, hom_BC, [ unwrap_morphism_in_abelian_category( PreCompose( range_cat, ell, iota ) ) ], 0 );
          
          return MorphismConstructor(
                      homotopy_category,
                      B,
                      _complexes_InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UnderlyingCategory( homotopy_category ), UnderlyingCell( B ), UnderlyingCell( C ), ell ),
                      C );
      
      end );
    
    else
      
      if IsIdenticalObj( cat, range_cat ) then
        ch_range_cat := homotopy_category;
      else
        ch_range_cat := ComplexesCategoryByCochains( range_cat );
      fi;
      
      SetIsEquippedWithHomomorphismStructure( homotopy_category, true );
      
      SetRangeCategoryOfHomomorphismStructure( homotopy_category, ch_range_cat );
      
      for name in [ "DistinguishedObjectOfHomomorphismStructure",
                    "HomomorphismStructureOnObjects",
                    "HomomorphismStructureOnMorphisms",
                    "HomomorphismStructureOnMorphismsWithGivenObjects",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                    "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                    "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ] do
        
        ValueGlobal( Concatenation( "Add", name ) )( homotopy_category, EvalString( Concatenation( "_complexes_", name ) ) );
      
      od;
      
    fi;
    
end );

