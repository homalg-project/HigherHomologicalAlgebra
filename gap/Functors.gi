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
    local H, ambient_cat, reps, inj_indec, r, name, cell_func;
    
    H := HomFunctorByExceptionalCollection( collection );
    
    ambient_cat := AsCapCategory( Source( H ) );
    
    reps := AsCapCategory( Range( H ) );
    
    inj_indec := FullSubcategoryGeneratedByIndecInjectiveObjects( ambient_cat );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of Hom(T,-) functor ", r[ 1 ], "from",
              r[ 2 ], " ", Name( inj_indec ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps )
            );
    
    cell_func := c -> ApplyFunctor( H, UnderlyingCell( UnderlyingCell( c ) ) );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, inj_indec, reps, cell_func, cell_func );
   
end );

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
    
    reps := AsCapCategory( Range( H ) );
    
    C := DefiningCategory( ambient_cat );
    
    chains_C := ChainComplexCategory( C );
    
    proj := FullSubcategoryGeneratedByProjectiveObjects( C );
    
    proj_indec := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
    
    H := PreCompose( [ InclusionFunctor( proj_indec ), InclusionFunctor( proj ), StalkChainFunctor( C, 0 ), ProjectionFunctor( ambient_cat ), H ] );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of Hom(T,-) functor ", r[ 1 ], "from", r[ 2 ], " ", Name( proj_indec ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps ) );
    
    cell_func := c -> ApplyFunctor( H, c );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, proj_indec, reps, cell_func, cell_func );
   
end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToInjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local cat, G, add_G, can, can_add_G, injs, reps, r, name, R;
    
    cat := AmbientCategory( DefiningFullSubcategory( collection ) );
    
    G := RestrictionOfHomFunctorByExceptionalCollectionToIndecInjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    can := EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecInjectiveObjects( cat );
    
    can_add_G := PreCompose( can, add_G );
    
    injs := AsCapCategory( Source( can_add_G ) );
    
    reps := AsCapCategory( Range( can_add_G ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of Hom(T,-) functor ", r[ 1 ], "from", r[ 2 ], " ", Name( injs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps ) );
    
    R := CapFunctor( name, injs, reps );
    
    AddObjectFunction( R, FunctorObjectOperation( can_add_G ) );
    
    AddMorphismFunction( R, FunctorMorphismOperation( can_add_G ) );
    
    return R;

end );

##
InstallMethod( RestrictionOfHomFunctorByExceptionalCollectionToProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local cat, G, add_G, can, can_add_G, projs, reps, r, name, R;
    
    cat := AmbientCategory( DefiningFullSubcategory( collection ) );
    
    if not IsHomotopyCategory( cat ) then
      
      TryNextMethod( );
      
    fi;
    
    cat := DefiningCategory( cat );
    
    G := RestrictionOfHomFunctorByExceptionalCollectionToIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( cat );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    reps := AsCapCategory( Range( can_add_G ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of Hom(T,-) functor ", r[ 1 ], "from", r[ 2 ], " ", Name( projs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( reps ) );
    
    R := CapFunctor( name, projs, reps );
    
    AddObjectFunction( R, FunctorObjectOperation( can_add_G ) );
    
    AddMorphismFunction( R, FunctorMorphismOperation( can_add_G ) );
    
    return R;

end );

##
InstallMethod( RestrictionOfTensorFunctorByExceptionalCollectionToIndecProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local full, ambient_cat, inc, iso2, A, iso1, iso, indec_projs, r, name, cell_func;
    
    full := DefiningFullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
    
    inc := InclusionFunctor( full );
     
    iso2 := IsomorphismFromAlgebroid( collection );
    
    A := AsCapCategory( Source( iso2 ) );
    
    iso1 := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( A );
    
    iso := PreCompose( [ iso1, iso2, inc ] );
    
    indec_projs := AsCapCategory( Source( iso ) );
    
    r := RANDOM_TEXT_ATTR();
    
    name := Concatenation( "- ⊗_{End T} T functor ", r[ 1 ], "from", r[ 2 ], " ", 
              Name( indec_projs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( ambient_cat ) );
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, indec_projs, ambient_cat, cell_func, cell_func );
    
end );

##
InstallMethod( RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects,
          [ IsExceptionalCollection ],
  function( collection )
    local G, add_G, C, can, can_add_G, projs, D, r, name, R;
    
    G := RestrictionOfTensorFunctorByExceptionalCollectionToIndecProjectiveObjects( collection );
    
    add_G := ExtendFunctorToAdditiveClosures( G ); # or add_G := ExtendFunctorToAdditiveClosureOfSource( G );
    
    C := AmbientCategory( AmbientCategory( AsCapCategory( Source( G ) ) ) );
    
    can := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
    
    can_add_G := PreCompose( can, add_G );
    
    projs := AsCapCategory( Source( can_add_G ) );
    
    D := AsCapCategory( Range( G ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Restriction of - ⊗_{End T} T functor ", r[ 1 ], "from", r[ 2 ], " ",
              Name( projs ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( D ) );
    
    R := CapFunctor( name, projs, D );
    
    AddObjectFunction( R, # FunctorObjectOperation( can_add_G ) );
      function( r )
        local a, summands;
        
        a := ApplyFunctor( can_add_G, r );
        
        summands := ObjectList( a );
        
        if IsEmpty( summands ) then
          
          a := ZeroObject( D );
          
        else
          
          a := DirectSum( summands );
          
        fi;
        
        a!.object_list := summands;
        
        return a;
        
    end );
    
    AddMorphismFunction( R, # FunctorMorphismOperation( can_add_G ) );
      function( s, alpha, r )
        local beta, morphism_matrix;
        
        beta := ApplyFunctor( can_add_G, alpha );
        
        morphism_matrix := MorphismMatrix( beta );
        
        beta := MorphismBetweenDirectSums( s, morphism_matrix, r );
        
        beta!.morphism_matrix := morphism_matrix;
        
        return beta;
        
    end );
    
    return R;
    
end );

##
InstallMethod( TensorFunctorByExceptionalCollection,
    [ IsExceptionalCollection ],
    
  function( collection )
    local R, r, projs, reps, cat, name, F;
    
    R := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
    
    projs := AsCapCategory( Source( R ) );
    
    reps := AmbientCategory( projs  );
    
    cat := AsCapCategory( Range( R ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "- ⊗_{End T} T functor ", r[ 1 ], "from", r[ 2 ], " ", Name( reps ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( cat ) );
    
    F := CapFunctor( name, reps, cat );
    
    AddObjectFunction( F,
      function( r )
        local P, cok;
        
        P := ProjectiveChainResolution( r );
        
        P := P ^ 1;
        
        P := ApplyFunctor( R, P / projs );
        
        cok := CokernelObject( P );
        
        cok!.defining_morphism_of_cokernel_object := P;
        
        return cok;
        
    end );
    
    AddMorphismFunction( F,
      function( source, alpha, range )
        local gamma, cok_func;
        
        gamma := MorphismBetweenProjectiveChainResolutions( alpha );
        
        gamma := [ Source( gamma ) ^ 1, gamma[ 0 ], Range( gamma ) ^ 1 ];
        
        gamma := List( gamma, g -> ApplyFunctor( R, g / projs ) );
        
        cok_func := CallFuncList( CokernelObjectFunctorial, gamma );
        
        cok_func!.defining_morphism_of_cokernel_object := gamma[ 2 ];
        
        return cok_func;
        
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
    
    DeactivateCachingOfCategory( add_indec_projs );
    
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
    
    DeactivateCachingOfCategory( add_indec_injs );
    
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
InstallMethod( IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
          [ IsExceptionalCollection ],
  function( collection )
    local full, iso_1, algebroid, iso_2, iso, ind_projs, r, name, cell_func;
    
    full := DefiningFullSubcategory( collection );
     
    iso_1 := IsomorphismIntoAlgebroid( collection );
    
    algebroid := AsCapCategory( Range( iso_1 ) );
    
    iso_2 := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
    
    iso := PreCompose( iso_1, iso_2 );
    
    ind_projs := AsCapCategory( Range( iso ) );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( ind_projs ) );
    
    cell_func := c -> ApplyFunctor( iso, c );
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, ind_projs, cell_func, cell_func );
end );

##
InstallMethod( IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
          [ IsAlgebroid ],
  function( algebroid )
    local A, A_op, full, quiver_op, nr_vertices, basis, projs, r, name, object_func, morphism_func;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    A_op := OppositeAlgebra( A );
       
    full := FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
    
    quiver_op := QuiverOfAlgebra( A_op );
    
    nr_vertices := NumberOfVertices( quiver_op );
    
    basis := BasisOfProjectives( A_op );
    
    projs := IndecProjRepresentations( A_op );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( algebroid ) );
     
    object_func :=
      function( a )
        local p, i;
        
        p := UnderlyingCell( UnderlyingCell( a ) );
        
        p := basis[ PositionProperty( basis, b -> DimensionVector( p ) = List( b, Size ) ) ];
        
        i := PositionProperty( [ 1 .. nr_vertices ], i -> [ A_op.( String( Vertex( quiver_op, i ) ) ) ] in p );
        
        return ObjectInAlgebroid( algebroid, Vertex( QuiverOfAlgebra( A ), i ) );
        
      end;
    
    morphism_func :=
      function( alpha )
        local s, r, basis, I, images, dim, rel;
        
        s := object_func( Source( alpha ) );
        
        r := object_func( Range( alpha ) );
        
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
      
      end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, algebroid, object_func, morphism_func );
    
end );

##
InstallMethod( IsomorphismIntoAlgebroid,
        [ IsExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, object_func, morphism_func;
    
    n := NumberOfObjects( collection );
    
    full := DefiningFullSubcategory( collection );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
    algebroid := Algebroid( A );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[1], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( algebroid ) );
    
    object_func :=
      function( e )
        local p;
                
        p := PositionProperty( [ 1 .. n ], i -> IsEqualForObjects( e, collection[ i ] ) );
        
        return algebroid.(p);
        
    end;
    
    morphism_func :=
      function( phi )
        local s, source, i, r, range, j, basis, labels, dim, paths, rel;
         
        s := Source( phi );
        
        source := object_func( s );
        
        i := PositionProperty( [ 1 .. n ], k -> IsEqualForObjects( s, collection[ k ] ) );
        
        r := Range( phi );
         
        range := object_func( r );
        
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
        
    end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, full, algebroid, object_func, morphism_func );
    
end );

##
InstallMethod( IsomorphismFromAlgebroid,
        [ IsExceptionalCollection ],
  function( collection )
    local n, full, A, algebroid, r, name, object_func, morphism_func;
    
    n := NumberOfObjects( collection );
    
    full := DefiningFullSubcategory( collection );
    
    A := EndomorphismAlgebraOfExceptionalCollection( collection );
    
    algebroid := Algebroid( A );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Isomorphism functor ", r[ 1 ], "from", r[ 2 ], " ", Name( algebroid ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( full ) );
    
    object_func :=
      function( e )
        local p;
        
        p := VertexIndex( UnderlyingVertex( e ) );
        
        return collection[ p ];
        
    end;
    
    morphism_func :=
      function( phi )
        local source, range, s, i, r, j, e, paths, coeffs, arrow_list, paths_list;
        
        source := object_func( Source( phi ) );
        
        range := object_func( Range( phi ) );
        
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
        
    end;
    
    return FunctorFromLinearCategoryByTwoFunctions( name, algebroid, full, object_func, morphism_func );
    
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
    
    if not ( HasIsAbelianCategory( cat_1 )
                and IsAbelianCategory( cat_1 )
                  and IsAbelianCategoryWithComputableEnoughProjectives( cat_1 ) ) then
      
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
    
    if not ( HasIsAbelianCategory( cat_1 )
                and IsAbelianCategory( cat_1 )
                  and IsAbelianCategoryWithComputableEnoughInjectives( cat_1 ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return RDerivedFunctor( ExtendFunctorToHomotopyCategories( F ) );
    
end );

##
InstallMethod( RightDerivedFunctor, [ IsCapFunctor ], RDerivedFunctor );


