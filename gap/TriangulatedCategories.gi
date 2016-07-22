


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

TestFunction1:= rec( 

installation_name := "TestFunction1", 
filter_list := [ "object" ],
cache_name := "TestFunction1",
return_type := "object" ),


TestFunction2:= rec( 

installation_name := "TestFunction2", 
filter_list := [ "object", "object" ],
cache_name := "TestFunction2",
return_type := "object" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

