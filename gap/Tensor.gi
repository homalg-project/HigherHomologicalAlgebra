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

## In case the ambient category of the collection is abelian
##
InstallMethod( TensorFunctor,
    [ IsExceptionalCollection ],
    
  function( collection )
    local full, cat, T, I, TI, projs, reps, name, F;
    
    full := DefiningFullSubcategory( collection );
    
    cat := AmbientCategory( collection );
    
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


## In case the ambient category of the collection is homotopy category
##
InstallMethod( TensorFunctor,
    [ IsExceptionalCollection ],
    
  function( collection )
    local ambient_cat, A, D, Ho_D, T;
    
    ambient_cat := AmbientCategory( collection );
    
    if HasIsAbelianCategory( ambient_cat ) and IsAbelianCategory( ambient_cat) then
      
      TryNextMethod( );
      
    fi;
   
    A := EndomorphismAlgebra( collection );
    
    A := OppositeAlgebra( A );
    
    D := CategoryOfQuiverRepresentations( A );
    
    Ho_D := HomotopyCategory( D );
    
    T := TensorFunctorOnProjectiveObjects( collection );
    
    T := PreCompose(
                  LocalizationFunctorByProjectiveObjects( Ho_D ),
                  ExtendFunctorToHomotopyCategories( T )
                );
    
    T!.Name := "- ⊗_{End T} T functor";
    
    return T;
    
end );


