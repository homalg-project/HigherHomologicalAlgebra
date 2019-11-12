

##
BindGlobal( "LazyQuiverRepresentation",

  function( A, dimensions, matrices )
    local cat, Q, objects, m, morphisms, i, a, source, range;

    cat := CategoryOfQuiverRepresentations( A );
    Q := QuiverOfAlgebra( A );

    objects := List( dimensions, VectorSpaceConstructor( cat ) );

    m := LinearTransformationConstructor( cat );
    
    morphisms := [];
    
    for i in [ 1 .. Size( matrices ) ] do
      a := Arrow( Q, i );
      source := objects[ VertexIndex( Source( a ) ) ];
      range := objects[ VertexIndex( Target( a ) ) ];
      morphisms[ i ] := m( source, range, matrices[ i ] );
    od;

    return QuiverRepresentationNC( cat, objects, morphisms );
end );


# The following method is correct only if the indecomposable projectives of the algebra form an exceptional collection.
# i.e., arrows go in one-direction.

##
InstallMethod( DecomposeProjectiveObject,
          [ IsQuiverRepresentation ],
  function( a )
    local A, quiver, field, projs, mats_of_projs, dims, dim_vectors_of_projs, dim_vector_of_a, sol, nr_arrows, nr_vertices, positions_isolated_projs, new_a, mats, isolated_summands, new_dim_vec, diff, bool, o, found_part_identical_to_some_proj, check_for_block, i, dims_of_mats, current_mats, found_part_isomorphic_to_some_proj, current_proj, temp, b, s, d, morphism_into_new_a, dim_projs, dim, p, B, m, k;
    
    if IsZero( a ) then
      
      return [ IdentityMorphism( a ) ];
      
    fi;
    
    A := AlgebraOfRepresentation( a );
    
    quiver := QuiverOfAlgebra( A );
    
    field := LeftActingDomain( A );
    
    projs := ShallowCopy( IndecProjRepresentations( A ) );
    
    mats_of_projs:= List( projs, MatricesOfRepresentation );
    
    dims := List( mats_of_projs, mats -> List( mats, DimensionsMat ) );

    dim_vectors_of_projs := List( projs, DimensionVector );
    
    dim_vector_of_a := DimensionVector( a );
    
    sol := SolutionIntMat( dim_vectors_of_projs, dim_vector_of_a );
    
    nr_arrows := NumberOfArrows( quiver );
    
    nr_vertices := NumberOfVertices( quiver );
    
    positions_isolated_projs := PositionsProperty( dims, d -> IsZero( d ) );
    
    new_a := a;
    
    mats := MatricesOfRepresentation( new_a );
    
    isolated_summands := [ ];
    
    if not IsEmpty( positions_isolated_projs ) then
      
      new_dim_vec := dim_vector_of_a - Sum( List( positions_isolated_projs, p -> sol[ p ] * dim_vectors_of_projs[ p ] ) );
      
      new_a := LazyQuiverRepresentation( A, new_dim_vec, mats );     
      
      isolated_summands := List( positions_isolated_projs, p -> ListWithIdenticalEntries( sol[ p ], projs[ p ] ) );
      
      isolated_summands := List( Concatenation( isolated_summands ), IdentityMorphism );
      
      diff := Difference( [ 1 .. nr_vertices ], positions_isolated_projs );
      
      projs := projs{ diff };
    
      dim_vectors_of_projs := dim_vectors_of_projs{ diff };
      
      mats_of_projs := mats_of_projs{ diff };
      
      dims := dims{ diff };
     
    fi;
    
    bool := true;
    
    o := isolated_summands;
    
    while bool do
      
      found_part_identical_to_some_proj := false;
      
      check_for_block := true;
      
      i := 1;
      
      while check_for_block and i <= Size( dims ) do
        
        dims_of_mats := List( mats, DimensionsMat );
                
        if not ForAny( Concatenation( dims_of_mats - dims[ i ] ), IsNegInt ) then
          
          current_mats :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                              [ 1 .. l[ 2 ] ]
                                                 )
               );
          
          if current_mats = mats_of_projs[ i ] then
            
            current_mats := ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                    CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                      [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                           );
            
            
            if ForAll( mats_of_projs[ i ], IsZero ) then
                
                if not mats = ListN( mats_of_projs[ i ], current_mats, StackMatricesDiagonally ) then
                  
                  i := i + 1;
                  
                  continue;
                
                fi;
            
            fi;
            
            new_dim_vec := new_dim_vec - dim_vectors_of_projs[ i ];
            
            Add( o, IdentityMorphism( projs[ i ] ) );
            
            mats := current_mats;
            
            found_part_identical_to_some_proj := true;
            
            check_for_block := false;
          
          fi;
        
        fi;
        
        i := i + 1;
        
      od;
      
      if found_part_identical_to_some_proj then
        
        continue;
      
      fi;
       
      found_part_isomorphic_to_some_proj := false;
      
      check_for_block := true;
      
      i := 1;
      
      while check_for_block and i <= Size( dims ) do
          
        dims_of_mats := List( mats, DimensionsMat );
               
        if not ForAny( Concatenation( dims_of_mats - dims[ i ] ), IsNegInt ) then
        
          current_mats :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                              [ 1 .. l[ 2 ] ]
                                                 )
               );
          
          current_proj := projs[ i ];
         
          temp := LazyQuiverRepresentation( A, dim_vectors_of_projs[ i ], current_mats );
          
          if IsWellDefined( temp ) then
            
            b := BasisOfExternalHom( temp, projs[ i ] );
          
            if Size( b ) = 1 and IsIsomorphism( b[ 1 ] ) then
            
              current_mats := ListN( dims[ i ], mats,
                { l, m } -> CertainColumnsOfQPAMatrix(
                    CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                      [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                           );
                       
              if ForAll( mats_of_projs[ i ], IsZero ) then
              
                if not mats = ListN( mats_of_projs[ i ], current_mats, StackMatricesDiagonally ) then
              
                  i := i + 1;
              
                  continue;
                  
                fi;
              
              fi;
                        
              new_dim_vec := new_dim_vec - dim_vectors_of_projs[ i ];
            
              Add( o, b[ 1 ] );
            
              mats := current_mats;
             
              found_part_isomorphic_to_some_proj := true;
            
              check_for_block := false;
         
            fi;
            
          fi;
        
        fi;
        
        i := i + 1;
        
      od;
      
      if found_part_isomorphic_to_some_proj then
        
        continue;
        
      fi;
     
      bool := false;
      
    od;
    
    new_a := LazyQuiverRepresentation( A, new_dim_vec, mats );
    
    s := Concatenation( List( o, Source ), [ new_a ] );
     
    d := DirectSum( s );
     
    o := List( [ 1 .. Size( s ) - 1 ], i -> ProjectionInFactorOfDirectSumWithGivenDirectSum( s, i, d ) );
     
    if IsZero( new_a ) then
      
      return o;
      
    else
      
      morphism_into_new_a := ProjectionInFactorOfDirectSumWithGivenDirectSum( s, Size( s ), d );
      
      Sort( projs, { a, b } -> IsEmpty( BasisOfExternalHom( b, a ) ) );

      dim_projs := List( projs, DimensionVector );
      
      dim := DimensionVector( new_a );
      
      sol := SolutionIntMat( dim_projs, dim );
      
      p := PositionsProperty( sol, s -> not IsZero( s ) );
      
      for i in p do
        
        B := BasisOfExternalHom( new_a, projs[ i ] );
   
        o := Concatenation( o, List( B, b -> PreCompose( morphism_into_new_a, b ) ) );
        
        m := MorphismBetweenDirectSums( [ B ] );
    
        k := KernelEmbedding( m );
          
        new_a := Source( k );
        
        Info( InfoWarning, 2, "DecomposeProjectiveObject: A colift in quiver representations is being computed" );
        
        morphism_into_new_a := PreCompose( morphism_into_new_a, Colift( k, IdentityMorphism( Source( k ) ) ) );
        
        Info( InfoWarning, 2, "done ..." );
       
      od;
      
    fi;
    
    if IsZero( new_a ) then
      
      Error( "Please check if the input is realy projective object!\n" );
      
    fi;
    
    return o;
    
end );

