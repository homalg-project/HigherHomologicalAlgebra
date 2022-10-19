# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  Functors
##
#############################################################################


##
#InstallMethod( HomFunctorToCategoryOfFunctors,
#    [ IsStrongExceptionalCollection ],
#  function( collection )
#    local algebroid, algebroid_op, k, functors, I;
#    
#    algebroid := Algebroid( collection );
#    
#    algebroid_op := OppositeAlgebroid( algebroid );
#    
#    ## This line should removed after changing the constructor in Algebroids package
#    SetAlgebroid( UnderlyingQuiverAlgebra( algebroid_op ), algebroid_op );
#    
#    k := CommutativeRingOfLinearCategory( algebroid_op );
#    
#    functors := Hom( algebroid_op, MatrixCategory( k ) );
#    
#    I := IsomorphismFromCategoryOfQuiverRepresentations( functors );
#    
#    I := PreCompose( HomFunctorToCategoryOfQuiverRepresentations( collection ), I );
#    
#    I!.Name := "Hom(T,-) functor";
#    
#    return I;
#    
#end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentations,
    [ IsStrongExceptionalCollection ],
    
  function( collection )
    local full, A, field, A_op, quiver, arrows, labels, ambient_cat, reps, r, name, F;
    
    full := FullSubcategory( collection );
    
    A := EndomorphismAlgebra( collection );
    
    field := LeftActingDomain( A );
    
    A_op := OppositeAlgebra( A );
    
    quiver := QuiverOfAlgebra( A );
    
    arrows := Arrows( quiver );
    
    labels := List( arrows,
                arrow ->
                  [
                    VertexIndex( Source( arrow ) ),
                    VertexIndex( Target( arrow ) ),
                    Int( SplitString( Label( arrow ), "_" )[ 3 ] )
                  ]
              );
    
    ambient_cat := AmbientCategory( full );
    
    if not HasRangeCategoryOfHomomorphismStructure( ambient_cat ) then
      
      Error( "We need homomorphism structure on ", Name( ambient_cat ), "!\n" );
    
    fi;
    
    reps := CategoryOfQuiverRepresentations( A_op );
    
    name := "Hom(T,-) functor";
          
    F := CapFunctor( name, ambient_cat, reps );
    
    AddObjectFunction( F,
      function( V )
        local dim_vec, bases, mats, i, j, k, B, a, Ei_to_V, current_mat, rel, pos, r, label, alpha, p;
        
        dim_vec := List( [ 1 .. NumberOfVertices( quiver ) ], i -> "?" );
        
        bases := List( [ 1 .. NumberOfVertices( quiver ) ], i -> "?" );
        
        mats := [ ];
        
        for label in labels do
          
          i := label[ 1 ];
          
          j := label[ 2 ];
          
          for k in [ i, j ] do
            
            if bases[ k ] = "?" then
              
              B := BasisOfExternalHom( UnderlyingCell( collection[ k ] ), V );
              
              bases[ k ] := B;
              
              dim_vec[ k ] := Length( B );
              
            fi;
          
          od;
          
          k := label[ 3 ];
          
          a := UnderlyingCell( Arrows( collection, i, j )[ k ] );
                    
          Ei_to_V := List( bases[ j ], b -> PreCompose( a, b ) );
          
          current_mat := [ ];
          
          for alpha in Ei_to_V do
            
            rel := RelationsBetweenMorphisms( Concatenation( [ alpha ], bases[ i ] ) );
            
            rel := List( rel[ 1 ], r -> r / field );
            
            rel := AdditiveInverse( Inverse( rel[ 1 ] ) ) * rel;
            
            Add( current_mat, rel{ [ 2 .. dim_vec[ i ] + 1 ] } );
          
          od;
          
          Add( mats, MatrixByRows( field, [ dim_vec[ j ], dim_vec[ i ] ], current_mat ) );
        
        od;
        
        pos := Positions( dim_vec, "?" );
          
        for p in pos do
            
          bases[ p ] := BasisOfExternalHom( UnderlyingCell( collection[ p ] ), V );
          
          dim_vec[ p ] := Length( bases[ p ] );
          
        od;
        
        r := QuiverRepresentation( A_op, dim_vec, mats );
        
        MakeImmutable( bases );
        
        r!.bases_of_vector_spaces := bases;
        
        return r;
    
    end );
    
    AddMorphismFunction( F,
      function( r1, alpha, r2 )
        local dim_vec_1, dim_vec_2, bases_1, bases_2, mats, current_mat, rel, i, b;
        
        dim_vec_1 := DimensionVector( r1 );
        
        dim_vec_2 := DimensionVector( r2 );
        
        bases_1 := List( r1!.bases_of_vector_spaces, maps -> List( maps, map -> PreCompose( map, alpha ) ) );
        
        bases_2 := r2!.bases_of_vector_spaces;
        
        mats := [ ];
        
        for i in [ 1 .. NumberOfObjects( collection ) ] do
          
          current_mat := [ ];
          
          for b in bases_1[ i ] do
            
            rel := RelationsBetweenMorphisms( Concatenation( [ b ], bases_2[ i ] ) );
            
            rel := List( rel[ 1 ], r -> r / field );
            
            rel := AdditiveInverse( Inverse( rel[ 1 ] ) ) * rel;
            
            Add( current_mat, rel{ [ 2 .. Length( rel ) ] } );
          
          od;
          
          Add( mats, MatrixByRows( field, [ dim_vec_1[ i ], dim_vec_2[ i ] ], current_mat ) );
        
        od;
        
        return QuiverRepresentationHomomorphism( r1, r2, mats );
        
    end );
    
    return F;
    
end );

########################################################
#
# if the collection is defined by subcategory
# which lives in the category of quiver representations
#
#########################################################

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnIndecInjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, reps, inj_indec, name, cell_func;
     
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) = fail then
      
      Error( "The method 'IndecInjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    reps := RangeOfFunctor( H );
    
    inj_indec := FullSubcategoryGeneratedByIndecInjectiveObjects( ambient_cat );
    
    name := "Hom(T,-) functor on indecomposable injective objects";
       
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( c ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, inj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnInjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, can, can_H, name;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) = fail then
      
      TryNextMethod( );
      
    fi;
   
    H := HomFunctorToCategoryOfQuiverRepresentationsOnIndecInjectiveObjects( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    can := DecompositionFunctorOfInjectiveQuiverRepresentations( ambient_cat );
    
    can_H := PreCompose( can, H );
    
    name := "Hom(T,-) functor on injective objects";
    
    can_H!.Name := name;
    
    return can_H;

end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnIndecProjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, reps, proj_indec, name, cell_func;
     
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) = fail then
      
      Error( "The method 'IndecProjectiveObjects' should be applicable on the ambient category" );
      
    fi;
   
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    reps := RangeOfFunctor( H );
    
    proj_indec := FullSubcategoryGeneratedByIndecProjectiveObjects( ambient_cat );
    
    name := "Hom(T,-) functor on indecomposable projective objects";
           
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( c ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, proj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnProjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, can, can_H, name;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) = fail then
      
      TryNextMethod( );
      
    fi;
       
    H := HomFunctorToCategoryOfQuiverRepresentationsOnIndecProjectiveObjects( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    can := DecompositionFunctorOfProjectiveQuiverRepresentations( ambient_cat );
    
    can_H := PreCompose( can, H );
        
    name := "Hom(T,-) functor on projective objects";
  
    can_H!.Name := name;
    
    return can_H;

end );

###############################################
#
# if the collection is defined by subcategory
# which lives in abelian category with enough
# projectives or injectives
#
###############################################

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnInjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, projs;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) <> fail then
      
      TryNextMethod( );
      
    fi;
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    projs := FullSubcategoryGeneratedByInjectiveObjects( ambient_cat );
    
    H := RestrictFunctorToFullSubcategoryOfSource( H, projs );
    
    H!.Name := "Hom(T,-) functor on injective objects";
    
    return H;
    
end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnProjectiveObjects,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local ambient_cat, H, projs;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) <> fail then
      
      TryNextMethod( );
      
    fi;
   
    if not IsAbelianCategoryWithComputableEnoughProjectives( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    projs := FullSubcategoryGeneratedByProjectiveObjects( ambient_cat );
    
    H := RestrictFunctorToFullSubcategoryOfSource( H, projs );
    
    H!.Name := "Hom(T,-) functor on projective objects";
    
    return H;
    
end );

########################################################
#
# If the collection lives in some homotopy categpry
#
########################################################

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnBaseCategory,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local H, Ho_C, C, B, reps, cell_func, name;
    
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    Ho_C := AmbientCategory( collection );
    
    if not IsHomotopyCategory( Ho_C ) then
      
      TryNextMethod( );
      
    fi;
     
    C := DefiningCategory( Ho_C );
    
    if not IsAdditiveClosureCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    B := UnderlyingCategory( C );
    
    reps := RangeOfFunctor( H );
    
    H := PreCompose( [
                      InclusionFunctorInAdditiveClosure( B ),
                      StalkChainFunctor( C, 0 ),
                      ProjectionFunctor( Ho_C ),
                      H
                     ] );
    
    cell_func := c -> ApplyFunctor( H, c );
    
    name := "Hom(T,-) functor on full subcategory generated by finite list of objects";
    
    return FunctorFromLinearCategoryByTwoFunctions( name, B, reps, cell_func, cell_func );
   
end );


##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnDefiningCategory,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local Ho_C, C, H;
    
    Ho_C := AmbientCategory( collection );
    
    if not IsHomotopyCategory( Ho_C ) then
      
      TryNextMethod( );
      
    fi;
     
    C := DefiningCategory( Ho_C );
    
    if not IsAdditiveClosureCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    H := HomFunctorToCategoryOfQuiverRepresentationsOnBaseCategory( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    H!.Name := "Hom(T,-) functor on additive closure category";
    
    return H;
   
end );

##
InstallMethod( HomFunctorToCategoryOfQuiverRepresentationsOnDefiningCategory,
          [ IsStrongExceptionalCollection ],
  function( collection )
    local H, Ho_C, C, I;
    
    H := HomFunctorToCategoryOfQuiverRepresentations( collection );
    
    Ho_C := AmbientCategory( collection );
    
    if not IsHomotopyCategory( Ho_C ) then
      
      TryNextMethod( );
      
    fi;
     
    C := DefiningCategory( Ho_C );
    
    if IsAdditiveClosureCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    I := EmbeddingFunctorInHomotopyCategory( C );
    
    H := PreCompose( I, H );
    
    H!.Name := "Hom(T,-) functor";
    
    return H;
    
end );

