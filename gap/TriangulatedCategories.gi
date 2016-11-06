


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

IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject := rec( 

installation_name := "IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject",
filter_list := [ "object" ],
cache_name := "IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject",
return_type := "morphism",
post_function := function( obj, return_value )
                 
                 if not IsEqualForObjects( obj, Source( return_value ) ) then 
                 
                    Error( "the source of the morphism computed by the given method does not equal the input object" );
                    
                 elif not IsEqualForObjects( ShiftOfObject( ReverseShiftOfObject( obj ) ), Range( return_value ) ) then
                 
                    Error( "the range of the morphism computed by the given method does not equal ShiftOfObject( ReverseShiftOfObject( input ) )" );
                 
                 fi;
                 
                 end ),

IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject := rec( 

installation_name := "IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject",
filter_list := [ "object" ],
cache_name := "IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject",
return_type := "morphism",
post_function := function( obj, return_value )
                 
                 if not IsEqualForObjects( obj, Source( return_value ) ) then 
                 
                    Error( "the source of the morphism computed by the given method does not equal the input object" );
                    
                 elif not IsEqualForObjects( ReverseShiftOfObject( ShiftOfObject( obj ) ), Range( return_value ) ) then
                 
                    Error( "the range of the morphism computed by the given method does not equal ReverseShiftOfObject( ShiftOfObject( input ) )" );
                 
                 fi;
                 
                 end ),

IsExactForTriangles:= rec( 

installation_name := "IsExactForTriangles", 
filter_list := [ IsCapCategoryTriangle ],
cache_name := "IsExactForTriangles",
return_type := "bool" ),

TR1:= rec(

installation_name := "TR1", 
filter_list := [ "morphism" ],
cache_name := "TR1",
return_type := [ "morphism", "object", "morphism" ] ),

CompleteMorphismToExactTriangleByTR1:= rec(

installation_name := "CompleteMorphismToExactTriangleByTR1", 
filter_list := [ "morphism" ],
cache_name := "CompleteMorphismToExactTriangleByTR1",
return_type := [ IsCapCategoryExactTriangle ] ),

TR3:= rec(

 installation_name := "TR3", 
 filter_list := [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, "morphism", "morphism" ],
 cache_name := "TR3",

   pre_function:= function( T1, T2, alpha, betta )
                 local mor1, mor2, is_equal_for_morphisms;
                 
                 mor1 := PreCompose( T1!.morphism1, betta );
                 mor2 := PreCompose( alpha, T2!.morphism1 );
                 
                 is_equal_for_morphisms := IsEqualForMorphisms( mor1, mor2 );
                 
                 if is_equal_for_morphisms = fail then
      
                     return [ false, "cannot decide whether the first squar is commutative" ];
      
                 elif is_equal_for_morphisms = false then
        
                     return [ false, "The first squar is not commutative" ];
        
                fi;
    
                return [ true ];
               
                end,
  
 return_type := "morphism"
#  ,
#    post_function := function( T1, T2, alpha, betta, return_value )
#                    local mor1, mor2, is_equal_for_morphisms;
#                    
#                    if not IsCapCategoryMorphism( return_value ) then 
#                    
#                       Error( "The function used by defining TR3 should return a morphism" );
#                       
#                    fi;
#                    
#                    mor1 := PreCompose( T1!.morphism2, return_value );
#                    mor2 := PreCompose( betta, T2!.morphism2 );
#                  
#                   is_equal_for_morphisms := IsEqualForMorphisms( mor1, mor2 );
#                  
#                   if is_equal_for_morphisms = fail then
#       
#                      Error( "cannot decide whether the second squar is commutative" );
#       
#                   elif is_equal_for_morphisms = false then
#         
#                      Error( "The second squar is not commutative" );
#         
#                   fi;
#       
#                   mor1 := PreCompose( T1!.morphism3, ShiftOfMorphism( alpha ) );
#                   mor2 := PreCompose( return_value, T2!.morphism3 );
#                  
#                   is_equal_for_morphisms := IsEqualForMorphisms( mor1, mor2 );
#                  
#                   if is_equal_for_morphisms = fail then
#       
#                      Error( "cannot decide whether the third squar is commutative" );
#       
#                   elif is_equal_for_morphisms = false then
#         
#                      Error( "The third squar is not commutative" );
#         
#                   fi;
#       
#       
#                   end 
                    ),

## pre and post functions to be added ...
CompleteToMorphismOfExactTrianglesByTR3:= rec(

installation_name := "CompleteToMorphismOfExactTrianglesByTR3", 
filter_list := [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, "morphism", "morphism", IsList ],
cache_name := "CompleteToMorphismOfExactTrianglesByTR3",
return_type := [ IsCapCategoryTrianglesMorphism ] ),
                
TR4:= rec(

installation_name := "TR4", 
filter_list := [ "morphism", "morphism" ],
cache_name := "TR4",

pre_function := function( alpha, betta )

                if not IsEqualForObjects( Range( alpha ), Source( betta ) ) then 
                
                   return [ false, "the given morphisms are not composable" ];
                   
                fi;
                
                
                return [ true ];
                
                end,
                
return_type := [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryExactTriangle ], 

post_function := function( alpha, betta, return_value )
                 local j,k,l,i,m,n,u,v,w;
                 
                 l:= return_value[ 2 ]!.morphism2;
                 
                 v:= return_value[ 4 ]!.morphism2;
                 
                 m:= return_value[ 3 ]!.morphism2;
                 
                 if not IsEqualForMorphisms( l, PreCompose( m, v ) ) then 
                 
                    Error( "Construction of TR4 can not be true." );
                 
                 fi;
                 
                 
                 k:= return_value[ 1 ]!.morphism3;
                 
                 n:= return_value[ 3 ]!.morphism3;
                 
                 u:= return_value[ 4 ]!.morphism1;
 
                 if not IsEqualForMorphisms( k, PreCompose( u, n ) ) then 
                 
                    Error( "Construction of TR4 can not be true.." );
                 
                 fi;
                 
                 w:= return_value[ 4 ]!.morphism3;
                 
                 j:= return_value[ 1 ]!.morphism2;
                 
                 i:= return_value[ 2 ]!.morphism3;
                 
                 if not IsEqualForMorphisms( w, PreCompose( i, ShiftOfMorphism( j ) ) ) then 
                 
                    Error( "Construction of TR4 can not be true..." );
                 
                 fi;
                 
                 if not IsEqualForMorphisms( PreCompose( v, i ), PreCompose( n, ShiftOfMorphism( alpha ) ) ) then 
                 
                    Error( "Construction of TR4 can not be true...." );
                 
                 fi;
                 
                 if not IsEqualForMorphisms( PreCompose( j, u ), PreCompose( betta, m ) ) then 
                 
                    Error( "Construction of TR4 can not be true....." );
                 
                 fi;
                 
end ),


                
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
function( triangle )

if not IsExactTriangleByAxioms( triangle )=fail then 

    return IsExactTriangleByAxioms( triangle );
    
else 

    return IsExactForTriangles( triangle );
    
fi;

end );

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
   
   Add( triangle!.iso_class, triangle );
   
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
                   iso_class:= [ ]
                 );
                   
   ObjectifyWithAttributes( triangle, TheTypeCapCategoryExactTriangle,
                            CapCategory, CapCategory( mor1 ) 
   );
   
   SetIsExactTriangle( triangle, true );
   
   Add( triangle!.iso_class, triangle );
   
   return triangle;
   
end );


InstallMethodWithCache( ConeObject,
                       
                       [  IsCapCategoryMorphism ], 
                        
  function( mor )
  local cone;
  
  cone:= TR1( mor );
  
  return cone[ 2 ];
  
end );

##
InstallMethodWithCache( CreateExactTriangle,
                        [  IsCapCategoryTriangle ], 
                        
  function( triangle )
  
  if HasIsExactTriangle( triangle ) then 
  
     if IsExactTriangle( triangle ) then 
     
         ObjectifyWithAttributes( triangle, TheTypeCapCategoryExactTriangle );
         
     else 
     
         Error( "The given triangle is not exact!" );
         
     fi;
     
  else
  
     SetIsExactTriangle( triangle, true );
     
     ObjectifyWithAttributes( triangle, TheTypeCapCategoryExactTriangle );
         
         
  fi;
  
  return triangle;
  
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
  
InstallMethod( ShiftFunctor,
                 [ IsCapCategory and IsTriangulatedCategory ],
                 
    function( category )
    local name, functor;
    
    name := Concatenation( "Shift functor in ", Name( category ) );
    
    functor := CapFunctor( name, category, category );
    
    if not CanCompute( category, "ShiftOfObject" ) or not CanCompute( category, "ShiftOfMorphism" ) then
    
       Error( "ShiftOfObject and ShiftOfMorphism should be added to the category" );
       
    fi;
    
    AddObjectFunction( functor, 
    
          function( obj )
          
          return ShiftOfObject( obj );
          
          end );
          
    AddMorphismFunction( functor, 
    
          function( new_source, mor, new_range )
          
          return ShiftOfMorphism( mor );
          
          end );
          
    return functor;
 
end );
    
##
InstallMethod( ReverseShiftFunctor,
                 [ IsCapCategory and IsTriangulatedCategory ],
                 
    function( category )
    local name, functor;
    
    name := Concatenation( "Reverse Shift functor in ", Name( category ) );
    
    functor := CapFunctor( name, category, category );
    
    if not CanCompute( category, "ReverseShiftOfObject" ) or not CanCompute( category, "ReverseShiftOfMorphism" ) then
    
       Error( "ReverseShiftOfObject and ReverseShiftOfMorphism should be added to the category" );
       
    fi;
    
    AddObjectFunction( functor, 
    
          function( obj )
          
          return ReverseShiftOfObject( obj );
          
          end );
          
    AddMorphismFunction( functor, 
    
          function( new_source, mor, new_range )
          
          return ReverseShiftOfMorphism( mor );
          
          end );
          
    return functor;
 
end );

InstallMethod( AutoequivalenceFromIdentityToShiftAfterReverseShiftFunctor, 
                     [ IsCapCategory and IsTriangulatedCategory ],
                     
       function( category )
       local id, shift, reverse_shift, shift_after_reverse_shift, name, nat;
       
       id := IdentityMorphism( AsCatObject( category ) );
       
       shift := ShiftFunctor( category );
       
       reverse_shift := ReverseShiftFunctor( category );
       
       shift_after_reverse_shift := PreCompose( reverse_shift, shift );
       
       name := "Autoequivalence from identity functor to Shift after ReverseShift functor in ";
       
       name := Concatenation( name, Name( category ) );
       
       nat := NaturalTransformation( name, id, shift_after_reverse_shift );
       
       AddNaturalTransformationFunction( nat, 
        
          function( Id_of_object, object, shift_after_reverse_shift_of_object )
             
             return IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject( object );
             
          end );
        
       return nat;
       
end );

InstallMethod( AutoequivalenceFromIdentityToReverseShiftAfterShiftFunctor, 
                     [ IsCapCategory and IsTriangulatedCategory ],
                     
       function( category )
       local id, shift, reverse_shift, reverse_shift_after_shift, name, nat;
       
       id := IdentityMorphism( AsCatObject( category ) );
       
       shift := ShiftFunctor( category );
       
       reverse_shift := ReverseShiftFunctor( category );
       
       reverse_shift_after_shift := PreCompose( shift, reverse_shift);
       
       name := "Autoequivalence from identity functor to ReverseShift after Shift functor in ";
       
       name := Concatenation( name, Name( category ) );
       
       nat := NaturalTransformation( name, id, reverse_shift_after_shift );
       
       AddNaturalTransformationFunction( nat, 
        
          function( Id_of_object, object, reverse_shift_after_shift_of_object )
             
             return IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject( object );
             
          end );
        
       return nat;
       
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

InstallMethod( IsIsomorphicTriangles, 
               [ IsCapCategoryTriangle, IsCapCategoryTriangle ],
               
  function( triangle1, triangle2 )
  
  if In( triangle1, triangle2!.iso_class ) or In( triangle1, CurrentIsoClassOfTriangle( triangle2 ) ) then 
  
     return true;
     
  fi;
  
  if In( triangle2, triangle1!.iso_class ) or In( triangle2, CurrentIsoClassOfTriangle( triangle1 ) ) then 
  
     return true;
     
  fi;
  
  return fail;
  
end );

InstallMethod( SetIsIsomorphicTriangles, 
               [ IsCapCategoryTriangle, IsCapCategoryTriangle ],
               
 function( triangle1, triangle2 )
 
 if not In( triangle1, triangle2!.iso_class ) then 
 
    Add( triangle2!.iso_class, triangle1 );
    
 fi;

 if not In( triangle2, triangle1!.iso_class ) then 
 
    Add( triangle1!.iso_class, triangle2 );
    
 fi;
 
 if   HasIsExactTriangle( triangle1 ) and not HasIsExactTriangle( triangle2 ) then 
 
      SetIsExactTriangle( triangle2, IsExactTriangle( triangle1 ) );
   
 elif HasIsExactTriangle( triangle2 ) and not HasIsExactTriangle( triangle1 ) then 
 
      SetIsExactTriangle( triangle1, IsExactTriangle( triangle2 ) );
      
 elif HasIsExactTriangle( triangle1 ) and HasIsExactTriangle( triangle2 ) then 
 
      if IsExactTriangle( triangle1 ) <> IsExactTriangle( triangle2 ) then 
      
         Error( "It has been tried to set two triangles to be isomorphic, but this can not be true because one of them is exact and the other ist not!" );
         
      fi;
      
 fi;
   
   

end );

InstallMethod( In,
               [ IsCapCategoryTriangle, IsList ], 
               
  function( triangle, l )
  local t;
  
  for t in l do 
  
     if IsEqualForTriangles( triangle, t ) then 
     
        return true;
        
     fi;
     
  od;
  
  return false;
   
   
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
                  
          SetIsIsomorphicTriangles( mor!.triangle1, mor!.triangle2 );
                  
       fi;
       
       return t;
      
  elif
  
    not CanCompute( CapCategory( mor ), "IsIsomorphism" ) then 
  
    Error( "'IsIsomorphism' for category morphisms is not yet 'Add'ed" );
    
  elif  IsIsomorphism( mor!.morphism11 ) and 
          IsIsomorphism( mor!.morphism22 ) and 
             IsIsomorphism( mor!.morphism33 ) then 
                
        SetIsIsomorphicTriangles( mor!.triangle1, mor!.triangle2 );
      
        return true;
           
  else 
  
        return false;
      
  fi;
  
end );


InstallMethod( IsExactTriangleByTR2Forward, 
               [ IsCapCategoryTriangle ], 
  function( triangle )
  
  if HasIsExactTriangle( triangle ) then 
  
      return IsExactTriangle( triangle );
      
  fi;
  
  if HasCreateTriangleByTR2Forward( triangle ) then 
  
     return IsExactTriangleByTR2Forward( CreateTriangleByTR2Forward( triangle ) );
     
  fi;
  
  
  return fail;
  
  
end );

InstallMethod( IsExactTriangleByTR2Backward, 
               [ IsCapCategoryTriangle ], 
  function( triangle )
  
  if HasIsExactTriangle( triangle ) then 
  
      return IsExactTriangle( triangle );
      
  fi;
  
  if HasCreateTriangleByTR2Backward( triangle ) then 
  
     return IsExactTriangleByTR2Forward( CreateTriangleByTR2Forward( triangle ) );
     
  fi;
  
  
  return fail;
  
  
end );


##
InstallMethod( IsExactTriangleByAxioms, 
               [ IsCapCategoryTriangle ], 
               
 function( triangle )
 local T, current_iso_class, iso_class, category;
 
 category := CapCategory( triangle );
 
 if IsCapCategoryExactTriangle( triangle ) then 
 
    return true;
    
 elif HasIsExactTriangle( triangle ) then 
 
    return IsExactTriangle( triangle );
    
 elif CanCompute( category, "IsZeroForMorphisms" ) and CanCompute( category, "PreCompose" ) then 
 
       if not IsZeroForMorphisms(PreCompose( triangle!.morphism1, triangle!.morphism2 ) ) or
            not IsZeroForMorphisms(PreCompose( triangle!.morphism2, triangle!.morphism3 ) ) then 
           
            return false;
           
       fi;
      
 else
      
 ## TR1 --- 2
   iso_class:= triangle!.iso_class;
  
   for T in iso_class do 
   
     if HasIsExactTriangle( T )  then 
      
         return IsExactTriangle( T );
         
     fi;

   od;
   
 fi; 
 
 current_iso_class:= CurrentIsoClassOfTriangle( triangle );
  
 for T in current_iso_class do
 
    ## By TR1 --- 2
    if HasIsExactTriangle( T )  then 
      
         return IsExactTriangle( T );
         
    elif CanCompute( category, "IsZeroForMorphisms" ) and CanCompute( category, "PreCompose" ) then 
 
       if not IsZeroForMorphisms(PreCompose( T!.morphism1, T!.morphism2 ) ) or
            not IsZeroForMorphisms(PreCompose( T!.morphism2, T!.morphism3 ) ) then 
           
            return false;
           
       fi;
       
     
    ## By TR1 --- 1
    elif ForAll( [ "IsZeroForObjects", "IsIdenticalToIdentityMorphism" ], i-> CanCompute( category, i ) ) and
 
       IsZeroForObjects( T!.object3 ) and IsIdenticalToIdentityMorphism( T!.morphism1 ) then 
       
       return true;
      
   ## By TR2
   elif not IsExactTriangleByTR2Forward( T )= fail then 
 
       return IsExactTriangleByTR2Forward( T );
    
   elif not IsExactTriangleByTR2Backward( T )= fail then 
 
       return IsExactTriangleByTR2Backward( T );
 
   fi;    
 
 od;
 
 return fail;
 
 end );
 

 InstallMethod( Iso_Triangles,
                 [ IsCapCategoryTriangle, IsList ], 
                 
  function( triangle, l )
  local dynamik_list, current_iso_class, T;
  
  dynamik_list := StructuralCopy( l );
  
  current_iso_class:= triangle!.iso_class;
  
     for T in current_iso_class do 
     
        if not In( T, dynamik_list ) then
        
           Add( dynamik_list, T );
           
        fi;
        
     od;
   
  return dynamik_list;
  
end );

  
 
 InstallMethod( CurrentIsoClassOfTriangle,
                 [ IsCapCategoryTriangle ], 
                 
 function( triangle )
 local dyn, new_dyn, T, old_length;
 
 dyn:= [ triangle ];
 
 while 1=1 do
 
   old_length := Length( dyn );
   
   new_dyn:= StructuralCopy( dyn );
   
   for T in new_dyn do 
   
       new_dyn := Iso_Triangles( T, new_dyn );
       
   od;
   
   if Length( new_dyn )= old_length then 
   
     for T in new_dyn do 
     
        T!.iso_class := new_dyn;
        
     od;
     
     return new_dyn;
     
   else 
   
     dyn:= new_dyn;
   
   fi;
   
od;

end );
   
#############################
##
##  Attributes
##
#############################

InstallMethod( CreateTriangleByTR2Forward,
                  [ IsCapCategoryTriangle ], 
                  
  function( triangle )
  
  local new_morphism, new_triangle;
  
  
  new_morphism :=  AdditiveInverseForMorphisms( ShiftOfMorphism( triangle!.morphism1 ) );
  
  if HasIsExactTriangle( triangle ) and IsExactTriangle( triangle ) then 
  
     new_triangle:= CreateExactTriangle( triangle!.morphism2, triangle!.morphism3, new_morphism );
     
     SetCreateTriangleByTR2Backward( new_triangle, triangle );
     
     return new_triangle;
     
  else 
  
     new_triangle:= CreateTriangle( triangle!.morphism2, triangle!.morphism3, new_morphism );
     
     SetCreateTriangleByTR2Backward( new_triangle, triangle );
     
     return new_triangle;
     
  fi;
  
end );
     

InstallMethod( CreateTriangleByTR2Backward,
                  [ IsCapCategoryTriangle ], 
                  
  function( triangle )
  
  local new_morphism, new_triangle;
  
  
  new_morphism :=  AdditiveInverseForMorphisms( ReverseShiftOfMorphism( triangle!.morphism3 ) );
  
  if HasIsExactTriangle( triangle ) and IsExactTriangle( triangle ) then 
  
     new_triangle:= CreateExactTriangle( new_morphism, triangle!.morphism1, triangle!.morphism2  );
     
     SetCreateTriangleByTR2Forward( new_triangle, triangle );
     
     return new_triangle;
     
  else 
  
     new_triangle:= CreateTriangle( new_morphism, triangle!.morphism1, triangle!.morphism2 );
     
     SetCreateTriangleByTR2Forward( new_triangle, triangle );
     
     return new_triangle;
     
  fi;
  
end );
 
InstallMethodWithCache( ApplyCreationTrianglesByTR2,
                        [ IsCapCategoryTriangle, IsInt ],
  function( t, n )
  
  if n=0 then 
  
    return t;
    
  elif n<0 then
  
    return CreateTriangleByTR2Backward( ApplyCreationTrianglesByTR2( t, n+1 ) );
    
  else 
  
    return CreateTriangleByTR2Forward( ApplyCreationTrianglesByTR2( t, n-1 ) );
    
  fi;
  
end );
 
  
                
##############################
##
## View
##
##############################

InstallMethod( ViewObj,
               
               [ IsCapCategoryTriangle ], 
               
  function( triangle )
  
  if HasIsExactTriangle( triangle ) then 
  
     if not IsExactTriangle( triangle ) then 
  
        Print( "< A not exact triangle in ", CapCategory( triangle ), " >" );

     else 
     
        Print( "< An exact triangle in ", CapCategory( triangle ), " >" );
 
     fi;
     
  else 
  
     Print( "< A triangle in ", CapCategory( triangle ), " >" );

  fi;
  
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
  
  
  
       
       
       
       


