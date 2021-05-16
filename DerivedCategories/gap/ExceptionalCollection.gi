# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  Exceptional collections
##
#############################################################################


#############################
##
## Representations
##
#############################

DeclareRepresentation( "IsStrongExceptionalCollectionRep",
                          IsStrongExceptionalCollection and IsAttributeStoringRep,
                            [ ] );
                         
##################################
##
## Family and Type
##
##################################

##
BindGlobal( "StrongExceptionalCollectionFamily",
  NewFamily( "StrongExceptionalCollectionFamily", IsObject ) );

##
BindGlobal( "TheTypeStrongExceptionalCollection",
  NewType( StrongExceptionalCollectionFamily,
                      IsStrongExceptionalCollectionRep ) );

##################################
##
##Constructors
##
#################################

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsCapFullSubcategory, IsList, IsString ],
  function( full, vertices_labels, cache )
    local L, range, positions, algebra, quiver, collection, n, i, j;
    
    if HasStrongExceptionalCollection( full ) then
      
      SetCachingOfCategory( full, cache );
      
      return StrongExceptionalCollection( full );
      
    fi;
    
    L := ShallowCopy( SetOfKnownObjects( full ) );
    
    if IsEmpty( L ) then
      
      Error( "The input is empty full-subcategory!" );
      
    fi;
    
    if not HasRangeCategoryOfHomomorphismStructure( full ) then
      
      Error( "The category needs homomorphism structure" );
       
    fi;
    
    range := RangeCategoryOfHomomorphismStructure( full );
    
    if not ( IsMatrixCategory( range ) or IsCategoryOfRows( range ) ) then
      
      Error( "The range category of homomorphism structure should be MatrixCategory( K ) or CategoryOfRows( K ) for some field K!\n" );
      
    fi;
    
    for i in [ 1 .. Size( L ) - 1 ] do
      for j in [ i + 1 .. Size( L ) ] do
        if not IsZero( HomomorphismStructureOnObjects( L[ j ], L[ i ] ) ) then
          Sort( L, { a, b } -> IsZero( HomomorphismStructureOnObjects( b, a ) ) );
        fi;
      od;
    od;
    
    for i in [ 1 .. Size( L ) - 1 ] do
      for j in [ i + 1 .. Size( L ) ] do
        if not IsZero( HomomorphismStructureOnObjects( L[ j ], L[ i ] ) ) then
          Error( "Please give the exceptional objects in the correct order!\n" );
        fi;
      od;
    od;
    
    # The labels also need to be sorted
    positions := List( L, o -> Position( SetOfKnownObjects( full ), o ) );
    
    vertices_labels := List( positions, p -> vertices_labels[ p ] );
    
    # to set better bounds
    if IsHomotopyCategory( AmbientCategory( full ) ) then
      
      Perform( L, obj -> ObjectsSupport( UnderlyingCell( obj ) ) );
      
    fi;
    
    MakeImmutable( L );
    
    algebra := Concatenation( "End( ", JoinStringsWithSeparator( vertices_labels, " ⊕ " ), " )" );
    
    quiver := "quiver";
    
    collection := rec(
                    char := "m",
                    quiver := quiver,
                    algebra := algebra,
                    vertices_labels := vertices_labels
                    );
    
    n := Length( L );
    
    ObjectifyWithAttributes(
      collection, TheTypeStrongExceptionalCollection,
        UnderlyingObjects, L,
        NumberOfObjects, n,
        DefiningFullSubcategory, full );
        
    SetStrongExceptionalCollection( full, collection );
    
    return collection;
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsList, IsList, IsString ],
  function( objects, vertices_labels, cache )
    local full;
    
    full := FullSubcategoryGeneratedByListOfObjects( objects );
    
    return CreateStrongExceptionalCollection( full, vertices_labels, cache );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsCapFullSubcategory, IsList ],
  function( full, vertices_labels )
    
    return CreateStrongExceptionalCollection( full, vertices_labels, "crisp" );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsList, IsList ],
  function( objects, vertices_labels )
    local full;
    
    full := FullSubcategoryGeneratedByListOfObjects( objects );
    
    return CreateStrongExceptionalCollection( full, vertices_labels );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsCapFullSubcategory ],
  function( full )
    local vertices_labels;
    
    vertices_labels := List( [ 1 .. Size( SetOfKnownObjects( full ) ) ], String );
    
    return CreateStrongExceptionalCollection( full, vertices_labels );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
          [ IsList ],
  function( objects )
    local full;
    
    full := FullSubcategoryGeneratedByListOfObjects( objects );
    
    return CreateStrongExceptionalCollection( full );
    
end );

##
InstallMethod( StrongExceptionalCollection,
          [ IsCapFullSubcategory ],
  CreateStrongExceptionalCollection
);

##
InstallMethod( TiltingObject,
          [ IsStrongExceptionalCollection ],
          
  function( collection )
    local full, I, objs;
    
    full := DefiningFullSubcategory( collection );
    
    I := InclusionFunctor( full );
    
    objs := UnderlyingObjects( collection );
    
    objs := List( objs, o -> ApplyFunctor( I, o ) );
    
    return DirectSum( objs );
    
end );

##
InstallMethod( InterpretMorphismInStrongExceptionalCollectionAsEndomorphismOfTiltingObject,
          [ IsStrongExceptionalCollection, IsCapCategoryMorphismInAFullSubcategory ],
          
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
          [ IsStrongExceptionalCollection, IsInt ],
          
  function( collection, i )
    local n;
    
    n := NumberOfObjects( collection );
    
    if i > n then
      
      Error( "There are only ", n, " objects in the collection!\n" );
      
    fi;
    
    return UnderlyingObjects( collection )[ i ];
    
end );

##
InstallMethod( PathsOfLengthGreaterThanOneOp,
          [ IsStrongExceptionalCollection, IsList ],
          
  function( collection, indices )
    local i, j, n;
    
    n := NumberOfObjects( collection );
    
    if not ForAll( indices, i -> i in [ 1 .. n ] ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    i := indices[ 1 ];
    
    j := indices[ 2 ];
    
    if j - i <= 1 then
      
      return [ ];
      
    else
      
      return
        Concatenation(
          List( [ i + 1 .. j - 1 ],
            u -> ListX(
                    PathsOfLengthOne( collection, [ i, u ] ),
                    AllPaths( collection, [ u, j ] ),
                    PreCompose
                  )
              )
        );
        
    fi;
    
end );

##
InstallOtherMethod( PathsOfLengthGreaterThanOne,
          [ IsStrongExceptionalCollection, IsInt, IsInt ],
  { collection, i, j } -> PathsOfLengthGreaterThanOne( collection, [ i, j ] )
);

##
InstallMethod( PathsOfLengthOneOp,
          [ IsStrongExceptionalCollection, IsList ],
    
  function( collection, indices )
    local i, s, j, r, n, full, hom_ij, D, maps, long_paths, arrows, beta, nr_arrows, m;
    
    i := indices[ 1 ];
    
    s := collection[ i ];
    
    j := indices[ 2 ];
    
    r := collection[ j ];
    
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input!\n" );
      
    fi;
 
    if i >= j then
        
      return [ ];
        
    else
      
      full := DefiningFullSubcategory( collection );
      
      hom_ij := HomStructure( s, r );
      
      D := DistinguishedObjectOfHomomorphismStructure( full );
      
      maps := BasisOfExternalHom( D, hom_ij );
      
      long_paths := PathsOfLengthGreaterThanOne( collection, [ i, j ] );
      
      if j - i = 1 or IsEmpty( long_paths ) then
        
        arrows := List( maps, m -> HomStructure( s, r, m ) );
        
      else
        
        beta := List( long_paths, p -> [ HomStructure( p ) ] );
        
        beta := MorphismBetweenDirectSums( beta );
        
        nr_arrows := RankOfObject( CokernelObject( beta ) );
        
        arrows := [ ];
        
        for m in maps do
        
          if not IsLiftable( m, beta ) then
            
            Add( arrows, HomStructure( s, r, m ) );
            
            beta := MorphismBetweenDirectSums( [ [ m ], [ beta ] ] );
            
            if Size( arrows ) = nr_arrows then
              
              break;
              
            fi;
            
          fi;
          
        od;
        
      fi;
      
      return arrows;
      
    fi;
      
end );

##
InstallOtherMethod( PathsOfLengthOne,
          [ IsStrongExceptionalCollection, IsInt, IsInt ],
  { collection, i, j } -> PathsOfLengthOne( collection, [ i, j ] )
);

##
InstallOtherMethod( Arrows,
          [ IsStrongExceptionalCollection, IsInt, IsInt ],
  { collection, i, j } -> PathsOfLengthOne( collection, [ i, j ] )
);

##
InstallMethod( AllPathsOp,
          [ IsStrongExceptionalCollection, IsList ],
          
  function( collection, indices )
    
    return
      Concatenation(
          PathsOfLengthOne( collection, indices ),
          PathsOfLengthGreaterThanOne( collection, indices )
        );
            
end );

##
InstallOtherMethod( AllPaths,
          [ IsStrongExceptionalCollection, IsInt, IsInt ],
  { collection, i, j } -> AllPaths( collection, [ i, j ] )
);

##
InstallMethod( BasisOfPathsOp,
          [ IsStrongExceptionalCollection, IsList ],
              
  function( collection, indices )
    local dim, arrows, arrows_labels, long_paths, long_paths_labels, B, B_labels, p, rel, labels;
    
    dim := RankOfObject( HomStructure( collection[ indices[ 1 ] ], collection[ indices[ 2 ] ] ) );
    
    arrows := PathsOfLengthOne( collection, indices );
    
    arrows_labels := List( LabelsForPathsOfLengthOne( collection, indices ), l -> [ l ] );
    
    long_paths := PathsOfLengthGreaterThanOne( collection, indices );
    
    long_paths_labels := LabelsForPathsOfLengthGreaterThanOne( collection, indices );
    
    B := [ ];
    
    B_labels := [ ];
    
    while Size( B ) < dim - Size( arrows ) do
      
      p := PositionProperty( long_paths, path -> not IsZero( path ) );
      
      rel := RelationsBetweenMorphisms( Concatenation( B, [ long_paths[ p ] ] ) );
      
      if IsEmpty( rel ) then
        
        Add( B, long_paths[ p ] );
        
        Add( B_labels, long_paths_labels[ p ] );
        
      fi;
      
      long_paths := long_paths{ [ p + 1 .. Size( long_paths ) ] };
      
      long_paths_labels := long_paths_labels{ [ p + 1 .. Size( long_paths_labels ) ] };
      
    od;
    
    B := Concatenation( arrows, B );
    
    labels := Concatenation( arrows_labels, B_labels );
    
    SetLabelsForBasisOfPaths( collection, indices, labels );
    
    return B;
    
end );

##
InstallOtherMethod( BasisOfPaths,
          [ IsStrongExceptionalCollection, IsInt, IsInt ],
  { collection, i, j } -> BasisOfPaths( collection, [ i, j ] )
);

##
InstallMethod( LabelsForPathsOfLengthOneOp,
          [ IsStrongExceptionalCollection, IsList ],
          
  function( collection, indices )
    local nr_arrows;
    
    nr_arrows := Length( PathsOfLengthOne( collection, indices ) );
    
    return List( [ 1 .. nr_arrows ], k -> Concatenation( indices, [ k ] ) );
    
end );

##
InstallMethod( LabelsForPathsOfLengthGreaterThanOneOp,
          [ IsStrongExceptionalCollection, IsList ],
          
  function( collection, indices )
    local i, j, n, labels;
    
    i := indices[ 1 ];
    
    j := indices[ 2 ];
    
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    if j - i <= 0 then
      
      return [ ];
      
    elif j - i = 1 then
      
      # should we change this
      return [ ];
      
    else
    
      return
        Concatenation(
          List( [ i + 1 .. j - 1 ],
            u -> ListX(
                  List( LabelsForPathsOfLengthOne( collection,  [ i, u ] ), l -> [ l ] ),
                  LabelsForAllPaths( collection, [ u, j ] ),
                  Concatenation
                )
              )
            );
            
    fi;
    
end );

##
InstallMethod( LabelsForAllPathsOp,
      [ IsStrongExceptionalCollection, IsList ],
      
  function( collection, indices )
    
    return Concatenation(
                List( LabelsForPathsOfLengthOne( collection, indices ), l -> [ l ] ),
                LabelsForPathsOfLengthGreaterThanOne( collection, indices )
              );
              
end );

##
InstallMethod( LabelsForBasisOfPathsOp,
              [ IsStrongExceptionalCollection, IsList ],
              
  function( collection, indices )
    local b;
    
    b := BasisOfPaths( collection, indices );
    
    return LabelsForBasisOfPaths( collection, indices );
    
end );

##
InstallGlobalFunction( RelationsBetweenMorphisms,

  function( morphisms )
    local map;
    
    map := MorphismBetweenDirectSums( List( morphisms, m -> [ HomStructure( m ) ] ) );
    
    return EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( KernelEmbedding( map ) ) );
    
end );

##
InstallMethod( EndomorphismAlgebra,
        [ IsStrongExceptionalCollection, IsField ],
        
  function( collection, field )
    local nr_vertices, arrows, sources, ranges, v, labels, extract_latex_string, arrows_latex, vertices_latex, quiver, A, relations, paths_in_collection, paths_in_quiver, rel, name, r, i, j;
    
    nr_vertices := NumberOfObjects( collection );
    
    arrows := List( [ 1 .. nr_vertices - 1 ],
                i -> Concatenation(
                  
                  List( [ i + 1 .. nr_vertices ],
                    j -> LabelsForPathsOfLengthOne( collection, [ i, j ] )
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
    
    extract_latex_string :=
      function( s )
        local r;
        
        r := SplitString( s{ [ 2 .. Size( s ) ] }, "_" );
        
        return Concatenation( v, "_{", r[ 1 ], ",", r[ 2 ], "}^{", r[ 3 ], "}" );
        
      end;
    
    arrows_latex := List( labels, extract_latex_string );
          
    if IsBound( collection!.vertices_latex ) then
      
      vertices_latex := collection!.vertices_latex;
      
    else
      
      vertices_latex := List( [ 1 .. nr_vertices ], i -> Concatenation( "E_{", String( i ), "}" ) );
      
    fi;

    
    quiver := RightQuiver( collection!.quiver,
                collection!.vertices_labels, labels, sources, ranges );
    
    SetLabelsAsLaTeXStrings( quiver, vertices_latex, arrows_latex );
     
    A := PathAlgebra( field, quiver );
    
    relations := [ ];
    
    for i in [ 1 .. nr_vertices - 1 ] do
      for j in [ i + 1 .. nr_vertices ] do
                      
        paths_in_collection := AllPaths( collection, [ i, j ] );
        
        if IsEmpty( paths_in_collection ) then
          continue;
        fi;
        
        labels := LabelsForAllPaths( collection, [ i, j ] );
        
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
    
    SetDefiningStrongExceptionalCollection( A, collection );
    
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
                                 "Quiver rows(", r[ 2 ], " ", name,
                                  " ", r[ 1 ], ")", r[ 2 ]
                                );;
                                
    fi;
    
    return A;
    
end );

##
InstallMethod( EndomorphismAlgebraAttr,
    [ IsStrongExceptionalCollection ],
    
  collection -> EndomorphismAlgebra( collection, GLOBAL_FIELD_FOR_QPA!.default_field )
);

##
InstallMethod( EndomorphismAlgebra,
          [ IsStrongExceptionalCollection ],
          
  EndomorphismAlgebraAttr
);

##
InstallMethod( AmbientCategory,
          [ IsStrongExceptionalCollection ],
          
  collection -> AmbientCategory( DefiningFullSubcategory( collection ) )
);

##
InstallMethod( Algebroid,
          [ IsStrongExceptionalCollection ],
          
  collection -> Algebroid( EndomorphismAlgebra( collection ) )
);

##
InstallMethod( QuiverRows,
          [ IsStrongExceptionalCollection ],
          
  collection -> QuiverRows( EndomorphismAlgebra( collection ) )
);

##
InstallMethod( CategoryOfQuiverRepresentationsOverOppositeAlgebra,
          [ IsStrongExceptionalCollection ],
          
  collection -> CategoryOfQuiverRepresentations( OppositeAlgebra( EndomorphismAlgebra( collection ) ) )
);

##
InstallOtherMethod( HomotopyCategory,
          [ IsStrongExceptionalCollection ],
          
  function( collection )
    local collection_plus;
     
    collection_plus := AdditiveClosure( DefiningFullSubcategory( collection ) );
    
    if IsCochainComplexCategory( UnderlyingCategory( AmbientCategory( collection ) ) ) then
      
      return HomotopyCategory( collection_plus, true );
      
    else
      
      return HomotopyCategory( collection_plus, false );
      
    fi;
    
end );

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
          [ IsStrongExceptionalCollection ],
          
  collection -> AdditiveClosureAsFullSubcategory( DefiningFullSubcategory( collection ) )
);

##
InstallMethod( AdditiveClosure,
          [ IsStrongExceptionalCollection ],
          
  collection -> AdditiveClosure( DefiningFullSubcategory( collection ) )
);

##
InstallMethodWithCache( BoxProduct,
          [ IsStrongExceptionalCollection, IsStrongExceptionalCollection, IsCapCategory ],
          
  function( collection_1, collection_2, category )
    local full;
    
    full := BoxProduct( DefiningFullSubcategory( collection_1 ), DefiningFullSubcategory( collection_2 ), category );
    
    return CreateStrongExceptionalCollection( full );
    
end );


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
    
    if IsQuiverRepresentationCategory( cat ) and not IsAdmissibleQuiverAlgebra( AlgebraOfCategory( cat ) ) then
      
      Error( "The quiver algebra of the category is not admissible!" );
      
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

##
InstallMethod( FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra,
        [ IsStrongExceptionalCollection ],
  collection -> FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( Algebroid( collection ) )
);

##
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

##
InstallOtherMethod( RankOfObject, [ IsVectorSpaceObject ], Dimension );

###########################
##
## For tests or internal use
##
###########################

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
InstallGlobalFunction( RandomQuiverAlgebraWhoseIndecProjectiveRepsAreStrongExceptionalCollection,
  function( field, nr_vertices, nr_arrows, nr_relations )
    local sources_of_arrows, ranges_of_arrows, arrows, labels, extract_latex_string, arrows_latex, vertices_latex, quiver, A, G, H, df_H, rel, g, e, i, name, name_op;
    
    sources_of_arrows := List( [ 1 .. nr_arrows ],
      i -> Random( [ 1 .. nr_vertices - 1 ] ) );
    
    ranges_of_arrows := List( [ 1 .. nr_arrows ],
      i -> Random( [ sources_of_arrows[ i ] + 1 .. nr_vertices ] ) );
    
    arrows := ListN( sources_of_arrows, ranges_of_arrows, {s,r} -> [ s, r ] );
    
    arrows := Collected( arrows );
        
    sources_of_arrows := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], k -> a[ 1 ][ 1 ] ) ) );
    
    ranges_of_arrows := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], k -> a[ 1 ][ 2 ] ) ) );
    
    labels := Concatenation( List( arrows, a -> List( [ 1 .. a[ 2 ] ], 
      k -> Concatenation( 
                "r",
                String( a[ 1 ][ 1 ] ),
                "_",
                String( a[ 1 ][ 2 ] ),
                "_",
                String( k ) 
              ) ) ) );
    
    extract_latex_string :=
      function( s )
        local r;
        
        r := SplitString( s{ [ 2 .. Size( s ) ] }, "_" );
        
        return Concatenation( "r_{", r[ 1 ], ",", r[ 2 ], "}^{", r[ 3 ], "}" );
        
      end;
    
    arrows_latex := List( labels, extract_latex_string );
    
    vertices_latex := List( [ 1 .. nr_vertices ], i -> Concatenation( "V_", String( i ) ) );

    quiver := RightQuiver( "Quiver", [ 1 .. nr_vertices ],
                labels, sources_of_arrows, ranges_of_arrows );
    
    SetLabelsAsLaTeXStrings( quiver, vertices_latex, arrows_latex );
    
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
    
    if not IsEmpty( rel ) then
      
      name := Concatenation( "(", Name( A ), ") / [ ", String( Size( rel ) ), " relations ]" );
      name_op := Concatenation( "(", Name( OppositeAlgebra( A ) ), ") / [ ", String( Size( rel ) ), " relations ]" );
      
    else
      
      name := Name( A );
      name_op := Name( OppositeAlgebra( A ) );
      
    fi;
    
    A := QuotientOfPathAlgebra( A, rel );
    
    A!.alternative_name := name;
    OppositeAlgebra(A)!.alternative_name := name_op;
        
    return A;
  
end );

############################
##
## View & Display
##
###########################

##
InstallMethod( ViewObj,
    [ IsStrongExceptionalCollection ],
  function( collection )
    local full;
    
    full := DefiningFullSubcategory( collection );
    
    Print( "<An exceptional collection defined by the objects of the ", Name( full ), ">" );
    
end );

##
InstallMethod( Display,
    [ IsStrongExceptionalCollection ],
  function( collection )
    local N, i;
    
    N := NumberOfObjects( collection );
    
    Print( "An exceptional collection defined by ", N, " objects:\n\n" );
    
    for i in [ 1 .. N ] do
      
      Print( "\n\033[33m\033[4mObject ", i, ":\033[0m\n" );
      
      Display( collection[ i ] );
      
    od;
    
end );

