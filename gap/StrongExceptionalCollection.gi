#############################################################################
##
##  DerivedCategories: Derived categories for additive categories
##
##  Copyright 2019, Kamal Saleh, University of Siegen
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
## Constructors
##
##################################

##
InstallGlobalFunction( CreateStrongExceptionalCollection,
  function( L )
    local cat, collection, n, i;

    L := ShallowCopy( L );
    
    if IsEmpty( L ) then
      
      Error( "The input is empty!" );
    
    fi;
    
    cat := CapCategory( L[ 1 ] );
    
    if not HasRangeCategoryOfHomomorphismStructure( cat ) then
      
      Error( "The category needs homomorphism structure" );
    
    fi;

    Sort( L, { a, b } -> IsZero( HomomorphismStructureOnObjects( b, a ) ) );
    
    collection := rec( 
                    arrows := rec( ),
                    other_paths := rec( ),
                    paths := rec( ),
                    labels_of_arrows := rec( ),
                    labels_of_other_paths := rec( ),
                    labels_of_paths := rec( )
                    );
    
    n := Length( L );
    
    ObjectifyWithAttributes(
      collection, TheTypeStrongExceptionalCollection,
        UnderlyingObjects, L,
        NumberOfObjects, n );
    
    return collection;
    
end );


##
InstallMethod( \[\],
      [ IsStrongExceptionalCollection, IsInt ],
  function( collection, i )
    
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
      [ InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( morphism ) ] );
    
    return MorphismBetweenDirectSums( linear_maps );
      
end );


##
InstallMethod( ArrowsBetweenTwoObjects,
    [ IsStrongExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local cat, n, source, range, H, U, maps, arrows, paths, one_morphism, nr_arrows, map;
    
    n := NumberOfObjects( collection );
    
    if i <= 0 or j <= 0 or i > n or j > n then
      
      Error( "Wrong input: some index is less than zero or bigger thanthe number of objects in the strong exceptional collection." );
      
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
          InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
            source, range, map ) );
      
      else
      
        paths := OtherPathsBetweenTwoObjects( collection, i, j );
      
        one_morphism := InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure( source, range, paths );
        
        nr_arrows := Dimension( CokernelObject( one_morphism ) );
        
        arrows := [ ];
      
        for map in maps do
        
          if not IsLiftable( map, one_morphism ) then
                  
            Add( arrows,
              InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( 
                source, range, map ) );
            
            one_morphism := MorphismBetweenDirectSums( [ [ map ], [ one_morphism ] ] );
            
            if Length( arrows ) = nr_arrows then
              
              break;
              
            fi;
         
          fi;
        
        od;
      
      fi;
     
      collection!.arrows!.( String( [ i, j ] ) ) := arrows;
      
      return arrows;
        
    fi;
      
end );

##
InstallMethod( OtherPathsBetweenTwoObjects,
    [ IsStrongExceptionalCollection, IsInt, IsInt ],
  
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
                ArrowsBetweenTwoObjects( collection, i, u ), 
                  Concatenation(
                    OtherPathsBetweenTwoObjects( collection, u, j ),
                      ArrowsBetweenTwoObjects( collection, u, j ) ), PreCompose ) );
      
      paths := Concatenation( paths );
      
      collection!.other_paths!.( String( [ i, j ] ) ) := paths;
      
      return paths;
    
    fi; 
    
end );

##
InstallMethod( PathsBetweenTwoObjects,
    [ IsStrongExceptionalCollection, IsInt, IsInt ],
  
  function( collection, i, j )
    local paths;
    
    paths := Concatenation( 
              ArrowsBetweenTwoObjects( collection, i, j ),
                OtherPathsBetweenTwoObjects( collection, i, j )
                );
    
    collection!.paths!.( String( [ i, j ] ) ) := paths;

    return paths;
    
end );


InstallMethod( LabelsOfArrowsBetweenTwoObjects,
    [ IsStrongExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local nr_arrows, labels;
    
    if IsBound( collection!.labels_of_arrows!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_of_arrows!.( String( [ i, j ] ) );
      
    fi;
   
    nr_arrows := Length( ArrowsBetweenTwoObjects( collection, i, j ) ); 
   
    labels := List( [ 1 .. nr_arrows ], k -> [ i, j, k ] );
    
    collection!.labels_of_arrows!.( String( [ i, j ] ) ) := labels;
  
    return labels;
    
end );

##
InstallMethod( LabelsOfOtherPathsBetweenTwoObjects,
    [ IsStrongExceptionalCollection, IsInt, IsInt ],
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
    
    if IsBound( collection!.labels_of_other_paths!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_of_other_paths!.( String( [ i, j ] ) );
    
    fi;
    
    labels := List( [ i + 1 .. j - 1 ],
              u -> ListX( 
                    
                    LabelsOfArrowsBetweenTwoObjects( collection, i, u ),
                    
                    Concatenation(
                      LabelsOfOtherPathsBetweenTwoObjects( collection, u, j ),
                        List( LabelsOfArrowsBetweenTwoObjects( collection, u, j ), a -> [ a ] )
                                 ),
                    
                    {a,b} -> Concatenation( [ a ], b ) )
              );
      
      labels := Concatenation( labels );
      
      collection!.labels_of_other_paths!.( String( [ i, j ] ) ) := labels;
      
      return labels;
    
    fi; 
  
end );

##
InstallMethod( LabelsOfPathsBetweenTwoObjects,
      [ IsStrongExceptionalCollection, IsInt, IsInt ],
  function( collection, i, j )
    local labels;
    
    if IsBound( collection!.labels_of_paths!.( String( [ i, j ] ) ) ) then
      
      return collection!.labels_of_paths!.( String( [ i, j ] ) );
      
    fi;
    
    labels := Concatenation( 
              List( LabelsOfArrowsBetweenTwoObjects( collection, i, j ), l -> [ l ] ),
                LabelsOfOtherPathsBetweenTwoObjects( collection, i, j )
                );
    
    collection!.labels_of_paths!.( String( [ i, j ] ) ) := labels;
    
    return labels;
    
end );

###########################
##
## For tests or internal use
##
###########################

##
InstallGlobalFunction( RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection,
  function( m, n )
    local sources_of_arrows, ranges_of_arrows, quiver;
  
    sources_of_arrows := List( [ 1 .. n ],
      i -> Random( [ 1 .. m - 1 ] ) );
    
    ranges_of_arrows := List( [ 1 .. n ],
      i -> Random( [ sources_of_arrows[ i ] + 1 .. m ] ) );
    
    quiver := RightQuiver( "QQ", MakeLabelsFromPattern( "1", m ),
                MakeLabelsFromPattern( "x1", n ),
                  sources_of_arrows, ranges_of_arrows );
    
    return PathAlgebra( Rationals, quiver );
  
end );

