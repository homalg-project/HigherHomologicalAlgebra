###################################################################################
##                                                                               ##
## Giving rational vector spaces category a structure of a triangulated category ##
##                                                                               ##
###################################################################################

## ReadPackage( "TriangulatedCategoriesForCAP", "examples/VectorSpacesTriangulatedCategory.gi" );

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

##################################
##
##  Display
##
##################################

InstallMethod( Display,
               [ IsHomalgRationalVectorSpaceRep ],

  function( obj )

    Print( "k^(1 X ", String( Dimension( obj ) ),") as an object in ",vecspaces );

end );

InstallMethod( Display,
               [ IsHomalgRationalVectorSpaceMorphismRep ],

  function( mor )

    
    Print( "A rational vector space homomorphism ",
    "k^(1 X ", String( Dimension( Source( mor ) ) ), ") --> ",
    "k^(1 X ", String( Dimension( Range( mor ) ) ),
    
    ") with matrix: \n" );
  
    Display( mor!.morphism );

end );



########################################
##
## Adding additive methods
##
########################################

##
identity_morphism := function( obj )

    return VectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), VECTORSPACES_FIELD ), obj );
    
end;

AddIdentityMorphism( vecspaces, identity_morphism );

##
pre_compose := function( mor_left, mor_right )
    local composition;

    composition := mor_left!.morphism * mor_right!.morphism;

    return VectorSpaceMorphism( Source( mor_left ), composition, Range( mor_right ) );

end;

AddPreCompose( vecspaces, pre_compose );

##
is_equal_for_objects := function( vecspace_1, vecspace_2 )
    
    return Dimension( vecspace_1 ) = Dimension( vecspace_2 );
    
end;

AddIsEqualForObjects( vecspaces, is_equal_for_objects );

##
is_equal_for_morphisms := function( a, b )
  
    return a!.morphism = b!.morphism;
  
end;

AddIsEqualForMorphisms( vecspaces, is_equal_for_morphisms );

is_zero_for_obj := function( obj )

return Dimension( obj )=0;
end;

AddIsZeroForObjects( vecspaces, is_zero_for_obj );


is_zero_for_mors := function( mor )

return IsZero( EntriesOfHomalgMatrixAsListList( mor!.morphism ) );

end;

AddIsZeroForMorphisms( vecspaces, is_zero_for_mors );

is_exact_for_triangles:= function( trian )
                         local f,g,h;
                         
                         if not IsZeroForMorphisms( PreCompose( f, g ) ) or 
                            not IsZeroForMorphisms( PreCompose( g, h ) ) or 
                            not IsZeroForMorphisms( PreCompose( h, f ) ) then 
                            
                            return false;
                            
                        fi;
                        
                        
#                         if not Dimension( KenelObject
                            
                         

                         
end;
                         
AddIsExactForTriangles( vecspaces, is_exact_for_triangles );                       

AddConeAndMorphisms( vecspaces, function( mor )

                               return [ mor, Source( mor ), mor ];
                               
                               end );

HelperByWritingMorphisms:= function( m, n, t )
                           local l;

l:= List( [ 1 .. m+n ], i-> List( [ 1 .. n+t], function( j )
    
                                                if i<= m then return 0;
                                                
                                                elif j> n then return 0;
                                                
                                                else return Random( [ -100 .. 100 ] );
                                                
                                                fi;
                                                
                                                end ) );

return l;

end;
# Finalize( vecspaces );
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
shifting_objects:= 
 
function( obj )
  
   return obj;
  
end;
 
AddShiftOfObject( vecspaces, shifting_objects );
AddReverseShiftOfObject( vecspaces, shifting_objects );


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

shifting_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

# matrix := -1*matrix;

return VectorSpaceMorphism( ShiftOfObject( Source( mor ) ), matrix, ShiftOfObject( Range( mor ) ) );

end;


reverse_shifting_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

# matrix := -1*matrix;

return VectorSpaceMorphism( ReverseShiftOfObject( Source( mor ) ), matrix, ReverseShiftOfObject( Range( mor ) ) );

end;

AddShiftOfMorphism( vecspaces, shifting_morphisms );
AddReverseShiftOfMorphism( vecspaces, reverse_shifting_morphisms );


additive_inverse_for_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

matrix := -1*matrix;

return VectorSpaceMorphism( Source( mor ) , matrix,  Range( mor )  );

end;

AddAdditiveInverseForMorphisms( vecspaces, additive_inverse_for_morphisms );



### some computations to see how everything works


 U:= QVectorSpace(1 );
 V:= QVectorSpace( 2 );
 W:= QVectorSpace( 1 );
 
 A:= QVectorSpace( 5 ); 
 B:= QVectorSpace( 7 ); 
 C:= QVectorSpace( 6 );
 
 XX:= QVectorSpace( 1 );
 YY:= QVectorSpace( 1 );
 ZZ:= QVectorSpace( 1 );
 
 UV:= VectorSpaceMorphism( U, [ [ 5, 0 ] ], V ); 
 VW:= VectorSpaceMorphism( V, [ [ 0 ], [ 6 ] ], W );
 WTU:= VectorSpaceMorphism(W, [ [ 0 ] ], ShiftOfObject( U ) );
 
 UV1:= VectorSpaceMorphism( U, [ [ 13, 1 ] ], V ); 
 VW1:= VectorSpaceMorphism( V, [ [ 0 ], [ 20 ] ], W );
 WTU1:= VectorSpaceMorphism(W, [ [ 0 ] ], ShiftOfObject( U ) );
 
 UV2:= VectorSpaceMorphism( U, [ [ 12, 0 ] ], V ); 
 VW2:= VectorSpaceMorphism( V, [ [ 0 ], [ 0 ] ], W );
 WTU2:= VectorSpaceMorphism(W, [ [ 2 ] ], ShiftOfObject( U ) );
 
 
 AB:= VectorSpaceMorphism( A, [ [ 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0 ],
 [ -5, 2, -93, 0, 0, 0, 0 ], [ -37, 85, -65, 0, 0, 0, 0 ], [ -76, 8, 86, 0, 0, 0, 0 ] ], B );
 BC:= VectorSpaceMorphism( B, [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
 [ -4, -17, 97, -9, 0, 0 ], [ -32, 67, 2, 57, 0, 0 ], [ 58, -87, 69, 5, 0, 0 ], 
  [ 76, 39, 57, -48, 0, 0 ] ], C );
 CTA := VectorSpaceMorphism( C, [ [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], 
 [ 66, 97, 0, 0, 0 ], [ -84, 44, 0, 0, 0 ] ], ShiftOfObject( A ) );
 
 AB1:= VectorSpaceMorphism( A, [ [ 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0 ], [ -35, 38, 52, 0, 0, 0, 0 ], [ 36, -19, -66, 0, 0, 0, 0 ], [ 24, -44, -17, 0, 0, 0, 0 ] ], B );
 BC1:= VectorSpaceMorphism( B, [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ -35, 49, 11, 56, 0, 0 ], [ 25, 77, 79, 27, 0, 0 ], [ 95, -3, -32, 98, 0, 0 ], 
  [ 76, 40, -95, 38, 0, 0 ] ], C );
 CTA1 := VectorSpaceMorphism( C, [ [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ -62, -98, 0, 0, 0 ], [ -49, -79, 0, 0, 0 ] ], ShiftOfObject( A ) );
 
 XXYY:= VectorSpaceMorphism( XX, [ [ 1 ] ], YY );
 YYZZ:= VectorSpaceMorphism( YY, [ [ 1 ] ], ZZ );
 ZZTXX:= VectorSpaceMorphism( ZZ, [ [ -2 ] ], ShiftOfObject( XX ) );
 
  UA:= VectorSpaceMorphism( U, [ [ 6,5,0,0,0 ] ], A );
  VB:= VectorSpaceMorphism( V,  [ [ 0,0,0,0,0,0,0 ], [ 3,1,2,3,4,5,6 ] ], B );
  WC:= VectorSpaceMorphism( W, [ [ 101, 8/3, 493/3, -31/3, 0, 0 ] ], C );
#  WC_:= VectorSpaceMorphism( W, [ [ 3 ] ], C );
#  
#  AXX:= VectorSpaceMorphism( A, [ [ 1 ], [ 1 ] ], XX );
#  BYY:= VectorSpaceMorphism( B, [ [ 0 ], [ 1 ] ], YY );
#  CZZ:= VectorSpaceMorphism( C, [ [ 1 ] ] ,ZZ );
#  
#  alpha:= VectorSpaceMorphism( U, [ [ 3, 4 ] ], V );
#  betta:= VectorSpaceMorphism( V, [ [ 7 ], [ 9 ] ], W );
#  gamma:= VectorSpaceMorphism( W, [ [ 12 ] ], ShiftOfObject( U ) );
#  delta:= VectorSpaceMorphism( W, [ [ -12 ] ], ShiftOfObject( U ) );
#  
#  
#  T:= CreateTriangle( alpha, betta, gamma );
#  S:= CreateTriangle( AB, BC, CTA );
#  S1:= CreateTriangle( AB1, BC1, CTA1 );
#  S2:= CreateTriangle( AB2, BC2, CTA2 );
#  M:= CreateTriangle( UV, VW, WTU );
#  M1:= CreateTriangle( UV1, VW1, WTU1 );
#  M2:= CreateTriangle( UV2, VW2, WTU2 );
# 
#   _T:= CreateExactTriangle( UV, VW, WTU );
#   _S:= CreateTriangle( AB, BC, CTA );
# #   m_T_S := CreateMorphismOfTriangles( _T, _S, UA, VB, WC );
#   
#  SetIsIsomorphism( UA, true );
#  SetIsIsomorphism( VB, true );
#  SetIsIsomorphism( WC, true );
# #  IsIsomorphism( m_T_S );





