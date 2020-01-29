#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
##
## Tensor.gi
##
#############################################################################

##
InstallMethod( TensorFunctorOnIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local full, iso, indec_projs, name, T;
    
    full := DefiningFullSubcategory( collection );
    
    iso := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
    
    indec_projs := AsCapCategory( Source( iso ) );
    
    name := "- ⊗_{End T} T functor on indecomposable projective objects";
    
    T := CapFunctor( name, indec_projs, full );
    
    AddObjectFunction( T, iso!.object_function_list[ 1 ][ 1 ] );
    
    AddMorphismFunction( T, iso!.morphism_function_list[ 1 ][ 1 ] );
    
    return T;
    
end );

##
InstallMethod( TensorFunctorOnProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local G, add_G, C, can, can_add_G, projs, D, name, R;
    
    G := TensorFunctorOnIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosures( G );
    
    C := AmbientCategory( AsCapCategory( Source( G ) ) );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    D := AsCapCategory( Range( can_add_G ) );
    
    name := "- ⊗_{End T} T functor on projective objects";
    
    R := CapFunctor( name, projs, D );
    
    AddObjectFunction( R, can_add_G!.object_function_list[ 1 ][ 1 ] );
        
    AddMorphismFunction( R, can_add_G!.morphism_function_list[ 1 ][ 1 ] );
    
    return R;
    
end );

##
InstallMethod( TensorFunctor,
    [ IsExceptionalCollection ],
    
  function( collection )
    local TP, reps, C, chains_reps, homotopy_reps, T, r, name, F;
    
    Info( InfoWarning, 1, "This method TensorFunctor on collection defined by full subcategory of a homotopy category still needs a mathematical proof!" );
    
    TP := TensorFunctorOnProjectiveObjects( collection );
    
    reps := AmbientCategory( AsCapCategory( Source( TP ) ) );
    
    C := AsCapCategory( Range( TP ) );
       
    if not IsHomotopyCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    chains_reps := ChainComplexCategory( reps );
    
    homotopy_reps := HomotopyCategory( reps );
    
    T := PreCompose(
                  LocalizationFunctorByProjectiveObjects( homotopy_reps ),
                  ExtendFunctorToHomotopyCategories( TP : name_for_functor := "Extension of - ⊗_{End T} T to homotopy categories" )
                );
    
    name := "- ⊗_{End T} T functor on quiver representations";
 
    F := CapFunctor( name, reps, C );
    
    AddObjectFunction( F,
      function( r )
        
        return Convolution( UnderlyingCell( T( IdentityMorphism ( r )/ chains_reps / homotopy_reps ) ) );
        
    end );
    
    AddMorphismFunction( F,
      function( source, alpha, range )
        
        return Convolution( UnderlyingCell( T( IdentityMorphism ( alpha )/ chains_reps / homotopy_reps ) ) );
        
    end );
    
    return F;
    
end );

##
InstallMethod( TensorFunctor,
    [ IsExceptionalCollection ],
    
  function( collection )
    local full, cat, T, I, TI, projs, reps, name, F;
    
    full := DefiningFullSubcategory( collection );
    
    cat := AmbientCategory( full );
    
    if not ( HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) ) then
      
      TryNextMethod( );
      
    fi;
    
    T := TensorFunctorOnProjectiveObjects( collection );
    
    I := ExtendFunctorToAdditiveClosureOfSource( InclusionFunctor( full ) );
    
    projs := AsCapCategory( Source( T ) );
    
    reps := AmbientCategory( projs  );
     
    name := "- ⊗_{End T} T functor on quiver representations";
    
    F := CapFunctor( name, reps, cat );
    
    AddObjectFunction( F,
      function( r )
        local p, ip, cok; 
        
        p := ProjectiveChainResolution( r );
        
        p := ApplyFunctor( T, p ^ 1 / projs );
        
        ip := ApplyFunctor( I, p );
        
        cok := CokernelObject( ip );
        
        cok!.defining_morphism_of_cokernel_object := p;
        
        cok!.embedded_defining_morphism_of_cokernel_object := ip;
        
        return cok;
        
    end );
    
    AddMorphismFunction( F,
      function( source, alpha, range )
        local gamma, i_gamma, cok_func;
        
        gamma := MorphismBetweenProjectiveChainResolutions( alpha );
        
        gamma := [ Source( gamma ) ^ 1, gamma[ 0 ], Range( gamma ) ^ 1 ];
        
        gamma := List( gamma, g -> ApplyFunctor( T, g / projs ) );
        
        i_gamma := List( gamma, g -> ApplyFunctor( I, g ) );
        
        cok_func := CallFuncList( CokernelObjectFunctorial, i_gamma );
        
        cok_func!.defining_morphism_of_cokernel_object := gamma[ 2 ];
        
        cok_func!.embedded_defining_morphism_of_cokernel_object := i_gamma[ 2 ];
        
        return cok_func;
        
    end );
    
    return F;
    
end );

