##############################
##
## bla bla
##
##############################


LoadPackage( "TriangulatedCategoriesForCap" );

DeclareRepresentation( "IsBradRep",
                        IsCapCategoryObjectRep,
                        [ ] );
                        
BindGlobal( "TheTypeOfBrad",
       NewType( TheFamilyOfCapCategoryObjects,
               IsBradRep ) );
               
DeclareRepresentation( "IsBradMorphismRep",
                        IsCapCategoryMorphismRep,
                        [ ] );
                        
BindGlobal( "TheTypeOfBradMorphism",
       NewType( TheFamilyOfCapCategoryMorphisms,
               IsBradMorphismRep ) );
               

DeclareOperation( "Brad",
                   [ IsInt ] );

DeclareOperation( "BradMorphism", 
                   [ IsBradRep, IsString, IsBradRep ] );

##########################
##
##   Creating a category 
##
##########################

BindGlobal( "BradsCategory", CreateCapCategory( "Category of brads" ) );

##########################
##
## Constructors of Brad
##
##########################

InstallMethod( Brad, 
               [ IsInt ], 
               
    function( m )
    local t;
    
    t := rec( ob:= m );
    ObjectifyWithAttributes( t, TheTypeOfBrad );
    Add( BradsCategory, t );
    
    return t;
    
end );

####################################
##
## Add some Methods to the category
##
####################################

AddTestFunction2( BradsCategory, 

 function( M, N )
 
 return M;
 
 end );
 
 
 
 

