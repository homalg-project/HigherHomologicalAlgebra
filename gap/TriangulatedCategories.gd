



DeclareGlobalVariable( "CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

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
 

#################################
##
##  Declarations
##
#################################

 DeclareOperation( "TestFunction1", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "TestFunction1" );

 
 DeclareOperationWithCache( "TestFunction2", [ IsCapCategoryObject, IsCapCategoryObject ] );
 DoDeclarationStuff( "TestFunction2" );
