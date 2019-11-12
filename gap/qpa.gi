

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

