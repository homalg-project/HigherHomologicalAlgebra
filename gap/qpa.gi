


################################
#
# Tools for qpa
#
################################

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

#         e                   s                   r=compose(e,s)
#    V_k --> V_m    x    V_m ---> V_n   ===> V_k ----------------> V_n
#
InstallGlobalFunction( MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement,
  
  function( source_list, range_list, e )
    local A, field, images, source_reps, paths, range_reps, coeffs, mat;
    
    A := AlgebraOfElement( e );
    
    field := LeftActingDomain( A );
     
    source_reps := List( source_list, Representative );
    
    source_reps := List( source_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( source_reps, r -> Size( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    paths := List( source_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Source ), s -> Target( Representative( e )!.paths[ 1 ] ) = s ) then
      
      Info( InfoWarning, 1, "This is not expected usage of the method\n" );
      
    fi;
    
    range_reps := List( range_list, Representative );
    
    range_reps := List( range_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( range_reps, r -> Size( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    images := List( source_list, s -> ComposeElements( e, s ) );
    
    coeffs := List( range_reps, r -> Inverse( r[ 1 ][ 1 ] ) );
    
    paths := List( range_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Source ), s -> s = Source( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoWarning, 1, "This is not expected usage of the method\n" );
      
    fi;
    
    mat := List( images, image -> ListN( coeffs, CoefficientsOfPaths( paths, image ), \* ) );
    
    return MatrixByRows( field, [ Size( source_list ), Size( range_reps ) ], mat );
  
end );


#         s                   e                   r=compose(s,e)
#    V_m --> V_n    x    V_n ---> V_?   ===> V_m ----------------> V_?
#
InstallGlobalFunction( MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement,
  
  function( source_list, range_list, e )
    local A, field, images, source_reps, paths, range_reps, coeffs, mat;
    
    A := AlgebraOfElement( e );
    
    field := LeftActingDomain( A );
     
    source_reps := List( source_list, Representative );
    
    source_reps := List( source_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( source_reps, r -> Size( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    paths := List( source_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Target ), t -> t = Source( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoWarning, 1, "This is not expected usage of the method\n" );
            
    fi;
    
    range_reps := List( range_list, Representative );
    
    range_reps := List( range_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( range_reps, r -> Size( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    coeffs := List( range_reps, r -> Inverse( r[ 1 ][ 1 ] ) );
    
    paths := List( range_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Target ), t -> t = Target( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoWarning, 1, "This is not expected usage of the method\n" );
 
    fi;
    
    images := List( source_list, s -> ComposeElements( s, e ) );
    
    mat := List( images, image -> ListN( coeffs, CoefficientsOfPaths( paths, image ), \* ) );
    
    return MatrixByRows( field, [ Size( source_list ), Size( range_reps ) ], mat );
    
end );

##
InstallMethod( MorphismBetweenIndecProjectivesGivenByElement,
    [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ],
  function( p1, e, p2 )
    local A, quiver, basis, b1, b2, mats;
    
    if IsZero( e ) then
      
      return ZeroMorphism( p1, p2 );
      
    fi;
    
    A := AlgebraOfElement( e );
    
    quiver := QuiverOfAlgebra( A );
    
    basis := BasisOfProjectives( A );
    
    b1 := basis[ PositionProperty( basis, p -> DimensionVector( p1 ) = List( p, Size ) ) ];
    
    b2 := basis[ PositionProperty( basis, p -> DimensionVector( p2 ) = List( p, Size ) ) ];
    
    mats := ListN( b1, b2, { bb1 , bb2 } -> MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement( bb1, bb2, e ) );
    
    return QuiverRepresentationHomomorphism( p1, p2, mats );
  
end );

##
InstallGlobalFunction( CertainRowsOfQPAMatrix,
  function( mat, L )
    local dim, rows;
    
    dim := DimensionsMat( mat );
    
    rows := RowsOfMatrix( mat );
    
    if not ForAll( L, i -> IsPosInt( i ) and i <= dim[ 1 ] ) then
      
      Error( "All indices should be less or equal to the number of rows!\n" );
      
    fi;
     
    if L = [ ] then
      
      return MakeZeroMatrix( BaseDomain( mat ), 0, dim[ 2 ] );
      
    fi;
    
    if dim[ 2 ] = 0 then
      
      return MakeZeroMatrix( BaseDomain( mat ), Size( L ), 0 );
      
    fi;
    
    rows := rows{ L };
   
    return MatrixByRows( BaseDomain( mat ), [ Size( L ), dim[ 2 ] ], rows );
  
end );

##
InstallGlobalFunction( CertainColumnsOfQPAMatrix,
  function( mat, L )
    local cols, dim;
    
    cols := ColsOfMatrix( mat );
    
    dim := DimensionsMat( mat );
    
    if not ForAll( L, i -> IsPosInt( i ) and i <= dim[ 2 ] ) then
      
      Error( "All indices should be less or equal to the number of columns!\n" );
      
    fi;
 
    if L = [ ] then
      
      return MakeZeroMatrix( BaseDomain( mat ), dim[ 1 ], 0 );
      
    fi;
    
    if dim[ 1 ] = 0 then
      
      return MakeZeroMatrix( BaseDomain( mat ), 0, Size( L ) );
      
    fi;
    
    cols := cols{ L };
    
    return MatrixByCols( BaseDomain( mat ), [ dim[ 1 ], Size( L ) ], cols );
  
end );

##
InstallGlobalFunction( StackMatricesDiagonally,
  function( mat_1, mat_2 )
    local d1,d2,F, mat_1_, mat_2_; 

    d1 := DimensionsMat( mat_1 );
    
    d2 := DimensionsMat( mat_2 );
   
    if d1 = [ 0, 0 ] then
      
      return mat_2;
      
    fi;
    
    if d2 = [ 0, 0 ] then
      
      return mat_1;
      
    fi;
   
    F := BaseDomain( mat_1 );
    
    if F <> BaseDomain( mat_2 ) then
      
       Error( "matrices over different rings" );
       
    fi;
   
    mat_1_ := StackMatricesHorizontally( mat_1, MakeZeroMatrix( F, d1[ 1 ], d2[ 2 ] ) );
    
    mat_2_ := StackMatricesHorizontally( MakeZeroMatrix( F, d2[ 1 ], d1[ 2 ] ), mat_2 );
    
    return StackMatricesVertically( mat_1_, mat_2_ );
    
end );



############################
#
# Operations
#
###########################


# The following method is correct only if the indecomposable projectives of the algebra form an exceptional collection.
# i.e., arrows go in one-direction.

##
InstallMethod( DecomposeProjectiveQuiverRepresentation,
          [ IsQuiverRepresentation ],
  function( a )
    local A, quiver, field, projs, mats_of_projs, dims, dim_vectors_of_projs, dim_vector_of_a, sol, nr_arrows, nr_vertices, positions_isolated_projs, new_a, new_dim_vec, mats, isolated_summands, diff, bool, o, found_part_identical_to_some_proj, check_for_block, i, dims_of_mats, current_mats_1, current_mats_2, current_mats_3, current_mats_4, found_part_isomorphic_to_some_proj, temp, b, s, d, morphism_from_new_a, B, m, k, p;
    
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
    
    if ForAny( sol, s -> s < 0 ) then
      
      Error( "Please check if the input is realy projective object!\n" );
      
    fi;
    
    nr_arrows := NumberOfArrows( quiver );
    
    nr_vertices := NumberOfVertices( quiver );
    
    positions_isolated_projs := PositionsProperty( dims, d -> IsZero( d ) );
    
    new_a := a;
    
    new_dim_vec := dim_vector_of_a;
    
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
          
          current_mats_1 :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                              [ 1 .. l[ 2 ] ]
                                                 )
               );
          
          current_mats_2 :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                              [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                           );
          
          if current_mats_1 = mats_of_projs[ i ] then
            
            current_mats_3 :=
              ListN( dims[ i ], mats,
                { l, m } -> CertainColumnsOfQPAMatrix(
                              CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                                [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                  );
            
            if not ForAll( current_mats_3, IsZero ) then
              
              i := i + 1;
              
              continue; 
            
            fi;
            
            current_mats_4 :=
              ListN( dims[ i ], mats,
                { l, m } -> CertainColumnsOfQPAMatrix(
                              CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                                [ 1 .. l[ 2 ] ]
                                                   )
                  );
            
            if not ForAll( current_mats_4, IsZero ) then
              
              i := i + 1;
              
              continue;
            
            fi;
            
            new_dim_vec := new_dim_vec - dim_vectors_of_projs[ i ];
            
            Add( o, IdentityMorphism( projs[ i ] ) );
            
            mats := current_mats_2;
            
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
        
          current_mats_1 :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                              [ 1 .. l[ 2 ] ]
                                                 )
               );
          
          current_mats_2 :=
            ListN( dims[ i ], mats,
              { l, m } -> CertainColumnsOfQPAMatrix(
                            CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                              [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                           );
          
          temp := LazyQuiverRepresentation( A, dim_vectors_of_projs[ i ], current_mats_1 );
          
          if IsWellDefined( temp ) then
            
            b := BasisOfExternalHom( projs[ i ], temp );
            
            if not ( Size( b ) = 1 and IsIsomorphism( b[ 1 ] ) ) then
                
                i := i + 1;
                
                continue;
            
            fi;
            
            current_mats_3 :=
              ListN( dims[ i ], mats,
                { l, m } -> CertainColumnsOfQPAMatrix(
                              CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                                [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                                   )
                  );
            
            if not ForAll( current_mats_3, IsZero ) then
              
              i := i + 1;
              
              continue; 
            
            fi;
            
            current_mats_4 :=
              ListN( dims[ i ], mats,
                { l, m } -> CertainColumnsOfQPAMatrix(
                              CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                                [ 1 .. l[ 2 ] ]
                                                   )
                  );
            
            if not ForAll( current_mats_4, IsZero ) then
              
              i := i + 1;
              
              continue;
            
            fi;
            
            new_dim_vec := new_dim_vec - dim_vectors_of_projs[ i ];
            
            Add( o, b[ 1 ] );
            
            mats := current_mats_2;
            
            found_part_isomorphic_to_some_proj := true;
            
            check_for_block := false;
          
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
    
    s := Concatenation( List( o, Range ), [ new_a ] );
     
    d := DirectSum( s );
     
    o := List( [ 1 .. Size( s ) - 1 ], i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, i, d ) );
    
    if IsZero( new_a ) then
      
      return o;
    
    else
      
      morphism_from_new_a := InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, Size( s ), d );
      
      Sort( projs, { a, b } -> IsEmpty( BasisOfExternalHom( a, b ) ) );
      
      for p in projs do
        
        B := BasisOfExternalHom( p, new_a );
        
        if IsEmpty( B ) then
          
          continue;
          
        fi;
        
        o := Concatenation( o, List( B, b -> PreCompose( b, morphism_from_new_a ) ) );
        
        m := MorphismBetweenDirectSums( List( B, b -> [ b ] ) );
        
        k := CokernelProjection( m );
        
        new_a := Range( k );
        
        Info( InfoWarning, 2, "DecomposeProjectiveObject: A lift in quiver representations is being computed" );
        
        morphism_from_new_a := PreCompose( Lift( IdentityMorphism( new_a ), k ), morphism_from_new_a );
        
        Info( InfoWarning, 2, "done ..." );
      
      od;
    
    fi;
    
    if not IsZero( new_a ) then
      
      Error( "Please check if the input is realy projective object!\n" );
    
    fi;
    
    return o;
    
end );

# to change the field of a quiver algebra
InstallMethod( \*,
    [ IsQuiverAlgebra, IsField ],
  function( A, field )
    local field_of_A, quiver, relations, n, coeffs_list, paths, path_algebra;
    
    field_of_A := LeftActingDomain( A );
    
    if IsIdenticalObj( field, field_of_A ) then
      
      return A;
      
    fi;
    
    quiver := QuiverOfAlgebra( A );
    
    relations := RelationsOfAlgebra( A );
    
    n := Length( relations );
    
    coeffs_list := List( relations, rel -> List( rel!.coefficients, String ) );
    
    paths := List( relations, rel -> rel!.paths );
    
    if HasIsRationalsForHomalg( field ) and IsRationalsForHomalg( field ) then
      
      coeffs_list := List( coeffs_list, coeff_list -> List( coeff_list, c -> c / field ) );
      
    elif field = Rationals then
      
      coeffs_list := List( coeffs_list, coeff_list -> List( coeff_list, c -> Rat( c ) ) );
      
    else
      
      Error( "Unknown field!" );
      
    fi;
    
    path_algebra := PathAlgebra( field, quiver );
    
    relations := List( [ 1 .. n ], i -> QuiverAlgebraElement( path_algebra, coeffs_list[ i ], paths[ i ] ) );
    
    return QuotientOfPathAlgebra( path_algebra, relations );
    
end );

#BindGlobal( "IndecProjRepresentationss",
#  function( A )
#    local B, quiver, nr_arrows, F, projs;
#  
#    B := BasisOfProjectives( A );
#  
#    quiver := QuiverOfAlgebra( A );
#  
#    nr_arrows := NumberOfArrows( quiver );
#  
#    F := function( L, arrow )
#          local i, j, e;
#        
#          i := VertexIndex( Source( arrow ) );
#        
#          j := VertexIndex( Target( arrow ) );
#        
#          e := PathAsAlgebraElement( A, arrow );
#        
#        return MatrixOfLinearMapDefinedByRightMultiplicationWithAlgebraElement( L[ i ], L[ j ], e );
#        
#    end;
#    
#    projs := List( B, L -> [ List( L, Size ), List( Arrows( quiver ), arrow -> F( L, arrow ) ) ] );
#
#    return List( projs, p -> QuiverRepresentation( A, p[ 1 ], p[ 2 ] ) );
#    
#end );

