#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
##
##  Exceptional collections
##
#############################################################################


#############################
##
## Representations
##
#############################

DeclareRepresentation( "IsExceptionalCollectionRep",
                          IsExceptionalCollection and IsAttributeStoringRep,
                            [ ] );
                         
##################################
##
## Family and Type
##
##################################

##
BindGlobal( "ExceptionalCollectionFamily",
  NewFamily( "ExceptionalCollectionFamily", IsObject ) );

##
BindGlobal( "TheTypeExceptionalCollection", 
  NewType( ExceptionalCollectionFamily, 
                      IsExceptionalCollectionRep ) );

##################################
##
##Constructors
##
#################################

##
InstallGlobalFunction( CreateExceptionalCollection,
  function( arg )
    local full, cache, L, collection, n, quiver, algebra, vertices_labels, positions;
    
    full := arg[ 1 ];
    
    if Size( arg ) = 1 then
      
      cache := "crisp";
      
    else
      
      cache := arg[ 2 ];
      
    fi;
    
    if HasExceptionalCollection( full ) then
      
      return ExceptionalCollection( full );
      
    fi;
    
    if IsList( full ) then
      
      full := FullSubcategoryGeneratedByListOfObjects( full );
      
      SetCachingOfCategory( full, cache );
     
    fi;
    
    L := ShallowCopy( SetOfKnownObjects( full ) );
    
    if IsEmpty( L ) then
      
      Error( "The input is empty!" );
    
    fi;
    
    if not HasRangeCategoryOfHomomorphismStructure( full ) then
      
      Error( "The category needs homomorphism structure" );
    
    fi;
    
    Sort( L, { a, b } -> IsZero( HomomorphismStructureOnObjects( b, a ) ) );
    
    vertices_labels := ValueOption( "vertices_labels" );
    
    # The labels also need to be sorted
    if vertices_labels <> fail then
      
      positions := List( L, o -> Position( SetOfKnownObjects( full ), o ) );
      
      vertices_labels := List( positions, p -> vertices_labels[ p ] );
      
    fi;
    
    # to set better bounds
    if IsHomotopyCategory( AmbientCategory( full ) ) then
      
      Perform( L, obj -> ObjectsSupport( UnderlyingCell( obj ) ) );
      
    fi;
    
    MakeImmutable( L );
     
    if vertices_labels = fail then
      
      vertices_labels := [ 1 .. Size( L ) ];
      
    fi;
    
    algebra := ValueOption( "algebra" );
    
    if algebra = fail and vertices_labels <> [ 1 .. Size( L ) ] then
      
      algebra := Concatenation( "End( ", JoinStringsWithSeparator( vertices_labels, "⊕ " ), " )" );
      
    fi;
    
    quiver := ValueOption( "quiver" );
     
    if quiver = fail then
      
      quiver := "quiver";
      
    fi;
        
    collection := rec(
                    char := "m",
                    arrows := rec( ),
                    other_paths := rec( ),
                    paths := rec( ),
                    basis_for_paths := rec( ),
                    labels_for_arrows := rec( ),
                    labels_for_other_paths := rec( ),
                    labels_for_paths := rec( ),
                    labels_for_basis_for_paths := rec( ),
                    quiver := quiver,
                    algebra := algebra,
                    vertices_labels := vertices_labels 
                    );
    
    n := Length( L );
    
    ObjectifyWithAttributes(
      collection, TheTypeExceptionalCollection,
        UnderlyingObjects, L,
        NumberOfObjects, n,
        DefiningFullSubcategory, full );
    
    SetExceptionalCollection( full, collection );
    
    return collection;
    
end );

##
InstallMethod( ExceptionalCollection,
          [ IsCapFullSubcategory ],
  function( full )
    local quiver, algebra, labels;
    
    labels := ValueOption( "vertices_labels" );
    quiver := ValueOption( "quiver" );
    algebra := ValueOption( "algebra" );
    
    CreateExceptionalCollection( full : quiver := quiver,
                                        algebra := algebra,
                                        vertices_labels := labels
                                      );
    
    return ExceptionalCollection( full );
  
end );

##
InstallOtherMethod( ExceptionalCollection,
        [ IsCapFullSubcategory, IsString, IsString ],
  { full, name_for_quiver, name_for_algebra } ->
    ExceptionalCollection( full : name_for_underlying_quiver := name_for_quiver, name_for_endomorphism_algebra := name_for_algebra )
);

##
InstallMethod( TiltingObject,
          [ IsExceptionalCollection ],
  function( collection )
    local full, I, objs;
    
    full := DefiningFullSubcategory( collection );
    
    I := InclusionFunctor( full );
    
    objs := UnderlyingObjects( collection );
    
    objs := List( objs, o -> ApplyFunctor( I, o ) );
    
    return DirectSum( objs );
    
end );

##
InstallMethod( InterpretMorphismInExceptionalCollectionAsEndomorphismOfTiltingObject,
              [ IsExceptionalCollection, IsCapCategoryMorphismInAFullSubcategory ],
  function( collection, phi )
    local nr_objects, objs, p_source, p_range, L;
    
    nr_objects := NumberOfObjects( collection );
    
    objs := UnderlyingObjects( collection );
        
    p_source := Position( objs, Source( phi ) );
        
    p_range := Position( objs, Range( phi ) );
        
    objs := List( objs, UnderlyingCell );
        
    L := List( [ 1 .. nr_objects ],
      i -> List( [ 1 .. nr_objects ], j -> ZeroMorphism( objs[ i ], objs[ j ] ) ) );
        
    L[ p_source ][ p_range ] := UnderlyingCell( phi );
        
    return MorphismBetweenDirectSums( L );
    
end );

##
InstallMethod( \[\],
      [ IsExceptionalCollection, IsInt ],
  function( collection, i )
    local n;
    
    n := NumberOfObjects( collection );
    
    if i > n then
      
      Error( "There are only ", n, " objects in the collection!\n" );
      
    fi;
    
    return UnderlyingObjects( collection )[ i ];
    
end );

## morphisms := [ f1,f2,f3: A -> B ] will be mapped to F:k^3 -> H(A,B).
##
InstallMethod( InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure,
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ],
    
  function( source, range, morphisms )
    local cat, linear_maps, H;
    
    cat := CapCategory( source );
    
    if not HasRangeCategoryOfHomomorphismStructure( cat ) then
      
      Error( "The category needs homomorphism structure" );
      
    fi;
    
    if IsEmpty( morphisms ) then
      
      H := HomomorphismStructureOnObjects( source, range );
      
      return UniversalMorphismFromZeroObject( H );
      
    fi;
    
    if not ForAll( morphisms,
        morphism -> IsEqualForObjects( Source( morphism ), source ) and
          IsEqualForObjects( Range( morphism ), range ) ) then
          
          Error( "All morphisms should have the same source and range" );
    
    fi;
    
    linear_maps := List( morphisms, morphism ->
      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( morphism ) ] );
    
    return MorphismBetweenDirectSums( linear_maps );
      
end );


##
InstallMethod( Arrows,
    [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local cat, n, source, range, H, U, maps, arrows, paths, one_morphism, nr_arrows, map;
    
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input: some index is less than zero or bigger than the number of objects in the strong exceptional collection." );
      
    fi;
 
    if i >= j then
        
      return [ ];
        
    else
      
      if IsBound( collection!.arrows.( String( [ i, j ] ) ) ) then
        
        return collection!.arrows.( String( [ i, j ] ) );
      
      fi;
       
      source := collection[ i ];
    
      range := collection[ j ];
      
      cat := CapCategory( source );

      H := HomomorphismStructureOnObjects( source, range );

      U := DistinguishedObjectOfHomomorphismStructure( cat );

      maps := BasisOfExternalHom( U, H );
     
      if j - i = 1 then
      
        arrows := List( maps, map ->
          InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
            source, range, map ) );
      
      else
      
        paths := OtherPaths( collection, i, j );
      
        one_morphism := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( source, range, paths );
        
        nr_arrows := Dimension( CokernelObject( one_morphism ) );
        
        arrows := [ ];
      
        for map in maps do
        
          if not IsLiftable( map, one_morphism ) then
                  
            Add( arrows,
              InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( 
                source, range, map ) );
            
            one_morphism := MorphismBetweenDirectSums( [ [ map ], [ one_morphism ] ] );
            
            if Length( arrows ) = nr_arrows then
              
              break;
              
            fi;
         
          fi;
        
        od;
      
      fi;
      
      MakeImmutable( arrows );
      
      collection!.arrows!.( String( [ i, j ] ) ) := arrows;
      
      return arrows;
        
    fi;
      
end );

##
InstallMethod( OtherPaths,
    [ IsExceptionalCollection, IsInt, IsInt ],
  
  function( collection, i, j )
    local n, paths;
   
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input: some index is less than zero or bigger with the number of objects in the strong exceptional collection." );
      
    fi;
    
    if j - i <= 0 then
      
      return [ ];
    
    elif j - i = 1 then
      
      # should we change this
      return [ ];
    
    else
     
      if IsBound( collection!.other_paths!.( String( [ i, j ] ) ) ) then
        
        return collection!.other_paths!.( String( [ i, j ] ) );
        
      fi;

      paths := List( [ i + 1 .. j - 1 ],
              u -> ListX( 
                Arrows( collection, i, u ), 
                  Concatenation(
                    OtherPaths( collection, u, j ),
                      Arrows( collection, u, j ) ), PreCompose ) );
      
      paths := Concatenation( paths );
      
      MakeImmutable( paths );
     
      collection!.other_paths!.( String( [ i, j ] ) ) := paths;
      
      return paths;
    
    fi; 
    
end );

##
InstallMethod( Paths,
    [ IsExceptionalCollection, IsInt, IsInt ],
  
  function( collection, i, j )
    local paths;
    
    paths := Concatenation( 
              Arrows( collection, i, j ),
                OtherPaths( collection, i, j )
                );
    
    collection!.paths!.( String( [ i, j ] ) ) := paths;
    
    MakeImmutable( paths );

    return paths;
    
end );

##
InstallMethod( BasisForPaths,
              [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local k, dim, paths, paths_labels, n, p, basis, labels, current_path, current_one_morphism;
    
    if IsBound( collection!.basis_for_paths!.( String( [ i, j ] ) ) ) then
        
        return collection!.basis_for_paths!.( String( [ i, j ] ) );
        
    fi;
    
    if i > j then
      
      basis := [ ];
      
      labels := [ ];
      
      MakeImmutable( basis );
      
      MakeImmutable( labels );
      
      collection!.basis_for_paths!.( String( [ i, j ] ) ) := basis;
      
      collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) ) := labels;
      
      return basis;
      
    elif i = j then
      
      basis := [ IdentityMorphism( collection[ i ] ) ];
      
      labels := [ [ i, i, 0 ] ];
      
      MakeImmutable( basis );
      
      MakeImmutable( labels );
      
      collection!.basis_for_paths!.( String( [ i, j ] ) ) := basis;
      
      collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) ) := labels;
      
      return basis;
      
    fi;
    
    dim := Dimension( HomomorphismStructureOnObjects( collection[ i ], collection[ j ] ) );
    
    paths := Paths( collection, i, j );
    
    paths_labels := LabelsForPaths( collection, i, j );
    
    n := Length( paths );
    
    p := PositionProperty( paths, p -> not IsZero( p ) );
    
    if p = fail then
      
      basis := [ ];
      
      labels := [ ];
      
      MakeImmutable( basis );
    
      MakeImmutable( labels );
    
      collection!.basis_for_paths!.( String( [ i, j ] ) ) := basis;
    
      collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) ) := labels;
      
      return basis;
      
    fi;
    
    basis := [ paths[ p ] ];
    
    labels := [ paths_labels[ p ] ];
    
    for k in [ p + 1 .. n ] do
      
      current_path := paths[ k ];
      
      current_path := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( current_path );
      
      current_one_morphism := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( collection[ i ], collection[ j ], basis );
      
      if not IsLiftable( current_path, current_one_morphism ) then
        
        Add( basis, paths[ k ] );
        
        Add( labels, paths_labels[ k ] );
        
      fi;
      
      if Length( basis ) = dim then
        
        continue;
        
      fi;
      
    od;
    
    MakeImmutable( basis );
    
    MakeImmutable( labels );
    
    collection!.basis_for_paths!.( String( [ i, j ] ) ) := basis;
    
    collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) ) := labels;
    
    return basis;
    
end );

##
InstallMethod( LabelsForArrows,
    [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local nr_arrows, labels;
    
    if IsBound( collection!.labels_for_arrows!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_for_arrows!.( String( [ i, j ] ) );
      
    fi;
   
    nr_arrows := Length( Arrows( collection, i, j ) ); 
   
    labels := List( [ 1 .. nr_arrows ], k -> [ i, j, k ] );
    
    collection!.labels_for_arrows!.( String( [ i, j ] ) ) := labels;
    
    MakeImmutable( labels );
 
    return labels;
    
end );

##
InstallMethod( LabelsForOtherPaths,
    [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local n, labels;
    
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input: some index is less than zero or bigger with the number of objects in the strong exceptional collection." );
      
    fi;
    
    if j - i <= 0 then
      
      return [ ];
    
    elif j - i = 1 then
      
      # should we change this
      return [ ];
    
    else
    
    if IsBound( collection!.labels_for_other_paths!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_for_other_paths!.( String( [ i, j ] ) );
    
    fi;
    
    labels := List( [ i + 1 .. j - 1 ],
              u -> ListX( 
                    
                    LabelsForArrows( collection, i, u ),
                    
                    Concatenation(
                      LabelsForOtherPaths( collection, u, j ),
                        List( LabelsForArrows( collection, u, j ), a -> [ a ] )
                                 ),
                    
                    {a,b} -> Concatenation( [ a ], b ) )
              );
      
      labels := Concatenation( labels );
      
      MakeImmutable( labels );

      collection!.labels_for_other_paths!.( String( [ i, j ] ) ) := labels;
      
      return labels;
    
    fi; 
  end );


##
InstallMethod( LabelsForPaths,
      [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local labels;
    
    if IsBound( collection!.labels_for_paths!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_for_paths!.( String( [ i, j ] ) );
      
    fi;
    
    labels := Concatenation( 
              List( LabelsForArrows( collection, i, j ), l -> [ l ] ),
                LabelsForOtherPaths( collection, i, j )
                );
    
    MakeImmutable( labels );

    collection!.labels_for_paths!.( String( [ i, j ] ) ) := labels;
    
    return labels;
    
end );

##
InstallMethod( LabelsForBasisForPaths,
              [ IsExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    
    if IsBound( collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) );
      
    fi;
   
    BasisForPaths( collection, i, j );
    
    return collection!.labels_for_basis_for_paths!.( String( [ i, j ] ) );
    
end );

##
InstallGlobalFunction( RelationsBetweenMorphisms,
  function( morphisms )
    local source, range, map;
    
    source := Source( morphisms[ 1 ] );
    
    range := Range( morphisms[ 1 ] );
    
    map := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( source, range, morphisms );
    
    return EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( KernelEmbedding( map ) ) );
  
end );

##
InstallMethod( QuiverAlgebraFromExceptionalCollection,
        [ IsExceptionalCollection, IsField ],
  function( collection, field )
    local nr_vertices, arrows, sources, ranges, labels, quiver, A, relations, paths_in_collection, paths_in_quiver, rel, i, j, algebroid, name, r, v, vertices_labels;
    
    nr_vertices := NumberOfObjects( collection );
    
    arrows := List( [ 1 .. nr_vertices - 1 ],
                i -> Concatenation( 
                  
                  List( [ i + 1 .. nr_vertices ],
                    j -> LabelsForArrows( collection, i, j )
                      )
                                  )
                  );
    
    arrows := Concatenation( arrows );
    
    sources := List( arrows, a -> a[ 1 ] );
    
    ranges := List( arrows, a -> a[ 2 ] );
    
    v := collection!.char;
    
    labels := List( arrows,
      a -> Concatenation( v, String( a[ 1 ] ),
              "_", String( a[ 2 ] ), "_", String( a[ 3 ] ) ) );
    
    quiver := RightQuiver( collection!.quiver,
                collection!.vertices_labels, labels, sources, ranges );
    
    A := PathAlgebra( field, quiver );
    
    relations := [ ];
    
    for i in [ 1 .. nr_vertices - 1 ] do
      for j in [ i + 1 .. nr_vertices ] do
                      
        paths_in_collection := Paths( collection, i, j );
        
        if IsEmpty( paths_in_collection ) then
          continue;
        fi;
        
        labels := LabelsForPaths( collection, i, j );
        
        paths_in_quiver := List( labels,
          l -> Product(
            List( l, a -> A.(
              Concatenation( v, String( a[1] ),
                "_", String( a[2] ), "_", String( a[ 3 ] ) ) ) ) )
              );
        
        rel := RelationsBetweenMorphisms( paths_in_collection );
        
        rel := List( rel, r -> List( r, e -> e / field ) * paths_in_quiver );
        
        relations := Concatenation( relations, rel );
                      
      od;
      
    od;
    
    relations := ComputeGroebnerBasis( relations );
    
    A := QuotientOfPathAlgebra( A, relations ); 
    
    SetDefiningExceptionalCollection( A, collection );
    
    if collection!.algebra <> fail then
      
      name := collection!.algebra;
      
      SetName( A, name );
      
      SetName( OppositeAlgebra( A ), Concatenation( name, "^op" ) );
      
      r := RandomTextColor( name );
      
      Algebroid( A )!.Name := Concatenation( r[ 1 ],
                                "Algebroid(", r[ 2 ], " ", name,
                                  " ", r[ 1 ], ")", r[ 2 ]
                                );;
      
      QuiverRows( A )!.Name := Concatenation( r[ 1 ],
                                 "QuiverRows(", r[ 2 ], " ", name,
                                  " ", r[ 1 ], ")", r[ 2 ]
                                );;
       
    fi;
    
    return A;
    
end );

##
InstallMethod( EndomorphismAlgebraAttr,
    [ IsExceptionalCollection ],
  function( collection )
    
    return QuiverAlgebraFromExceptionalCollection( collection, GLOBAL_FIELD_FOR_QPA!.default_field );
  
end );

##
InstallMethod( EndomorphismAlgebra,
          [ IsExceptionalCollection ],
  E -> EndomorphismAlgebraAttr( E )
);

##
InstallMethod( AmbientCategory,
          [ IsExceptionalCollection ],
  collection -> AmbientCategory( DefiningFullSubcategory( collection ) )
);

##
InstallMethod( Algebroid,
          [ IsExceptionalCollection ],
  collection -> Algebroid( EndomorphismAlgebra( collection ) )
);

##
InstallMethod( CategoryOfQuiverRepresentationsOverOppositeAlgebra,
          [ IsExceptionalCollection ],
  collection -> CategoryOfQuiverRepresentations( OppositeAlgebra( EndomorphismAlgebra( collection ) ) )
);

##
InstallMethod( HomotopyCategory,
          [ IsExceptionalCollection ],
  collection -> HomotopyCategory( AdditiveClosure( DefiningFullSubcategory( collection ) ) )
);

##
InstallMethod( AdditiveClosureAsFullSubcategory,
          [ IsCapFullSubcategory ],
  function( full )
    local ambient_cat, r, name, A;
  
    if HasIsAdditiveCategory( full ) and IsAdditiveCategory( full ) then
      
      Error( "Bad input!\n" );
      
    fi;
    
    ambient_cat := AmbientCategory( full );
    
    if not ( HasIsAdditiveCategory( ambient_cat ) and IsAdditiveCategory( ambient_cat ) ) then
      
      Error( "Bad input!\n" );
      
    fi;
    
    r := RandomTextColor( Name( full) );
    
    name := Concatenation( r[ 1 ], "Additive closure as full subcategory ( ", r[ 2 ],
              Name( full ), r[ 1 ], " )", r[ 2 ] );
    
    A := FullSubcategory( ambient_cat, name : is_additive := true );
    
    A!.DefiningFullSubcategory := full;
    
    return A;
    
end );

##
InstallMethod( AdditiveClosureAsFullSubcategory,
          [ IsExceptionalCollection ],
  collection -> AdditiveClosureAsFullSubcategory( DefiningFullSubcategory( collection ) )
);

##
InstallMethod( AdditiveClosure,
          [ IsExceptionalCollection ],
  collection -> AdditiveClosure( DefiningFullSubcategory( collection ) )
);


##
BindGlobal( "ADD_RANDOM_METHODS_FOR_INDEC_PROJS_AND_INJS",
  function( full )
    local ambient, ring;
    
    ambient := AmbientCategory( full );
    
    ring := CommutativeRingOfLinearCategory( full );
    
    ## full is subcategory in quiver reps
    
    if IsQuiverRepresentationCategory( ambient ) then
      
      AddRandomObjectByInteger( full,
        function( full, n )
          local obj;
          obj := Shuffle( ShallowCopy( SetOfKnownObjects( full ) ) );
          return Random( obj );
      end );
      
      AddRandomMorphismWithFixedSourceByInteger( full,
        function( o, n )
          local objects, p, b; 
          
          objects := Shuffle( ShallowCopy( SetOfKnownObjects( full ) ) );
          
          p := PositionProperty( objects, obj -> not IsZero( HomStructure( o, obj ) ) );
          
          if p = fail then
              return Random( [ 0 .. AbsInt( n ) ] ) * One( ring ) * IdentityMorphism( o );
          fi;
          
          b := BasisOfExternalHom( o, objects[ p ] );
          
          return Sum( List( [ 0 .. AbsInt( n ) ], i -> Random( b ) ) );
          
      end );
      
      AddRandomMorphismWithFixedRangeByInteger( full,
        function( o, n )
          local objects, p, b;
          
          objects := Shuffle( ShallowCopy( SetOfKnownObjects( full ) ) );
          
          p := PositionProperty( objects, obj -> not IsZero( HomStructure( obj, o ) ) );
          
          if p = fail then
              return Random( [ 0 .. AbsInt( n ) ] ) * One( ring ) * IdentityMorphism( o );
          fi;
          
          b := BasisOfExternalHom( objects[ p ], o );
          
          return Sum( List( [ 0 .. AbsInt( n ) ], i -> Random( b ) ) );
          
      end );
      
      AddRandomMorphismWithFixedSourceAndRangeByInteger( full,
        function( s, r, n )
          local b;
          
          b := BasisOfExternalHom( s, r );
          
          if IsEmpty( b ) then
              return ZeroMorphism( s, r );
          fi;
          
          return Sum( List( [ 0 .. AbsInt( n ) ], i -> Random( b ) ) );
          
        end );
      
    else
      
      Info( InfoWarning, 1, "Maybe you can add random methods?" );
      
      return;
      
    fi;
   
end );

##
BindGlobal( "ADD_IS_EQUAL_METHODS_FOR_INDEC_PROJS_AND_INJS",
  function( full )
    local ambient;
    
    ambient := AmbientCategory( full );
    
    ## full is subcategory in quiver reps
    
    if IsQuiverRepresentationCategory( ambient ) then
      AddIsEqualForObjects( full,
        { a, b } -> IsIdenticalObj( a, b ) or
          DimensionVector( UnderlyingCell( a ) ) = DimensionVector( UnderlyingCell( b ) )
      );
      
      AddIsEqualForMorphisms( full,
        function( alpha, beta )
          return
          DimensionVector( Source( UnderlyingCell( alpha ) ) )
            = DimensionVector( Source( UnderlyingCell( beta ) ) ) and
          DimensionVector( Range( UnderlyingCell( alpha ) ) )
            = DimensionVector( Range( UnderlyingCell( beta ) ) ) and
          MatricesOfRepresentationHomomorphism( UnderlyingCell( alpha ) )
            #{ Positions( DimensionVector( Source( UnderlyingCell( alpha )  ) ), 1 ) }
              = MatricesOfRepresentationHomomorphism( UnderlyingCell( beta ) )
                #{ Positions( DimensionVector( Source( UnderlyingCell( alpha )  ) ), 1 ) }
                ;
                
        end );
              
      AddIsEqualForCacheForObjects( full, IsEqualForObjects );
      
      AddIsEqualForCacheForMorphisms( full, IsEqualForMorphisms );
    
    else
    
      Info( InfoWarning, 1, "Maybe you can optimize the equality methods?" );
    
      return;
    
    fi;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecProjectiveObjects,
          [ IsCapFullSubcategory ],
  function( full_subcategory_by_projs )
    local cat, projs, r, name, full;
    
    cat := AmbientCategory( full_subcategory_by_projs );
    
    if ApplicableMethod( IndecProjectiveObjects, [ cat ] ) = fail then
      
      Error( "The method 'IndecProjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    projs := IndecProjectiveObjects( cat );
    
    projs := List( projs, p -> AsSubcategoryCell( full_subcategory_by_projs, p ) );
    
    r := RandomTextColor( Name( full_subcategory_by_projs ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory generated by the ", String( Size( projs ) ),
              " indecomposable projective objects( ",
              r[ 2 ], Name( full_subcategory_by_projs ), r[ 1 ], " )", r[ 2 ] );
              
    full := FullSubcategoryGeneratedByListOfObjects( projs :
              FinalizeCategory := false, name_of_full_subcategory := name );
              
    ADD_IS_EQUAL_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    Finalize( full );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategoryCrisp( full );
    
    return full;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecProjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local projs, r, name, full;
    
    if ApplicableMethod( IndecProjectiveObjects, [ cat ] ) = fail then
      
      Error( "The method 'IndecProjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    projs := IndecProjectiveObjects( cat );
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory generated by the ", String( Size( projs ) ),
              " indecomposable projective objects( ",
              r[ 2 ], Name( cat ), r[ 1 ], " )", r[ 2 ] );
              
    full := FullSubcategoryGeneratedByListOfObjects( projs :
              FinalizeCategory := false, name_of_full_subcategory := name );
              
    ADD_IS_EQUAL_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    ADD_RANDOM_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    full!.full_subcategory_generated_by_indec_projective_objects := true;
    
    Finalize( full );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategoryCrisp( full );
    
    SetCachingOfCategoryCrisp( full );
    
    return full;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecInjectiveObjects,
          [ IsCapFullSubcategory ],
  function( full_subcategory_by_injs )
    local cat, injs, r, name, full;
    
    cat := AmbientCategory( full_subcategory_by_injs );
    
    if ApplicableMethod( IndecInjectiveObjects, [ cat ] ) = fail then
      
      Error( "The method 'IndecInjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    injs := IndecInjectiveObjects( cat );
    
    injs := List( injs, p -> AsSubcategoryCell( full_subcategory_by_injs, p ) );
    
    r := RandomTextColor( Name( full_subcategory_by_injs ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory generated by the ", String( Size( injs ) ),
              " indecomposable injective objects( ",
              r[ 2 ], Name( full_subcategory_by_injs ), r[ 1 ], " )", r[ 2 ] );
              
    full := FullSubcategoryGeneratedByListOfObjects( injs :
              FinalizeCategory := false, name_of_full_subcategory := name );
    
    ADD_IS_EQUAL_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    Finalize( full );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategoryCrisp( full );
 
    SetCachingOfCategoryCrisp( full );
    
    return full;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecInjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local injs, r, name, full;
    
    if ApplicableMethod( IndecInjectiveObjects, [ cat ] ) = fail then
      
      Error( "The method 'IndecInjectiveObjects' should be applicable on the ambient category" );
      
    fi;
    
    injs := IndecInjectiveObjects( cat );
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], "Full subcategory generated by the ", String( Size( injs ) ),
              " indecomposable injective objects( ",
              r[ 2 ], Name( cat ), r[ 1 ], " )", r[ 2 ] );
              
    full := FullSubcategoryGeneratedByListOfObjects( injs :
              FinalizeCategory := false, name_of_full_subcategory := name );
    
    full!.full_subcategory_generated_by_indec_injective_objects := true;
            
    ADD_IS_EQUAL_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    ADD_RANDOM_METHODS_FOR_INDEC_PROJS_AND_INJS( full );
    
    Finalize( full );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategoryCrisp( full );
 
    SetCachingOfCategoryCrisp( full );
    
    return full;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
          [ IsAlgebroid ],
  function( algebroid )
    local A, A_op, cat, FinalizeCategory;
    
    A := UnderlyingQuiverAlgebra( algebroid );
    
    A_op := OppositeAlgebra( A );
    
    if IsAdmissibleQuiverAlgebra( A ) then
      
      SetIsAdmissibleQuiverAlgebra( A_op, true );
      
    fi;
    
    cat := CategoryOfQuiverRepresentations( A_op );
    
    return FullSubcategoryGeneratedByIndecProjectiveObjects( cat );
    
end );

BindGlobal( "ADD_RANDOM_METHODS_FOR_PROJS_AND_INJS",
  function( full )
    local ambient;
    
    ambient := AmbientCategory( full );
    
    ## full is subcategory in quiver reps
    
    if IsQuiverRepresentationCategory( ambient ) then
      
      AddRandomObjectByInteger( full,
        function( full, n )
          local I, C;
          I := EquivalenceFromAdditiveClosureOfIndecProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects( ambient );
          C := SourceOfFunctor( I );
          return I( RandomObjectByInteger( C, n ) );
      end );
      
      AddRandomMorphismWithFixedSourceByInteger( full,
        function( s, n )
          local I, J;
          J := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( ambient );
          I := EquivalenceFromAdditiveClosureOfIndecProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects( ambient );
          return I( RandomMorphismWithFixedSourceByInteger( J( s ), n ) );
      end );
    
      AddRandomMorphismWithFixedRangeByInteger( full,
        function( r, n )
          local I, J;
          J := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( ambient );
          I := EquivalenceFromAdditiveClosureOfIndecProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects( ambient );
          return I( RandomMorphismWithFixedRangeByInteger( J( r ), n ) );
      end );
     
      AddRandomMorphismWithFixedSourceAndRangeByInteger( full,
        function( s, r, n )
          local I, J;
          J := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( ambient );
          I := EquivalenceFromAdditiveClosureOfIndecProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects( ambient );
          return I( RandomMorphismWithFixedSourceAndRangeByInteger( J( s ), J( r ), n ) );
        end );
      
    fi;
       
end );

##
InstallMethod( FullSubcategoryGeneratedByProjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local full, finalize, name, r;
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then
      
      Error( "The input should be an abelian category with computable enough projectives" );
      
    fi;
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], "Full additive subcategory generated by projective objects( ", r[ 2 ], Name( cat ), r[ 1 ], " )", r[ 2 ] );
    
    full := FullSubcategory( cat, name : FinalizeCategory := false, is_additive := true );
    
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
       
      ##
      AddIsWellDefinedForObjects( full,
        function( a )
        
          return IsWellDefined( UnderlyingCell( a ) ) and IsProjective( UnderlyingCell( a ) );
    
      end );
      
      ##
      AddIsWellDefinedForMorphisms( full,
        function( phi )
          
          return IsWellDefined( Source( phi ) ) and IsWellDefined( Range( phi ) ) and IsWellDefined( UnderlyingCell( phi ) );
      
      end );
    
    fi;
    
    if CanCompute( cat, "BasisOfExternalHom" ) and CanCompute( cat, "CoefficientsOfMorphismWithGivenBasisOfExternalHom" ) then
      
      ##
      AddBasisOfExternalHom( full,
        function( a, b )
          local B;
          
          B := BasisOfExternalHom( UnderlyingCell( a ), UnderlyingCell( b ) );
          
          return List( B, m -> AsSubcategoryCell( full, m ) );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( alpha, B )
          
          return CoefficientsOfMorphism( UnderlyingCell( alpha ) );
          
      end );
    
    fi;
    
    ADD_RANDOM_METHODS_FOR_PROJS_AND_INJS( full );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
      
      return full;
    
    fi;
    
    Finalize( full );
       
    DeactivateCachingOfCategory( full );
 
    return full;

end );

##
InstallMethod( FullSubcategoryGeneratedByInjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local full, finalize, name, r;
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The input should be an abelian category with computable enough injectives" );
      
    fi;
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], "Full additive subcategory generated by injective objects( ", r[ 2 ], Name( cat ), r[ 1 ], " )", r[ 2 ] );
  
    full := FullSubcategory( cat, name : FinalizeCategory := false, is_additive := true );
    
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
      
      ##
      AddIsWellDefinedForObjects( full,
        function( a )
        
          return IsWellDefined( UnderlyingCell( a ) ) and IsInjective( UnderlyingCell( a ) );
    
      end );
      
      ##
      AddIsWellDefinedForMorphisms( full,
        function( phi )
          
          return IsWellDefined( Source( phi ) ) and IsWellDefined( Range( phi ) ) and IsWellDefined( UnderlyingCell( phi ) );
      
      end );
    
    fi;
    
    if CanCompute( cat, "BasisOfExternalHom" ) and CanCompute( cat, "CoefficientsOfMorphismWithGivenBasisOfExternalHom" ) then
      
      ##
      AddBasisOfExternalHom( full,
        function( a, b )
          local B;
          
          B := BasisOfExternalHom( UnderlyingCell( a ), UnderlyingCell( b ) );
          
          return List( B, m -> AsSubcategoryCell( full, m ) );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( alpha, B )
          
          return CoefficientsOfMorphism( UnderlyingCell( alpha ) );
          
      end );
     
    fi;
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
     
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
      
      return full;
    
    fi;
    
    DeactivateCachingOfCategory( full );
    
    Finalize( full );
    
    return full;

end );

###########################
##
## For tests or internal use
##
###########################

##
InstallGlobalFunction( RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection,
  function( field, nr_vertices, nr_arrows, nr_relations )
    local sources_of_arrows, ranges_of_arrows, arrows, labels, quiver, A, G, H, df_H, rel, g, e, cat, i;
    
    sources_of_arrows := List( [ 1 .. nr_arrows ],
      i -> Random( [ 1 .. nr_vertices - 1 ] ) );
    
    ranges_of_arrows := List( [ 1 .. nr_arrows ],
      i -> Random( [ sources_of_arrows[ i ] + 1 .. nr_vertices ] ) );
    
    arrows := ListN( sources_of_arrows, ranges_of_arrows, {s,r} -> [ s, r ] );
    
    arrows := Collected( arrows );
    
    sources_of_arrows := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], k -> a[ 1 ][ 1 ] ) ) );
    
    ranges_of_arrows := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], k -> a[ 1 ][ 2 ] ) ) );
    
    labels := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], 
      k -> Concatenation( "o", String( a[ 1 ][ 1 ] ), "_o", String( a[ 1 ][ 2 ] ), "_", String( k )  ) ) ) );
    
    quiver := RightQuiver( "Q", [ 1 .. nr_vertices ],
                labels, sources_of_arrows, ranges_of_arrows );
    
    A := PathAlgebra( field, quiver );
    
    G := GeneratorsOfLeftOperatorAdditiveGroup( A );
    
    G := List( G, g -> g!.paths[ 1 ] );
    
    G := Filtered( G, g -> Length( g ) >= 2 );
    
    H := List( G, g -> [ Source( g ), Target( g ) ] );
    
    df_H := DuplicateFreeList( H );
    
    G := List( df_H, u -> G{ Positions( H, u ) } );
    
    rel := [ ];
      
    if not IsEmpty( G ) then
      
      for i in [ 1 .. nr_relations ] do
        
        g := Random( G );
        
        e := QuiverAlgebraElement( A, List( [ 1 .. Size( g ) ], k -> Random( [ -2 .. 2 ] ) ), g );
        
        Add( rel, e );
        
      od;
    
    fi;
    
    rel := ComputeGroebnerBasis( rel );
    
    A := QuotientOfPathAlgebra( A, rel );
        
    return A;
  
end );

############################
##
## View & Display
##
###########################

##
InstallMethod( ViewObj,
    [ IsExceptionalCollection ],
  function( collection )
    local full;
    
    full := DefiningFullSubcategory( collection );
    
    Print( "<A strong exceptional collection defined by the objects of the ", Name( full ), ">" );
    
end );

##
InstallMethod( Display,
    [ IsExceptionalCollection ],
  function( collection )
    local N, i;
    
    N := NumberOfObjects( collection );
    
    Print( "A strong exceptional collection defined by ", N, " objects:\n\n" );
    
    for i in [ 1 .. N ] do
      
      Print( "\n\033[33m\033[4mObject ", i, ":\033[0m\n" );
      
      Display( collection[ i ] );
      
    od;
    
end );

