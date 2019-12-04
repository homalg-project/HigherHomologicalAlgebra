#############################################################################
##
## DerivedCategories: Derived categories for additive categories
##
## Copyright 2019, Kamal Saleh, University of Siegen
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
  function( full )
    local L, collection, n;
    
    if HasExceptionalCollection( full ) then
      
      return ExceptionalCollection( full );
      
    fi;
    
    if IsList( full ) then
      
      full := FullSubcategoryGeneratedByListOfObjects( full );
      
      SetCachingOfCategoryCrisp( full );
     
    fi;
    
    L := ShallowCopy( full!.Objects );
    
    L := List( L, obj -> AsFullSubcategoryCell( full, obj ) );
    
    if IsEmpty( L ) then
      
      Error( "The input is empty!" );
    
    fi;
    
    if not HasRangeCategoryOfHomomorphismStructure( full ) then
      
      Error( "The category needs homomorphism structure" );
    
    fi;
    
    Sort( L, { a, b } -> IsZero( HomomorphismStructureOnObjects( b, a ) ) );
    
    MakeImmutable( L );
    
    collection := rec( 
                    arrows := rec( ),
                    other_paths := rec( ),
                    paths := rec( ),
                    basis_for_paths := rec( ),
                    labels_for_arrows := rec( ),
                    labels_for_other_paths := rec( ),
                    labels_for_paths := rec( ),
                    labels_for_basis_for_paths := rec( ) 
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

InstallMethod( ExceptionalCollection,
          [ IsCapFullSubcategory ],
  function( full )
    
    CreateExceptionalCollection( full );
    
    return ExceptionalCollection( full );
  
end );

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
      
      Error( "There is only ", n, " objects in the collection!\n" );
      
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
    local nr_vertices, arrows, sources, ranges, labels, quiver, A, relations, paths_in_collection, paths_in_quiver, rel, i, j;
    
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
    
    labels := List( arrows, a -> Concatenation( "v", String( a[ 1 ] ), "_v", String( a[ 2 ] ), "_", String( a[ 3 ] ) ) );
    
    quiver := RightQuiver( "quiver", [ 1 .. nr_vertices ], labels, sources, ranges );
    
    A := PathAlgebra( field, quiver );
    
    relations := [ ];
    
    for i in [ 1 .. nr_vertices - 1 ] do
      for j in [ i + 1 .. nr_vertices ] do  #TODO can we start from i+2?
                      
        paths_in_collection := Paths( collection, i, j );
        
        if IsEmpty( paths_in_collection ) then
          continue;
        fi;
        
        labels := LabelsForPaths( collection, i, j );
        
        paths_in_quiver := List( labels,
          l -> Product(
            List( l, a -> A.( Concatenation( "v", String( a[1] ), "_v", String( a[2] ), "_", String( a[ 3 ] ) ) ) ) ) );
      
        rel := RelationsBetweenMorphisms( paths_in_collection );
      
        rel := List( rel, r -> r * paths_in_quiver );
      
        relations := Concatenation( relations, rel );
                      
      od;
      
    od;
    
    relations := ComputeGroebnerBasis( relations );
    
    A := QuotientOfPathAlgebra( A, relations ); 
    
    Assert( 2, IsAdmissibleQuiverAlgebra( A ) );
   
    SetIsAdmissibleQuiverAlgebra( A, true );
    
    return A;
    
end );

##
InstallMethod( EndomorphismAlgebraOfExceptionalCollection,
    [ IsExceptionalCollection ],
  function( collection )
    local full, k;
    
    full := DefiningFullSubcategory( collection );
    
    k := CommutativeRingOfLinearCategory( full );
    
    return QuiverAlgebraFromExceptionalCollection( collection, k );
  
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecProjectiveObjects,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local A, full, full_subcategory_by_projs, projs;
    
    A := AlgebraOfCategory( cat );
    
    if not IsFiniteDimensional( A ) then
      
      Error( "The underlying quiver algebra should be finite dimensional!\n" );
      
    fi;
    
    full_subcategory_by_projs := FullSubcategoryGeneratedByProjectiveObjects( cat );
    
    projs := IndecProjRepresentations( A );
    
    projs := List( projs, p -> AsFullSubcategoryCell( full_subcategory_by_projs, p ) );
    
    full := FullSubcategoryGeneratedByListOfObjects( projs );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategory( full, "none" ); 
    
    return full;
   
end );

##
InstallMethod( FullSubcategoryGeneratedByIndecInjectiveObjects,
          [ IsQuiverRepresentationCategory ],
  function( cat )
    local A, full, full_subcategory_by_injs, injs;
    
    A := AlgebraOfCategory( cat );
    
    if not IsFiniteDimensional( A ) then
      
      Error( "The underlying quiver algebra should be finite dimensional!\n" );
      
    fi;
    
    full_subcategory_by_injs := FullSubcategoryGeneratedByInjectiveObjects( cat );
    
    injs := IndecInjRepresentations( A );
    
    injs := List( injs, p -> AsFullSubcategoryCell( full_subcategory_by_injs, p ) );
    
    full := FullSubcategoryGeneratedByListOfObjects( injs );
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategory( full, "none" ); 
    
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
      
    cat := CategoryOfQuiverRepresentations( A_op : FinalizeCategory := false );
    
    if not HasIsLinearCategoryOverCommutativeRing( cat ) then
      
      SetIsLinearCategoryOverCommutativeRing( cat, true );
      
    fi;
    
    if not HasCommutativeRingOfLinearCategory( cat ) then
      
      SetCommutativeRingOfLinearCategory( cat, LeftActingDomain( A_op ) );
      
    fi;
    
    Finalize( cat );
    
    return FullSubcategoryGeneratedByIndecProjectiveObjects( cat );
    
end );

##
InstallMethod( FullSubcategoryGeneratedByProjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local full, finalize;
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then
      
      Error( "The input should be an abelian category with computable enough projectives" );
      
    fi;
    
    full := FullSubcategory( cat, "Full subcategory generated by projective objects in " 
              : FinalizeCategory := false, is_additive := true );
    
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
          
          return List( B, m -> AsFullSubcategoryCell( full, m ) );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( alpha, B )
          
          return CoefficientsOfMorphism( UnderlyingCell( alpha ) );
          
      end );
     
    fi;
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategory( full, "none" ); 
    
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
      
      return full;
    
    fi;
        
    Finalize( full );
    
    return full;

end );

##
InstallMethod( FullSubcategoryGeneratedByInjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local full, finalize;
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The input should be an abelian category with computable enough injectives" );
      
    fi;
    
    full := FullSubcategory( cat, "Full subcategory generated by injective objects in " 
              : FinalizeCategory := false, is_additive := true );
    
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
          
          return List( B, m -> AsFullSubcategoryCell( full, m ) );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( alpha, B )
          
          return CoefficientsOfMorphism( UnderlyingCell( alpha ) );
          
      end );
     
    fi;
    
    CapCategorySwitchLogicOff( full );
    
    DisableSanityChecks( full );
    
    SetCachingOfCategory( full, "none" ); 
   
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
      
      return full;
    
    fi;
    
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
    
    Assert( 2, IsAdmissibleQuiverAlgebra( A ) );
    
    SetIsAdmissibleQuiverAlgebra( A, true );
    
    cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );
    
    SetIsLinearCategoryOverCommutativeRing( cat, true );
    
    SetCommutativeRingOfLinearCategory( cat, field );
    
    Finalize( cat );
    
    if not ( HasIsFieldForHomalg( field ) and IsFieldForHomalg( field ) ) then
      
      Info( InfoDerivedCategories, 1, "The category of quiver representations for this random quiver algebra may not have homomorphism strucure\n" );
      
    fi;
     
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

