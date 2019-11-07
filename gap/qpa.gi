

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

Decompose1 :=
  function( a )
    local A, projs, dim_projs, dim, sol, i, B, m, k, l;
    
    A := AlgebraOfRepresentation( a );
    
    projs := ShallowCopy( IndecProjRepresentations( A ) );
    
    Sort( projs, {p1,p2} -> Size( PositionsProperty( DimensionVector( p1 ), IsZero ) ) > Size( PositionsProperty( DimensionVector( p2 ), IsZero ) ) );
    
    dim_projs := List( projs, DimensionVector );
    
    dim := DimensionVector( a );
    
    if IsZero( dim ) then
      
      return [ ];
      
    fi;
    
    sol := SolutionIntMat( dim_projs, dim );
    
    i := PositionProperty( sol, s -> not IsZero( s ) );
    
    B := BasisOfExternalHom( a, projs[ i ] );
   
    m := MorphismBetweenDirectSums( [ B ] );
    
    k := KernelEmbedding( m );
    
    if IsZero( k ) then
      
      return B;
      
    else
      
      l := Colift( k, IdentityMorphism( Source( k ) ) );
      
      return Concatenation( B, List( Decompose1( Source( k ) ), d -> PreCompose( l, d ) ) );
      
    fi;
    
end;

Decompose2 :=
  function( a )
    local A, projs, dim_projs, dim, sol, i, B, m, cok, l;
    
    A := AlgebraOfRepresentation( a );
    
    projs := ShallowCopy( IndecProjRepresentations( A ) );
    
    Sort( projs, {p1,p2} -> Size( PositionsProperty( DimensionVector( p1 ), IsZero ) ) < Size( PositionsProperty( DimensionVector( p2 ), IsZero ) ) );
    
    dim_projs := List( projs, DimensionVector );
    
    dim := DimensionVector( a );
    
    if IsZero( dim ) then
      
      return [ ];
      
    fi;
    
    sol := SolutionIntMat( dim_projs, dim );
    
    i := PositionProperty( sol, s -> not IsZero( s ) );
    
    B := BasisOfExternalHom( projs[ i ], a );
   
    m := MorphismBetweenDirectSums( List( B, b -> [ b ] ) );
    
    cok := CokernelProjection( m );
    
    if IsZero( cok ) then
      
      return B;
      
    else
      
      l := Lift( IdentityMorphism( Range( cok ) ), cok );
      
      return Concatenation( B, List( Decompose2( Range( cok ) ), d -> PreCompose( d, l ) ) );
      
    fi;
    
end;

##
InstallGlobalFunction( CertainRowsOfQPAMatrix,
  function( mat, L )
    local dim, rows, l;
    
    dim := DimensionsMat( mat );
    
    rows := RowsOfMatrix( mat );
    
    l := Filtered( L, e -> e in [ 1 .. DimensionsMat( mat )[ 1 ] ] );
     
    if l = [ ] then
      
      return MakeZeroMatrix( BaseDomain( mat ), 0, dim[ 2 ] );
      
    fi;
    
    if dim[ 2 ] = 0 then
      
      return MakeZeroMatrix( BaseDomain( mat ), Size( l ), 0 );
      
    fi;
    
    rows := rows{ l };
   
    return MatrixByRows( BaseDomain( mat ), [ Size( l ), dim[ 2 ] ], rows );
  
end );

##
InstallGlobalFunction( CertainColumnsOfQPAMatrix,
  function( mat, L )
    local cols, dim, l;
    
    cols := ColsOfMatrix( mat );
    
    dim := DimensionsMat( mat );
    
    l := Filtered( L, e -> e in [ 1 .. dim[ 2 ] ] );
 
    if l = [ ] then
      
      return MakeZeroMatrix( BaseDomain( mat ), dim[ 1 ], 0 );
      
    fi;
    
    if dim[ 1 ] = 0 then
      
      return MakeZeroMatrix( BaseDomain( mat ), 0, Size( l ) );
      
    fi;
    
    cols := cols{ l };
    
    return MatrixByCols( BaseDomain( mat ), [ dim[ 1 ], Size( l ) ], cols );
  
end );

##
InstallMethod( DecomposeProjectiveQuiverRepresentation,
        [ IsQuiverRepresentation ],
  function( a )
    local A, quiver, projs, dimension_vectors_of_projs, dimension_vector_of_a, sol, nr_arrows,
      nr_vertices, mats_of_projs, dims, positions_simple_projs, summands, mats_of_a, F;
    
    if IsZero( a ) then
      
      return [ a ];
      
    fi;
        
    A := AlgebraOfRepresentation( a );
    
    quiver := QuiverOfAlgebra( A );
    
    projs := IndecProjRepresentations( A );
    
    dimension_vectors_of_projs := List( projs, DimensionVector );
    
    dimension_vector_of_a := DimensionVector( a );
    
    sol := SolutionIntMat( dimension_vectors_of_projs, dimension_vector_of_a );
    
    nr_arrows := NumberOfArrows( quiver );
    
    nr_vertices := NumberOfVertices( quiver );
    
    mats_of_projs:= List( projs, MatricesOfRepresentation );
    
    dims := List( mats_of_projs, mats -> List( mats, DimensionsMat ) );
    
    positions_simple_projs := PositionsProperty( dims, IsZero );
    
    summands := List( positions_simple_projs, p -> ListWithIdenticalEntries( sol[ p ], projs[ p ] ) );
    
    summands := Concatenation( summands );
    
    projs := projs{ Difference( [ 1 .. nr_vertices ], positions_simple_projs ) };
    
    dims := dims{ Difference( [ 1 .. nr_vertices ], positions_simple_projs ) };
    
    mats_of_projs := mats_of_projs{ Difference( [ 1 .. nr_vertices ], positions_simple_projs ) };
    
    mats_of_a := MatricesOfRepresentation( a );
    
    F := function( matrices )
      local dims_of_mats, p, d;
      
      dims_of_mats := List( matrices, DimensionsMat );
      
      p := Positions( dims, dims_of_mats );
      
      if Length( p ) = 1 then
        
        return [ projs[ p[ 1 ] ] ];
        
      elif Length( p ) > 2 then
      
        Error( "This should not happen, please report this" );
      
      fi;
      
      p := PositionProperty( dims,
        dim -> 
          ListN( dim, matrices,
            { l, m } -> CertainColumnsOfQPAMatrix(
                          CertainRowsOfQPAMatrix( m, [ 1 .. l[ 1 ] ] ),
                          [ 1 .. l[ 2 ] ]
                                                 )
               ) 
          = mats_of_projs[ Position( dims, dim ) ] );
      
      if p = fail then
        
        return fail;
        
      fi;
      
      matrices := ListN( dims[ p ], matrices,
        { l, m } -> CertainColumnsOfQPAMatrix(
                      CertainRowsOfQPAMatrix( m, [ l[ 1 ] + 1 .. DimensionsMat( m )[ 1 ] ] ),
                      [ l[ 2 ] + 1 .. DimensionsMat( m )[ 2 ] ]
                                             )
                           );
      
      d := F( matrices );
      
      if d <> fail then
        
        return Concatenation( [ projs[ p ] ], d );
        
      else
        
        return fail;
        
      fi;
    
    end;
    
    return Concatenation( summands, F( mats_of_a ) );
    
end );



#DeclareOperation( "PathsBetweenTwoVertices", [ IsQuiverAlgebra, IsInt, IsInt ] );
#
###
#InstallMethod( PathsBetweenTwoVertices,
#    [ IsQuiverAlgebra, IsInt, IsInt ],
#  function( A, i, j )
#    local quiver, G;
#    
#    quiver := QuiverOfAlgebra( A );
#    
#    G := GeneratorsOfLeftOperatorAdditiveGroup( A );
#    
#    if IsQuotientOfPathAlgebra( A ) then
#      
#      return Filtered( G, g -> 
#        Source( g!.representative!.paths[1] ) = Vertex( quiver, i )
#          and Target( g!.representative!.paths[1] ) = Vertex( quiver, j ) );
#    else
#      
#      return Filtered( G, g -> 
#        Source( g!.paths[1] ) = Vertex( quiver, i )
#          and Target( g!.paths[1] ) = Vertex( quiver, j ) );
#      
#    fi;
#  
#end );


## to change the field of a quiver algebra
#InstallMethod( \*,
#    [ IsQuiverAlgebra, IsField ],
#  function( A, field )
#    local field_of_A, quiver, relations, n, coeffs_list, paths, path_algebra;
#    
#    field_of_A := LeftActingDomain( A );
#    
#    if IsIdenticalObj( field, field_of_A ) then
#      
#      return A;
#      
#    fi;
#    
#    quiver := QuiverOfAlgebra( A );
#    
#    relations := RelationsOfAlgebra( A );
#    
#    n := Length( relations );
#    
#    coeffs_list := List( relations, rel -> List( rel!.coefficients, String ) );
#    
#    paths := List( relations, rel -> rel!.paths );
#    
#    if HasIsRationalsForHomalg( field ) and IsRationalsForHomalg( field ) then
#      
#      coeffs_list := List( coeffs_list, coeff_list -> List( coeff_list, c -> c / field ) );
#      
#    elif field = Rationals then
#      
#      coeffs_list := List( coeffs_list, coeff_list -> List( coeff_list, c -> Rat( c ) ) );
#      
#    else
#      
#      Error( "Unknown field!" );
#      
#    fi;
#    
#    path_algebra := PathAlgebra( field, quiver );
#    
#    relations := List( [ 1 .. n ], i -> QuiverAlgebraElement( path_algebra, coeffs_list[ i ], paths[ i ] ) );
#    
#    return QuotientOfPathAlgebra( path_algebra, relations );
#    
#end );


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

