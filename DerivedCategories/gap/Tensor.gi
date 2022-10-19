# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
## Tensor.gi
##
#############################################################################

##
#InstallMethod( TensorFunctorFromCategoryOfFunctorsOnIndecProjectiveObjects,
#          [ IsStrongExceptionalCollection ],
#          
#  function( collection )
#    local full, iso, indec_projs, name, T;
#    
#    full := FullSubcategory( collection );
#    
#    iso := InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfFunctors( collection );
#    
#    indec_projs := SourceOfFunctor( iso );
#    
#    name := "-⊗ T functor";
#    
#    T := CapFunctor( name, indec_projs, full );
#    
#    AddObjectFunction( T, iso!.object_function_list[ 1 ][ 1 ] );
#    
#    AddMorphismFunction( T, iso!.morphism_function_list[ 1 ][ 1 ] );
#    
#    return T;
#    
#end );

##
InstallMethod( TensorFunctorFromCategoryOfQuiverRepresentationsOnIndecProjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local full, iso, indec_projs, name, T;
    
    full := FullSubcategory( collection );
    
    iso := InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( collection );
    
    indec_projs := SourceOfFunctor( iso );
    
    name := "-⊗ T functor";
    
    T := CapFunctor( name, indec_projs, full );
    
    AddObjectFunction( T, iso!.object_function_list[ 1 ][ 1 ] );
    
    AddMorphismFunction( T, iso!.morphism_function_list[ 1 ][ 1 ] );
    
    return T;
    
end );

##
#InstallMethod( TensorFunctorFromCategoryOfFunctorsOnProjectiveObjects,
#          [ IsStrongExceptionalCollection ],
#  function( collection )
#    local algebroid, algebroid_op, k, Hom, I, projs, T, F;
#    
#    algebroid := Algebroid( collection );
#    
#    algebroid_op := OppositeAlgebroid( algebroid );
#    
#    SetAlgebroid( UnderlyingQuiverAlgebra( algebroid_op ), algebroid_op );
#    
#    k := CommutativeRingOfLinearCategory( algebroid );
#    
#    Hom := Hom( algebroid_op, MatrixCategory( k ) );
#    
#    I := IsomorphismOntoCategoryOfQuiverRepresentations( Hom );
#    
#    projs := FullSubcategoryGeneratedByProjectiveObjects( Hom );
#    
#    T := TensorFunctorFromCategoryOfQuiverRepresentationsOnProjectiveObjects( collection );
#    
#    I := RestrictFunctorToFullSubcategories( I, projs, SourceOfFunctor( T ) );
#    
#    F := PreCompose( I, T );
#    
#    F!.Name := "-⊗ T functor";
#    
#    return F;
#    
#end );

##
InstallMethod( TensorFunctorFromCategoryOfQuiverRepresentationsOnProjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local G, add_G, C, can, can_add_G, projs, D, name, R;
    
    G := TensorFunctorFromCategoryOfQuiverRepresentationsOnIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosures( G );
    
    C := AmbientCategory( SourceOfFunctor( G ) );
    
    can := DecompositionFunctorOfProjectiveQuiverRepresentations( C );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := SourceOfFunctor( can_add_G );
    
    D := RangeOfFunctor( can_add_G );
    
    name := "-⊗ T functor";
    
    R := CapFunctor( name, projs, D );
    
    AddObjectFunction( R, can_add_G!.object_function_list[ 1 ][ 1 ] );
        
    AddMorphismFunction( R, can_add_G!.morphism_function_list[ 1 ][ 1 ] );
    
    return R;
    
end );

###
#InstallMethod( TensorFunctorFromCategoryOfFunctors,
#    [ IsStrongExceptionalCollection ],
#     
#  function( collection )
#    local algebroid, algebroid_op, k, functors, I;
#    
#    algebroid := Algebroid( collection );
#    
#    algebroid_op := OppositeAlgebroid( algebroid );
#    
#    SetAlgebroid( UnderlyingQuiverAlgebra( algebroid_op ), algebroid_op );
#    
#    k := CommutativeRingOfLinearCategory( algebroid_op );
#    
#    functors := Hom( algebroid_op, MatrixCategory( k ) );
#    
#    I := IsomorphismOntoCategoryOfQuiverRepresentations( functors );
#    
#    I := PostCompose( TensorFunctorFromCategoryOfQuiverRepresentations( collection ), I );
#    
#    I!.Name := "-⊗ T functor";
#    
#    return I;
#    
#end );

## In case the ambient category of the collection is abelian
##
InstallMethod( TensorFunctorFromCategoryOfQuiverRepresentations,
    [ IsStrongExceptionalCollection ],
    
  function( collection )
    local full, cat, T, I, TI, projs, reps, name, F;
    
    full := FullSubcategory( collection );
    
    cat := AmbientCategory( collection );
    
    if not ( HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) ) then
      
      TryNextMethod( );
      
    fi;
    
    T := TensorFunctorFromCategoryOfQuiverRepresentationsOnProjectiveObjects( collection );
    
    I := ExtendFunctorToAdditiveClosureOfSource( InclusionFunctor( full ) );
    
    projs := SourceOfFunctor( T );
    
    reps := AmbientCategory( projs  );
     
    name := "-⊗ T functor";
    
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
InstallMethod( TensorFunctorFromCategoryOfQuiverRepresentations,
    [ IsStrongExceptionalCollection ],
    
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
    
    T := TensorFunctorFromCategoryOfQuiverRepresentationsOnProjectiveObjects( collection );
    
    T := PreCompose(
                  LocalizationFunctorByProjectiveObjects( Ho_D ),
                  ExtendFunctorToHomotopyCategories( T )
                );
    
    T!.Name := "-⊗ T functor";
    
    return T;
    
end );


