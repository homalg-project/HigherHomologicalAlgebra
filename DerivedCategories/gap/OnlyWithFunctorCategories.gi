# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
InstallMethod( EmbeddingIntoDerivedCategory,
          [ IsHomotopyCategory ],
  
  function( homotopy_cat )
    local add_closure, B, PSh, overhead, Y;
    
    if not IsAdditiveClosureCategory( DefiningCategory( homotopy_cat ) ) then
        TryNextMethod( );
    fi;
    
    add_closure := DefiningCategory( homotopy_cat );
    
    if not IsAdditiveClosureCategory( add_closure ) then
        TryNextMethod( );
    fi;
     
    B := UnderlyingCategory( add_closure );
    
    if not ( IsAlgebroid( B ) or IsAlgebroidFromDataTables( B ) ) then
        TryNextMethod( );
    fi;
    
    PSh := PreSheaves( B : overhead := false );
    
    Y := IsomorphismFromSourceIntoImageOfYonedaEmbeddingOfSource( PSh );
    
    Y := PreCompose( Y, InclusionFunctor( RangeOfFunctor( Y ) ) );
    
    Y := ExtendFunctorToAdditiveClosureOfSource( Y );
    
    Y := ExtendFunctorToHomotopyCategoriesByCochains( Y );
    
    Y := PreCompose( Y, LocalizationFunctor( RangeOfFunctor( Y ) ) );
    
    Y!.Name := "Embedding functor into derived category of presheaves";
    
    return Y;
    
end );

##
InstallMethod( EquivalenceOntoDerivedCategory,
          [ IsHomotopyCategory ],
  
  function( homotopy_cat )
    local Y;
    
    Y := EmbeddingIntoDerivedCategory( homotopy_cat );
    
    Y!.Name := "Equivalence functor onto derived category of presheaves";
    
    return Y;
    
end );

##
InstallMethod( HomFunctorOfStrongExceptionalSequence,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local cat, seq_oid, I, objs, gen_morphisms, PSh, overhead, H;
    
    cat := AmbientCategory( seq );
    
    seq_oid := AbstractionAlgebroid( seq );
    
    I := IsomorphismFromAbstractionAlgebroid( seq );
    
    objs := List( SetOfObjects( seq_oid ), o -> UnderlyingCell( ApplyFunctor( I, o ) ) );
    gen_morphisms := List( SetOfGeneratingMorphisms( seq_oid ), m -> UnderlyingCell( ApplyFunctor( I, m ) ) );
    
    PSh := PreSheaves( seq_oid );
    
    H := CapFunctor( "Hom(T,-) functor", cat, PSh );
    
    AddObjectFunction( H,
      function ( A )
        local images_of_objects, images_of_gen_morphisms, output;
        
        images_of_objects := List( objs, E -> HomomorphismStructureOnObjects( cat, E, A ) );
        images_of_gen_morphisms := List( gen_morphisms, m -> HomomorphismStructureOnMorphisms( cat, m, IdentityMorphism( A ) ) );
        
        output := CreatePreSheafByValues( PSh, images_of_objects, images_of_gen_morphisms );
        output!.defining_data_for_hom_functor := rec( argument := A );
        
        return output;
        
    end );
    
    AddMorphismFunction( H,
      function ( S, phi, R )
        local images_of_objects;
        
        images_of_objects := List( objs, E -> HomomorphismStructureOnMorphisms( cat, IdentityMorphism( E ), phi ) );
        
        return CreatePreSheafMorphismByValues( PSh, S, images_of_objects, R );
        
      end );
    
    return H;
    
end );

##
InstallMethod( TensorProductFunctorOfStrongExceptionalSequence,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local cat, seq_oid, PSh, overhead, I_1, I_2, I_3, I, y_image, T;
    
    cat := AmbientCategory( seq );
    
    seq_oid := AbstractionAlgebroid( seq );
    
    PSh := PreSheaves( seq_oid );
    
    I_1 := IsomorphismFromImageOfYonedaEmbeddingOfSourceIntoSource( PSh );
    
    DeactivateCachingObject( ObjectCache( I_1 ) );
    DeactivateCachingObject( MorphismCache( I_1 ) );
    
    I_2 := IsomorphismFromAbstractionAlgebroid( seq );
    I_3 := InclusionFunctor( seq );

    I := PreCompose( [ I_1, I_2, I_3 ] );
    DeactivateCachingObject( ObjectCache( I ) );
    DeactivateCachingObject( MorphismCache( I ) );
    
    y_image := SourceOfFunctor( I );
    
    T := CapFunctor( "-⊗T functor", PSh, cat );
    
    AddObjectFunction( T,
      function ( F )
        local kappa_F, pres_F, range_injections, range_summands, range_projections, source_injections, source_summands,
          mat_TF, diagram_S, diagram_R, pres_TF, TF;
        
        kappa_F := KernelEmbedding( EpimorphismFromProjectiveCoverObject( F ) );
        pres_F := PreCompose( EpimorphismFromProjectiveCoverObject( Source( kappa_F ) ), kappa_F );
        
        range_injections := ProjectiveCoverObjectDataOfPreSheaf( Range( pres_F ) );
        range_summands := List( range_injections, Source );
        range_projections := List( [ 1 .. Length( range_summands ) ],
                                k -> ProjectionInFactorOfDirectSumWithGivenDirectSum( range_summands, k, Range( pres_F ) ) );
        
        source_injections := ProjectiveCoverObjectDataOfPreSheaf( Source( pres_F ) );
        source_summands := List( source_injections, Source );
        
        mat_TF := List( source_injections,
                    iota -> List( range_projections,
                      pi -> ApplyFunctor( I, AsSubcategoryCell( y_image, PreCompose( [ iota, pres_F, pi ] ) ) ) ) );
        
        diagram_S := List( source_summands, P -> ApplyFunctor( I, AsSubcategoryCell( y_image, P ) ) );
        diagram_R := List( range_summands, P -> ApplyFunctor( I, AsSubcategoryCell( y_image, P ) ) );
        
        pres_TF := MorphismBetweenDirectSums( cat, diagram_S, mat_TF, diagram_R );
        
        TF := CokernelObject( pres_TF );
        
        TF!.defining_data_for_tensor_functor :=
            rec( argument := F, matrix_of_exceptional_presentation := mat_TF, exceptional_presentation := pres_TF,
                  range_injections := range_injections, range_projections := range_projections, range_summands := diagram_R );
        
        return TF;
        
    end );
    
    AddMorphismFunction( T,
      function ( TF, alpha, TG )
        local F, pi_F, pres_TF, inj_F, summands_F, G, pi_G, pres_TG, proj_G, summands_G, l, mat_l, Tl;
        
        F := Source( alpha );
        pi_F := EpimorphismFromProjectiveCoverObject( F );
        
        if IsBound( TF!.defining_data_for_tensor_functor ) then
            
            pres_TF := TF!.defining_data_for_tensor_functor!.exceptional_presentation;
            inj_F := TF!.defining_data_for_tensor_functor!.range_injections;
            summands_F := TF!.defining_data_for_tensor_functor.range_summands;
            
        else Error( "This should not happen!" ); fi;
        
        G := Range( alpha );
        pi_G := EpimorphismFromProjectiveCoverObject( G );
        
        if IsBound( TG!.defining_data_for_tensor_functor ) then
            
            pres_TG := TG!.defining_data_for_tensor_functor!.exceptional_presentation;
            proj_G := TG!.defining_data_for_tensor_functor!.range_projections;
            summands_G := TG!.defining_data_for_tensor_functor.range_summands;
            
        else Error( "This should not happen!" ); fi;
        
        l := ProjectiveLift( PSh, PreCompose( PSh, pi_F, alpha ), pi_G );
        mat_l := List( inj_F, iota -> List( proj_G, pi -> ApplyFunctor( I, AsSubcategoryCell( y_image, PreCompose( [ iota, l, pi ] ) ) ) ) );
        Tl := MorphismBetweenDirectSumsWithGivenDirectSums( cat, Range( pres_TF ), summands_F, mat_l, summands_G, Range( pres_TG ) );
        
        return CokernelObjectFunctorialWithGivenCokernelObjects( TF, pres_TF, Tl, pres_TG, TG );
        
    end );
    
    return T;
    
end );

##
InstallMethod( CounitOfTensorHomAdjunction,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local cat, T, H, PSh, y_image, name, epsilon;
    
    cat := AmbientCategory( seq );
    
    T := TensorProductFunctorOfStrongExceptionalSequence( seq );
    H := HomFunctorOfStrongExceptionalSequence( seq );
    
    PSh := SourceOfFunctor( T );
    y_image := IndecomposableProjectiveObjects( PSh );
    
    name := "Hom(T,-) ⊗ T => Id";
    
    epsilon := NaturalTransformation( name, PreCompose( H, T ), IdentityFunctor( cat ) );
    
    AddNaturalTransformationFunction( epsilon,
      function ( TH_A, A, ID_A )
        local objs, H_A, pres_TH_A, p_cover_data, positions, tau, epi;
        
        objs := seq!.Objects;
         
        if IsBound( TH_A!.defining_data_for_tensor_functor ) then
            
            H_A := TH_A!.defining_data_for_tensor_functor!.argument;
            pres_TH_A := TH_A!.defining_data_for_tensor_functor!.exceptional_presentation;
            
        else Error( "This should not happen!" ); fi;
        
        p_cover_data := ProjectiveCoverObjectDataOfPreSheaf( H_A );
        
        positions := List( p_cover_data, iota -> Position( y_image, Source( iota ) ) );
        
        tau := ListN( p_cover_data, positions,
                    { iota, p } -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                                        objs[p],
                                        A,
                                        ValuesOnAllObjects( iota )[p] ) );
        
        epi := UniversalMorphismFromDirectSumWithGivenDirectSum( cat, List( tau, Source ), A, tau, Range( pres_TH_A ) );
        
        return CokernelColiftWithGivenCokernelObject( pres_TH_A, epi, TH_A );
        
    end );
    
    return epsilon;
    
end );

##
InstallMethod( UnitOfTensorHomAdjunction,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local objs, cat, T, H, PSh, name, mu;
    
    objs := seq!.Objects;
    
    cat := AmbientCategory( seq );
    
    T := TensorProductFunctorOfStrongExceptionalSequence( seq );
    H := HomFunctorOfStrongExceptionalSequence( seq );
    
    PSh := SourceOfFunctor( T );
    
    name := "Id => Hom(T, -⊗T)";
    
    mu := NaturalTransformation( name, IdentityFunctor( PSh ), PreCompose( T, H ) );
    
    AddNaturalTransformationFunction( mu,
      function ( ID_F, F, HT_F )
        local T_F, cokernel_projection, summands, positions, gens;
        
        if IsBound( HT_F!.defining_data_for_hom_functor ) then
            
            T_F := HT_F!.defining_data_for_hom_functor!.argument;
            
        else T_F := ApplyFunctor( T, F ); fi;
        
        cokernel_projection := CokernelProjection( T_F!.defining_data_for_tensor_functor!.exceptional_presentation );
        
        summands := T_F!.defining_data_for_tensor_functor!.range_summands;
        
        positions := List( summands, E -> Position( objs, E ) );
        
        gens := ListN( [ 1 .. Length( positions ) ], positions,
                    function ( i, k )
                        return CoverElementByIndecomposableProjectivePreSheaf( HT_F,
                                  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( PreCompose(
                                        InjectionOfCofactorOfDirectSumWithGivenDirectSum( summands, i, Source( cokernel_projection ) ),
                                        cokernel_projection ) ), k );
                    end );
        
        return ColiftAlongEpimorphism( EpimorphismFromProjectiveCoverObject( F ), UniversalMorphismFromDirectSum( gens ) );
        
    end );
    
    return mu;
    
end );

