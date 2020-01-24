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
InstallMethod( RestrictionOfTensorFunctorByExceptionalCollectionToIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local full, ambient_cat, inc, iso2, A, iso1, iso, indec_projs, r, name, cell_func;
    
    full := DefiningFullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
    
    inc := InclusionFunctor( full );
     
    iso2 := IsomorphismFromAlgebroid( collection );
    
    A := AsCapCategory( Source( iso2 ) );
    
    iso1 := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( A );
    
    iso := PreCompose( [ iso1, iso2, inc ] );
    
    indec_projs := AsCapCategory( Source( iso ) );
    
    r := RandomBoldTextColor( );

    name := Concatenation( "\033[1m- ⊗_{End T} T", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ", 
              Name( indec_projs ), " ", r[ 1 ], "--->", r[ 2 ], " ", Name( ambient_cat ) );
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, indec_projs, ambient_cat, cell_func, cell_func );
    
end );

##
InstallMethod( RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local G, add_G, C, can, can_add_G, projs, D, r, name, R;
    
    G := RestrictionOfTensorFunctorByExceptionalCollectionToIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosures( G ); # or add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    C := AmbientCategory( AmbientCategory( AsCapCategory( Source( G ) ) ) );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    D := AsCapCategory( Range( G ) );
    
    r := RandomBoldTextColor( );

    name := Concatenation( "\033[1m- ⊗_{End T} T", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ", 
              Name( projs ), " ", r[ 1 ], "--->", r[ 2 ], " ", Name( D ) );
        
    R := CapFunctor( name, projs, D );
    
    AddObjectFunction( R, # FunctorObjectOperation( can_add_G ) );
      function( r )
        local a, summands;
        
        a := ApplyFunctor( can_add_G, r );
        
        summands := ObjectList( a );
        
        if IsEmpty( summands ) then
          
          a := ZeroObject( D );
          
        else
          
          a := DirectSum( summands );
          
        fi;
        
        a!.object_list := summands;
        
        return a;
        
    end );
    
    AddMorphismFunction( R, # FunctorMorphismOperation( can_add_G ) );
      function( s, alpha, r )
        local beta, morphism_matrix;
        
        beta := ApplyFunctor( can_add_G, alpha );
        
        morphism_matrix := MorphismMatrix( beta );
        
        beta := MorphismBetweenDirectSums( s, morphism_matrix, r );
        
        beta!.morphism_matrix := morphism_matrix;
        
        return beta;
        
    end );
    
    return R;
    
end );

##
InstallMethod( TensorFunctorByExceptionalCollection,
    [ IsExceptionalCollection ],
    
  function( collection )
    local R, r, projs, reps, cat, name, F;
    
    R := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
    
    projs := AsCapCategory( Source( R ) );
    
    reps := AmbientCategory( projs  );
    
    cat := AsCapCategory( Range( R ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "- ⊗_{End T} T functor ", r[ 1 ], "from", r[ 2 ], " ", Name( reps ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( cat ) );
    
    F := CapFunctor( name, reps, cat );
    
    AddObjectFunction( F,
      function( r )
        local P, cok;
        
        P := ProjectiveChainResolution( r );
        
        P := P ^ 1;
        
        P := ApplyFunctor( R, P / projs );
        
        cok := CokernelObject( P );
        
        cok!.defining_morphism_of_cokernel_object := P;
        
        return cok;
        
    end );
    
    AddMorphismFunction( F,
      function( source, alpha, range )
        local gamma, cok_func;
        
        gamma := MorphismBetweenProjectiveChainResolutions( alpha );
        
        gamma := [ Source( gamma ) ^ 1, gamma[ 0 ], Range( gamma ) ^ 1 ];
        
        gamma := List( gamma, g -> ApplyFunctor( R, g / projs ) );
        
        cok_func := CallFuncList( CokernelObjectFunctorial, gamma );
        
        cok_func!.defining_morphism_of_cokernel_object := gamma[ 2 ];
        
        return cok_func;
        
    end );
    
    return F;
    
end );


