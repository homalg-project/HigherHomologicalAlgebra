


###############################
##
##  Representations
##
###############################

DeclareRepresentation( "IsCapCategoryExactTriangleRep",
                        IsCapCategoryExactTriangle and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryTriangleRep",
                        IsCapCategoryTriangle and IsAttributeStoringRep,
                        [ ] );
                        
##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryExactTrianglesFamily",
  NewFamily( "CapCategoryExactTrianglesFamily", IsCapCategoryCell ) );

BindGlobal( "CapCategoryTrianglesFamily",
  NewFamily( "CapCategoryTrianglesFamily", IsCapCategoryCell ) );
  

BindGlobal( "TheTypeCapCategoryExactTriangle", 
  NewType( CapCategoryExactTrianglesFamily, 
                      IsCapCategoryExactTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryTriangle", 
  NewType( CapCategoryTrianglesFamily, 
                      IsCapCategoryTriangleRep ) );

                      
###############################
##
##  
##
###############################

InstallValue( CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, rec( 

ShiftOfObject:= rec( 

installation_name := "ShiftOfObject", 
filter_list := [ "object" ],
cache_name := "ShiftOfObject",
return_type := "object" ),


ShiftOfMorphism:= rec( 

installation_name := "ShiftOfMorphism", 
filter_list := [ "morphism" ],
cache_name := "ShiftOfMorphism",
return_type := "morphism" ),

ReverseShiftOfObject:= rec( 

installation_name := "ReverseShiftOfObject", 
filter_list := [ "object" ],
cache_name := "ReverseShiftOfObject",
return_type := "object" ),


ReverseShiftOfMorphism:= rec( 

installation_name := "ReverseShiftOfMorphism", 
filter_list := [ "morphism" ],
cache_name := "ReverseShiftOfMorphism",
return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


####################################
##
##
##
####################################

InstallMethodWithCache( ApplyShift,
                        [ IsCapCategoryObject, IsInt ],
  function( obj, n )
  
  if n=0 then 
  
    return obj;
    
  elif n<0 then
  
    return ReverseShiftOfObject( ApplyShift( obj, n+1 ) );
    
  else 
  
    return ShiftOfObject( ApplyShift( obj, n-1 ) );
    
  fi;
  
end );

InstallMethodWithCache( ApplyShift,
                        [ IsCapCategoryMorphism, IsInt ],
  function( mor, n )
  
  if n=0 then 
  
    return mor;
    
  elif n<0 then
  
    return ReverseShiftOfMorphism( ApplyShift( mor, n+1 ) );
    
  else 
  
    return ShiftOfMorphism( ApplyShift( mor, n-1 ) );
    
  fi;
  
end );


####################################
##
## Constructors
##
####################################


InstallMethodWithCache( CreateTriangle, 
               [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
  
                      
function( mor1, mor2, mor3 )
   local  triangle;
   
   triangle:= rec( object1:= Source( mor1 ),
                   morphism12:= mor1,
                   object2:= Source( mor2 ),
                   morphism23:= mor2,
                   object3:= Source( mor3 ),
                   morphism34:= mor3,
                   object4:=  Range( mor3 ) );
                   
   ObjectifyWithAttributes( triangle, TheTypeCapCategoryTriangle );
   
   return triangle;
   
end );
   

