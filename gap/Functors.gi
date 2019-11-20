
##
InstallMethod( HomFunctorByExceptionalCollection,
    [ IsExceptionalCollection ],
  function( collection )
    local full, field, A, A_op, quiver, arrows, labels, ambient_cat, reps, r, name, F;
    
    full := DefiningFullSubcategory( collection );
    
    field := CommutativeRingOfLinearCategory( full );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
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
    
    r := RANDOM_TEXT_ATTR();
    
    r[ 1 ] := Concatenation( " ", r[ 1 ] );
    
    r[ 2 ] := Concatenation( r[ 2 ], " " );
    
    name := Concatenation( "Hom(T,-) functor", r[ 1 ], "from", r[ 2 ], Name( ambient_cat ), r[ 1 ], "into", r[ 2 ], Name( reps ) );
    
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
            
            rel := AdditiveInverse( Inverse( rel[ 1 ][ 1 ] ) ) * rel[ 1 ];
            
            Add( current_mat, rel{ [ 2 .. dim_vec[ i ] + 1 ] } );
          
          od;
          
          Add( mats, MatrixByRows( field, [ dim_vec[ j ], dim_vec[ i ] ], current_mat ) );
        
        od;
        
        r := LazyQuiverRepresentation( A_op, dim_vec, mats );
        
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
            
            rel := AdditiveInverse( Inverse( rel[ 1 ][ 1 ] ) ) * rel[ 1 ];
            
            Add( current_mat, rel{ [ 2 .. Size( rel ) ] } );
          
          od;
          
          Add( mats, MatrixByRows( field, [ dim_vec_1[ i ], dim_vec_2[ i ] ], current_mat ) );
        
        od;
        
        return QuiverRepresentationHomomorphism( r1, r2, mats );
        
    end );
    
    return F;
    
end );

