###################################################################################
##                                                                               ##
## Giving rational vector spaces category a structure of a triangulated category ##
##                                                                               ##
###################################################################################

## ReadPackage( "TriangulatedCategoriesForCAP", "examples/VectorSpacesTriangulatedCategory.gi" );

######################################
##
##  Loading needed packages
##
######################################

LoadPackage( "MatricesForHomalg" );

LoadPackage( "Gauss" );

LoadPackage( "GaussForHomalg" );

LoadPackage( "LinearAlgebraForCap" );

LoadPackage( "TriangulatedCategoriesForCap" );

########################################
##
## Declarations, Representations ...
##
########################################


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

## Attributes 


DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );
 
DeclareAttribute( "AsSpaceInMatrixCategory", IsHomalgRationalVectorSpaceRep ); 

DeclareAttribute( "AsMorphismInMatrixCategory", IsHomalgRationalVectorSpaceMorphismRep );


##  Methods

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );
 
DeclareOperation( "QVectorSpace",
                  [ IsVectorSpaceObject ] );


DeclareOperation( "QVectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );
                  
DeclareOperation( "QVectorSpaceMorphism",
                  [ IsVectorSpaceMorphism ] );

#################################
##
## Creation of category
##
#################################
 
BindGlobal( "vecspaces", CreateCapCategory( "VectorSpaces" ) );

# SetIsAbelianCategory( vecspaces, true );

BindGlobal( "Q", HomalgFieldOfRationals( ) );

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
                             Dimension, dim,
                             AsSpaceInMatrixCategory, VectorSpaceObject( dim, Q )
    );
    
    Add( vecspaces, space );
    
    return space;
    
end );

InstallMethod( QVectorSpace, 
              [ IsVectorSpaceObject ], 
         
   function( space )
   
    return QVectorSpace( Dimension( space ) );
    
end );

InstallMethod( QVectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism, homalg_matrix;

    if not IsHomalgMatrix( matrix ) then
    
      homalg_matrix := HomalgMatrix( matrix, Dimension( source ), Dimension( range ), Q );

    else

      homalg_matrix := matrix;

    fi;

    if NrRows( homalg_matrix ) <> Dimension( source ) or NrColumns( homalg_matrix ) <> Dimension( range ) then 
                             
      Error( "The inputs are not compatible" );
    
    fi;
    
    morphism := rec( morphism := homalg_matrix );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                      Source, source,
                      Range, range,
                      AsMorphismInMatrixCategory, VectorSpaceMorphism(  AsSpaceInMatrixCategory( source ), homalg_matrix, AsSpaceInMatrixCategory( range ) )
    );

    Add( vecspaces, morphism );
    
    return morphism;
    
end );

InstallMethod( QVectorSpaceMorphism,
               [ IsVectorSpaceMorphism ], 
               
 function( morphism )
 
 return QVectorSpaceMorphism( QVectorSpace( Source( morphism ) ), morphism!.UnderlyingMatrix, QVectorSpace( Range( morphism ) ) );
              
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

    Print( "Q^(1 X ", String( Dimension( obj ) ),") as an object in ",vecspaces );

end );

InstallMethod( Display,
               [ IsHomalgRationalVectorSpaceMorphismRep ],

  function( mor )

    
    Print( "A rational vector space homomorphism ",
    "Q^(1 X ", String( Dimension( Source( mor ) ) ), ") --> ",
    "Q^(1 X ", String( Dimension( Range( mor ) ) ),
    
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

    return QVectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), Q ), obj );
    
end;

AddIdentityMorphism( vecspaces, identity_morphism );

##
pre_compose := function( mor_left, mor_right )
    local composition;

    composition := mor_left!.morphism * mor_right!.morphism;

    return QVectorSpaceMorphism( Source( mor_left ), composition, Range( mor_right ) );

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
                         
                         if not IsEvenInt( Dimension( trian!.object1 ) + Dimension( trian!.object2 ) - Dimension( trian!.object3 ) ) then 
                         
                             return false;
                             
                         fi;
                         
                         f:= AsMorphismInMatrixCategory( trian!.morphism1 );
                         g:= AsMorphismInMatrixCategory( trian!.morphism2 );
                         h:= AsMorphismInMatrixCategory( trian!.morphism3 );
                         
                         if not IsZeroForMorphisms( PreCompose( f, g ) ) or 
                            not IsZeroForMorphisms( PreCompose( g, h ) ) or 
                            not IsZeroForMorphisms( PreCompose( h, f ) ) then 
                            
                            return false;
                            
                        fi;
                        
                        ## in abelian categories, for f:A ---> B we have
                        ## im( f )   = ker( coker( f ) )
                        ## coim( f ) = coker( ker( f ) )
                        
                        if not Dimension( KernelObject( g ) ) = Dimension( KernelObject( CokernelProjection( f ) ) ) or
                           not Dimension( KernelObject( h ) ) = Dimension( KernelObject( CokernelProjection( g ) ) ) or
                           not Dimension( KernelObject( f ) ) = Dimension( KernelObject( CokernelProjection( h ) ) ) then
                           
                           return false;
                           
                        fi;
                        
                        return true;                        
end;
                         
AddIsExactForTriangles( vecspaces, is_exact_for_triangles );                       


tr1 := function( mor )
       local f,ker_f, m, f1,n,f2,g1,t,C,G2,g2,g,h1,h;
       
       f := AsMorphismInMatrixCategory( mor );
       
       ker_f:= KernelEmbedding( f );
       m := Dimension( KernelObject( f ) );
       
       f1:= CokernelProjection( ker_f );
       n:= Dimension( CokernelObject ( ker_f ) );
       
       f2:= CokernelColift( ker_f, f );
       
       g1:= CokernelProjection( f );
       t:= Dimension( CokernelObject( f ) );
       
       C :=  VectorSpaceObject( t+m, Q );
       
       G2 := TransposedMat( Concatenation( IdentityMat( t ), NullMat( m, t ) ) );
       G2 := HomalgMatrix( G2, t, m+t, Q );
       
       g2:= VectorSpaceMorphism( Range( g1 ), G2, C );
       g := PreCompose( g1, g2 );
       
       h1 := CokernelProjection( g );
       h := PreCompose( h1, ker_f );
       
       return [ QVectorSpaceMorphism( g ), QVectorSpace( C ), QVectorSpaceMorphism( h ) ];
       
       end;
       
AddTR1( vecspaces, tr1 );


tr3:= function( t1, t2, u_, v_ )
      local f,g,h,h2,h1,f_,g_,h_,h_2,h_1, beta,u,v, bar_H_1, bar_h_1,g1,g2, bar_G2, bar_g2, g_1,g_2, alpha, part1, part2, w; 
      
      f:= AsMorphismInMatrixCategory( t1!.morphism1 );
      g:= AsMorphismInMatrixCategory( t1!.morphism2 );
      h:= AsMorphismInMatrixCategory( t1!.morphism3 );
      
      h2:= KernelEmbedding( f );
      h1:= KernelLift( f, h );     
      
      f_:= AsMorphismInMatrixCategory( t2!.morphism1 );
      g_:= AsMorphismInMatrixCategory( t2!.morphism2 );
      h_:= AsMorphismInMatrixCategory( t2!.morphism3 );
      
      h_2:= KernelEmbedding( f_ );
      h_1:= KernelLift( f_, h_ );     
      
      u:= AsMorphismInMatrixCategory( u_ );
      v:= AsMorphismInMatrixCategory( v_ );
      
      beta := KernelLift( f_, PreCompose( h2, u ) );
      bar_H_1 := RightDivide( HomalgIdentityMatrix( Dimension( Range( h_1 ) ), Q ), h_1!.UnderlyingMatrix );
      bar_h_1 := VectorSpaceMorphism( Range( h_1 ), bar_H_1, Source( h_1 ) );
      
      g1:= CokernelProjection( f );
      g2:= CokernelColift( f, g );
      
      bar_G2 := LeftDivide( g2!.UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Source( g2 ) ), Q ) );
      bar_g2 := VectorSpaceMorphism( Range( g2 ), bar_G2, Source( g2 ) );
      
      g_1:= CokernelProjection( f_ );
      g_2:= CokernelColift( f_, g_ );
      
      alpha := CokernelColift( f, PreCompose( v, g_1 ) );
      
      part1:= PreCompose( PreCompose( bar_g2, alpha ), g_2 );
      part2:= PreCompose( PreCompose( h1, beta ), bar_h_1 );
      
      w:= part1+part2;
      
#       return [ h2, h1, h_2, h_1, beta, bar_h_1, g1, g2, bar_g2, g_1,g_2, alpha, w ];

      return QVectorSpaceMorphism( w );
      
end;

AddTR3( vecspaces, tr3 );


tr4:= function( f, g )
      local i,j,T, S, W, N, u,v, w;
      
      T := CompleteMorphismToExactTriangleByTR1( f );
      
      S := CompleteMorphismToExactTriangleByTR1( PreCompose( f, g ) );
      
      u := TR3( T, S, IdentityMorphism( Source( f ) ), g );
      
      W := CompleteMorphismToExactTriangleByTR1( g );
      
      v := TR3( S, W, f, IdentityMorphism( Range( g ) ) );
      
      j:= T!.morphism2;
      i:= W!.morphism3;
      
      w:= PreCompose( i, ShiftOfMorphism( j ) );
      
      return [T, S, W, CreateExactTriangle( u, v, w ) ];
      
      end;
      
      
      


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
#  return QVectorSpaceMorphism( new_source, matr, new_range );
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
#    return QVectorSpaceMorphism( new_source, matr, new_range );
# 
# end;

shifting_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

# matrix := -1*matrix;

return QVectorSpaceMorphism( ShiftOfObject( Source( mor ) ), matrix, ShiftOfObject( Range( mor ) ) );

end;


reverse_shifting_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

# matrix := -1*matrix;

return QVectorSpaceMorphism( ReverseShiftOfObject( Source( mor ) ), matrix, ReverseShiftOfObject( Range( mor ) ) );

end;

AddShiftOfMorphism( vecspaces, shifting_morphisms );
AddReverseShiftOfMorphism( vecspaces, reverse_shifting_morphisms );


additive_inverse_for_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

matrix := -1*matrix;

return QVectorSpaceMorphism( Source( mor ) , matrix,  Range( mor )  );

end;

AddAdditiveInverseForMorphisms( vecspaces, additive_inverse_for_morphisms );



### some computations to see how everything works

A:= QVectorSpace( 3 );
B:= QVectorSpace( 4 );
f := QVectorSpaceMorphism( A, [ [2,3,4,0], [ 2,0,0,1 ], [ 0, 3, 4, -1 ] ], B );

A_ := QVectorSpace( 4 );
B_ := QVectorSpace( 2 );

f_ := QVectorSpaceMorphism( A_, [ [2,1], [ 4,2 ], [ 2,1 ], [ 2,1] ], B_ );

AA_ := QVectorSpaceMorphism( A, 2*[ [2,3,4,0], [ 2,0,0,1 ], [ 0, 3, 4, -1 ] ], A_ );
BB_ := QVectorSpaceMorphism( B, 2*[ [2,1], [ 4,2 ], [ 2,1 ], [ 2,1] ], B_ );

T:= CompleteMorphismToExactTriangleByTR1( f );
T_ := CompleteMorphismToExactTriangleByTR1( f_ );
pppp:= tr3( T, T_, AA_, BB_ );


# 
#  U:= QVectorSpace(1 );
#  V:= QVectorSpace( 2 );
#  W:= QVectorSpace( 1 );
#  
#  A:= QVectorSpace( 5 ); 
#  B:= QVectorSpace( 7 ); 
#  C:= QVectorSpace( 6 );
#  
#  XX:= QVectorSpace( 1 );
#  YY:= QVectorSpace( 1 );
#  ZZ:= QVectorSpace( 1 );
#  
#  UV:= QVectorSpaceMorphism( U, [ [ 5, 0 ] ], V ); 
#  VW:= QVectorSpaceMorphism( V, [ [ 0 ], [ 6 ] ], W );
#  WTU:= QVectorSpaceMorphism(W, [ [ 0 ] ], ShiftOfObject( U ) );
#  
#  UV1:= QVectorSpaceMorphism( U, [ [ 13, 1 ] ], V ); 
#  VW1:= QVectorSpaceMorphism( V, [ [ 0 ], [ 20 ] ], W );
#  WTU1:= QVectorSpaceMorphism(W, [ [ 0 ] ], ShiftOfObject( U ) );
#  
#  UV2:= QVectorSpaceMorphism( U, [ [ 12, 0 ] ], V ); 
#  VW2:= QVectorSpaceMorphism( V, [ [ 0 ], [ 0 ] ], W );
#  WTU2:= QVectorSpaceMorphism(W, [ [ 2 ] ], ShiftOfObject( U ) );
#  
#  
#  AB:= QVectorSpaceMorphism( A, [ [ 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0 ],
#  [ -5, 2, -93, 0, 0, 0, 0 ], [ -37, 85, -65, 0, 0, 0, 0 ], [ -76, 8, 86, 0, 0, 0, 0 ] ], B );
#  BC:= QVectorSpaceMorphism( B, [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
#  [ -4, -17, 97, -9, 0, 0 ], [ -32, 67, 2, 57, 0, 0 ], [ 58, -87, 69, 5, 0, 0 ], 
#   [ 76, 39, 57, -48, 0, 0 ] ], C );
#  CTA := QVectorSpaceMorphism( C, [ [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], 
#  [ 66, 97, 0, 0, 0 ], [ -84, 44, 0, 0, 0 ] ], ShiftOfObject( A ) );
#  
#  AB1:= QVectorSpaceMorphism( A, [ [ 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0 ], [ -35, 38, 52, 0, 0, 0, 0 ], [ 36, -19, -66, 0, 0, 0, 0 ], [ 24, -44, -17, 0, 0, 0, 0 ] ], B );
#  BC1:= QVectorSpaceMorphism( B, [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ -35, 49, 11, 56, 0, 0 ], [ 25, 77, 79, 27, 0, 0 ], [ 95, -3, -32, 98, 0, 0 ], 
#   [ 76, 40, -95, 38, 0, 0 ] ], C );
#  CTA1 := QVectorSpaceMorphism( C, [ [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ -62, -98, 0, 0, 0 ], [ -49, -79, 0, 0, 0 ] ], ShiftOfObject( A ) );
#  
#  XXYY:= QVectorSpaceMorphism( XX, [ [ 1 ] ], YY );
#  YYZZ:= QVectorSpaceMorphism( YY, [ [ 1 ] ], ZZ );
#  ZZTXX:= QVectorSpaceMorphism( ZZ, [ [ -2 ] ], ShiftOfObject( XX ) );
#  
#   UA:= QVectorSpaceMorphism( U, [ [ 6,5,0,0,0 ] ], A );
#   VB:= QVectorSpaceMorphism( V,  [ [ 0,0,0,0,0,0,0 ], [ 3,1,2,3,4,5,6 ] ], B );
#   WC:= QVectorSpaceMorphism( W, [ [ 101, 8/3, 493/3, -31/3, 0, 0 ] ], C );
#  WC_:= QVectorSpaceMorphism( W, [ [ 3 ] ], C );
#  
#  AXX:= QVectorSpaceMorphism( A, [ [ 1 ], [ 1 ] ], XX );
#  BYY:= QVectorSpaceMorphism( B, [ [ 0 ], [ 1 ] ], YY );
#  CZZ:= QVectorSpaceMorphism( C, [ [ 1 ] ] ,ZZ );
#  
#  alpha:= QVectorSpaceMorphism( U, [ [ 3, 4 ] ], V );
#  betta:= QVectorSpaceMorphism( V, [ [ 7 ], [ 9 ] ], W );
#  gamma:= QVectorSpaceMorphism( W, [ [ 12 ] ], ShiftOfObject( U ) );
#  delta:= QVectorSpaceMorphism( W, [ [ -12 ] ], ShiftOfObject( U ) );
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





