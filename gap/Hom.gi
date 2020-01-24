#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
##
##  Functors
##
#############################################################################

##
InstallMethod( HomFunctorByExceptionalCollection,
    [ IsExceptionalCollection ],
    
  function( collection )
    local full, A, field, A_op, quiver, arrows, labels, ambient_cat, reps, r, name, F;
    
    full := DefiningFullSubcategory( collection );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
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
    
    reps := CategoryOfQuiverRepresentations( A_op, CommutativeRingOfLinearCategory( full ) );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( ambient_cat ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
       
    F := CapFunctor( name, ambient_cat, reps );
    
    AddObjectFunction( F,
      function( V )
        local dim_vec, bases, mats, i, j, k, a, Ei_to_V, current_mat, rel, r, label, alpha;
        
        dim_vec := [ ];
        
        bases := [ ];
        
        mats := [ ];
        
        for label in labels do
          
          i := label[ 1 ];
          
          j := label[ 2 ];
          
          k := label[ 3 ];
          
          if not IsBound( bases[ i ] ) then
            
            Add( bases, BasisOfExternalHom( UnderlyingCell( collection[ i ] ), V ), i );
            
            Add( dim_vec, Size( bases[ i ] ), i );
          
          fi;
          
          if not IsBound( bases[ j ] ) then
            
            Add( bases, BasisOfExternalHom( UnderlyingCell( collection[ j ] ), V ), j );
            
            Add( dim_vec, Size( bases[ j ] ), j );
          
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

########################################################
#
# if the collection is defined by subcategory
# which lives in the category of quiver representations
#
#########################################################

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToIndecInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local H, ambient_cat, reps, inj_indec, r, name, cell_func;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    if not IsQuiverRepresentationCategory( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    reps := AsCapCategory( Range( H ) );
    
    inj_indec := FullSubcategoryGeneratedByIndecInjectiveObjects( ambient_cat );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( inj_indec ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
    
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( UnderlyingCell( c ) ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, inj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local cat, G, add_G, can, can_add_G, injs, reps, r, name, R;
    
    cat := AmbientCategory( DefiningFullSubcategory( collection ) );
    
    if not IsQuiverRepresentationCategory( cat ) then
      
      TryNextMethod( );
      
    fi;
    
    G := RestrictionOfHomFunctorByExceptionalCollectionToIndecInjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    can := EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecInjectiveObjects( cat );
    
    can_add_G := PreCompose( can, add_G );
    
    injs := AsCapCategory( Source( can_add_G ) );
    
    reps := AsCapCategory( Range( can_add_G ) );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( injs ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
       
    R := CapFunctor( name, injs, reps );
    
    AddObjectFunction( R, FunctorObjectOperation( can_add_G ) );
    
    AddMorphismFunction( R, FunctorMorphismOperation( can_add_G ) );
    
    return R;

end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local H, ambient_cat, reps, proj_indec, r, name, cell_func;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    if not IsQuiverRepresentationCategory( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    reps := AsCapCategory( Range( H ) );
    
    proj_indec := FullSubcategoryGeneratedByIndecProjectiveObjects( ambient_cat );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( proj_indec ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
        
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( UnderlyingCell( c ) ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, proj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local cat, G, add_G, can, can_add_G, projs, reps, r, name, R;
    
    cat := AmbientCategory( DefiningFullSubcategory( collection ) );
    
    if not IsQuiverRepresentationCategory( cat ) then
      
      TryNextMethod( );
      
    fi;
    
    G := RestrictionOfHomFunctorByExceptionalCollectionToIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( cat );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    reps := AsCapCategory( Range( can_add_G ) );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( projs ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
        
    R := CapFunctor( name, projs, reps );
    
    AddObjectFunction( R, FunctorObjectOperation( can_add_G ) );
    
    AddMorphismFunction( R, FunctorMorphismOperation( can_add_G ) );
    
    return R;

end );

###############################################
#
# if the collection is defined by subcategory
# which lives in some homotopy category
# of quiver representations
#
###############################################

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local H, ambient_cat, reps, C, chains_C, proj, proj_indec, r, name, cell_func;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    if not IsHomotopyCategory( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
     
    C := DefiningCategory( ambient_cat );
    
    if not IsQuiverRepresentationCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    chains_C := ChainComplexCategory( C );
    
    proj := FullSubcategoryGeneratedByProjectiveObjects( C );
    
    proj_indec := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
    
    reps := AsCapCategory( Range( H ) );
    
    H := PreCompose( [ InclusionFunctor( proj_indec ), InclusionFunctor( proj ),
            StalkChainFunctor( C, 0 ), ProjectionFunctor( ambient_cat ), H ] );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( proj_indec ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
   
    cell_func := c -> ApplyFunctor( H, c );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, proj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local cat, C, G, add_G, can, can_add_G, projs, reps, r, name, R;
    
    cat := AmbientCategory( DefiningFullSubcategory( collection ) );
    
    if not IsHomotopyCategory( cat ) then
      
      TryNextMethod( );
      
    fi;
    
    C := DefiningCategory( cat );
    
    G := RestrictionOfHomFunctorByExceptionalCollectionToIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    reps := AsCapCategory( Range( can_add_G ) );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( projs ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );
       
    R := CapFunctor( name, projs, reps );
    
    AddObjectFunction( R, FunctorObjectOperation( can_add_G ) );
    
    AddMorphismFunction( R, FunctorMorphismOperation( can_add_G ) );
    
    return R;

end );


###############################################
#
# if the collection is defined by subcategory
# which lives in some homotopy category
# of some additive closure category
#
###############################################

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToAdditiveClosure,
          [ IsExceptionalCollection ],
  function( collection )
    local H, ambient_cat, C, chains_C, indec_C, reps, cell_func, r, name, F;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    if not IsHomotopyCategory( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
     
    C := DefiningCategory( ambient_cat );
    
    if not IsAdditiveClosureCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    chains_C := UnderlyingCategory( ambient_cat );
    
    indec_C := UnderlyingCategory( C );
    
    reps := AsCapCategory( Range( H ) );
    
    H := PreCompose( [
                      InclusionFunctorInAdditiveClosure( indec_C ),
                      StalkChainFunctor( C, 0 ),
                      ProjectionFunctor( ambient_cat ),
                      H
                     ] );
    
    cell_func := c -> ApplyFunctor( H, c );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "\033[1mHom(T,-)", r[ 2 ], " functor ", r[ 1 ], ":", r[ 2 ], " ",
              Name( indec_C ), " ", r[ 1 ], "--->", r[ 2 ] , " ", Name( reps ) );

    
    F := FunctorFromLinearCategoryByTwoFunctions( name, indec_C, reps, cell_func, cell_func );
    
    return ExtendFunctorToAdditiveClosureOfSource( F );
   
end );

