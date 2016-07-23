###################################################################################
##                                                                               ##
## Giving rational vector spaces category a structure of a triangulated category ##
##                                                                               ##
###################################################################################

############################
##
## Declarations
##
###########################

LoadPackage( "MatricesForHomalg" );

LoadPackage( "TriangulatedCategoriesForCap" );


DeclareRepresentation( "IsHomalgRationalVectorSpaceRep",
                        IsCapCategoryObjectRep,
                        [ ] );
                        
BindGlobal( "TheTypeOfHomalgRationalVectorSpaces",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomalgRationalVectorSpaceRep ) );

DeclareRepresentation( "IsHomalgRationalVectorSpaceMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaceMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsHomalgRationalVectorSpaceMorphismRep ) );

DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

#################################
##
## Creation of category
##
#################################
 
BindGlobal( "vecspaces", CreateCapCategory( "VectorSpaces" ) );

# SetIsAbelianCategory( vecspaces, true );

BindGlobal( "VECTORSPACES_FIELD", HomalgFieldOfRationals( ) );

###########################################
##
## Constructors for objects and morphisms 
##
###########################################

InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim 
    );
    
    Add( vecspaces, space );
    
    return space;
    
end );

InstallMethod( VectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism;

    if not IsHomalgMatrix( matrix ) then
    
      morphism := HomalgMatrix( matrix, Dimension( source ), Dimension( range ), VECTORSPACES_FIELD );

    else

      morphism := matrix;

    fi;

    if NrRows( morphism ) <> Dimension( source ) or NrColumns( morphism ) <> Dimension( range ) then 
                             
      Error( "The inputs are not compatible" );
    
    fi;
    
    morphism := rec( morphism := morphism );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                             Source, source,
                             Range, range 
    );

    Add( vecspaces, morphism );
    
    return morphism;
    
end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceRep ],

  function( obj )

    Print( "<A rational vector space of dimension ", 
    String( Dimension( obj ) )," as an object in ",vecspaces, ">" );

end );

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceMorphismRep ],

  function( obj )

    Print( "A rational vector space homomorphism with matrix: \n" );
  
    Display( obj!.morphism );

end );


########################################
##
## Adding triangulation Methods
##
########################################


## Here we define additive equivalence ...
## shifting( V ) = V \sum V
## shifting( alpha )= ( alpha, 0     )
##                            (  0   , alpha ).
# shifting_functor:= CapFunctor( "Shifting in vecspaces", vecspaces, vecspaces );
# 
# AddObjectFunction( shifting_functor, 
#  
#  function( obj )
# 
#  return QVectorSpace( 2 * Dimension( obj ) );
# 
# end );
# 
# AddMorphismFunction( shifting_functor,
# 
# function( new_source, mor, new_range )
# local matr, matr1;
# 
#  matr := EntriesOfHomalgMatrixAsListList( mor!.morphism );
# 
#  matr := Concatenation( List( matr, i -> Concatenation( i, ListWithIdenticalEntries( Length( i ), 0 ) ) ),
# 
#  List( matr, i -> Concatenation( ListWithIdenticalEntries( Length( i ), 0 ), i ) ) );
# 
#  return VectorSpaceMorphism( new_source, matr, new_range );
# 
# end );

##
# shifting_objects:= 
# 
# function( obj )
#  
#   return QVectorSpace( 2 * Dimension( obj ) );
#  
# end;
# 
# AddShiftOfObject( vecspaces, shifting_objects );

AddShiftOfObject( vecspaces, IdFunc );
AddReverseShiftOfObject( vecspaces, IdFunc );


##
# shifting_morphisms:=  
# 
# function( mor )
#  local matr, new_source, new_range;
# 
#    matr := EntriesOfHomalgMatrixAsListList( mor!.morphism );
# 
#    matr := Concatenation( List( matr, i -> Concatenation( i, ListWithIdenticalEntries( Length( i ), 0 ) ) ),
#  
#    List( matr, i -> Concatenation( ListWithIdenticalEntries( Length( i ), 0 ), i ) ) );
#  
#    new_source:= shifting_objects( Source( mor ) );
#    
#    new_range:= shifting_objects( Range( mor ) );
#    
#    return VectorSpaceMorphism( new_source, matr, new_range );
# 
# end;
   
AddShiftOfMorphism( vecspaces, IdFunc );
AddReverseShiftOfMorphism( vecspaces, IdFunc );

