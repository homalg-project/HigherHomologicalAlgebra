

#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryExactTriangle", IsCapCategoryCell );

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
##  Methods Declarations
##
#################################

 DeclareOperationWithCache( "ShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ShiftOfObject" );

 
 DeclareOperationWithCache( "ShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ShiftOfMorphism" );

 DeclareOperationWithCache( "ReverseShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ReverseShiftOfObject" );
 
 DeclareOperationWithCache( "ReverseShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ReverseShiftOfMorphism" );
 
 DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryObject, IsInt ] );
  DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryMorphism, IsInt ] );
