

#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryTriangle", IsObject );

DeclareCategory( "IsCapCategoryExactTriangle", IsCapCategoryTriangle );


#################################
##
##  Saving time for declarations 
##
#################################

##
 DeclareOperation( "DoDeclarationStuff", [ IsString ] );
 
## 
 InstallMethod( DoDeclarationStuff, 
                [ IsString ], 
 function( name_of_the_function )

 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction ] );


 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList ] );
 end );
 

####################################
##
##  Methods Declarations in Records
##
####################################

 DeclareOperationWithCache( "ShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ShiftOfObject" );

 
 DeclareOperationWithCache( "ShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ShiftOfMorphism" );

 DeclareOperationWithCache( "ReverseShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ReverseShiftOfObject" );
 
 DeclareOperationWithCache( "ReverseShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ReverseShiftOfMorphism" );
 
 DeclareOperationWithCache( "IsExactForTriangles", [ IsCapCategoryTriangle ] );
 DoDeclarationStuff( "IsExactForTriangles" );
 
 ###################################
 ##
 ## General Methods declaration
 ##
 ##################################
 
 DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryObject,   IsInt ] );
 DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryMorphism, IsInt ] );
 
 DeclareOperation( "CreateTriangle", 
                    [ IsCapCategoryMorphism,IsCapCategoryMorphism,IsCapCategoryMorphism ]); 
 
 DeclareOperation( "CreateExactTriangle", 
                    [ IsCapCategoryMorphism,IsCapCategoryMorphism,IsCapCategoryMorphism ]); 
 
 DeclareOperation( "CreateExactTriangle", 
                    [ IsCapCategoryTriangle ]); 
 
 ###############################
 ##
 ## Attributes
 ##
 ###############################
 
 DeclareAttribute( "CapCategory", IsCapCategoryTriangle );
 
 ##############################
 ##
 ## Properties
 ##
 ##############################
 
 DeclareProperty( "IsExactTriangle", IsCapCategoryTriangle );
 
 
 
 
 
 
 
 
 