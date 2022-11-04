# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
## Some qpa tweaks to improve performance and functionality
##
#############################################################################

##
InstallValue( GLOBAL_FIELD_FOR_QPA, rec( is_locked := false, default_field := HomalgFieldOfRationals( ) ) );

InstallGlobalFunction( SET_GLOBAL_FIELD_FOR_QPA,
  function( field )
    
    #if GLOBAL_FIELD_FOR_QPA!.is_locked then
      
      #Error( "Setting the GLOBAL_FIELD_FOR_QPA should be done only once per session!\n" );
      
    #fi;
    
    
    GLOBAL_FIELD_FOR_QPA!.field := field;
      
    GLOBAL_FIELD_FOR_QPA!.is_locked := true;
    
end );

###############################
#
# Interface to qpa matrices
#
###############################

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
      
      return MakeZeroMatrix( BaseDomain( mat ), Length( L ), 0 );
      
    fi;
    
    rows := rows{ L };
   
    return MatrixByRows( BaseDomain( mat ), [ Length( L ), dim[ 2 ] ], rows );
  
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
      
      return MakeZeroMatrix( BaseDomain( mat ), 0, Length( L ) );
      
    fi;
    
    cols := cols{ L };
    
    return MatrixByCols( BaseDomain( mat ), [ dim[ 1 ], Length( L ) ], cols );
  
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
          5000,
  function( L )
        
    if Length( L ) = 1 then
      return L[1];
    elif Length( L ) = 2 then
      return StackMatricesDiagonally( L[ 1 ], L[ 2 ] );
    else
      return StackMatricesDiagonally(
                StackMatricesDiagonally( L{ [ 1 .. Int( Length( L ) / 2 ) ] } ),
                StackMatricesDiagonally( L{ [ Int( Length( L ) / 2 ) + 1 .. Length( L ) ] } )
            );
    fi;
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
InstallMethod( KroneckerProduct, "for two QPA matrices",
    [ IsQPAMatrix, IsQPAMatrix ],
  function( M1, M2 )
    local k, dim1, dim2, mat;
  
    k := BaseDomain( M1 );
  
    if not IsIdenticalObj( k, BaseDomain( M2 ) ) then
      Error( "Base domains of the given matrices are not identical" );
    fi;
  
    dim1 := DimensionsMat( M1 );
    dim2 := DimensionsMat( M2 );
  
    if dim1[ 1 ] * dim2[ 1 ] = 0 or dim1[ 2 ] * dim2[ 2 ] = 0 then
      return MatrixByRows( k, [ dim1[ 1 ] * dim2[ 1 ], dim1[ 2 ] * dim2[ 2 ] ], [ ] );
    fi;
  
    mat := KroneckerProduct( RowsOfMatrix( M1 ), RowsOfMatrix( M2 ) );
  
    return MatrixByRows( k, [ dim1[ 1 ] * dim2[ 1 ], dim1[ 2 ] * dim2[ 2 ] ], mat );
  
end );

#####################################
#
# Constructors without check
#
####################################

## Modified version of a similar method in QPA.
## Aim: reduce any checks.
##
InstallMethod( QuiverRepresentation,
          [ IsQuiverAlgebra, IsDenseList, IsDenseList ],
          5000,
  function( A, dimensions, matrices )
    local cat, Q, objects, m, morphisms, i, a, source, range;
    
    cat := CategoryOfQuiverRepresentations( A );
    
    Q := QuiverOfAlgebra( A );
    
    objects := List( dimensions, VectorSpaceConstructor( cat ) );
    
    m := LinearTransformationConstructor( cat );
    
    morphisms := [];
    
    for i in [ 1 .. Length( matrices ) ] do
      
      a := Arrow( Q, i );
      
      source := objects[ VertexIndex( Source( a ) ) ];
      
      range := objects[ VertexIndex( Target( a ) ) ];
      
      morphisms[ i ] := m( source, range, matrices[ i ] );
      
    od;
    
    return QuiverRepresentationNC( cat, objects, morphisms );
    
end );

#InstallGlobalFunction( QuiverRepresentationNoCheck, { A, dim, l } -> QuiverRepresentation( A, dim, l ) );

## Modified version of a similar method in QPA.
## Aim: reduce any checks.
##
InstallMethod( QuiverRepresentationHomomorphism,
          [ IsQuiverRepresentation, IsQuiverRepresentation, IsDenseList ],
          5000,
  function( R1, R2, maps )
    local cat, ucat, Q, morphisms, V1, V2, morphism, m, i;
 
    cat := CapCategory( R1 );
  
    if not IsIdenticalObj( cat, CapCategory( R2 ) ) then
    
      Error( "representations in different categories" );
    
    fi;
  
    ucat := VectorSpaceCategory( cat );

    Q := QuiverOfRepresentation( R1 );
  
    morphisms := [];
  
    for i in [ 1 .. NumberOfVertices( Q ) ] do
    
      V1 := VectorSpaceOfRepresentation( R1, i );
    
      V2 := VectorSpaceOfRepresentation( R2, i );
    
      if not IsBound( maps[ i ] ) then
      
        morphism := ZeroMorphism( V1, V2 );
      
      else
      
        m := maps[ i ];
      
        if IsCapCategoryMorphism( m ) then
               
          morphism := m;
        
        else
        
          morphism := LinearTransformationConstructor( cat )( V1, V2, m );
        
        fi;
      
      fi;
    
      Add( morphisms, morphism );
    
    od;

    return QuiverRepresentationHomomorphismNC( R1, R2, morphisms );
  
end );

#InstallGlobalFunction( QuiverRepresentationHomomorphismNoCheck, { r1, r2, l } -> QuiverRepresentationHomomorphism( r1, r2, l ) );

#######################################
#
# Operations for homological algebra
#
#######################################

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
    
    if not ForAll( source_reps, r -> Length( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    paths := List( source_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Source ), s -> Target( Representative( e )!.paths[ 1 ] ) = s ) then
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
      
    fi;
    
    range_reps := List( range_list, Representative );
    
    range_reps := List( range_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( range_reps, r -> Length( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    images := List( source_list, s -> ComposeElements( e, s ) );
    
    coeffs := List( range_reps, r -> Inverse( r[ 1 ][ 1 ] ) );
    
    paths := List( range_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Source ), s -> s = Source( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
      
    fi;
    
    mat := List( images, image -> ListN( coeffs, CoefficientsOfPaths( paths, image ), \* ) );
    
    return MatrixByRows( field, [ Length( source_list ), Length( range_reps ) ], mat );
  
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
    
    if not ForAll( source_reps, r -> Length( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    paths := List( source_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Target ), t -> t = Source( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
            
    fi;
    
    range_reps := List( range_list, Representative );
    
    range_reps := List( range_reps, r -> [  r!.coefficients, r!.paths ] );
    
    if not ForAll( range_reps, r -> Length( r[ 2 ] ) = 1 ) then
      
      Error( "This case is not yet covered" ); # and not needed in this package
      
    fi;
    
    coeffs := List( range_reps, r -> Inverse( r[ 1 ][ 1 ] ) );
    
    paths := List( range_reps, r -> r[ 2 ][ 1 ] );
    
    if not ForAll( List( paths, Target ), t -> t = Target( Representative( e )!.paths[ 1 ] ) ) then
      
      Info( InfoDerivedCategories, 2, "This is not expected usage of the method\n" );
 
    fi;
    
    images := List( source_list, s -> ComposeElements( s, e ) );
    
    mat := List( images, image -> ListN( coeffs, CoefficientsOfPaths( paths, image ), \* ) );
    
    return MatrixByRows( field, [ Length( source_list ), Length( range_reps ) ], mat );
    
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
    
    b1 := basis[ PositionProperty( basis, p -> DimensionVector( p1 ) = List( p, Length ) ) ];
    
    b2 := basis[ PositionProperty( basis, p -> DimensionVector( p2 ) = List( p, Length ) ) ];
    
    mats := ListN( b1, b2, { bb1 , bb2 } -> MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement( bb1, bb2, e ) );
    
    return QuiverRepresentationHomomorphism( p1, p2, mats );
    
end );

##
InstallMethod( IndecProjRepresentations,
          [ IsQuiverAlgebra ],
          100,
  function( A )
    local with_setting_properties, projs;
    
    with_setting_properties := ValueOption( "ipr_derived_cats" );
    
    if with_setting_properties = false then
      
      TryNextMethod( );
      
    fi;
    
    projs := IndecProjRepresentations( A : ipr_derived_cats := false );
    
    Perform( projs, function( i ) SetIsProjective( i, true ); end );
    
    return projs;
  
end );

##
InstallOtherMethod( IndecProjectiveObjects,
    [ IsQuiverRepresentationCategory ],
  function( cat )
  
    return IndecProjRepresentations( AlgebraOfCategory( cat ) );
    
end );

##
InstallMethod( IndecInjRepresentations,
          [ IsQuiverAlgebra ],
          100,
  function( A )
    local injs;
    
    injs := IndecProjRepresentations( OppositeAlgebra( A ) );
    
    injs := List( injs, DualOfRepresentation );
    
    Perform( injs, function( i ) SetIsInjective( i, true ); end );
   
    return injs;
  
end );

##
InstallOtherMethod( IndecInjectiveObjects,
    [ IsQuiverRepresentationCategory ],
  function( cat )
  
    return IndecInjRepresentations( AlgebraOfCategory( cat ) );
    
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

##
InstallMethod( DecomposeProjectiveQuiverRepresentation,
          [ IsQuiverRepresentation ],
          100,
  function( a )
    local A, projs, summands;
    
    if not HasUnderlyingProjectiveSummands( a ) then
      
      TryNextMethod( );
      
    fi;
    
    A := AlgebraOfRepresentation( a );
    
    projs := IndecProjRepresentations( A );
    
    summands := UnderlyingProjectiveSummands( a );
    
    if not ForAll( summands, s -> ForAny( projs, p -> IsIdenticalObj( s, p ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    SetIsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition( a, IdentityMorphism( a ) );
    
    SetIsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( a, IdentityMorphism( a ) );
    
    Info( InfoDerivedCategories, 2, "Decomposition of a projective object the easy way" );
    
    return List( [ 1 .. Length( summands ) ],
      i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( summands, i, a ) );
      
end );

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
      
      new_a := QuiverRepresentation( A, new_dim_vec, mats );
      
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
      
      while check_for_block and i <= Length( dims ) do
        
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
      
      while check_for_block and i <= Length( dims ) do
        
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
          
          temp := QuiverRepresentation( A, dim_vectors_of_projs[ i ], current_mats_1 );
          
          if IsWellDefined( temp ) then
            
            b := BasisOfExternalHom( projs[ i ], temp );
            
            if not ( Length( b ) = 1 and IsIsomorphism( b[ 1 ] ) ) then
                
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
    
    new_a := QuiverRepresentation( A, new_dim_vec, mats );
    
    s := Concatenation( List( o, Range ), [ new_a ] );
    
    d := DirectSum( s );
    
    output := List( [ 1 .. Length( s ) - 1 ], i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, i, d ) );
    
    if IsZero( new_a ) then
      
      SetIsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition( a, DirectSumFunctorial( o ) );
      
      SetIsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( a, DirectSumFunctorial( List( o, Inverse ) ) );
      
      return output;
    
    else
      
      Info( InfoDerivedCategories, 2, "Decomposition of a projective object the very hard way" );

      # the following three lines can do the job, but it may take forever, hence we use them only if there is no better way.
      morphism_from_new_a := InjectionOfCofactorOfDirectSumWithGivenDirectSum( s, Length( s ), d );
      
      mingen := MinimalGeneratingSet( new_a );
      
      output := Concatenation( output, List( mingen, x -> PreCompose( HomFromProjective( x, new_a ), morphism_from_new_a ) ) );
    
    fi;
    
    return output;
    
end );

##
InstallMethod( DecomposeInjectiveQuiverRepresentation,
          [ IsQuiverRepresentation ],
          100,
  function( a )
    local A, injs, summands;
    
    if not HasUnderlyingInjectiveSummands( a ) then
      
      if HasDualOfRepresentation( a ) and HasUnderlyingProjectiveSummands( DualOfRepresentation( a ) ) then
        
        summands := List( UnderlyingProjectiveSummands( DualOfRepresentation( a ) ), DualOfRepresentation );
        
        SetUnderlyingInjectiveSummands( a, summands );
        
      else
        
        TryNextMethod( );
        
      fi;
      
    fi;
    
    A := AlgebraOfRepresentation( a );
    
    injs := IndecInjRepresentations( A );
    
    summands := UnderlyingInjectiveSummands( a );
    
    if not ForAll( summands, s -> ForAny( injs, p -> IsIdenticalObj( s, p ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    SetIsomorphismOntoInjectiveRepresentationFromCanonicalDecomposition( a, IdentityMorphism( a ) );
    
    SetIsomorphismFromInjectiveRepresentationIntoCanonicalDecomposition( a, IdentityMorphism( a ) );
    
    Info( InfoDerivedCategories, 2, "Decomposition of an injective object the easy way" );
    
    return List( [ 1 .. Length( summands ) ],
      i -> ProjectionInFactorOfDirectSumWithGivenDirectSum( summands, i, a ) );
      
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
InstallMethod( IsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition,
          [ IsQuiverRepresentation ],
  function( a )
    local d;
    
    d := DecomposeProjectiveQuiverRepresentation( a );
    
    if HasIsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition( a ) then
      
      return IsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition( a );
      
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
    
    return Inverse( IsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition( a ) );
    
end );

##
InstallMethod( IsomorphismOntoInjectiveRepresentationFromCanonicalDecomposition,
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
            IsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition(
              DualOfRepresentation( a ) ) );
    
end );

## Modified version of a similar method in QPA.
## Aim: improve performance.
InstallMethod( ProjectiveCover, "for a quiver representation",
          [ IsQuiverRepresentation ],
          5000,
function( R )
  local   mingen,  maps,  PR,  projections;
  
  if Sum( DimensionVector( R ) ) = 0 then
    return ZeroMorphism( ZeroObject( CapCategory( R ) ), R);
  else
    mingen := MinimalGeneratingSet( R );
    maps := List( mingen, x -> HomFromProjective( x, R ) );
    return UniversalMorphismFromDirectSum( maps );
  fi;
end );

## Modified version of a similar method in QPA.
## Aim: improve performance.
InstallMethod ( DualOfRepresentation,
"for a IsQuiverRepresentation",
[ IsQuiverRepresentation ], 5000,
function( R )
    local C, D;
    
    C := CapCategory( R );
    D := DualFunctor( C );
    
    D := ApplyFunctor( D, R );
    SetDualOfRepresentation( D, R );
    
    return D;
end
  );

## Modified version of a similar method in QPA.
## Aim: improve performance.
InstallMethod ( DualOfRepresentationHomomorphism,
"for a map between two representations of a quiver",
[ IsQuiverRepresentationHomomorphism ],
function( f )

    local   C,  D;
    
    C := CapCategory( f );
    D := DualFunctor( C );
    
    D := ApplyFunctor( D, f );
    SetDualOfRepresentationHomomorphism( D, f );
    SetDualOfRepresentation( Source( D ), Range( f ) );
    SetDualOfRepresentation( Range( D ), Source( f ) );
   
    return D;
end
  );

##############################
#
# QPA matrices
#
##############################

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
          5000,
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
        5000,
  function( R, mat )
  
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
    
    return MatrixByRows( R, DimensionsMat( mat ), mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
        [ IsRing, IsMatrix ],
        5000,
  function( R, mat )
  
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
      
      TryNextMethod( );
      
    fi;
    
    return MatrixByCols( R, Reversed( DimensionsMat( mat ) ), mat );
    
end );

##
InstallOtherMethod( MatrixByCols,
          [ IsRing, IsDenseList, IsDenseList ],
          5000,
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
               5000,
function( M )
  local dim;
  
  dim := DimensionsMat( M );
  
  Print( "<", dim[ 1 ], " x ", dim[ 2 ], " QPA-matrix over ", Name( BaseDomain( M ) ), ">" );
  
end );

##
InstallOtherMethod( RowsOfMatrix, "for QPA matrix",
               [ IsQPAMatrix ],
               5000,
  function( M )
    
    if IsRowMatrixRep( M ) then
      
      return M!.rows;
      
    elif IsColMatrixRep( M ) then
      
      return TransposedMat( M!.cols );
      
    else
      
      Info( InfoDerivedCategories, 3, "I am using external method to compute the rows of a qpa matrix" );
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallOtherMethod( ColsOfMatrix, "for QPA matrix",
               [ IsQPAMatrix ],
               5000,
  function( M )
    
    if IsColMatrixRep( M ) then
      
      return M!.cols;
      
    elif IsRowMatrixRep( M ) then
      
      return TransposedMat( M!.rows );
      
    else
      
      Info( InfoDerivedCategories, 3, "I am using external method to compute the cols of a qpa matrix" );
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallOtherMethod( MakeZeroMatrix,
              [ IsField, IsInt, IsInt ],
              5000,
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
               5000,
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
          5000,
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
          5000,
  function( M )
    
    if IsRowMatrixRep( M ) then
      
      return IsZero( RowsOfMatrix( M ) );
      
    elif IsColMatrixRep( M ) then
      
      return IsZero( ColsOfMatrix( M ) );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( IsZero, [ IsQPAMatrix ], 5000, IsZeroMatrix );

##
InstallMethod( IsIdentityMatrix,
          [ IsQPAMatrix ],
          5000,
  function( M )
    local dim, id;
    
    dim := DimensionsMat( M );
    
    if dim[ 1 ] <> dim[ 2 ] then
      
      return false;
      
    fi;
    
    id := IdentityMatrix( BaseDomain( M ), dim[ 1 ] );
    
    return M = id;
  
end );

##
InstallMethod( \*,
          [ IsQPAMatrix, IsQPAMatrix ],
          5000,
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

##
InstallMethod( \+,
          [ IsQPAMatrix, IsQPAMatrix ],
          5000,
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

##
InstallMethod( \*,
          [ IsMultiplicativeElement, IsQPAMatrix ],
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
          5000,
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
               5000,
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

###########################################
#
# Methods in case there is a homalg field
#
###########################################

#############################
#
# Interface to homalg
#
##############################

##
InstallGlobalFunction( QPA_to_Homalg_Matrix_With_Given_Homalg_Field,
  
  function( qpa_mat, field )
    local dim;
     
    dim := DimensionsMat( qpa_mat );
    
    return HomalgMatrix( RowsOfMatrix( qpa_mat ), dim[ 1 ], dim[ 2 ], field );
    
end );

##
InstallGlobalFunction( QPA_to_Homalg_Matrix,
  
  function( qpa_mat )
   
    if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
      
      Error( "No homalg field is set" );
      
    fi;
      
    return QPA_to_Homalg_Matrix_With_Given_Homalg_Field( qpa_mat, GLOBAL_FIELD_FOR_QPA!.field );
    
end );
 
##
InstallGlobalFunction( Homalg_to_QPA_Matrix,

  function( homalg_mat )
    local underlying_field, dim, qpa_mat;
    
    underlying_field := HomalgRing( homalg_mat );
    
    if not IsRationalsForHomalg( underlying_field ) then
      
      Error( "The matrix should be defined over rationals field for homalg" );
      
    fi;
    
    dim := [ NrRows( homalg_mat ), NrCols( homalg_mat ) ];
    
    if ForAny( dim, IsZero ) then
      
      qpa_mat := MakeZeroMatrix( Rationals, dim[ 1 ], dim[ 2 ] );
      
    else
      
      if IsHomalgExternalRingRep( underlying_field ) then
        
        homalg_mat := ConvertHomalgMatrix( homalg_mat, GLOBAL_FIELD_FOR_QPA!.default_field );
        
      fi;
      
      qpa_mat := MatrixByRows( Rationals, dim, EntriesOfHomalgMatrixAsListList( homalg_mat ) );
      
    fi;
    
    return qpa_mat;
    
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
function( M, vec )
  local dim, V, v, sol, m;
  
  if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
    TryNextMethod( );
  fi;
  
  dim := DimensionsMat( M );
  if dim[ 2 ] <> Length( vec ) then
    Error("a row vector of length ",Length( vec )," cannot be in the image of a ",
          dim[ 1 ]," x ",dim[ 2 ],"-matrix,\n");
  fi;
  if dim[ 1 ] = 0 then
    if IsZero( vec ) then
      return EmptyVector( BaseDomain( M ) );
    else
      return fail;
    fi;
  fi;
  
  V := StandardVectorSpace( BaseDomain( M ), dim[ 1 ] );
  
  if dim[ 1 ] = dim[ 2 ] and IsIdentityMatrix( M ) then
    return AsList( vec );
  elif HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
    if IsZero( vec ) then
      return Zero( V );
    else
      return fail;
    fi;
  fi;
  
  if dim[ 2 ] = 0 then
    return Zero( V );
  else
    
    Info( InfoDerivedCategories, 3,
      Concatenation( "Using homalg field to compute SolutionMat( ", String( dim ), " -matrix, ", String( Length( vec ) ), " -vector )" ) );
    
    m := QPA_to_Homalg_Matrix( M );
    
    v := HomalgMatrix( AsList( vec ), 1, Length( vec ), GLOBAL_FIELD_FOR_QPA!.field );
    
    sol := RightDivide( v, m );
    
    Info( InfoDerivedCategories, 3, "Done!" );
    
    if sol = fail then
      
      return fail;
      
    else
      
      sol := Homalg_to_QPA_Matrix( sol );
      
      sol := RowsOfMatrix( sol )[ 1 ];
      
      sol := Vector( V, sol );
      
      Assert( 2, sol * M = vec );
      
      return sol;
      
    fi;
    
  fi;
  
end 
);

##
InstallMethod( NullspaceMat, "for QPA matrix",
          [ IsQPAMatrix ],
          5000,
function( M )
  local dim, domain, syz;
  
  if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
    
    TryNextMethod( );
  
  fi;
  
  dim := DimensionsMat( M );
  
  domain := BaseDomain( M );
  
  if dim[ 1 ] = 0 or dim[ 2 ] = 0 then
    
    return IdentityMatrix( BaseDomain( M ), dim[ 1 ] );
    
  elif HasIsIdentityMatrix( M ) and IsIdentityMatrix( M ) then
    
    return MakeZeroMatrix( domain, 0, dim[ 1 ] );
    
  else
    
    Info( InfoDerivedCategories, 3,
      Concatenation( "Using homalg field to compute NullspaceMat( ", String( dim ), " -matrix )" ) );
    
    M := QPA_to_Homalg_Matrix( M );
    
    syz := SyzygiesOfRows( M );
    
    Assert( 2, IsZero( syz * M ) );
    
    syz := Homalg_to_QPA_Matrix( syz );
    
    Info( InfoDerivedCategories, 3, "Done!" );
    
    return syz;
    
  fi;
  
end );

##
InstallMethod( SolutionMat, "for QPA matrix and a list of standard vector",
          [ IsQPAMatrix, IsDenseList ],
          5000,
function( M, list_of_vectors )
  local dim, list, nr_vectors, solution, V, v, sol, D, entries, positions, p, m;
  
  dim := DimensionsMat( M );
  
  if ForAll( list_of_vectors, v -> dim[ 2 ] <> Length( v ) ) then
    Error("a row vector of length ", Length( v[1] )," cannot be in the image of a ",
          dim[ 1 ]," x ",dim[ 2 ],"-matrix,\n");
  fi;
  
  list := List( list_of_vectors, AsList );
  
  nr_vectors := Length( list );
  
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
  
  if not IsBound( GLOBAL_FIELD_FOR_QPA!.field ) then
    
    return List( list_of_vectors, v -> SolutionMat( M, v ) );
    
  elif dim[ 2 ] = 0 then
    
    return ListWithIdenticalEntries( nr_vectors, Zero( V ) );
    
  else
    
    Info( InfoDerivedCategories, 3,
      Concatenation( "Using homalg field to compute SolutionMat( ", String( dim ),
        " -matrix, list of ", String( Length( list_of_vectors ) ), " -vectors )" ) );
    
    m := QPA_to_Homalg_Matrix( M );
    
    v := HomalgMatrix( list, nr_vectors, Length( list[ 1 ] ), GLOBAL_FIELD_FOR_QPA!.field );
    
    solution := List( [ 1 .. nr_vectors ], i -> fail );
    
    sol := HomalgVoidMatrix( GLOBAL_FIELD_FOR_QPA!.field );
    
    D := DecideZeroRowsEffectively( v, m, sol );
    
    if not IsZero( D ) then
      
      entries := EntriesOfHomalgMatrixAsListList( D );
      
      positions := PositionsProperty( [ 1 .. NrRows( v ) ], i -> IsZero( entries[ i ] ) );
      
    else
      
      positions := [ 1 .. NrRows( v ) ];
      
    fi;
    
    Info( InfoDerivedCategories, 3, "Done!" );
    
    sol := RowsOfMatrix( Homalg_to_QPA_Matrix( sol ) );
    
    sol := sol{ positions };
    
    for p in positions do
      
      solution[ p ] := Vector( V, -sol[ 1 ] );
      
      Assert( 2, solution[ p ] * M = list_of_vectors[ p ] );
      
      Remove( sol, 1 );
      
    od;
    
  fi;
  
  return solution;
  
end );

##
InstallMethod( PreImagesRepresentative,
          [ IsLinearTransformation, IsDenseList ],
          5000,
  function( T, list_of_vectors )
    local x, i;
    
    x := ShallowCopy( SolutionMat( RightMatrixOfLinearTransformation( T ), list_of_vectors ) );
    
    for i in [ 1 .. Length( x ) ] do
      
      if x[ i ] <> fail then
        
        x[ i ] := Vector( Source( T ), x[ i ] );
        
      fi;
      
    od;
    
    return x;
    
end );

##
InstallMethod( PreImagesRepresentative, "for a representation homomorphism and a representation element",
               [ IsQuiverRepresentationHomomorphism, IsDenseList ],
               5000,
function( f, list_of_elements )
  local elements_vectors, maps, preimages, output, preimage;
  
  if not ForAll( list_of_elements, m -> m in Range( f ) ) then
    
    Error("Some elements are not in the range for the entered homomorphism,\n");
    
  fi;
  
  if IsEmpty( list_of_elements ) then
    
    return [ ];
    
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

InstallMethod( MinimalGeneratingSet, "for a quiver representation",
               [ IsQuiverRepresentation ],
               5000,
function( R )
  local f;

  f := TopProjection( R );
   
  return PreImagesRepresentative( f, BasisVectors( Basis( Range( f ) ) ) );
  
end
);

######################################################
#
# Overload some categorical methods for vector spaces
# They should eventually, maybe?, to QPA
#
######################################################

##
InstallMethod( LiftAlongMonomorphism,
          [ IsLinearTransformation, IsLinearTransformation ],
          5000,
  function( i, test )
    local matrix, F;
    if IsZero( Source( i ) ) or IsZero( Source( test ) ) then
      return ZeroMorphism( Source( test ), Source( i ) );
    fi;
    F := UnderlyingField( CapCategory( i ) );
    matrix := PreImagesRepresentative( i, List( Basis( Source( test ) ), v -> ImageElm( test, v ) ) );
    matrix := List( matrix, AsList );
    return LinearTransformationByRightMatrix
           ( Source( test ), Source( i ),
             MatrixByRows( F, matrix ) );
end );

##
InstallMethod( ColiftAlongEpimorphism,
          [ IsLinearTransformation, IsLinearTransformation ],
          5000,
  function( e, test )
    local matrix, F;
    if IsZero( Range( e ) ) or IsZero( Range( test ) ) then
      return ZeroMorphism( Range( e ), Range( test ) );
    fi;
    F := UnderlyingField( CapCategory( e ) );
    matrix := List( PreImagesRepresentative( e, Basis( Range( e ) ) ), v -> AsList( ImageElm( test, v ) ) );
    return LinearTransformationByRightMatrix
           ( Range( e ), Range( test ),
             MatrixByRows( F, matrix ) );
end );

###########################################
#
# Lift and Colift in quiver representations
#
###########################################

##
BindGlobal( "COMPUTE_LIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE",
  function( alpha, beta )
    local cat, field, partitions, mats_alpha, mats_beta, matrices, vector, sol, positions, l;
    
    cat := CapCategory( alpha );
    
    field := CommutativeRingOfLinearCategory( cat );
    
    partitions := PARTITIONS_OF_AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( Source( alpha ), Source( beta ) );
    
    if IsEmpty( partitions ) then
      if IsZeroForMorphisms( alpha ) then
        return ZeroMorphism( Source( alpha ), Source( beta ) );
      else
        return fail;
      fi;
    fi;
    
    mats_alpha := MatricesOfRepresentationHomomorphism( alpha );
    
    mats_alpha := List( mats_alpha, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    mats_beta := MatricesOfRepresentationHomomorphism( beta );
    
    mats_beta := List( mats_beta, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    matrices := List( partitions, part -> ListN( part, mats_beta, \* ) );
    
    matrices := List( matrices,
              mats -> UnionOfRows(
                List( mats, mat -> ConvertTransposedMatrixToColumn( TransposedMatrix( mat ) ) )
                                 )
                );
    
    matrices := UnionOfColumns( matrices );
    
    vector := Filtered( mats_alpha, m -> NrRows( m ) <> 0 and NrCols( m ) <> 0 );
    
    vector := List( vector, v -> ConvertTransposedMatrixToColumn( TransposedMatrix( v ) ) );
              
    vector := UnionOfRows( vector );
    
    Info( InfoDerivedCategories, 3, "computing LeftDivide of ",
            NrRows( matrices ), " x ", NrCols( matrices ),
              " & ", NrRows( vector ), " x ", NrCols( vector ), " -homalg matrices" );
 
    sol := LeftDivide( matrices, vector );
    
    Info( InfoDerivedCategories, 3, "Done!" );
    
    if sol = fail then
      
      return fail;
      
    fi;
    
    sol := EntriesOfHomalgMatrix( sol );
    
    positions := PositionsProperty( sol, s -> not IsZero( s ) );
    
    if IsEmpty( positions ) then
      
      return ZeroMorphism( Source( alpha ), Source( beta ) );
    
    fi;
    
    l := Sum( ListN( sol{ positions }, partitions{ positions }, { s, p } -> s * p ) );
    
    l := List( l, Homalg_to_QPA_Matrix );
    
    return QuiverRepresentationHomomorphism( Source( alpha ), Source( beta ), l );
    
end );

##
BindGlobal( "COMPUTE_COLIFT_IN_QUIVER_REPS_DERIVED_CATS_PACKAGE",
  function( beta, alpha )
    local cat, field, partitions, mats_alpha, mats_beta, matrices, vector, sol, positions, l;
    
    cat := CapCategory( alpha );
    
    field := CommutativeRingOfLinearCategory( cat );
    
    partitions := PARTITIONS_OF_AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( Range( beta ), Range( alpha ) );
    
    if IsEmpty( partitions ) then
      if IsZeroForMorphisms( alpha ) then
        return ZeroMorphism( Range( beta ), Range( alpha ) );
      else
        return fail;
      fi;
    fi;
   
    mats_alpha := MatricesOfRepresentationHomomorphism( alpha );
    
    mats_alpha := List( mats_alpha, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    mats_beta := MatricesOfRepresentationHomomorphism( beta );
    
    mats_beta := List( mats_beta, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    matrices := List( partitions, part -> ListN( mats_beta, part, \* ) );
    
    matrices := List( matrices,
              mats -> UnionOfRows(
                List( mats, mat -> ConvertTransposedMatrixToColumn( TransposedMatrix( mat ) ) )
                                 )
                );
    
    matrices := UnionOfColumns( matrices );
    
    vector := Filtered( mats_alpha, m -> NrRows( m ) <> 0 and NrCols( m ) <> 0 );
    
    vector := List( vector, v -> ConvertTransposedMatrixToColumn( TransposedMatrix( v ) ) );
              
    vector := UnionOfRows( vector );
    
    Info( InfoDerivedCategories, 3, "computing LeftDivide of ",
            NrRows( matrices ), " x ", NrCols( matrices ),
              " & ", NrRows( vector ), " x ", NrCols( vector ), " -homalg matrices" );
    
    sol := LeftDivide( matrices, vector );
    
    Info( InfoDerivedCategories, 3, "Done!" );
   
    if sol = fail then
      
      return fail;
      
    fi;
    
    sol := EntriesOfHomalgMatrix( sol );
    
    positions := PositionsProperty( sol, s -> not IsZero( s ) );
    
    if IsEmpty( positions ) then
      
      return ZeroMorphism( Range( beta ), Range( alpha ) );
      
    fi;
    
    l := Sum( ListN( sol{ positions }, partitions{ positions }, { s, p } -> s * p ) );
    
    l := List( l, Homalg_to_QPA_Matrix );
    
    return QuiverRepresentationHomomorphism( Range( beta ), Range( alpha ), l );
        
end );

#
#####################################
#
# For Homomorphism structure
#
#####################################

InstallMethodWithCache( AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM,
          [ IsQuiverRepresentation, IsQuiverRepresentation ],
  function( S, R )
    local cat, field, A, domain, quiver, nr_of_vertices, S_dimensions, R_dimensions, mat, nr_of_arrows, source_of_arrow, range_of_arrow, S_i, R_i, id_1, id_2, nr_rows_of_block, u, v, nr_cols_in_block1, block_1, block_2, nr_cols_in_block3, block_3, block_4, nr_cols_in_block5, block_5, block, i;
    
    cat := CapCategory( S );
    
    if not HasIsLinearCategoryOverCommutativeRing( cat ) then
      
      Error( "The category should be linear over some homalg field of rationals!\n" );
      
    fi;
    
    field := CommutativeRingOfLinearCategory( cat );
    
    if not IsFieldForHomalg( field ) then
      
      Error( "The category should be linear over some homalg field of rationals!\n" );
      
    fi;
    
    Info( InfoDerivedCategories, 3,
      "computing AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( <", String( S ), ">, <", String( R ), "> )" 
      );
    
    A := AlgebraOfRepresentation( S );
    
    domain := LeftActingDomain( A );
    
    quiver := QuiverOfAlgebra( A );
    
    nr_of_vertices := NumberOfVertices( quiver );
    
    S_dimensions := DimensionVector( S );
    
    R_dimensions := DimensionVector( R );
    
    mat := HomalgZeroMatrix( 0, S_dimensions * R_dimensions, field );
    
    nr_of_arrows := NumberOfArrows( quiver );
    
    for i in [ 1 .. nr_of_arrows ] do
      
      source_of_arrow := VertexIndex( Source( Arrow( quiver, i ) ) );
      
      range_of_arrow := VertexIndex( Target( Arrow( quiver, i ) ) );
      
      S_i := RightMatrixOfLinearTransformation( MapForArrow( S, i ) );
      
      S_i := HomalgMatrix( RowsOfMatrix( S_i ), DimensionsMat( S_i )[ 1 ], DimensionsMat( S_i )[ 2 ], field );
      
      R_i := RightMatrixOfLinearTransformation( MapForArrow( R, i ) );
      
      R_i := HomalgMatrix( RowsOfMatrix( R_i ), DimensionsMat( R_i )[ 1 ], DimensionsMat( R_i )[ 2 ], field );
      
      id_1 := HomalgIdentityMatrix( NrRows( S_i ), field );
      
      id_2 := HomalgIdentityMatrix( NrCols( R_i ), field );
      
      nr_rows_of_block := NrRows( S_i ) * NrCols( R_i );
      
      u := Minimum( source_of_arrow, range_of_arrow );
      
      v := Maximum( source_of_arrow, range_of_arrow );
      
      if u = 1 then
        
        nr_cols_in_block1 := 0;
      
      else
        
        nr_cols_in_block1 := S_dimensions{ [ 1 .. u - 1 ] } * R_dimensions{ [ 1 .. u - 1 ] };
      
      fi;
      
      block_1 := HomalgZeroMatrix( nr_rows_of_block,  nr_cols_in_block1, field );
      
      if u = source_of_arrow then
        
        block_2 := - KroneckerMat( TransposedMatrix( R_i ), id_1 );
        
      elif u = range_of_arrow then
        
        block_2 := KroneckerMat( id_2, S_i );
        
      fi;
      
      if v - u in [ 0, 1 ] then
        
        nr_cols_in_block3 := 0;
        
      else
        
        nr_cols_in_block3 := S_dimensions{ [ u + 1 .. v - 1 ] } * R_dimensions{ [ u + 1 .. v - 1 ] };
        
      fi;
      
      block_3 := HomalgZeroMatrix( nr_rows_of_block,  nr_cols_in_block3, field );
      
      if v = source_of_arrow then
        
        block_4 := - KroneckerMat( TransposedMatrix( R_i ), id_1 );
        
      elif v = range_of_arrow then
        
        block_4 := KroneckerMat( id_2, S_i );
        
      fi;
      
      if v = nr_of_vertices then
        
        nr_cols_in_block5 := 0;
        
      else
        
        nr_cols_in_block5 := S_dimensions{ [ v + 1 .. nr_of_vertices ] }
                              * R_dimensions{ [ v + 1 .. nr_of_vertices ] };
        
      fi;
      
      block_5 := HomalgZeroMatrix( nr_rows_of_block,  nr_cols_in_block5, field );
      
      block := UnionOfColumns( [ block_1, block_2, block_3, block_4, block_5 ] );
      
      mat := UnionOfRows( mat, block );
      
    od;
    
    Info( InfoDerivedCategories, 3, "computing SyzygiesOfColumns of ", NrRows( mat ), " x ", NrCols( mat ) );
    
    mat := SyzygiesOfColumns( mat );
    
    Info( InfoDerivedCategories, 3, "Done!" );
    
    return mat;
    
end );

##
InstallMethodWithCache( PARTITIONS_OF_AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM,
          [ IsQuiverRepresentation, IsQuiverRepresentation ],
  
  function( S, R )
    local cat, p, A, quiver, nr_of_vertices, S_dimensions, R_dimensions, mat, matrices, nr_cols, i, field;
    
    mat := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( S, R );
    
    field := HomalgRing( mat );
    
    cat := CapCategory( S );
    
    A := AlgebraOfRepresentation( S );
    
    quiver := QuiverOfAlgebra( A );
    
    nr_of_vertices := NumberOfVertices( quiver );
    
    S_dimensions := DimensionVector( S );
    
    R_dimensions := DimensionVector( R );
    
    matrices := [ ];
    
    for i in [ 1 .. nr_of_vertices ] do
      
      Add( matrices, CertainRows( mat, [ 1 .. S_dimensions[ i ] * R_dimensions[ i ] ] ) );
      
      mat := CertainRows( mat, [ S_dimensions[ i ] * R_dimensions[ i ] + 1 .. NrRows( mat ) ] );
      
    od;
     
    nr_cols := NrCols( mat );
     
    matrices := List( [ 1 .. nr_cols ], i -> List( matrices, m -> CertainColumns( m, [ i ] ) ) );
    
    matrices := List( matrices,
      mats -> List( [ 1 .. nr_of_vertices ],
        function( i )
          
          if R_dimensions[ i ] <> 0 then
            
            return UnionOfColumns( List( [ 1 .. R_dimensions[ i ] ],
                      r -> CertainRows( mats[ i ], [ ( r - 1 ) * S_dimensions[ i ] + 1 .. r * S_dimensions[ i ] ] ) )
                    );
          else
            
            return HomalgZeroMatrix( S_dimensions[ i ], 0, field );
            
          fi;
          
        end ) );
        
    return matrices;
    
end );

# TODO we can use the partitions, but I think this is quicker!
#
InstallGlobalFunction( BASIS_OF_EXTERNAL_HOM_OF_QUIVER_REPRESENTATIONS,
  
  function( S, R )
    local mat, field, A, domain, quiver, nr_of_vertices, S_dimensions, R_dimensions, cols, homs, dim_hom, map, k, current_mat, b, i, x, y;
    
    if IsZero( S ) or IsZero( R ) then
      
      return [ ];
      
    fi;
    
    mat := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( S, R );
    
    field := HomalgRing( mat );
    
    A := AlgebraOfRepresentation( S );
    
    domain := LeftActingDomain( A );
    
    quiver := QuiverOfAlgebra( A );
    
    nr_of_vertices := NumberOfVertices( quiver );
    
    S_dimensions := DimensionVector( S );
    
    R_dimensions := DimensionVector( R );
    
    if IsHomalgExternalRingRep( field ) then
      
      Info( InfoDerivedCategories, 3, "converting a ", NrRows( mat ), " x ", NrCols( mat ), " - matrix ..." );
      
      mat := ConvertHomalgMatrix( mat, GLOBAL_FIELD_FOR_QPA!.default_field );
      
      Info( InfoDerivedCategories, 3, "Done!" );
      
    fi;
    
    cols := TransposedMat( EntriesOfHomalgMatrixAsListList( mat ) );
    
    homs := [ ];
    
    dim_hom := 0;
    
    for b in cols do
      map := [ ];
      dim_hom := dim_hom + 1;
      k := 1;
      for i in [ 1 .. nr_of_vertices ] do
        if ( S_dimensions[ i ] <> 0 ) and ( R_dimensions[ i ] <> 0 ) then 
          current_mat := NullMat( S_dimensions[ i ], R_dimensions[ i ], domain );
          for x in [ 1..R_dimensions[ i ] ] do
            for y in [ 1..S_dimensions[ i ] ] do
              current_mat[ y ][ x ] := b[ k ];
              k := k + 1;
            od;
          od;
          map[ i ] := MatrixByRows( domain, current_mat );
        fi;
      od;
      homs[ dim_hom ] := QuiverRepresentationHomomorphism( S, R, map );
    od;
    
    return homs;
  
end );

##
InstallGlobalFunction( COEFFICIENTS_OF_QUIVER_REPRESENTATIONS_HOMOMORPHISM,
  
  function( alpha )
    local mat, vector, field;
    
    field := CommutativeRingOfLinearCategory( CapCategory( alpha ) );
    
    if IsZero( Source( alpha ) ) or IsZero( Range( alpha ) ) then
      
      return HomalgZeroMatrix( 0, 1, field );
      
    fi;
    
    mat := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( Source( alpha ), Range( alpha ) );
    
    if IsZero( NrCols( mat ) ) then
      
      return HomalgZeroMatrix( 0, 1, field );
      
    fi;
    
    vector := List( MatricesOfRepresentationHomomorphism( alpha ),
                m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    vector := Filtered( vector, m -> NrRows( m ) <> 0 and NrCols( m ) <> 0 );
    
    vector := List( vector, v -> ConvertTransposedMatrixToColumn( TransposedMatrix( v ) ) );
              
    vector := UnionOfRows( vector );
    
    return LeftDivide( mat, vector );
    
end );

##
InstallGlobalFunction( HOM_STRUCTURE_ON_QUIVER_REPRESENTATIONS,
  
  function( S, R )
    local mat, field;
    
    field := CommutativeRingOfLinearCategory( CapCategory( S ) );
    
    if IsZero( S ) or IsZero( R ) then
      
      return VectorSpaceObject( 0, field );
      
    fi;
    
    mat := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( S, R );
    
    return VectorSpaceObject( NrCols( mat ), field );
    
end );

##
InstallGlobalFunction( HOM_STRUCTURE_ON_QUIVER_REPRESENTATION_HOMOMORPHISMS_WITH_GIVEN_OBJECTS,
          
  function( s, alpha, beta, r )
    local cat, field, mats_alpha, mats_beta, partitions, mats, B, sol;
    
    if IsZero( s ) or IsZero( r ) then
        
      return ZeroMorphism( s, r );
    
    fi;
     
    cat := CapCategory( alpha );
    
    field := CommutativeRingOfLinearCategory( cat );
    
    mats_alpha := MatricesOfRepresentationHomomorphism( alpha );
    
    mats_alpha := List( mats_alpha, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    mats_beta := MatricesOfRepresentationHomomorphism( beta );
    
    mats_beta := List( mats_beta, m -> QPA_to_Homalg_Matrix_With_Given_Homalg_Field( m, field ) );
    
    partitions := PARTITIONS_OF_AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( Range( alpha ), Source( beta ) );
    
    if IsEmpty( partitions ) then
      
      return ZeroMorphism( s, r );
      
    fi;
    
    # This assumes that the quiver is right!
    partitions := List( partitions, mats -> ListN( mats_alpha, mats, mats_beta, { x, y, z } -> x * y * z ) );
    
    mats := List( partitions,
              mats -> UnionOfRows(      
                List( mats, mat -> ConvertTransposedMatrixToColumn( TransposedMatrix( mat ) ) )
                                 )
                );
    
    mats := UnionOfColumns( mats );
    
    B := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( Source( alpha ), Range( beta ) );
    
    sol := TransposedMatrix( LeftDivide( B, mats ) );
    
    return VectorSpaceMorphism( s, sol, r );
    
end );

##
InstallGlobalFunction( INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE,
  
  function( alpha )
    local cat, field, U, mat;
    
    cat := CapCategory( alpha );
    
    field := CommutativeRingOfLinearCategory( cat );
    
    U := DistinguishedObjectOfHomomorphismStructure( cat );
    
    mat := COEFFICIENTS_OF_QUIVER_REPRESENTATIONS_HOMOMORPHISM( alpha );
    
    return VectorSpaceMorphism( U, TransposedMatrix( mat ), HomStructure( Source( alpha ), Range( alpha ) ) );
    
end );

##
InstallGlobalFunction( INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM,
  
  function( S, R, iota )
    local A, domain, quiver, nr_of_vertices, S_dimensions, R_dimensions, B, c, b, map, k, current_mat, i, x, y;
    
    if IsZero( iota ) then
      
      return ZeroMorphism( S, R );
      
    fi;
    
    A := AlgebraOfRepresentation( S );
    
    domain := LeftActingDomain( A );
    
    quiver := QuiverOfAlgebra( A );
    
    nr_of_vertices := NumberOfVertices( quiver );
    
    S_dimensions := DimensionVector( S );
    
    R_dimensions := DimensionVector( R );
    
    if IsZero( S_dimensions ) or IsZero( R_dimensions ) then
      
      return ZeroMorphism( S, R );
      
    fi;
    
    B := AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM( S, R );
    
    c := TransposedMatrix( UnderlyingMatrix( iota ) );
    
    b := B * c;
    
    b := Homalg_to_QPA_Matrix( b );
    
    b := ColsOfMatrix( b )[ 1 ];
    
    map := [ ];
    
    k := 1;
    
    for i in [ 1 .. nr_of_vertices ] do
      
      if ( S_dimensions[ i ] <> 0 ) and ( R_dimensions[ i ] <> 0 ) then
        
        current_mat := NullMat( S_dimensions[ i ], R_dimensions[ i ], domain );
        
        for x in [ 1..R_dimensions[ i ] ] do
          
          for y in [ 1..S_dimensions[ i ] ] do
            
            current_mat[ y ][ x ] := b[ k ];
            
            k := k + 1;
            
          od;
          
        od;
        
        map[ i ] := MatrixByRows( domain, current_mat );
        
      fi;
    
    od;
    
    return QuiverRepresentationHomomorphism( S, R, map );
    
end );


#####################################
#
# QPA categorical methods
#
#####################################

## It can be derived from BasisOfExternalHom & CoefficientsOfMorphism
## But this is much much quicker :)
##
BindGlobal( "ADD_HOMOMORPHISM_STRUCTURE_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE",
  
  function( cat )
    local field;
    
    if not (  
        
            HasIsLinearCategoryOverCommutativeRing( cat ) and
            IsLinearCategoryOverCommutativeRing( cat ) and
            HasCommutativeRingOfLinearCategory( cat ) and
            IsFieldForHomalg( CommutativeRingOfLinearCategory( cat ) ) 
              
          ) then
      
      Info( InfoDerivedCategories, 2, "Since the category is not linear, I couldn't add the homomorphism structure methods" );
      
      return;
      
    fi;
    
    ##
    field := CommutativeRingOfLinearCategory( cat );
    
    ##
    SetRangeCategoryOfHomomorphismStructure( cat, MatrixCategory( field ) );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
      function( )
        
        return VectorSpaceObject( 1, field );
        
    end );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
      HOM_STRUCTURE_ON_QUIVER_REPRESENTATIONS );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
      HOM_STRUCTURE_ON_QUIVER_REPRESENTATION_HOMOMORPHISMS_WITH_GIVEN_OBJECTS );
      
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
      INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE );
      
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
      INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM );
    
    return;
    
end );


##
BindGlobal( "ADD_RANDOM_METHODS_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE",
  function( cat )
    local A, field;
    
    A := AlgebraOfCategory( cat );
    
    field := UnderlyingField( VectorSpaceCategory( cat ) );
    
    AddRandomObjectByList( cat,
      
      function( C, l )
        local indec_proj, indec_injs, simples, ind, s1, s2, alpha, B;
        
        indec_proj := IndecProjRepresentations( A );
        
        indec_injs := IndecInjRepresentations( A );
        
        simples := SimpleRepresentations( A );
        
        ind := Concatenation( indec_injs, indec_proj, simples );
        
        while true do
          
          s1 := DirectSum( List( [ 1 .. Random( l ) ], i -> Random( ind ) ) );
          
          s2 := DirectSum( List( [ 1 .. Random( l ) ], i -> Random( ind ) ) );
          
          B := BasisOfExternalHom( s1, s2 );
          
          alpha := Sum( B );
          
          if not IsEmpty( B ) then
            
            break;
            
          fi;
          
        od;
        
        return CokernelObject( alpha );
        
    end );
    
    AddRandomObjectByInteger( cat,
      
      function( C, n )
        
        return RandomObjectByList( C, [ n ] );
        
    end );
    
    AddRandomMorphismByList( cat,
      
      function( C, L )
        local a, b, B;
        
        a := RandomObjectByList( C, L );
        
        b := RandomObjectByList( C, L );
        
        B := BasisOfExternalHom( a, b );
        
        if IsEmpty( B ) then
          
          return ZeroMorphism( a, b );
          
        fi;
        
        return Sum( B );
        
    end );
    
    AddRandomMorphismByInteger( cat,
      
      function( C, n )
        
        return RandomMorphismByList( C, [ n ] );
    
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
    
    return;
    
end );

InstallOtherMethod( Name,
        [ IsQuiverAlgebra ],
  function( A )
    if IsBound( A!.alternative_name ) then
      return A!.alternative_name;
    else
      return String( A );
    fi;
end );

##
InstallOtherMethod( Representative,
          [ IsPathAlgebraElement ],
  IdFunc );

#
InstallOtherMethod( CategoryOfVectorSpaces,
        [ IsFieldForHomalg ],
         
  function( F )
    local vec;
    
    vec := CategoryOfVectorSpaces( F!.ring );
        
    DisableSanityChecks( vec );
    CapCategorySwitchLogicOff( vec );
    DisableAddForCategoricalOperations( vec );
    
    return vec;
    
end );

##
InstallMethod( CategoryOfQuiverRepresentations,
              [ IsQuiverAlgebra and IsRightQuiverAlgebra, IsRationalsForHomalg ],
              1000,
  function( A, field )
    local cat, domain, r, name, finalize_cat;
    
    if HasCategoryOfQuiverRepresentations( A ) then
      
      cat := CategoryOfQuiverRepresentations( A );
      
      if not IsIdenticalObj( CommutativeRingOfLinearCategory( cat ), field ) then
        
        Error( "The category has been already created over a different homalg field!\n" );
        
      fi;
      
      if HasIsFinalized( cat ) then
        
        return cat;
        
      fi;
      
    fi;
    
    cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false, coqr_derived_cats := false );
    
    if HasTensorProductFactors( A ) then
      
      name := List( TensorProductFactors( A ), Name );
      
      name := JoinStringsWithSeparator( name, "⊗ " );
      
      A!.alternative_name := name;
      
    fi;
    
    if Name( A ) <> "none" then
      
      r := RandomTextColor( Name( A ) );
      
      cat!.Name := Concatenation( r[ 1 ], "Quiver representations(", r[ 2 ], " ", Name( A ), " ", r[ 1 ], ")", r[ 2 ] );
      
    fi;
    
    domain := LeftActingDomain( A );
    
    SetIsLinearCategoryOverCommutativeRing( cat, true );
    
    SetCommutativeRingOfLinearCategory( cat, field );
    
    DisableSanityChecks( cat );
    
    CapCategorySwitchLogicOff( cat );
    
    DisableAddForCategoricalOperations( cat );
    
    AddIsEqualForCacheForObjects( cat, IsIdenticalObj );
    
    AddIsEqualForCacheForMorphisms( cat, IsIdenticalObj );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
      function( r, alpha )
        
        return ( r / domain ) * alpha;
        
    end );
    
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
          
          d := QuiverRepresentation( A, dimension_vector, matrices );
          
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
      function( D1, source_diagram, morphisms, range_diagram, D2 )
        local matrices;
        
        matrices := List( morphisms, MatricesOfRepresentationHomomorphism );
        
        matrices := List( Transpose( matrices ), StackMatricesDiagonally );
        
        return QuiverRepresentationHomomorphism( D1, D2, matrices );
        
      end );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
      function( D1, source_diagram, morphisms, range_diagram, D2 )
        local matrices;
        
        if IsEmpty( morphisms ) or IsEmpty( morphisms[ 1 ] ) then
          
          return ZeroMorphism( D1, D2 );
          
        fi;
        
        matrices := List( [ 1 .. NumberOfVertices( QuiverOfAlgebra( A ) ) ],
                      i -> STACK_LISTLIST_QPA_MATRICES(
                        List( morphisms,
                          row -> List( row,
                            morphism -> MatricesOfRepresentationHomomorphism( morphism )[ i ] ) ) ) );
        
        return QuiverRepresentationHomomorphism( D1, D2, matrices );
        
      end );
     
    ##
    ADD_RANDOM_METHODS_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE( cat );
    
    ##
    ADD_HOMOMORPHISM_STRUCTURE_TO_QUIVER_REPRESENTATIONS_DERIVED_CATS_PACKAGE( cat );
    
    ##
    AddBasisOfExternalHom( cat,
      BASIS_OF_EXTERNAL_HOM_OF_QUIVER_REPRESENTATIONS );
    
    ##
    AddCoefficientsOfMorphism( cat,
      { alpha } ->
        EntriesOfHomalgMatrix( COEFFICIENTS_OF_QUIVER_REPRESENTATIONS_HOMOMORPHISM( alpha ) )
      );
    
    Finalize( cat );
     
    return cat;
  
end );

##
InstallMethod( CategoryOfQuiverRepresentations,
              [ IsQuiverAlgebra and IsRightQuiverAlgebra ],
              1000,
  function( A )
    local v;
    
    v := ValueOption( "coqr_derived_cats" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
     
    return CategoryOfQuiverRepresentations( A, GLOBAL_FIELD_FOR_QPA!.default_field );
    
end );

