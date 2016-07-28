


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

DeclareRepresentation( "IsCapCategoryTrianglesMorphismRep",

                        IsCapCategoryTrianglesMorphism and IsAttributeStoringRep, 
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

BindGlobal( "CapCategoryTrianglesMorphismsFamily",
  NewFamily( "CapCategoryTrianglesMorphismsFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryTriangle", 
  NewType( CapCategoryTrianglesFamily, 
                      IsCapCategoryTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactTriangle", 
  NewType( CapCategoryExactTrianglesFamily, 
                      IsCapCategoryExactTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryTrianglesMorphism", 
  NewType( CapCategoryTrianglesMorphismsFamily, 
                      IsCapCategoryTrianglesMorphismRep ) );
                      
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
   
   
   if CanCompute( CapCategory( mor1 ), "IsEqualForObjects" ) then 
   
      
       if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) or
              not IsEqualForObjects( Range( mor2 ), Source( mor3 ) ) or
                  not IsEqualForObjects( Range( mor3 ), ShiftOfObject( Source( mor1 ) ) ) then 
      
        Error( "Morphisms are not compatible" );
      
       fi;
   
   
   elif not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) or
            not IsIdenticalObj( Range( mor2 ), Source( mor3 ) ) or
                  not IsIdenticalObj( Range( mor3 ), ShiftOfObject( Source( mor1 ) ) ) then 
      
       Error( "Morphisms are not compatible." );
      
   fi;
     
   triangle:= rec( object1:= Source( mor1 ),
                   morphism1:= mor1,
                   object2:= Source( mor2 ),
                   morphism2:= mor2,
                   object3:= Source( mor3 ),
                   morphism3:= mor3,
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
              not IsEqualForObjects( Range( mor2 ), Source( mor3 ) ) or
                  not IsEqualForObjects( Range( mor3 ), ShiftOfObject( Source( mor1 ) ) ) then 
      
        Error( "Morphisms are not compatible" );
      
       fi;
   
   
   elif not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) or
            not IsIdenticalObj( Range( mor2 ), Source( mor3 ) ) or
                  not IsIdenticalObj( Range( mor3 ), ShiftOfObject( Source( mor1 ) ) ) then 
      
       Error( "Morphisms are not compatible." );
      
   fi;
   
   triangle:= rec( object1:= Source( mor1 ),
                   morphism1:= mor1,
                   object2:= Source( mor2 ),
                   morphism2:= mor2,
                   object3:= Source( mor3 ),
                   morphism3:= mor3,
                   object4:=  Range( mor3 ) 
                   
                 );
                   
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


 InstallMethod( CreateMorphismOfTriangles, 
 
              [ IsCapCategoryExactTriangle, IsCapCategoryTriangle,
              IsCapCategoryMorphism, IsCapCategoryMorphism, 
                      IsCapCategoryMorphism ], 
              
  function( triangle1, triangle2, morphism11, morphism22, morphism33 )
  local category, morphism;
  
  category := CapCategory( triangle1 );
  
  # Are all inputs in the same category?
  if not ForAll( [ triangle2, morphism11, morphism22, morphism33 ], 
                 i-> CapCategory( i ) = category ) then 
                 
        Error( "Some inputs are not in the same category" );
      
  fi;
  
  # Are Source and Range of all morphisms compatible?
  
  if CanCompute( category, "IsEqualForObjects" ) then 
  
     if not IsEqualForObjects( Source( morphism11 ), triangle1!.object1 ) or 
        not IsEqualForObjects( Range( morphism11 ), triangle2!.object1 )  then 
        
        Error( "The third input is not compatible with the triangles" );
        
     fi;
     
     if not IsEqualForObjects( Source( morphism22 ), triangle1!.object2 ) or 
        not IsEqualForObjects( Range( morphism22 ), triangle2!.object2 )  then 
        
        Error( "The 4'th input is not compatible with the triangles" );
     
     fi;
     
     if not IsEqualForObjects( Source( morphism33 ), triangle1!.object3 ) or 
        not IsEqualForObjects( Range( morphism33 ), triangle2!.object3 )  then 
        
        Error( "The 5'th input is not compatible with the triangles" );
     
     fi;
     
  else 
     
     if not IsIdenticalObj( Source( morphism11 ), triangle1!.object1 ) or 
        not IsIdenticalObj( Range( morphism11 ), triangle2!.object1 )  then 
        
        Error( "The third input is not compatible with the triangles" );
        
     fi;
     
     if not IsIdenticalObj( Source( morphism22 ), triangle1!.object2 ) or 
        not IsIdenticalObj( Range( morphism22 ), triangle2!.object2 )  then 
        
        Error( "The 4'th input is not compatible with the triangles" );
     
     fi;
     
     if not IsIdenticalObj( Source( morphism33 ), triangle1!.object3 ) or 
        not IsIdenticalObj( Range( morphism33 ), triangle2!.object3 )  then 
        
        Error( "The 5'th input is not compatible with the triangles" );
     
     fi;
     
  fi;
  
  
  # Is the diagram commutative?
  
  if not CanCompute( category, "IsEqualForMorphisms" ) or 
     not CanCompute( category, "PreCompose" ) then 
     
     Error( "It can not be determined if the diagram is commutative or not, since either PreCompose or IsEqualForMorphisms is not yet 'Add'ed." );
     
  else 
  
     if not IsEqualForMorphisms( PreCompose( triangle1!.morphism1, morphism22 ), PreCompose( morphism11, triangle2!.morphism1 ) ) then
     
        Error( "The first squar is not commutative" );
        
     fi;
     
     if not IsEqualForMorphisms( PreCompose( triangle1!.morphism2, morphism33 ), PreCompose( morphism22, triangle2!.morphism2 ) ) then
     
        Error( "The second squar is not commutative" );
        
     fi;
     
     if not IsEqualForMorphisms( PreCompose( triangle1!.morphism3, ShiftOfMorphism( morphism11) ), 
                                 PreCompose( morphism33, triangle2!.morphism3 ) ) then
     
        Error( "The third squar is not commutative" );
        
     fi;
     
     
  fi;
  
  morphism := rec( triangle1:= triangle1,
                   
                   triangle2:= triangle2,
                   
                   morphism11:= morphism11,
                   
                   morphism22:= morphism22,
                   
                   morphism33:= morphism33 
                   
                 );
                 
  ObjectifyWithAttributes( morphism, TheTypeCapCategoryTrianglesMorphism,
                           Source, triangle1,
                           Range, triangle2,
                           CapCategory, category
                         );
  
  return morphism;
  
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
  
InstallMethod( ViewObj, 

               [ IsCapCategoryTrianglesMorphism ], 
               
  function( morphism )
  
  Print( "< A morphism of triangles in ", CapCategory( morphism ), " >" );
  
end );
  
##############################
##
## Display
##
##############################


InstallMethod( Display, 

        [ IsCapCategoryTriangle ],
        
  function( triangle )
    
  Print( "object1 --(morphism1)--> object2 --(morphism2)--> object3 --(morphism3)--> ShiftOfObject( object1 )\n" );
  
  Print( "\nobject1 is\n" ); Display( triangle!.object1 );
  
  Print( "\nmorphism1 is \n");Display( triangle!.morphism1 );
  
  Print( "\nobject2 is\n" );Display( triangle!.object2 );
  
  Print( "\nmorphism2 is \n");Display( triangle!.morphism2 );
  
  Print( "\nobject3 is\n" );Display( triangle!.object3 );
  
  Print( "\nmorphism3 is \n");Display( triangle!.morphism3 );
  
  Print( "\nShiftOfObject( object1 ) is \n" ); Display( ShiftOfObject( triangle!.object1 ) );
  
end );

InstallMethod( Display, 

       [ IsCapCategoryTrianglesMorphism ],
   
  function( morphism )
  
  Print( "A morphism of triangles:\n");

  Print( "Triangle1: object1 --(morphism1)--> object2 --(morphism2)--> object3 --(morphism3)--> ShiftOfObject( object1 ) \n" );
  Print( "              |                        |                        |                              |               \n" );
  Print( "              |                        |                        |                              |               \n" );
  Print( "          morphism11               morphism22               morphism33            ShiftOfMorphism( morphism11 )\n" );
  Print( "              |                        |                        |                              |               \n" );
  Print( "              |                        |                        |                              |               \n" );
  Print( "              V                        V                        V                              V               \n" );
  Print( "Triangle2: object1 --(morphism1)--> object2 --(morphism2)--> object3 --(morphism3)--> ShiftOfObject( object1 ) \n" );
  Print( "\n--------------------------------\n" );
  Print( "Triangle1 is \n" );
  Display( morphism!.triangle1 );
  Print( "--------------------------------" );
  Print( "\nTriangle2 is \n" );
  Display( morphism!.triangle2 );
  Print( "--------------------------------" );
  Print( "\nMorphism11\n" );
  Display( morphism!.morphism11 );
  Print( "--------------------------------" );
  Print( "\nMorphism22\n" );
  Display( morphism!.morphism22 );
  Print( "--------------------------------" );
  Print( "\nMorphism33\n" );
  Display( morphism!.morphism33 );
  Print( "--------------------------------" );
  Print( "\nShiftOfMorphism( morphism11 )\n" );
  Display( ShiftOfMorphism( morphism!.morphism11 ) );
  Print( "--------------------------------" );
  
end );
  
  
  
       
       
       
       


