
##
DeclareGlobalVariable( "GLOBAL_FIELD_FOR_QPA" );

##
InstallValue( GLOBAL_FIELD_FOR_QPA, rec( is_locked := false, default_field := HomalgFieldOfRationals( ) ) );

BindGlobal( "SET_GLOBAL_FIELD_FOR_QPA",
  function( arg )
    
    if GLOBAL_FIELD_FOR_QPA!.is_locked then
      
      Error( "Setting the GLOBAL_FIELD_FOR_QPA should be done only once per session!\n" );
      
    fi;
    
    if Size( arg ) = 2 then
      
      GLOBAL_FIELD_FOR_QPA!.field := arg[ 1 ];
      GLOBAL_FIELD_FOR_QPA!.field_for_basis_of_hom := arg[ 2 ];
    
    else
      
      GLOBAL_FIELD_FOR_QPA!.field := arg[ 1 ];
      
    fi;
      
    GLOBAL_FIELD_FOR_QPA!.is_locked := true;
    
end );

BindGlobal( "RESET_GLOBAL_FIELD_FOR_QPA",
  function( )
    
    Unbind( GLOBAL_FIELD_FOR_QPA!.field );
    Unbind( GLOBAL_FIELD_FOR_QPA!.field_for_basis_of_hom );
    
end );


#SET_GLOBAL_FIELD_FOR_QPA( GLOBAL_FIELD_FOR_QPA!.default_field, GLOBAL_FIELD_FOR_QPA!.default_field, 2 );

################################
#
# Tools for qpa
#
################################

##
BindGlobal( "QuiverRepresentationNoCheck",
  
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


BindGlobal( "COMPUTE_LIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE",
  function( f, g )
    local hom_basis, Q, k, V, hom_basis_composed_with_g, L, vector, mat, sol, lift, h;
    
    if IsZeroForObjects( Range( f ) ) then
      
      return ZeroMorphism( Source( f ), Source( g ) );
    
    fi;
    
    hom_basis := BasisOfExternalHom( Source( f ), Source( g ) );
    
    if IsZeroForMorphisms( f ) then
      
      return ZeroMorphism( Source( f ), Source( g ) );
    
    fi;
    
    if hom_basis = [ ] then
      
      return fail;
    
    fi;
    
    Q := QuiverOfRepresentation( Source( f ) );
    
    k := LeftActingDomain( AlgebraOfRepresentation( Source( f ) ) );
    
    V := Vertices( Q );
    
    hom_basis_composed_with_g := List( hom_basis, m -> PreCompose( m, g ) );
    
    L := List( V, v -> Concatenation( 
          [ RightMatrixOfLinearTransformation( MapForVertex( f, v ) ) ],
            List( hom_basis_composed_with_g,
              h -> RightMatrixOfLinearTransformation( MapForVertex( h, v ) ) ) ) );
    
    L := Filtered( L, l -> ForAll( l, m -> not IsZero( DimensionsMat( m )[ 1 ] * DimensionsMat( m )[ 2 ] ) ) );
    
    L := List( L, l ->  List( l, m -> MatrixByCols( k, [ Concatenation( ColsOfMatrix( m ) ) ] ) ) );
    
    L := List( TransposedMat( L ), l -> StackMatricesVertically( l ) );
    
    vector := StandardVector( k!.ring, ColsOfMatrix( L[ 1 ] )[ 1 ] );
    
    mat := TransposedMat( StackMatricesHorizontally( List( [ 2 .. Length( L ) ], i -> L[ i ] ) ) );
    
    sol := SolutionMat( mat, vector );
    
    if sol = fail then
      
      return fail;
    
    else
      
      sol := ShallowCopy( AsList( sol ) );
      
      lift := ZeroMorphism( Source( f ), Source( g ) );
      
      for h in hom_basis do
        
        if not IsZero( sol[ 1 ] ) then
          
          lift := lift + sol[ 1 ]*h;
        
        fi;
        
        Remove( sol, 1 );
      
      od;
    
    fi;
    
    return lift;
    
end );

##
BindGlobal( "COMPUTE_COLIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE",
  function( f, g )
    local hom_basis, Q, k, V, hom_basis_composed_with_f, L, vector, mat, sol, colift, h;
    
    hom_basis := BasisOfExternalHom( Range( f ), Range( g ) );
    
    # if hom_basis = [] then there is only the zero morphism between range(f) and range(g)
    # Thus g must be zero in order for colift to exist.
    
    if IsZeroForMorphisms( g ) then
      
      return ZeroMorphism( Range( f ), Range( g ) );
    
    fi;
    
    if hom_basis = [ ] then
      
      return fail;
    
    fi;
    
    Q := QuiverOfRepresentation( Source( f ) );
    
    k := LeftActingDomain( AlgebraOfRepresentation( Source( f ) ) );
    
    V := Vertices( Q );
    
    hom_basis_composed_with_f := List( hom_basis, m -> PreCompose( f, m ) );
    
    L := List( V, v -> Concatenation( 
            [ RightMatrixOfLinearTransformation( MapForVertex( g, v ) ) ],
              List( hom_basis_composed_with_f, 
                h -> RightMatrixOfLinearTransformation( MapForVertex( h, v ) ) ) ) );
    
    L := Filtered( L, l -> ForAll( l, m -> not IsZero( DimensionsMat( m )[ 1 ] * DimensionsMat( m )[ 2 ] ) ) );
    
    L := List( L, l ->  List( l, m -> MatrixByCols( k, [ Concatenation( ColsOfMatrix( m ) ) ] ) ) );
    
    L := List( TransposedMat( L ), l -> StackMatricesVertically( l ) );
    
    vector := StandardVector( k!.ring, ColsOfMatrix( L[ 1 ] )[ 1 ] );
    
    mat := TransposedMat( StackMatricesHorizontally( List( [ 2 .. Length( L ) ], i -> L[ i ] ) ) );
    
    sol := SolutionMat( mat, vector );
    
    if sol = fail then
      
      return fail;
    
    else
      
      sol := ShallowCopy( AsList( sol ) );
      
      colift := ZeroMorphism( Range( f ), Range( g ) );
      
      for h in hom_basis do
        
        if not IsZero( sol[ 1 ] ) then
          
          colift := colift + sol[ 1 ] * h;
        
        fi;
        
        Remove( sol, 1 );
        
      od;
    
    fi;
    
    return colift;
    
end );

##
BindGlobal( "STACK_LISTLIST_QPA_MATRICES",
  function( matrices )
    
    if matrices = [] or matrices[ 1 ] = [ ] then
      
      Error( "The input should not be or contain empty lists of qpa matrices!\n" );
    
    else
      
      return StackMatricesVertically( List( matrices, StackMatricesHorizontally ) );
      
    fi;
    
end );

##
InstallMethod( ProjectiveCover, "for a quiver representation",
               [ IsQuiverRepresentation ],
               1000,
function( R )
  local   mingen,  maps,  PR,  projections;

  if Sum( DimensionVector( R ) ) = 0 then
    return ZeroMorphism( ZeroObject( CapCategory( R ) ), R);
  else
    mingen := MinimalGeneratingSet( R );
    maps := List( mingen, x -> HomFromProjective( x, R ) );
    return MorphismBetweenDirectSums( List( maps, map -> [ map ] ) );
  fi;
end
);

BindGlobal( "ADD_RANDOM_METHODS_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE",
  function( cat )
    local A, field;
    
    A := AlgebraOfCategory( cat );
    
    field := UnderlyingField( VectorSpaceCategory( cat ) );
    
    AddRandomObjectByList( cat,
      
      function( C, l )
        local indec_proj, indec_injs, simples, ind, s;
        
        indec_proj := IndecProjRepresentations( A );
        
        indec_injs := IndecInjRepresentations( A );
        
        simples := SimpleRepresentations( A );
        
        ind := Concatenation( indec_injs, indec_proj, simples );
        
        s := List( [ 1 .. Random( l ) ], i -> Random( ind ) );
        
        return DirectSum( s );
        
    end );
    
    AddRandomObjectByInteger( cat,
      
      function( C, n )
        
        return RandomObjectByList( C, [ n, n ] );
        
    end );
    
    AddRandomMorphismWithFixedRangeByList( cat,
    
      function( M, L )
        local pi, K, H;
        
        if not ForAll( L, l -> l in field ) then
          
          Error( "All entries should belong to the acting field of the algebra" );
          
        fi;
        
        pi := ProjectiveCover( M );
        
        K := KernelObject( pi );
        
        if IsZero( K ) then
          
          K := Source( pi );
          
        fi;
        
        H := BasisOfExternalHom( K, M );
        
        H := Concatenation( H, [ ZeroMorphism( K, M ) ] );
        
        return Sum( List( L, l -> Random( L ) * Random( H ) ) );
        
     end );
    
    AddRandomMorphismWithFixedRangeByInteger( cat,
      
      function( M, n )
        
        return RandomMorphismWithFixedRangeByList( M, [ 1 .. n ] * One( field ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceByList( cat,
      
      function( M, L )
        local iota, K, H;
        
        if not ForAll( L, l -> l in field ) then
          
          Error( "All entries should belong to the acting field of the algebra" );
          
        fi;
        
        iota := InjectiveEnvelope( M );
        
        K := CokernelObject( iota );
        
        if IsZero( K ) then
          
          K := Range( iota );
          
        fi;
        
        H := BasisOfExternalHom( M, K );
        
        H := Concatenation( H, [ ZeroMorphism( M, K ) ] );
        
        return Sum( List( L, l -> Random( L ) * Random( H ) ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceByInteger( cat,
      
      function( M, n )
        
        return RandomMorphismWithFixedSourceByList( M, [ 1 .. n ] * One( field ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceAndRangeByList( cat,
      
      function( M, N, L )
        local H;
        
        H := BasisOfExternalHom( M, N );
        
        if H = [ ] then
          
          return ZeroMorphism( M, N );
          
        fi;
        
        return Sum( List( H, h -> Random( L ) * h ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceAndRangeByInteger( cat,
      
      function( M, N, n )
        
        return RandomMorphismWithFixedSourceAndRangeByList( M, N, [ 1 .. n ] * One( field ) );
        
    end );
    
end );

##
InstallMethod( CategoryOfQuiverRepresentations,
              [ IsQuiverAlgebra and IsRightQuiverAlgebra ],
              1000,
  function( A )
    local add_extra_methods, cat, to_be_finalized, domain, indec_proj, indec_inj;
    
    add_extra_methods := ValueOption( "AddExtraMethods" );
    
    if add_extra_methods = false then
      
      TryNextMethod( );
    
    fi;
    
    cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false, AddExtraMethods := false );
    
    domain := LeftActingDomain( A );
    
    SetIsLinearCategoryOverCommutativeRing( cat, true );
    
    SetCommutativeRingOfLinearCategory( cat, domain );
       
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, \* );
    
    # quicker than the lift and colift derived by hom structure
    
    AddLift( cat, COMPUTE_LIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE );
    
    AddColift( cat, COMPUTE_COLIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE );
    
    AddIsProjective( cat, IsProjectiveRepresentation );
    
    AddIsInjective( cat, IsInjectiveRepresentation );
    
    AddProjectiveLift( cat,
      function( pi, epsilon )
        local P, A, B, top_basis, images;
        
        P := Source( pi );
        
        A := Range( pi );
        
        B := Source( epsilon );
        
        top_basis := TopBasis( P );
        
        if IsEmpty( top_basis ) then
          
          return ZeroMorphism( P, B );
          
        fi;
        
        images := PreImagesRepresentative( epsilon, List( top_basis, elm -> ImageElm( pi, elm ) ) );
        
        return QuiverRepresentationHomomorphismByImages( P, B, top_basis, images );
        
    end );
    
    ##
    AddInjectiveColift( cat,
      function( iota, beta )
        
        return DualOfRepresentationHomomorphism(
                  ProjectiveLift( DualOfRepresentationHomomorphism( beta ), DualOfRepresentationHomomorphism( iota ) )
                );
        
    end );
    
    ##
    AddIsMonomorphism( cat,
      function( alpha )
        
        return ForAll( MapsOfRepresentationHomomorphism( alpha ), IsMonomorphism );
        
    end );
    
    ##
    AddIsEpimorphism( cat,
      function( alpha )
        
        return ForAll( MapsOfRepresentationHomomorphism( alpha ), IsEpimorphism );
        
    end ); 
    
    ##
    AddIsIsomorphism( cat,
      function( alpha )
        
        return ForAll( MapsOfRepresentationHomomorphism( alpha ), IsIsomorphism );
        
    end ); 
   
    ##
    AddIsWellDefinedForObjects( cat,
      function( R )
        local A, relations;
        
        A := AlgebraOfRepresentation( R );
        
        relations := RelationsOfAlgebra( A );
        
        return ForAll( relations, rel -> IsZero( MapForAlgebraElement( R, rel ) ) );
    
    end );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
      function( alpha )
        local S, R, arrows;
        
        S := Source( alpha );
        
        R := Range( alpha );
        
        arrows := Arrows( QuiverOfRepresentation( S ) );
        
        return ForAll( arrows, arrow ->
                            IsEqualForMorphisms(
                              PreCompose( MapForArrow( S, arrow ), MapForVertex( alpha, Target( arrow ) ) ),
                                PreCompose( MapForVertex( alpha, Source( arrow ) ), MapForArrow( R, arrow ) )
                                               )
                   );
    
    end );
    
    ##
    AddDirectSum( cat,
      function( summands )
        local dimension_vector, matrices, d, l, N, d1, d2;
        
        if Length( summands ) = 1 then
          
          return summands[ 1 ];
          
        elif Length( summands ) = 2 then
          
          dimension_vector := Sum( List( summands, DimensionVector ) );
          
          matrices := List( summands, MatricesOfRepresentation );
          
          matrices := List( Transpose( matrices ), StackMatricesDiagonally );
          
          d := QuiverRepresentationNoCheck( A, dimension_vector, matrices );
          
          if ForAll( summands, s -> HasIsProjective( s ) and IsProjective( s ) ) then
            
            SetIsProjective( d, true );
            
            SetUnderlyingProjectiveSummands( d, Concatenation( List( summands, UnderlyingProjectiveSummands ) ) );
            
          fi;
          
          if ForAll( summands, s -> HasIsInjective( s ) and IsInjective( s ) ) then
            
            SetIsInjective( d, true );
            
            SetUnderlyingInjectiveSummands( d, Concatenation( List( summands, UnderlyingInjectiveSummands ) ) );
            
          fi;
           
          return d;
        
        else
          
          N := Length( summands );
          
          d1 := DirectSum( summands{ [ 1 .. Int( N/2 ) ] } );
          
          d2 := DirectSum( summands{ [ Int( N/2 ) + 1 .. N ] } );
          
          return DirectSum( d1, d2 );
        
        fi;
    
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,      
      function( D1, morphisms, D2 )
        local matrices;
        
        matrices := List( morphisms, MatricesOfRepresentationHomomorphism );
        
        matrices := List( Transpose( matrices ), StackMatricesDiagonally );
        
        return QuiverRepresentationHomomorphism( D1, D2, matrices );
        
      end );
    
    ##
    AddMorphismBetweenDirectSums( cat,
      function( D1, morphisms, D2 )
        local matrices;
        
        matrices := List( [ 1 .. NumberOfVertices( QuiverOfAlgebra( A ) ) ],
                      i -> STACK_LISTLIST_QPA_MATRICES(
                        List( morphisms,
                          row -> List( row,
                            morphism -> MatricesOfRepresentationHomomorphism( morphism )[ i ] ) ) ) );
        
        return QuiverRepresentationHomomorphism( D1, D2, matrices );
        
      end );
    
    ##
    AddBasisOfExternalHom( cat,
      function( R1, R2 )
      
        return BasisVectors( CanonicalBasis( Hom( R1, R2 ) ) );
        
      end );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
      function( alpha, B )
      
        return Coefficients( CanonicalBasis( Hom( Source( alpha ), Range( alpha ) ) ), alpha );
        
      end );
    
    ##
    ADD_RANDOM_METHODS_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE( cat );
       
    FinalizeCategory( cat, true );
    
    ## setting projective & injective indecomposable 
    
    indec_proj := IndecProjRepresentations( A );
    
    indec_inj := IndecInjRepresentations( A );
    
    Perform( indec_proj, function( p ) SetIsProjective( p, true ); SetUnderlyingProjectiveSummands( p, [ p ] ); end );
    
    Perform( indec_inj, function( i ) SetIsInjective( i, true ); SetUnderlyingInjectiveSummands( i, [ i ] ); end );
 
    return cat;
  
end );

##
InstallMethod( UnderlyingProjectiveSummands,
          [ IsQuiverRepresentation and IsProjective ],
  function( a )
    
    if IsZero( a ) then
      
      return [ ];
      
    else
      
      return [ a ];
      
    fi;
    
end );

##
InstallMethod( UnderlyingInjectiveSummands,
          [ IsQuiverRepresentation and IsInjective ],
  function( a )
    
    if IsZero( a ) then
      
      return [ ];
      
    else
      
      return [ a ];
      
    fi;
    
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
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
      
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
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
      
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
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
            
    fi;
    
    range_reps := List( range_list, Representative );
    
    range_reps := List( range_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( range_reps, r -> Size( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    coeffs := List( range_reps, r -> Inverse( r[ 1 ][ 1 ] ) );
    
    paths := List( range_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Target ), t -> t = Target( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
 
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
InstallMethod( StackMatricesDiagonally,
        [ IsQPAMatrix, IsQPAMatrix ],
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

##
InstallMethod( StackMatricesDiagonally,
          [ IsDenseList ],
          1000,
  function( L )
        
    if Size( L ) = 1 then
      return L[1];
    elif Size( L ) = 2 then
      return StackMatricesDiagonally( L[ 1 ], L[ 2 ] );
    else
      return StackMatricesDiagonally(
                StackMatricesDiagonally( L{ [ 1 .. Int( Size( L ) / 2 ) ] } ),
                StackMatricesDiagonally( L{ [ Int( Size( L ) / 2 ) + 1 .. Size( L ) ] } )
            );
    fi; 
end );

#
InstallOtherMethod( CategoryOfVectorSpaces,
        [ IsFieldForHomalg ],
        
  function( F )
    
    return CategoryOfVectorSpaces( F!.ring );
    
end );

##
InstallOtherMethod( MatrixByRows,
        [ IsFieldForHomalg, IsDenseList, IsDenseList ],
        
  function( F, dimensions, mat )
    
    return MatrixByRows( F!.ring, dimensions, mat );
    
end );

##
InstallOtherMethod( MatrixByRows,
        [ IsFieldForHomalg, IsList ],
        
  function( F, mat )
    
    return MatrixByRows( F!.ring, mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
        [ IsFieldForHomalg, IsDenseList, IsDenseList ],
        
  function( F, dimensions, mat )
    
    return MatrixByCols( F!.ring, dimensions, mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
        [ IsFieldForHomalg, IsList ],
        
  function( F, mat )
    
    return MatrixByCols( F!.ring, mat );
    
end );

##
InstallOtherMethod( EmptyVector,
        [ IsFieldForHomalg ],
  
  function( F )
    
    return EmptyVector( F!.ring );
    
end );

##
InstallOtherMethod( MatrixByRows,
          [ IsRing, IsDenseList, IsDenseList ],
          1000,
  function( R, dim, rows )
    local matrix;
       
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
         
    if ForAny( dim, IsZero ) then
      
      rows := ListWithIdenticalEntries( dim[ 1 ], [ ] );
      
    fi;
    
    if not IsEmpty( rows ) and not IsList( rows[ 1 ] ) then
      
      if not Length( rows ) = dim[ 1 ] * dim[ 2 ] then
        
        Error( "wronge input" );
        
      fi;
      
      rows := List( [ 1 .. dim[ 1 ] ], i -> rows{ [ ( i - 1) * dim[ 2 ] + 1 .. i * dim[ 2 ] ] } );
      
    fi;
    
    matrix := rec( rows := rows );
    
    ObjectifyWithAttributes( matrix,
      NewType( FamilyOfQPAMatrices, IsQPAMatrix and IsRowMatrixRep ),
      BaseDomain, R,
      DimensionsMat, dim
    );
    
    if ForAny( dim, IsZero ) then
      SetIsZeroMatrix( matrix, true );
    fi;
  
    return matrix;
  
end );

##
InstallOtherMethod( MatrixByRows,
        [ IsRing, IsMatrix ],
        1000,
  function( R, mat )
  
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
    
    return MatrixByRows( R, DimensionsMat( mat ), mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
        [ IsRing, IsMatrix ],
        1000,
  function( R, mat )
  
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
    
    return MatrixByCols( R, Reversed( DimensionsMat( mat ) ), mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
          [ IsRing, IsDenseList, IsDenseList ],
          1000,
  function( R, dim, cols )
    local matrix;
     
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
      
    if ForAny( dim, IsZero ) then
      
      cols := ListWithIdenticalEntries( dim[ 2 ], [ ] );
      
    fi;
    
    if not IsEmpty( cols ) and not IsList( cols[ 1 ] ) then
      
      if not Length( cols ) = dim[ 1 ] * dim[ 2 ] then
        
        Error( "wronge input" );
        
      fi;
      
      cols := List( [ 1 .. dim[ 2 ] ], i -> cols{ [ ( i - 1) * dim[ 1 ] + 1 .. i * dim[ 1 ] ] } );
      
    fi;

    
    matrix := rec( cols := cols );
    
    ObjectifyWithAttributes( matrix,
      NewType( FamilyOfQPAMatrices, IsQPAMatrix and IsColMatrixRep ),
      BaseDomain, R,
      DimensionsMat, dim
    );
    
    if ForAny( dim, IsZero ) then
      SetIsZeroMatrix( matrix, true );
    fi;
   
  return matrix;
  
end );

InstallOtherMethod( ViewObj, "for QPA matrix",
               [ IsQPAMatrix ],
               1000,
function( M )
  local dim;
  
  dim := DimensionsMat( M );
  
  Print( "<", dim[ 1 ], "x", dim[ 2 ], " qpa-matrix over ", Name( BaseDomain( M ) ), ">" );
  
end );

##
InstallOtherMethod( RowsOfMatrix, "for QPA matrix",
               [ IsQPAMatrix ],
               1000,
  function( M )
    
    if IsRowMatrixRep( M ) then
      
      return M!.rows;
      
    elif IsColMatrixRep( M ) then
      
      return TransposedMat( M!.cols );
      
    else
      
      Info( InfoDerivedCategories, 2, "I am using external method to compute the rows of a qpa matrix" );
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallOtherMethod( ColsOfMatrix, "for QPA matrix",
               [ IsQPAMatrix ],
               1000,
  function( M )
    
    if IsColMatrixRep( M ) then
      
      return M!.cols;
      
    elif IsRowMatrixRep( M ) then
      
      return TransposedMat( M!.rows );
      
    else
      
      Info( InfoDerivedCategories, 2, "I am using external method to compute the cols of a qpa matrix" );
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallOtherMethod( MakeZeroMatrix,
              [ IsField, IsInt, IsInt ],
              1000,
  function( F, m, n )
    local l, matrix;
    
    if m < 0 or n < 0 then
      
      Error( "The integers should be positive!\n" );
      
    fi;
    
    if m = 0 then
      
      l := [ ];
      
    elif n = 0 then
      
      l := ListWithIdenticalEntries( m, [ ] );
      
    else
      
      l := ListWithIdenticalEntries( m, ListWithIdenticalEntries( n, Zero( F ) ) );
      
    fi;
    
    matrix := MatrixByRows( F, [ m, n ], l );
    
    SetIsZeroMatrix( matrix, true );
    
    return matrix;
    
end );


##
InstallOtherMethod( IdentityMatrix, "for ring and integer",
               [ IsRing, IsInt ],
               1000,
function( R, n )
  local rows, matrix, i;
  
  if n < 0 then
    Error( "negative matrix dimension" );
  fi;
  
  rows := IdentityMat( n, R );
  
  matrix := MatrixByRows( R, [ n, n ], rows );
  
  SetIsIdentityMatrix( matrix, true );
  
  SetIsZeroMatrix( matrix, n = 0 );
  
  SetTransposedMat( matrix, matrix );
  
  return matrix;
  
end );

##
InstallMethod( TransposedMat,
          [ IsQPAMatrix ],
          1000,
  function( M )
    local tM;
    
    if IsRowMatrixRep( M ) then
      
      tM := MatrixByCols( BaseDomain( M ), Reversed( DimensionsMat( M ) ), RowsOfMatrix( M ) );
      
    elif IsColMatrixRep( M ) then
      
      tM := MatrixByRows( BaseDomain( M ), Reversed( DimensionsMat( M ) ), ColsOfMatrix( M ) );
     
    else
      
      TryNextMethod( );
      
    fi;
    
    if HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
      
      SetIsZeroMatrix( tM, true );
      
    fi;
    
    if HasIsIdentityMatrix( M ) and IsIdentityMatrix( M ) then
      
      SetIsIdentityMatrix( tM, true );
      
    fi;
   
    return tM;
    
end );

##
InstallMethod( IsZeroMatrix,
          [ IsQPAMatrix ],
          1000,
  function( M )
    
    if IsRowMatrixRep( M ) then
      
      return IsZero( RowsOfMatrix( M ) );
      
    elif IsColMatrixRep( M ) then
    
      return IsZero( ColsOfMatrix( M ) );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

#
InstallMethod( IsZero, [ IsQPAMatrix ], 1000, IsZeroMatrix );

##
InstallMethod( IsIdentityMatrix,
          [ IsQPAMatrix ],
          1000,
  function( M )
    local dim, id;
    
    dim := DimensionsMat( M );
    
    if dim[ 1 ] <> dim[ 2 ] then
      
      return false;
      
    fi;
    
    id := IdentityMatrix( BaseDomain( M ), dim[ 1 ] );
    
    return M = id;
  
end );
#

InstallMethod( \*,
          [ IsQPAMatrix, IsQPAMatrix ],
function( M1, M2 )
  local R, dim1, dim2;
  
  R := BaseDomain( M1 );
  dim1 := DimensionsMat( M1 );
  dim2 := DimensionsMat( M2 );
  
  if R <> BaseDomain( M2 ) then
    Error( "matrices over different rings" );
  elif dim1[ 2 ] <> dim2[ 1 ] then
    Error( "dimensions of matrices do not match" );
  elif ( HasIsZeroMatrix( M1 ) and IsZeroMatrix( M1 ) ) 
          or ( HasIsZeroMatrix( M2 ) and IsZeroMatrix( M2 ) ) then
    return MakeZeroMatrix( R, dim1[ 1 ], dim2[ 2 ] );
  elif IsIdentityMatrix( M1 ) then
    return M2;
  elif IsIdentityMatrix( M2 ) then
    return M1;
  elif IsColMatrixRep( M1 ) then
    return MatrixByCols( R, [ dim1[ 1 ], dim2[ 2 ] ], ColsOfMatrix( M2 ) * ColsOfMatrix( M1 ) );
  else
    return MatrixByRows( R, [ dim1[ 1 ], dim2[ 2 ] ], RowsOfMatrix( M1 ) * RowsOfMatrix( M2 ) );
  fi;
end );
#
InstallMethod( \+,
          [ IsQPAMatrix, IsQPAMatrix ],
function( M1, M2 )
  local R, dim;
  R := BaseDomain( M1 );
  dim := DimensionsMat( M1 );
  if R <> BaseDomain( M2 ) then
    Error( "matrices over different rings" );
  elif dim <> DimensionsMat( M2 ) then
    Error( "dimensions of matrices do not match" );
  elif HasIsZeroMatrix( M1 ) and IsZeroMatrix( M1 ) then
    return M2;
  elif HasIsZeroMatrix( M2 ) and IsZeroMatrix( M2 ) then
    return M1;
  elif IsColMatrixRep( M1 ) or IsColMatrixRep( M2 ) then
    return MatrixByCols( R, dim, ColsOfMatrix( M1 ) + ColsOfMatrix( M2 ) );
  else
    return MatrixByRows( R, dim, RowsOfMatrix( M1 ) + RowsOfMatrix( M2 ) );
  fi;
end );
#
InstallMethod( \*, [ IsMultiplicativeElement, IsQPAMatrix ],
function( a, M )
  local dim;
  if not a in BaseDomain( M ) then
    TryNextMethod( );
  fi;
  
  dim := DimensionsMat( M );
  
  if HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
    return M;
  elif IsColMatrixRep( M ) then
    return MatrixByCols( BaseDomain( M ), dim, a * ColsOfMatrix( M ) );
  else
    return MatrixByRows( BaseDomain( M ), dim, a * RowsOfMatrix( M ) );
  fi;
 
end );

##
InstallMethod( AdditiveInverseMutable,
          [ IsQPAMatrix ],
  function( M )
    local R, dim;
    R := BaseDomain( M );
    dim := DimensionsMat( M );
    if HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
      return M;
    elif IsColMatrixRep( M ) then
      return MatrixByCols( R, dim, - ColsOfMatrix( M ) );
    else
      return MatrixByRows( R, dim, - RowsOfMatrix( M ) );
    fi;
end );

##
InstallMethod( \=, "for QPA matrices",
               [ IsQPAMatrix, IsQPAMatrix ],
function( M1, M2 )
  local dim, i, j;
  dim := DimensionsMat( M1 );
  
  if dim <> DimensionsMat( M2 ) then
    return false;
  fi;
  
  if HasIsZeroMatrix( M1 ) and IsZeroMatrix( M1 )
      and HasIsZeroMatrix( M2 ) and IsZeroMatrix( M2 ) then
    return true;
  fi;
  
  if HasIsIdentityMatrix( M1 ) and IsIdentityMatrix( M1 )
      and HasIsIdentityMatrix( M2 ) and IsIdentityMatrix( M2 ) then
    return true;
  fi;
  
  if IsColMatrixRep( M1 ) then
    return ColsOfMatrix( M1 ) = ColsOfMatrix( M2 );
  else
    return RowsOfMatrix( M1 ) = RowsOfMatrix( M2 );
  fi;
  
end );


#############################
#
# Interface to homalg
#
##############################

##
InstallMethod( QPA_to_Homalg_Matrix,
          [ IsQPAMatrix ],
  function( qpa_mat )
    local dim, homalg_mat;
    
    dim := DimensionsMat( qpa_mat );
    
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      
      Error( "no global field is set" );
      
    else
      
      homalg_mat := HomalgMatrix( RowsOfMatrix( qpa_mat ), dim[ 1 ], dim[ 2 ], GLOBAL_FIELD_FOR_QPA!.field );
      
      SetHomalg_to_QPA_Matrix( homalg_mat, qpa_mat );
      
      return homalg_mat;
      
    fi;
    
end );

##
InstallMethod( Homalg_to_QPA_Matrix,
          [ IsHomalgMatrix ],
  function( homalg_mat )
    local dim, qpa_mat;
    
    dim := [ NrRows( homalg_mat ), NrCols( homalg_mat ) ];
    
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      
      Error( "no global field is set" );
      
    else
      
      if ForAny( dim, IsZero ) then
        
        qpa_mat := MakeZeroMatrix( Rationals, dim[ 1 ], dim[ 2 ] );
        
      else
        
        if IsHomalgExternalRingRep( GLOBAL_FIELD_FOR_QPA!.field ) then
          
          homalg_mat := ConvertHomalgMatrix( homalg_mat, GLOBAL_FIELD_FOR_QPA!.default_field );
          
        fi;
        
        qpa_mat := MatrixByRows( Rationals, dim, EntriesOfHomalgMatrixAsListList( homalg_mat ) );
        
      fi;
      
      SetQPA_to_Homalg_Matrix( qpa_mat, homalg_mat );
      
      return qpa_mat;
      
    fi;
    
end );

##############################
#
# solve linear equations
#
#############################

##
InstallMethod( SolutionMat, "for QPA matrix and standard vector",
	       [ IsQPAMatrix, IsStandardVector ],
         5000,
function( M, v )
  local dim, V, solution_as_list;
  
  dim := DimensionsMat( M );
  if dim[ 2 ] <> Length( v ) then
    Error("a row vector of length ",Length( v )," cannot be in the image of a ",
          dim[ 1 ]," x ",dim[ 2 ],"-matrix,\n"); 
  fi;
  if dim[ 1 ] = 0 then
    if IsZero( v ) then
      return EmptyVector( BaseDomain( M ) );
    else
      return fail;
    fi;
  fi;
  
  V := StandardVectorSpace( BaseDomain( M ), dim[ 1 ] );

  if HasIsIdentityMatrix( M ) and IsIdentityMatrix( M ) then
    return AsList( v );
  elif HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
    if IsZero( v ) then
      return Zero( V );
    else
      return fail;
    fi;
  fi;
  
  if dim[ 2 ] = 0 then
    return Zero( V );
  else
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      solution_as_list := SolutionMat( RowsOfMatrix( M ), AsList( v ) );
    else
      Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level,
        Concatenation( "Using global field to compute SolutionMat( ", String( dim ), " -matrix, ", String( Length( v ) ), " -vector )" ) );
      M := HomalgMatrix( RowsOfMatrix( M ), dim[ 1 ], dim[ 2 ], GLOBAL_FIELD_FOR_QPA!.field );
      v := HomalgMatrix( AsList( v ), 1, Length( v ), GLOBAL_FIELD_FOR_QPA!.field );
      solution_as_list := RightDivide( v, M );
      Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level, "Done!" );
      if solution_as_list <> fail then
        if IsHomalgExternalRingRep( GLOBAL_FIELD_FOR_QPA!.field ) then
          solution_as_list := ConvertHomalgMatrix( solution_as_list, HomalgFieldOfRationals() );
        fi;
        solution_as_list := EntriesOfHomalgMatrix( solution_as_list );
      fi;
    fi;
    
    if solution_as_list = fail then
      return fail;
    else
      return Vector( V, solution_as_list );
    fi;
  fi;
end 
);

##
InstallMethod( SolutionMat, "for QPA matrix and a list of standard vector",
	       [ IsQPAMatrix, IsDenseList ],
         5000,
function( M, list_of_vectors )
  local dim, list, nr_vectors, solution, V, reset, v, D, positions, sol, p;
  dim := DimensionsMat( M );
    
  if ForAll( list_of_vectors, v -> dim[ 2 ] <> Length( v ) ) then
    Error("a row vector of length ", Length( v[1] )," cannot be in the image of a ",
          dim[ 1 ]," x ",dim[ 2 ],"-matrix,\n"); 
  fi;
  
  list := List( list_of_vectors, AsList );
  
  nr_vectors := Size( list );

  if dim[ 1 ] = 0 then
    
    solution := [ ];
    
    for v in list_of_vectors do
      
      if IsZero( v ) then
        
        Add( solution, EmptyVector( BaseDomain( M ) ) );
        
      else
        
        Add( solution, fail );
        
      fi;
      
    od;
    
    return solution;
    
  fi;
  
  V := StandardVectorSpace( BaseDomain( M ), dim[ 1 ] );

  if HasIsIdentityMatrix( M ) and IsIdentityMatrix( M ) then
    
    return list;
    
  elif HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
  
    solution := [ ];
    
    for v in list_of_vectors do
      
      if IsZero( v ) then
        
        Add( solution, Zero( V ) );
        
      else
        
        Add( solution, fail );
        
      fi;
      
    od;
    
    return solution;
    
  fi;
  
  if dim[ 2 ] = 0 then
    
    return ListWithIdenticalEntries( nr_vectors, Zero( V ) );
    
  else
    
    reset := false;
    
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      
      SET_GLOBAL_FIELD_FOR_QPA( GLOBAL_FIELD_FOR_QPA!.default_field, 2 );
      
      reset := true;
      
    fi;
    
    Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level,
      Concatenation( "Using global field to compute SolutionMat( ", String( dim ),
        " -matrix, list of ", String( Length( list_of_vectors ) ), " -vectors )" ) );
    
    M := HomalgMatrix( RowsOfMatrix( M ), dim[ 1 ], dim[ 2 ], GLOBAL_FIELD_FOR_QPA!.field );
    
    v := HomalgMatrix( list, nr_vectors, Size( list[ 1 ] ), GLOBAL_FIELD_FOR_QPA!.field );
    
    solution := List( [ 1 .. nr_vectors ], i -> fail );
    
    D := DecideZeroRows( v, M );
    
    positions := PositionsProperty( [ 1 .. NrRows( v ) ], i -> IsZero( CertainRows( D, [ i ] ) ) );
    
    sol := RightDivide( v, M, D );
       
    Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level, "Done!" );
    
    if IsHomalgExternalRingRep( GLOBAL_FIELD_FOR_QPA!.field ) then
      sol := ConvertHomalgMatrix( sol, HomalgFieldOfRationals() );
    fi;
    
    sol := EntriesOfHomalgMatrixAsListList( sol );
    
    sol := sol{ positions };
    
    for p in positions do
      
      solution[ p ] := Vector( V, sol[ 1 ] );
      
      Remove( sol, 1 );
      
    od;
    
    if reset then
      
      RESET_GLOBAL_FIELD_FOR_QPA( );
      
    fi;
    
  fi;
  
  return solution;
  
end );

##
InstallMethod( NullspaceMat, "for QPA matrix",
          [ IsQPAMatrix ],
          5000,
function( M )
  local dim, domain;
  dim := DimensionsMat( M );
  
  domain := BaseDomain( M );
  
  if dim[ 1 ] = 0 or dim[ 2 ] = 0 then
    return IdentityMatrix( BaseDomain( M ), dim[ 1 ] );
  else
    
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      M := NullspaceMat( RowsOfMatrix( M ) );
    else
      Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level,
        Concatenation( "Using global field to compute NullspaceMat( ", String( dim ), " -matrix )" ) );
      M := HomalgMatrix( RowsOfMatrix( M ), dim[ 1 ], dim[ 2 ], GLOBAL_FIELD_FOR_QPA!.field );
      M := SyzygiesOfRows( M );
      if IsHomalgExternalRingRep( GLOBAL_FIELD_FOR_QPA!.field ) then
        M := ConvertHomalgMatrix( M, HomalgFieldOfRationals() );
      fi;
      M := EntriesOfHomalgMatrixAsListList( M );
      Info( InfoWarning, GLOBAL_FIELD_FOR_QPA!.info_level, "Done!" );
    fi;
 
    if Length( M ) = 0 then
      return MakeZeroMatrix( domain, 0, dim[ 1 ] );
    else
      return MatrixByRows( domain, M );
    fi;
  fi;
end 
);

##
InstallMethod( PreImagesRepresentative, [ IsLinearTransformation, IsDenseList ],
  function( T, list_of_vectors )
    local x, i;
    
    x := ShallowCopy( SolutionMat( RightMatrixOfLinearTransformation( T ), list_of_vectors ) );
    
    for i in [ 1 .. Size( x ) ] do
      
      if x[ i ] <> fail then
        
        x[ i ] := Vector( Source( T ), x[ i ] );
        
      fi;
      
    od;
    
    return x;
    
end );

##
InstallMethod( PreImagesRepresentative, "for a representation homomorphism and a representation element",
               [ IsQuiverRepresentationHomomorphism, IsDenseList ],
function( f, list_of_elements )
  local elements_vectors, maps, preimages, output, preimage;
  
  if not ForAll( list_of_elements, m -> m in Range( f ) ) then
    
    Error("Some elements are not in the range for the entered homomorphism,\n");
    
  fi;
  
  if IsEmpty( list_of_elements ) then
    
    Error( "The list of elements is empty" );
    
  fi;
  
  elements_vectors := List( list_of_elements, m -> ElementVectors( m ) );
  
  elements_vectors := TransposedMat( elements_vectors );
  
  maps := MapsOfRepresentationHomomorphism( f );
  
  preimages := ListN( maps, elements_vectors, PreImagesRepresentative );
  
  preimages := TransposedMat( preimages );
  
  output := [ ];
  
  for preimage in preimages do
    
    if ForAll( preimage, p -> p <> fail ) then
    
      Add( output, QuiverRepresentationElement( Source( f ), preimage ) );
    
    else
    
      Add( output, fail );
    
    fi;
    
  od;
  
  return output;
  
end );


## This is somehow clean and works whenever we have a indecomposable generating projectives.
## BUT: it is VERY slow, since it uses lifts. It is not used in the package.
##
InstallMethod( EpimorphismFromSomeDirectSum,
          [ IsList, IsCapCategoryObject ],
  function( projs, a )
    local output, A, current_a, epimorphism_from_a, b, temp, pi, gamma, p, m;
     
    if IsZero( a ) then
      
      return UniversalMorphismFromZeroObject( a );
      
    fi;
    
    output := [ ];
    
    current_a := a;
    
    epimorphism_from_a := IdentityMorphism( a );
    
    projs := ShallowCopy( projs );
    
    Sort( projs, {p,q} -> IsEmpty( BasisOfExternalHom( p, q ) ) );
    
    while not IsZero( current_a ) do
       
      for p in projs do
        
        b := BasisOfExternalHom( p, current_a );
        
        if not IsEmpty( b ) then
          
          projs := projs{ [ Position( projs, p ) + 1 .. Size( projs ) ] };
          
          break;
        
        fi;
        
      od;
      
      if IsEmpty( b ) then
        
        break;
        
      fi;
           
      temp := b[ 1 ];
      
      for m in b{ [ 2 .. Size( b ) ] } do
        
        pi := CokernelProjection( temp );
        
        gamma := PreCompose( m, pi );
         
        if IsZero( gamma ) then
          
          continue;
          
        fi;
         
        temp := MorphismBetweenDirectSums( [ [ m ], [ temp ] ] );
        
      od;
      
      Add( output, Lift( temp, epimorphism_from_a ) );
      
      pi := CokernelProjection( temp );
      
      current_a := Range( pi );
      
      epimorphism_from_a := PreCompose( epimorphism_from_a, pi );
      
    od;
    
    return MorphismBetweenDirectSums( List( output, o -> [ o ] ) );
    
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
    local A, quiver, field, projs, mats_of_projs, dims, dim_vectors_of_projs, dim_vector_of_a, sol, nr_arrows, nr_vertices, positions_isolated_projs, new_a, new_dim_vec, mats, isolated_summands, diff, bool, o, found_part_identical_to_some_proj, check_for_block, i, dims_of_mats, current_mats_1, current_mats_2, current_mats_3, current_mats_4, found_part_isomorphic_to_some_proj, temp, b, s, d, output, morphism_from_new_a, mingen;
    
    if IsZero( a ) then
      
      return [ IdentityMorphism( a ) ];
    
    fi;
    
    Info( InfoDerivedCategories, 2, "Decomposition of a projective object the hard way" );

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
      
      new_a := QuiverRepresentationNoCheck( A, new_dim_vec, mats );     
      
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
          
          temp := QuiverRepresentationNoCheck( A, dim_vectors_of_projs[ i ], current_mats_1 );
          
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
    
    new_a := QuiverRepresentationNoCheck( A, new_dim_vec, mats );
    
    s := Concatenation( List( o, Range ), [ new_a ] );
    
    d := DirectSum( s );
    
    output := List( [ 1 .. Size( s ) - 1 ], i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, i, d ) );
    
    if IsZero( new_a ) then
      
      SetIsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition( a, DirectSumFunctorial( o ) );
      
      SetIsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( a, DirectSumFunctorial( List( o, Inverse ) ) );
      
      return output;
    
    else
      
      Info( InfoDerivedCategories, 2, "Decomposition of a projective object the very hard way" );

      # the following three lines can do the job, but it may take forever, hence we use them only if there is no better way.
      morphism_from_new_a := InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, Size( s ), d );
      
      mingen := MinimalGeneratingSet( new_a );
      
      output := Concatenation( output, List( mingen, x -> PreCompose( HomFromProjective( x, new_a ), morphism_from_new_a ) ) );
    
    fi;
    
    return output;
    
end );

##
InstallMethod( DecomposeInjectiveQuiverRepresentation,
          [ IsQuiverRepresentation ],
  function( a )
    local d;
    
    Info( InfoDerivedCategories, 2, "Decomposition of a injective object the hard way" );
   
    d := DecomposeProjectiveQuiverRepresentation( DualOfRepresentation( a ) );
    
    return List( d, DualOfRepresentationHomomorphism );
    
end );

##
InstallMethod( IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition,
          [ IsQuiverRepresentation ],
  function( a )
    local d;
    
    d := DecomposeProjectiveQuiverRepresentation( a );
    
    if HasIsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition( a ) then
      
      return IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition( a );
      
    fi;
    
    return MorphismBetweenDirectSums( List( d, i -> [ i ] ) );
    
end );

##
InstallMethod( IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition,
          [ IsQuiverRepresentation ],
  function( a )
    local d;
    
    d := DecomposeProjectiveQuiverRepresentation( a );
    
    if HasIsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( a ) then
      
      return IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( a );
      
    fi;
    
    return Inverse( IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition( a ) );
    
end );

##
InstallMethod( IsomorphismIntoInjectiveRepresentationFromCanonicalDecomposition,
          [ IsQuiverRepresentation ],
  function( a )
    
    return DualOfRepresentationHomomorphism(
           IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition(
              DualOfRepresentation( a ) ) );
   
end );

##
InstallMethod( IsomorphismFromInjectiveRepresentationIntoCanonicalDecomposition,
          [ IsQuiverRepresentation ],
  function( a )
    
    return DualOfRepresentationHomomorphism(
            IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition(
              DualOfRepresentation( a ) ) );
    
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
