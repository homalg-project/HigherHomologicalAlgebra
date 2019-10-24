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
    local collection, n, i;
    
    L := ShallowCopy( L );
    
    if IsEmpty( L ) then
      
      Error( "The input is empty!" );
      
    fi;
        
    Sort( L, { a, b } -> IsZero( HomomorphismStructureOnObjects( b, a ) ) );
    
    collection := rec( arrows := rec( ), other_paths := rec( ), paths := rec( ) );
    
    n := Length( L );
    
    ObjectifyWithAttributes(
      collection, TheTypeStrongExceptionalCollection,
        UnderlyingObjects, L,
        NumberOfObjects, n );
    
    return collection;
    
end );

## morphisms := [ f1,f2,f3: A -> B ] will be mapped to F:k^3 -> H(A,B).
##
InstallMethod( InterpretListOfMorphismsAsOneMorphism,
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ],
    
  function( source, range, morphisms )
    local linear_maps, H;
    
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


###########################
##
## For tests or internal use
##
###########################

##
InstallGlobalFunction( RandomQuiverWhoseIndecProjectiveRepsAreExceptionalCollection,
  function( m, n )
    local sources_of_arrows, ranges_of_arrows;
  
    sources_of_arrows := List( [ 1 .. n ],
      i -> Random( [ 1 .. m - 1 ] ) );
    
    ranges_of_arrows := List( [ 1 .. n ],
      i -> Random( [ sources_of_arrows[ i ] + 1 .. m ] ) );
    
    return RightQuiver( "QQ", MakeLabelsFromPattern( "1", m ),
              MakeLabelsFromPattern( "x1", n ),
                sources_of_arrows, ranges_of_arrows );
  
end );

