


###############################
##
##  Representations
##
###############################

DeclareRepresentation( "IsCapCategoryExactTriangleRep",
                        IsCapCategoryExactTriangle and IsAttributeStoringRep,
                        [ ] );
                        
##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryExactTrianglesFamily",
  NewFamily( "CapCategoryExactTrianglesFamily", IsCapCategoryCell ) );

  

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

ShiftObject:= rec( 

installation_name := "ShiftObject", 
filter_list := [ "object" ],
cache_name := "ShiftObject",
return_type := "object" ),


ShiftMorphism:= rec( 

installation_name := "ShiftMorphism", 
filter_list := [ "morphism" ],
cache_name := "ShiftMorphism",
return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

