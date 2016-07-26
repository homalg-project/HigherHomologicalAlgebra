


###############################
##
##  Representations
##
###############################

DeclareRepresentation( "IsCapCategoryTriangleRep",
                        IsCapCategoryTriangle and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryExactTriangleRep",

                        IsCapCategoryExactTriangle and IsAttributeStoringRep,
                        [ ] );


##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryTrianglesFamily",
  NewFamily( "CapCategoryTrianglesFamily", IsObject ) );

BindGlobal( "CapCategoryExactTrianglesFamily",
  NewFamily( "CapCategoryExactTrianglesFamily", IsCapCategoryTriangle ) );

  
BindGlobal( "TheTypeCapCategoryTriangle", 
  NewType( CapCategoryTrianglesFamily, 
                      IsCapCategoryTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactTriangle", 
  NewType( CapCategoryExactTrianglesFamily, 
                      IsCapCategoryExactTriangleRep ) );
                      

                      
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

IsExactForTriangles:= rec( 

installation_name := "IsExactForTriangles", 
filter_list := [ IsCapCategoryTriangle ],
cache_name := "IsExactForTriangles",
return_type := "bool" ),


) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


####################################
##
## Methods
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

InstallMethod( IsExactTriangle, 
               [ IsCapCategoryTriangle ], 
               
IsExactForTriangles );

####################################
##
## Constructors
##
####################################

##
InstallMethodWithCache( CreateTriangle, 
               [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
  
                      
function( mor1, mor2, mor3 )
   local  triangle;
   
   if not CanCompute( CapCategory( mor1 ), "ShiftOfObject" ) then 
   
      return Error( "creating triangle needs a shift functor" );
      
   fi;
   
   if CapCategory( mor1 ) <> CapCategory( mor2) or CapCategory( mor2 ) <> CapCategory( mor3 ) then 
   
      return Error( "Morphisms are not in the same Category" );
      
   fi;
   
   
   if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) or
      not IsIdenticalObj( Range( mor2 ), Source( mor3 ) ) then 
      
      Error( "Morphisms are not compatible" );
      
   fi;
     
   triangle:= rec( object1:= Source( mor1 ),
                   morphism12:= mor1,
                   object2:= Source( mor2 ),
                   morphism23:= mor2,
                   object3:= Source( mor3 ),
                   morphism34:= mor3,
                   object4:=  Range( mor3 ) );
                   
   ObjectifyWithAttributes( triangle, TheTypeCapCategoryTriangle, 
                            CapCategory, CapCategory( mor1 )
   );
   
   return triangle;
   
end );
   

##
InstallMethodWithCache( CreateExactTriangle, 
               [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
  
                      
function( mor1, mor2, mor3 )
   local  triangle;
   
   if not CanCompute( CapCategory( mor1 ), "ShiftOfObject" ) then 
   
      return Error( "creating a triangle needs a shift functor" );
      
   fi;
   
   if CapCategory( mor1 ) <> CapCategory( mor2) or CapCategory( mor2 ) <> CapCategory( mor3 ) then 
   
      return Error( "Morphisms are not in the same Category" );
      
   fi;
   
   
   if CanCompute( CapCategory( mor1 ), "IsEqualForObjects" ) then 
   
      
       if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) or
              not IsEqualForObjects( Range( mor2 ), Source( mor3 ) ) then 
      
        Error( "Morphisms are not compatible" );
      
       fi;
   
   
   elif not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) or
            not IsIdenticalObj( Range( mor2 ), Source( mor3 ) ) then 
      
       Error( "Morphisms are not compatible." );
      
   fi;
   
   triangle:= rec( object1:= Source( mor1 ),
                   morphism12:= mor1,
                   object2:= Source( mor2 ),
                   morphism23:= mor2,
                   object3:= Source( mor3 ),
                   morphism34:= mor3,
                   object4:=  Range( mor3 ) );
                   
   ObjectifyWithAttributes( triangle, TheTypeCapCategoryExactTriangle,
                            CapCategory, CapCategory( mor1 ) 
   );
   
   SetIsExactTriangle( triangle, true );
   
   return triangle;
   
end );

InstallMethodWithCache( CreateExactTriangle,
                        [  IsCapCategoryTriangle ], 
                        
  function( triangle )
  
  return CreateExactTriangle( triangle!.morphism12, triangle!.morphism23, triangle!.morphism34 );
  
end );
  
##############################
##
## View
##
##############################

InstallMethod( ViewObj,
               
               [ IsCapCategoryExactTriangle ], 
               
  function( triangle )
  
  Print( "< An Exact triangle in ", CapCategory( triangle ), " >" );

end );
  
InstallMethod( ViewObj,
               
               [ IsCapCategoryTriangle ], 
               
  function( triangle )
  
  Print( "< An triangle in ", CapCategory( triangle ), " >" );

end );
  
  
  


