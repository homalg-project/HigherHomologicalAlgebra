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
    
    r := RANDOM_TEXT_ATTR();
    
    name := Concatenation( "Hom(T,-) functor ", r[ 1 ], "from", r[ 2 ], " ", Name( ambient_cat ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps ) );
    
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
        
        r := QuiverRepresentationNoCheck( A_op, dim_vec, mats );
        
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
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToIndecInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local H, ambient_cat, reps, inj_indec, name, G, r;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    reps := AsCapCategory( Range( H ) );
    
    inj_indec := FullSubcategoryGeneratedByIndecInjectiveObjects( ambient_cat );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of Hom(T,-) functor ", r[ 1 ], "from", r[ 2 ], " ", Name( inj_indec ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps ) );
    
    G := CapFunctor( name, inj_indec, reps );
    
    AddObjectFunction( G,
      function( a )
        local aa, p;
        
        if not IsBound( G!.ValuesForObjects ) then
          
          aa := ApplyFunctor( H, UnderlyingCell( UnderlyingCell( a ) ) );
          
          G!.ValuesForObjects := [ [ a, aa ] ];
          
          return aa;
          
        else
          
          p := PositionProperty( G!.ValuesForObjects,
                v -> IsIdenticalObj( v[ 1 ], a ) or IsEqualForObjects( v[ 1 ], a )
                  );
         
          if p = fail then
            
            aa := ApplyFunctor( H, UnderlyingCell( UnderlyingCell( a ) ) );
            
            Add( G!.ValuesForObjects, [ a, aa ] );
            
            return aa;
            
          else
            
            return G!.ValuesForObjects[ p ][ 2 ];
            
          fi;
          
        fi;
        
    end );
      
    AddMorphismFunction( G,
      function( s, alpha, r )
        local a, b, coeffs, basis, images, p;
        
        a := Source( alpha );
        
        b := Range( alpha );
               
        if not IsBound( G!.GeneratingValuesForMorphisms ) then
          
          basis := BasisOfExternalHom( a, b );
        
          images := List( basis, phi -> ApplyFunctor( H, UnderlyingCell( UnderlyingCell( phi ) ) ) );
          
          G!.GeneratingValuesForMorphisms := [ [ a, b, images ] ];
          
        else
          
          p := PositionProperty( G!.GeneratingValuesForMorphisms,
            v -> ( IsIdenticalObj( v[ 1 ], a ) or IsEqualForObjects( v[ 1 ], a ) ) and
                  ( IsIdenticalObj( v[ 2 ], b ) or IsEqualForObjects( v[ 2 ], b ) )
                );
          
          if p = fail then
            
            basis := BasisOfExternalHom( a, b );
        
            images := List( basis, phi -> ApplyFunctor( H, UnderlyingCell( UnderlyingCell( phi ) ) ) );
          
            Add( G!.GeneratingValuesForMorphisms, [ a, b, images ] );
            
          else
            
            images := G!.GeneratingValuesForMorphisms[ p ][ 3 ];
            
          fi;
          
        fi; 
        
        if IsEmpty( images ) then
          
          return ZeroMorphism( s, r );
          
        fi;
 
        coeffs := CoefficientsOfMorphism( alpha );
        
        return coeffs * images;
        
    end );
    
    return G;
   
end );

##
InstallMethod( TensorFunctorByExceptionalCollection,
    [ IsExceptionalCollection ],
    
  function( collection )
    local full, inc, iso2, A, iso1, iso, ambient_cat, A_op, reps, can, projs, r, name, F;
    
    full := DefiningFullSubcategory( collection );
    
    inc := InclusionFunctor( full );
    
    inc := ExtendFunctorToAdditiveClosureOfSource( inc );
    
    iso2 := IsomorphismFromAlgebroid( collection );
    
    A := AsCapCategory( Source( iso2 ) );
    
    iso1 := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( A );
    
    iso := PreCompose( iso1, iso2 );
    
    iso := ExtendFunctorToAdditiveClosures( iso );
    
    ambient_cat := AmbientCategory( full );
    
    A_op := OppositeAlgebra( UnderlyingQuiverAlgebra( A ) );
    
    reps := CategoryOfQuiverRepresentations( A_op, CommutativeRingOfLinearCategory( full ) );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( reps );
    
    projs := AsCapCategory( Source( can ) );
    
    r := RANDOM_TEXT_ATTR();
    
    name := Concatenation( "- ⊗_{End T} T functor ", r[ 1 ], "from", r[ 2 ], " ", Name( reps ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( ambient_cat ) );
    
    F := CapFunctor( name, reps, ambient_cat );
    
    AddObjectFunction( F,
      function( r )
        local P;
        
        P := ProjectiveChainResolution( r );
        
        P := P^1;
        
        P := ApplyFunctor( can, P / projs );
        
        P := ApplyFunctor( iso, P );
        
        P := ApplyFunctor( inc, P );
        
        return CokernelObject( P );
        
    end );
    
    AddMorphismFunction( F,
      function( source, alpha, range )
        local gamma;
        
        gamma := MorphismBetweenProjectiveChainResolutions( alpha );
        
        gamma := [ Source( gamma ) ^ 1, gamma[ 0 ], Range( gamma ) ^ 1 ];
        
        gamma := List( gamma, g -> ApplyFunctor( can, g / projs ) );
        
        gamma := List( gamma, g -> ApplyFunctor( iso, g ) );
        
        gamma := List( gamma, g -> ApplyFunctor( inc, g ) );
        
        return CallFuncList( CokernelObjectFunctorial, gamma );
        
    end );
    
    return F;
    
end );

##
InstallMethod( EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local A, projs, indec_projs, add_indec_projs, r, name, F;
    
    A := AlgebraOfCategory( cat );
    
    projs := FullSubcategoryGeneratedByProjectiveObjects( cat );
    
    indec_projs := FullSubcategoryGeneratedByIndecProjectiveObjects( cat );
    
    add_indec_projs := AdditiveClosure( indec_projs  );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Equivalence functor ", r[ 1 ], "from", r[2], " ", Name( projs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( add_indec_projs ) );
    
    F := CapFunctor( name, projs, add_indec_projs );
    
    AddObjectFunction( F,
      function( a )
        local d;
        
        d := DecomposeProjectiveQuiverRepresentation( UnderlyingCell( a ) );
        
        if Size( d ) = 1 and IsZero( d[ 1 ] ) then
          
          return ZeroObject( add_indec_projs );
          
        fi;
        
        d := List( d, m -> AsFullSubcategoryCell( projs, Source( m ) ) );
        
        d := List( d, o -> AsFullSubcategoryCell( indec_projs, o ) );
        
        return AdditiveClosureObject( d, add_indec_projs ); 
      
    end );
    
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local d_source_cell, d_range_cell, alpha_cell, iso, mat;
        
        if ( HasIsZeroForObjects( s ) and IsZeroForObjects( s ) ) or ( HasIsZeroForObjects( r ) and IsZeroForObjects( r ) ) then
          
          return ZeroMorphism( s, r );
          
        fi;
         
        d_source_cell := DecomposeProjectiveQuiverRepresentation( UnderlyingCell( Source( alpha ) ) );
        
        d_range_cell := DecomposeProjectiveQuiverRepresentation( UnderlyingCell( Range( alpha ) ) );
        
        alpha_cell := UnderlyingCell( alpha );
        
        iso := IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition( UnderlyingCell( Range( alpha ) ) );
        
        d_range_cell := List( d_range_cell, Source );
        
        d_range_cell := List( [ 1 .. Size( d_range_cell ) ],
          i -> PreCompose(
                  iso,
                  ProjectionInFactorOfDirectSumWithGivenDirectSum( d_range_cell, i, Range( iso ) )
                ) );
        
        mat := List( d_source_cell, u -> List( d_range_cell, v -> PreCompose( [ u, alpha_cell, v ] ) ) );
        
        mat := List( mat, row -> List( row, m -> AsFullSubcategoryCell( projs, m ) ) );
        
        mat := List( mat, row -> List( row, m -> AsFullSubcategoryCell( indec_projs, m ) ) );
        
        return AdditiveClosureMorphism( s, mat, r );
        
    end );
    
    return F;
  
end );

##
InstallMethod( EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecInjectiveObjects,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local A, injs, indec_injs, add_indec_injs, r, name, F;
    
    A := AlgebraOfCategory( cat );
    
    injs := FullSubcategoryGeneratedByInjectiveObjects( cat );
    
    indec_injs := FullSubcategoryGeneratedByIndecInjectiveObjects( cat );
    
    add_indec_injs := AdditiveClosure( indec_injs  );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Equivalence functor", " ", r[ 1 ], "from", r[ 2 ], " ", Name( injs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( add_indec_injs ) );
    
    F := CapFunctor( name, injs, add_indec_injs );
    
    AddObjectFunction( F,
      function( a )
        local d;
        
        d := DecomposeInjectiveQuiverRepresentation( UnderlyingCell( a ) );
        
        if Size( d ) = 1 and IsZero( d[ 1 ] ) then
          
          return ZeroObject( add_indec_injs );
          
        fi;
        
        d := List( d, m -> AsFullSubcategoryCell( injs, Range( m ) ) );
        
        d := List( d, o -> AsFullSubcategoryCell( indec_injs, o ) );
        
        return AdditiveClosureObject( d, add_indec_injs ); 
      
    end );
    
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local d_source_cell, d_range_cell, alpha_cell, iso, mat;
        
        if ( HasIsZeroForObjects( s ) and IsZeroForObjects( s ) ) or ( HasIsZeroForObjects( r ) and IsZeroForObjects( r ) ) then
          
          return ZeroMorphism( s, r );
          
        fi;
      
        d_source_cell := DecomposeInjectiveQuiverRepresentation( UnderlyingCell( Source( alpha ) ) );
        
        d_range_cell := DecomposeInjectiveQuiverRepresentation( UnderlyingCell( Range( alpha ) ) );
        
        alpha_cell := UnderlyingCell( alpha );
        
        iso := IsomorphismIntoInjectiveRepresentationFromCanonicalDecomposition( UnderlyingCell( Source( alpha ) ) );
        
        d_source_cell := List( d_source_cell, Range );
        
        d_source_cell := List( [ 1 .. Size( d_source_cell ) ],
          i -> PostCompose(
                  iso,
                  InjectionOfCofactorOfDirectSumWithGivenDirectSum( d_source_cell, i, Source( iso ) )
                ) );
        
        mat := List( d_source_cell, u -> List( d_range_cell, v -> PreCompose( [ u, alpha_cell, v ] ) ) );
        
        mat := List( mat, row -> List( row, m -> AsFullSubcategoryCell( injs, m ) ) );
        
        mat := List( mat, row -> List( row, m -> AsFullSubcategoryCell( indec_injs, m ) ) );
        
        return AdditiveClosureMorphism( s, mat, r );
        
    end );
    
    return F;
  
end );

##
InstallMethod( IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
          [ IsAlgebroid ],
  function( algebroid )
    local A, A_op, full, ambient_cat, quiver_op, nr_vertices, basis, projs, projs_in_subcategory, r, name, F;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    A_op := OppositeAlgebra( A );
       
    full := FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
    
    ambient_cat := AmbientCategory( full );
    
    quiver_op := QuiverOfAlgebra( A_op );
    
    nr_vertices := NumberOfVertices( quiver_op );
    
    basis := BasisOfProjectives( A_op );
    
    projs := IndecProjRepresentations( A_op );
    
    projs_in_subcategory := List( projs, p -> AsFullSubcategoryCell( ambient_cat, p ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( algebroid ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( full ) );
    
    F := CapFunctor( name, algebroid, full );
    
    AddObjectFunction( F,
      function( a )
        local i, aa, p;
        
        i := VertexIndex( UnderlyingVertex( a ) );
        
        aa := basis[ PositionProperty( basis, b -> [ A_op.( String( Vertex( quiver_op, i ) ) ) ] in b ) ];
        
        p := projs_in_subcategory[ PositionProperty( projs, p -> DimensionVector( p ) = List( aa, Size ) ) ];
        
        return AsFullSubcategoryCell( full, p );
      
      end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        local e, i, j, mor;
        
        e := UnderlyingQuiverAlgebraElement( alpha );
        
        e := OppositeAlgebraElement( e );
        
        mor := MorphismBetweenIndecProjectivesGivenByElement( 
                UnderlyingCell( UnderlyingCell( s ) ),
                e,
                UnderlyingCell( UnderlyingCell( r ) ) );
        
        mor := AsFullSubcategoryCell( ambient_cat, mor );
        
        return AsFullSubcategoryCell( full, mor );
      
      end );
    
    return F;
    
end );

##
InstallMethod( IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
          [ IsAlgebroid ],
  function( algebroid )
    local A, A_op, full, quiver_op, nr_vertices, basis, projs, r, name, G;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    A_op := OppositeAlgebra( A );
       
    full := FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
    
    quiver_op := QuiverOfAlgebra( A_op );
    
    nr_vertices := NumberOfVertices( quiver_op );
    
    basis := BasisOfProjectives( A_op );
    
    projs := IndecProjRepresentations( A_op );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( algebroid ) );
    
    G := CapFunctor( name, full, algebroid );
    
    AddObjectFunction( G,
      function( a )
        local p, i;
        
        p := UnderlyingCell( UnderlyingCell( a ) );
        
        p := basis[ PositionProperty( basis, b -> DimensionVector( p ) = List( b, Size ) ) ];
        
        i := PositionProperty( [ 1 .. nr_vertices ], i -> [ A_op.( String( Vertex( quiver_op, i ) ) ) ] in p );
        
        return ObjectInAlgebroid( algebroid, Vertex( QuiverOfAlgebra( A ), i ) );
        
      end );
    
    AddMorphismFunction( G,
      function( s, alpha, r )
        local basis, I, images, dim, rel;
        
        basis := BasisOfExternalHom( s, r );
        
        I := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
        
        images := List( basis, b -> ApplyFunctor( I, b ) );
        
        dim := Size( basis );
        
        rel := RelationsBetweenMorphisms( Concatenation( [ alpha ], images ) );
        
        if Size( rel ) > 1 then
        
          Error( "This should not happen!\n" );
        
        fi;
        
        rel := AdditiveInverse( Inverse( rel[ 1 ][ 1 ] ) ) * rel[ 1 ];
        
        rel := rel{ [ 2 .. dim + 1 ] };
        
        if IsEmpty( rel ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return rel * basis;
          
        fi;
      
      end );
    
    return G;
    
end );

##
InstallMethod( IsomorphismIntoAlgebroid,
        [ IsExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, F;
    
    n := NumberOfObjects( collection );
    
    full := DefiningFullSubcategory( collection );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
    algebroid := Algebroid( A );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[1], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( algebroid ) );
    
    F := CapFunctor( name, full, algebroid );
    
    AddObjectFunction( F,
      function( e )
        local p;
                
        p := PositionProperty( [ 1 .. n ], i -> IsEqualForObjects( e, collection[ i ] ) );
        
        return algebroid.(p);
        
    end );
    
    AddMorphismFunction( F,
      function( source, phi, range )
        local s, i, r, j, basis, labels, dim, paths, rel;
        
        s := Source( phi );
        
        i := PositionProperty( [ 1 .. n ], k -> IsEqualForObjects( s, collection[ k ] ) );
        
        r := Range( phi );
        
        j := PositionProperty( [ 1 .. n ], k -> IsEqualForObjects( r, collection[ k ] ) );
        
        basis := BasisForPaths( collection, i, j );
        
        if IsEmpty( basis ) then
          
          return ZeroMorphism( source, range );
          
        fi;
        
        labels := LabelsForBasisForPaths( collection, i, j );
        
        dim := Length( basis );
        
        if i > j then
          
          return ZeroMorphism( source, range );
          
        elif i = j then
          
          paths := [ IdentityMorphism( algebroid.( i ) ) ]; # Because the quiver has no loops.
          
        else
          
          paths := List( labels, label ->
                  PreCompose(
                  List( label, arrow_label ->
                    algebroid.( Concatenation( 
                                  "v",
                                  String( arrow_label[ 1 ] ),
                                  "_v",
                                  String( arrow_label[ 2 ] ),
                                  "_",
                                  String( arrow_label[ 3 ] ) )
                              ) ) ) );
        fi;
        
        rel := RelationsBetweenMorphisms( Concatenation( [ phi ], basis ) );
        
        if Length( rel ) > 1 then
          
          Error( "This should not happen, please report this" );
          
        fi;
        
        rel := AdditiveInverse( Inverse( rel[ 1 ][ 1 ] ) ) * rel[ 1 ];
        
        return rel{ [ 2 .. dim + 1 ] } * paths;
        
    end );
    
    return F;
    
end );

##
InstallMethod( IsomorphismFromAlgebroid,
        [ IsExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, F;
    
    n := NumberOfObjects( collection );
    
    full := DefiningFullSubcategory( collection );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
    algebroid := Algebroid( A );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( algebroid ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( full ) );
    
    F := CapFunctor( name, algebroid, full );
    
    AddObjectFunction( F,
      function( e )
        local p;
        
        p := VertexIndex( UnderlyingVertex( e ) );
        
        return collection[ p ];
        
    end );
    
    AddMorphismFunction( F,
      function( source, phi, range )
        local s, i, r, j, basis, labels, e, paths, coeffs, arrow_list, paths_list;
        
        s := Source( phi );
        
        i := VertexIndex( UnderlyingVertex( s ) );
        
        r := Range( phi );
        
        j := VertexIndex( UnderlyingVertex( r ) );
              
        e := Representative( UnderlyingQuiverAlgebraElement( phi ) );
        
        if IsZero( e ) then
          
          return ZeroMorphism( source, range );
          
        fi;
        
        paths := Paths( e );
        
        coeffs := Coefficients( e );
        
        if Size( paths ) = 1 and Source( paths[ 1 ] ) = Target( paths[ 1 ] ) then
          
          return coeffs * [ IdentityMorphism( source ) ];
        
        fi;
        
        arrow_list := List( paths, ArrowList );
        
        arrow_list := List( arrow_list, 
          l -> List( l, arrow -> [
                                    VertexIndex( Source( arrow ) ),
                                    VertexIndex( Target( arrow ) ),
                                    Int( SplitString( Label( arrow ), "_" )[ 3 ] )
                                 ]
                   ) );
        
        
        paths_list := List( arrow_list,
          l -> PreCompose(
                   List( l, indices -> Arrows( collection, indices[ 1 ], indices[ 2 ] )[ indices[ 3 ] ] )
                   ) );  
        
        return coeffs * paths_list;
        
    end );
    
    return F;
    
end );

##
InstallMethod( RestrictFunctorIterativelyToFullSubcategoryOfSource,
              [ IsCapFunctor, IsCapFullSubcategory ],
  function( F, full )
    local G;
    
    if IsIdenticalObj( AsCapCategory( Source( F ) ), AmbientCategory( full ) ) then
      
      return RestrictFunctorToFullSubcategoryOfSource( F, full );
    
    else
      
      G := RestrictFunctorIterativelyToFullSubcategoryOfSource( F, AmbientCategory( full ) );
      
      return RestrictFunctorToFullSubcategoryOfSource( G, full );
      
    fi;
    
end );

InstallMethod( LocalizationFunctor,
              [ IsHomotopyCategory ],
  function( homotopy )
    local complexes, cat, D, r, name, F;
    
    complexes := UnderlyingCapCategory( homotopy );
    
    cat := UnderlyingCategory( complexes );
    
    D := DerivedCategory( cat );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Localization functor ", r[ 1 ], "from", r[ 2 ], " ", Name( homotopy ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( D ) );
    
    F := CapFunctor( name, homotopy, D );
    
    AddObjectFunction( F,
      function( a )
        
        return a/D;
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        
        return alpha/D;
        
    end );
    
    return F;
  
end );

##
InstallMethod( UniversalFunctorFromDerivedCategory,
          [ IsCapFunctor ],
  function( F )
    local homotopy_cat, C, cat, D, r, name, U;
    
    homotopy_cat := AsCapCategory( Source( F ) );
    
    C := AsCapCategory( Range( F ) );
    
    if not IsHomotopyCategory( homotopy_cat ) then
      
      Error( "The input be a functor from homotopy category of some abelian category" );
      
    fi;
    
    cat := DefiningCategory( homotopy_cat );
    
    D := DerivedCategory( cat );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Universal functor ", r[ 1 ], "from", r[ 2 ], " ", Name( D ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( C ) );
    
    U := CapFunctor( name, D, C );
    
    AddObjectFunction( U,
      function( a )
        
        return ApplyFunctor( F, UnderlyingCell( a ) );
        
    end );
    
    AddMorphismFunction( U,
      function( s, alpha, r )
        local i, j;
        
        i := ApplyFunctor( F, SourceMorphism( UnderlyingRoof( alpha ) ) );
        
        j := ApplyFunctor( F, RangeMorphism( UnderlyingRoof( alpha ) ) );
        
        return PreCompose( Inverse( i ), j );
        
    end );
    
    return U;
    
end );

##
InstallMethod( LDerivedFunctor,
          [ IsCapFunctor ],
  function( F )
    local H_1, cat_1, D_1, H_2, cat_2, D_2, name, LF;
    
    H_1 := AsCapCategory( Source( F ) );
    
    H_2 := AsCapCategory( Range( F ) );
    
    if not ( IsHomotopyCategory( H_1 ) and IsHomotopyCategory( H_2 ) ) then
      
      TryNextMethod( );
      
    fi;
    
    cat_1 := DefiningCategory( H_1 );
    
    D_1 := DerivedCategory( cat_1 );
    
    cat_2 := DefiningCategory( H_2 );
    
    D_2 := DerivedCategory( cat_2 );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat_1 ) then
      
      Error( Name( cat_1 ), " should be abelian with enough projectives!\n" );
      
    fi;
    
    name := Concatenation( "Left derived functor of ", Name( F ) );
    
    LF := CapFunctor( name, D_1, D_2 );
    
    AddObjectFunction( LF,
      function( a )
        local p, Fp;
        
        p := ProjectiveResolution( UnderlyingCell( UnderlyingCell( a ) ), true ) / H_1;
        
        Fp := ApplyFunctor( F, p );
        
        return DerivedCategoryObject( D_2, Fp );
        
    end );
    
    AddMorphismFunction( LF,
      function( s, alpha, r )
        local roof, quasi_iso, morphism, F_quasi_iso, F_morphism;
        
        roof := UnderlyingRoof( alpha );
        
        quasi_iso := SourceMorphism( roof );
        
        quasi_iso := MorphismBetweenProjectiveResolutions( UnderlyingCell( quasi_iso ), true ) / H_1;
        
        morphism := RangeMorphism( roof );
        
        morphism := MorphismBetweenProjectiveResolutions( UnderlyingCell( morphism ), true ) / H_1;
        
        F_quasi_iso := ApplyFunctor( F, quasi_iso );
        
        F_morphism := ApplyFunctor( F, morphism );
        
        roof := Roof( F_quasi_iso, F_morphism );
        
        return DerivedCategoryMorphism( s, roof, r );
        
    end );
    
    return LF;
    
end );

##
InstallMethod( LDerivedFunctor,
          [ IsCapFunctor ],
  function( F )
    local cat_1;
    
    cat_1 := AsCapCategory( Source( F ) );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat_1 ) then
      
      TryNextMethod( );
      
    fi;
    
    return LDerivedFunctor( ExtendFunctorToHomotopyCategories( F ) );
    
end );

InstallMethod( LeftDerivedFunctor, [ IsCapFunctor ], LDerivedFunctor );

##
InstallMethod( RDerivedFunctor,
          [ IsCapFunctor ],
  function( F )
    local H_1, cat_1, D_1, H_2, cat_2, D_2, name, RF;
    
    H_1 := AsCapCategory( Source( F ) );
    
    H_2 := AsCapCategory( Range( F ) );
    
    if not ( IsHomotopyCategory( H_1 ) and IsHomotopyCategory( H_2 ) ) then
      
      TryNextMethod( );
      
    fi;
    
    cat_1 := DefiningCategory( H_1 );
    
    D_1 := DerivedCategory( cat_1 );
    
    cat_2 := DefiningCategory( H_2 );
    
    D_2 := DerivedCategory( cat_2 );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat_1 ) then
      
      Error( Name( cat_1 ), " should be abelian with enough injectives!\n" );
      
    fi;
    
    name := Concatenation( "Right derived functor of ", Name( F ) );
    
    RF := CapFunctor( name, D_1, D_2 );
    
    AddObjectFunction( RF,
      function( a )
        local i, Fi;
        
        i := InjectiveResolution( UnderlyingCell( UnderlyingCell( a ) ), true ) / H_1;
        
        Fi := ApplyFunctor( F, i );
        
        return DerivedCategoryObject( D_2, Fi );
        
    end );
    
    AddMorphismFunction( RF,
      function( s, alpha, r )
        local roof, quasi_iso, morphism, F_quasi_iso, F_morphism;
        
        roof := UnderlyingRoof( alpha );
        
        quasi_iso := SourceMorphism( roof );
        
        quasi_iso := MorphismBetweenInjectiveResolutions( UnderlyingCell( quasi_iso ), true ) / H_1;
        
        morphism := RangeMorphism( roof );
        
        morphism := MorphismBetweenInjectiveResolutions( UnderlyingCell( morphism ), true ) / H_1;
        
        F_quasi_iso := ApplyFunctor( F, quasi_iso );
        
        F_morphism := ApplyFunctor( F, morphism );
        
        roof := Roof( F_quasi_iso, F_morphism );
        
        return DerivedCategoryMorphism( s, roof, r );
        
    end );
    
    return RF;
    
end );

##
InstallMethod( RDerivedFunctor,
          [ IsCapFunctor ],
  function( F )
    local cat_1;
    
    cat_1 := AsCapCategory( Source( F ) );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat_1 ) then
      
      TryNextMethod( );
      
    fi;
    
    return RDerivedFunctor( ExtendFunctorToHomotopyCategories( F ) );
    
end );

##
InstallMethod( RightDerivedFunctor, [ IsCapFunctor ], RDerivedFunctor );

