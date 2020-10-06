#
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  Functors
##
#############################################################################

##
##
InstallMethod( HomFunctorAttr,
    [ IsExceptionalCollection ],
    
  function( collection )
    local full, A, field, A_op, quiver, arrows, labels, ambient_cat, reps, r, name, F;
    
    full := DefiningFullSubcategory( collection );
    
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
        
        dim_vec := [ ];
        
        bases := [ ];
        
        mats := [ ];
        
        for label in labels do
          
          i := label[ 1 ];
          
          j := label[ 2 ];
          
          k := label[ 3 ];
          
          if not IsBound( bases[ i ] ) then
            
            B := BasisOfExternalHom( UnderlyingCell( collection[ i ] ), V );
            
            bases[ i ] := B;
            
            dim_vec[ i ] := Size( B );
            
          fi;
          
          if not IsBound( bases[ j ] ) then
            
            B := BasisOfExternalHom( UnderlyingCell( collection[ j ] ), V );
            
            bases[ j ] := B;
            
            dim_vec[ j ] := Size( B );
             
          fi;
          
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
        
        if not IsDenseList( dim_vec ) then
          
          pos := PositionsProperty( [ 1 .. Length( dim_vec ) ], p -> not IsBound( dim_vec[ p ] ) );
          
          for p in pos do
            
            dim_vec[ p ] := Size( BasisOfExternalHom( UnderlyingCell( collection[ p ] ), V ) );
            
          od;
          
        fi;
        
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
            
            Add( current_mat, rel{ [ 2 .. Size( rel ) ] } );
          
          od;
          
          Add( mats, MatrixByRows( field, [ dim_vec_1[ i ], dim_vec_2[ i ] ], current_mat ) );
        
        od;
        
        return QuiverRepresentationHomomorphism( r1, r2, mats );
        
    end );
    
    return F;
    
end );

##
InstallMethod( HomFunctor, [ IsExceptionalCollection ], HomFunctorAttr );

########################################################
#
# if the collection is defined by subcategory
# which lives in the category of quiver representations
#
#########################################################

##
InstallMethod( HomFunctorOnIndecInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, reps, inj_indec, name, cell_func;
     
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) = fail then
      
      Error( "The method 'IndecInjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    H := HomFunctor( collection );
    
    reps := RangeOfFunctor( H );
    
    inj_indec := FullSubcategoryGeneratedByIndecInjectiveObjects( ambient_cat );
    
    name := "Hom(T,-) functor on indecomposable injective objects";
       
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( c ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, inj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( HomFunctorOnInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, can, can_H, name;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) = fail then
      
      TryNextMethod( );
      
    fi;
   
    H := HomFunctorOnIndecInjectiveObjects( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    can := EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecInjectiveObjects( ambient_cat );
    
    can_H := PreCompose( can, H );
    
    name := "Hom(T,-) functor on injective objects";
    
    can_H!.Name := name;
    
    return can_H;

end );

##
InstallMethod( HomFunctorOnIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, reps, proj_indec, name, cell_func;
     
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) = fail then
      
      Error( "The method 'IndecProjectiveObjects' should be applicable on the ambient category" );
      
    fi;
   
    H := HomFunctor( collection );
    
    reps := RangeOfFunctor( H );
    
    proj_indec := FullSubcategoryGeneratedByIndecProjectiveObjects( ambient_cat );
    
    name := "Hom(T,-) functor on indecomposable projective objects";
           
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( c ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, proj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( HomFunctorOnProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, can, can_H, name;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) = fail then
      
      TryNextMethod( );
      
    fi;
       
    H := HomFunctorOnIndecProjectiveObjects( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( ambient_cat );
    
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
InstallMethod( HomFunctorOnInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, projs;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecInjectiveObjects, [ ambient_cat ] ) <> fail then
      
      TryNextMethod( );
      
    fi;
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    H := HomFunctor( collection );
    
    projs := FullSubcategoryGeneratedByInjectiveObjects( ambient_cat );
    
    H := RestrictFunctorToFullSubcategoryOfSource( H, projs );
    
    H!.Name := "Hom(T,-) functor on injective objects";
    
    return H;
    
end );

##
InstallMethod( HomFunctorOnProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local ambient_cat, H, projs;
    
    ambient_cat := AmbientCategory( collection );
    
    if ApplicableMethod( IndecProjectiveObjects, [ ambient_cat ] ) <> fail then
      
      TryNextMethod( );
      
    fi;
   
    if not IsAbelianCategoryWithComputableEnoughProjectives( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    H := HomFunctor( collection );
    
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
InstallMethod( HomFunctorOnBaseCategory,
          [ IsExceptionalCollection ],
  function( collection )
    local H, Ho_C, C, B, reps, cell_func, name;
    
    H := HomFunctor( collection );
    
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
InstallMethod( HomFunctorOnDefiningCategory,
          [ IsExceptionalCollection ],
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
    
    H := HomFunctorOnBaseCategory( collection );
    
    H := ExtendFunctorToAdditiveClosureOfSource( H );
    
    H!.Name := "Hom(T,-) functor on additive closure category";
    
    return H;
   
end );

##
InstallMethod( HomFunctorOnDefiningCategory,
          [ IsExceptionalCollection ],
  function( collection )
    local H, Ho_C, C, I;
    
    H := HomFunctor( collection );
    
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

