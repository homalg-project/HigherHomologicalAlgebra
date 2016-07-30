


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
   
   
   else 
   
       Print( "'IsEqualForObjects' is not yet added." );
   
       return fail;
      
   fi;
     
   triangle:= rec( object1:= Source( mor1 ),
                   morphism1:= mor1,
                   object2:= Source( mor2 ),
                   morphism2:= mor2,
                   object3:= Source( mor3 ),
                   morphism3:= mor3,
                   object4:=  Range( mor3 ), 
                   iso_class:= [ ] 
                   
                 );
                   
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
   
      Error( "creating a triangle needs a shift functor" );
      
      
   fi;
   
   if not CanCompute( CapCategory( mor1 ), "IsEqualForObjects" ) then 
     
      Error( "'IsEqualForObjects' is not yet added.\n" );
   
   fi;
      
   if CapCategory( mor1 ) <> CapCategory( mor2) or CapCategory( mor2 ) <> CapCategory( mor3 ) then 
   
      return Error( "Morphisms are not in the same Category" );
      
   fi;
   
      
   if not IsEqualForObjects( Range( mor1 ), Source( mor2 ) ) or
              not IsEqualForObjects( Range( mor2 ), Source( mor3 ) ) or
                  not IsEqualForObjects( Range( mor3 ), ShiftOfObject( Source( mor1 ) ) ) then 
   
      Error( "Morphisms are not compatible" );
      
   fi;
   
   triangle:= rec( object1:= Source( mor1 ),
                   morphism1:= mor1,
                   object2:= Source( mor2 ),
                   morphism2:= mor2,
                   object3:= Source( mor3 ),
                   morphism3:= mor3,
                   object4:=  Range( mor3 ),
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


 InstallMethodWithCache( CreateMorphismOfTriangles, 
 
              [ IsCapCategoryTriangle, IsCapCategoryTriangle,
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
  
  # Are required methods are defined
  
     if not ForAll( [ "PreCompose", "IsEqualForObjects", "IsEqualForMorphisms" ], 
                    s-> CanCompute( category, s ) ) then 
                    
         Error( "'PreCompose', 'IsEqualForObjects' or 'IsEqualForMorphisms' is not yet Added" );
        
     fi;
  
  # Are Source and Range of all morphisms compatible?
  
   
  
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
  
  
  # Is the diagram commutative?

  
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
## Methods
##
##############################
 
InstallMethodWithCache( PreCompose, 
 
                 [ IsCapCategoryTrianglesMorphism, IsCapCategoryTrianglesMorphism ],
                 
 function( mor1, mor2 )
 local category;
 
 category:= CapCategory( mor1 );
 
 if not  category = CapCategory( mor2 ) then 
 
    Error( "The morphisms are not in the same category" );
    
 fi;
 
 if not CanCompute( category , "PreCompose" ) then 
 
    Error( "'PreCompose' for morphisms in ",category, " is not yet 'Add'ed." );
    
 fi;
 
 return CreateMorphismOfTriangles( Source( mor1), Range( mor2 ), PreCompose( mor1!.morphism11, mor2!.morphism11 ),
                                       PreCompose( mor1!.morphism22, mor2!.morphism22 ),
                                       PreCompose( mor1!.morphism33, mor2!.morphism33 )
                                 );

end );
 

## 
InstallMethodWithCache( PostCompose, 
 
                 [ IsCapCategoryTrianglesMorphism, IsCapCategoryTrianglesMorphism ],
                 
 function( mor2, mor1 )
 local category;
 
 category:= CapCategory( mor1 );
 
 if not  category = CapCategory( mor2 ) then 
 
    Error( "The morphisms are not in the same category" );
    
 fi;
 
 if not CanCompute( category , "PostCompose" ) then 
 
    Error( "'PostCompose' for morphisms in ",category, " is not yet 'Add'ed." );
    
 fi;
 
 return CreateMorphismOfTriangles( Source( mor1), Range( mor2 ), PostCompose( mor2!.morphism11, mor1!.morphism11 ),
                                       PostCompose( mor2!.morphism22, mor1!.morphism22 ),
                                       PostCompose( mor2!.morphism33, mor1!.morphism33 )
                                 );

end );

InstallMethodWithCache( IsEqualForTriangles,

                        [ IsCapCategoryTriangle, IsCapCategoryTriangle ],
                        
  function( trian1, trian2 )
  local category;

  category := CapCategory( trian1 );
  
  if category <> CapCategory( trian2 ) then 
  
    return false;
    
  fi;
   
  if CanCompute( category, "IsEqualForObjects" ) and CanCompute( category, "IsEqualForMorphisms" ) then
  
     return IsEqualForObjects( trian1!.object1, trian2!.object1 ) and 
            IsEqualForObjects( trian1!.object2, trian2!.object2 ) and 
            IsEqualForObjects( trian1!.object3, trian2!.object3 ) and 
            IsEqualForMorphisms( trian1!.morphism1, trian2!.morphism1 ) and 
            IsEqualForMorphisms( trian1!.morphism2, trian2!.morphism2 ) and 
            IsEqualForMorphisms( trian1!.morphism3, trian2!.morphism3 );
            
  else
     
    Error( "Either 'IsEqualForObjects' or 'IsEqualForMorphisms' is not yet added.\n" );
           
  fi;
 
end );

InstallMethod( IsIsomorphism, 
       
               [ IsCapCategoryTrianglesMorphism ], 
               
  function( mor )
  local t;
  
  if HasIsIsomorphism( mor!.morphism11 ) and 
          HasIsIsomorphism( mor!.morphism22 ) and 
             HasIsIsomorphism( mor!.morphism33 ) then 
             
       t:= IsIsomorphism( mor!.morphism11 ) and 
          IsIsomorphism( mor!.morphism22 ) and 
             IsIsomorphism( mor!.morphism33 );
             
       if t= true then 
             
              if not IsCapCategoryExactTriangle( mor!.triangle1 ) then 
      
                  Add( mor!.triangle1!.iso_class, mor!.triangle2 );
          
              fi;
      
              if not IsCapCategoryExactTriangle( mor!.triangle2 ) then 
      
                  Add( mor!.triangle2!.iso_class, mor!.triangle1 );
          
              fi;
            
        fi;
        
              return t; 
             
  elif
  
    not CanCompute( CapCategory( mor ), "IsIsomorphism" ) then 
  
    Error( "'IsIsomorphism' for category morphisms is not yet 'Add'ed" );
    
  elif  IsIsomorphism( mor!.morphism11 ) and 
          IsIsomorphism( mor!.morphism22 ) and 
             IsIsomorphism( mor!.morphism33 ) then 
                
      if not IsCapCategoryExactTriangle( mor!.triangle1 ) then 
      
          Add( mor!.triangle1!.iso_class, mor!.triangle2 );
          
      fi;
      
      if not IsCapCategoryExactTriangle( mor!.triangle2 ) then 
      
          Add( mor!.triangle2!.iso_class, mor!.triangle1 );
          
      fi;
      
      return true;
           
  else 
  
      return false;
      
  fi;
  
end );
  
##
InstallMethod( IsExactTriangleByAxioms, 
               [ IsCapCategoryTriangle ], 
               
 function( triangle )
 
 if IsCapCategoryExactTriangle( triangle ) then 
 
    return true;
    
 elif HasIsExactTriangle( triangle ) and IsExactTriangle( triangle ) then 
 
    return true;
    
 else
  
    return not ForAll( triangle!.iso_class, T-> not IsExactTriangleByAxioms( T ) );
 
 fi;
 
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
  
  Print( "\n\nobject1 is\n" ); Display( triangle!.object1 );
  
  Print( "\n\nmorphism1 is \n");Display( triangle!.morphism1 );
  
  Print( "\n\nobject2 is\n" );Display( triangle!.object2 );
  
  Print( "\n\nmorphism2 is \n");Display( triangle!.morphism2 );
  
  Print( "\n\nobject3 is\n" );Display( triangle!.object3 );
  
  Print( "\n\nmorphism3 is \n");Display( triangle!.morphism3 );
  
  Print( "\n\nShiftOfObject( object1 ) is \n" ); Display( ShiftOfObject( triangle!.object1 ) );
  
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
  Print( "\n--------------------------------" );
  Print( "\nTriangle2 is \n" );
  Display( morphism!.triangle2 );
  Print( "\n--------------------------------" );
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
  
  
  
       
       
       
       


