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
    
    collection := rec( arrows := rec( ), other_paths := rec( ), paths := rec( ) );
    
    n := Length( L );
    
    ObjectifyWithAttributes(
      collection, TheTypeStrongExceptionalCollection,
        UnderlyingObjects, L,
        NumberOfObjects, n );
    
    return collection;
    
end );


