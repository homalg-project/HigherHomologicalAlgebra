#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   13.Feb.2017                             Kamal Saleh
#
#####################################################################

########################
##
## Declarations
##
########################

DeclareRepresentation( "IsHomotopyCategoryRep",
                       IsCapCategoryRep and IsHomotopyCategory,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategory",
        NewType( TheFamilyOfCapCategories,
                IsHomotopyCategoryRep ) );


DeclareRepresentation( "IsHomotopyCategoryObjectRep",
                       IsCapCategoryObjectRep and IsHomotopyCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomotopyCategoryObjectRep ) );

DeclareRepresentation( "IsHomotopyCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsHomotopyCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsHomotopyCategoryMorphismRep ) );

########################
##
## Installer
##
########################


BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_HOMOTOPY_CATEGORY",
  
  function( category )
    local test_function;
    
    test_function := TestFunctionForHomotopyCategory( category );
    
    ## Equalities
    
    AddIsEqualForObjects( category, 
          
       function( obj1, obj2 )
       
         return IsEqualForObjects( UnderlyingComplex( obj1 ), UnderlyingComplex( obj2 ) );
       
    end );
    
    AddIsEqualForMorphisms( category, 
    
       function( morphism1, morphism2 )
       
       return test_function( morphism1 - morphism2 );
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingMorphism( morphism1 ),
                                   UnderlyingMorphism( morphism2 ) );
        
        return AsHomotopyCategoryMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
      
        return AsHomotopyCategoryMorphism( category, IdentityMorphism( UnderlyingComplex( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingMorphism( morphism1 ),
                                     UnderlyingMorphism( morphism2 ) );
        
        return AsHomotopyCategoryMorphism( category, sum );
        
    end );
    
    ## IsZeroForMorphisms
    AddIsZeroForMorphisms( category, 
    
       function( morphism )
       local underlying_mor;
       
       underlying_mor := UnderlyingMorphism( morphism );
       
       if HasIsZero( underlying_mor ) and IsZero( underlying_mor ) then
        
          return true;
          
       else 
       
          return test_function( morphism );
          
       fi;
       
    end );
    
    ## IsZeroForObjects
    AddIsZeroForObjects( category, 
    
    function( obj )
    local underlying_obj;
       
       underlying_obj := UnderlyingComplex( obj );
       
       if HasIsZero( underlying_obj ) and IsZero( underlying_obj ) then
        
          return true;
          
       else 
       
          return IsZero( IdentityMorphism( obj ) );
       
       fi;
       
    end );
    
    
    ## Additive inverse for morphisms
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local new_mor;
        
        new_mor := AdditiveInverseForMorphisms( UnderlyingMorphism( morphism ) );
        
        return AsHomotopyCategoryMorphism( category, new_mor );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local zero_mor;
        
        zero_mor := ZeroMorphism( UnderlyingComplex( source ), UnderlyingComplex( range ) );
        
        return AsHomotopyCategoryMorphism( category, zero_mor );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local zero_obj;
        
        zero_obj := ZeroObject( UnderlyingCategory( category ) );
        
        return AsHomotopyCategoryObject( category, zero_obj );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local underlying_list, underlying_sum;
        
        underlying_list := List( obj_list, UnderlyingComplex );
        
        underlying_sum := CallFuncList( DirectSum, underlying_list );
        
        return AsHomotopyCategoryObject( category, underlying_sum );
        
    end );

end );
    
#########################
#
# constructor
#
########################

InstallMethod( HomotopyCategory,
                 [ IsCapCategory, IsFunction ],
                                  
  function( category, test_function )
    local homotopy_category, gen_category, name, preconditions,
          category_weight_list, i, to_be_finalized;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        return;
        
    fi;
    
    ## this may be extended or reduced ...
    
    preconditions := [ "IsEqualForObjects",
                       "AdditiveInverseForMorphisms",
                       "IdentityMorphism",
                       "ZeroMorphism",
                       "DirectSum",
                       "ProjectionInFactorOfDirectSumWithGivenDirectSum",
                       "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                       "UniversalMorphismFromDirectSum",
                       "UniversalMorphismIntoDirectSum",
                       "DirectSumFunctorial" ];
    
    category_weight_list := category!.derivations_weight_list;
    
    for i in preconditions do
        
        if CurrentOperationWeight( category_weight_list, i ) = infinity then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "The homotopy category of ", name ); # , " by ", function_name
    
    homotopy_category := CreateCapCategory( name );
    
    SetFilterObj( homotopy_category, WasCreatedAsHomotopyCategory );
    
    SetUnderlyingCategory( homotopy_category, category );
    
    SetTestFunctionForHomotopyCategory( homotopy_category, test_function );
    
    SetIsAdditiveCategory( homotopy_category, true );
     
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_HOMOTOPY_CATEGORY( homotopy_category );
    
       to_be_finalized := ValueOption( "FinalizeHomotopyCategory" );
   
    if to_be_finalized = true then
      
       Finalize( homotopy_category );
      
    fi;
   
    return homotopy_category;
   
end );

# HomotopyCategory( category, funk: FinalizeHomotopyCategory := false );

##
InstallMethod( AsHomotopyCategoryMorphism,
               [ IsCapCategory and WasCreatedAsHomotopyCategory, IsCapCategoryMorphism ],
               
    function( category, mor )
    local underlying_category, homotopy_morphism;
    underlying_category := UnderlyingCategory( category );
    
    if not IsIdenticalObj( underlying_category, CapCategory( mor ) ) then 
    
       Error( "The morphism does not belong to the underlying category of the homotopy category" );
       
    fi;
    
    homotopy_morphism := rec( );
    
    ObjectifyWithAttributes( homotopy_morphism, TheTypeOfHomotopyCategoryMorphism,
                             Source, AsHomotopyCategoryObject( category, Source( mor ) ),
                             Range,  AsHomotopyCategoryObject( category, Range( mor ) )
                             );
    
    SetUnderlyingMorphism( homotopy_morphism, mor );

    ## here we should add to do list... 
    
    AddMorphism( category, homotopy_morphism );
    
    return homotopy_morphism;
    
end );
    
    
##
InstallMethod( AsHomotopyCategoryObject,
               [ IsCapCategory and WasCreatedAsHomotopyCategory, IsCapCategoryObject ],
               
    function( category, obj )
    local underlying_category, homotopy_obj;
    underlying_category := UnderlyingCategory( category );
    
    if not IsIdenticalObj( underlying_category, CapCategory( obj ) ) then 
    
       Error( "The object does not belong to the underlying category of the homotopy category" );
       
    fi;
    
    homotopy_obj := rec( );
    
    ObjectifyWithAttributes( homotopy_obj, TheTypeOfHomotopyCategoryObject );
    
    SetUnderlyingComplex( homotopy_obj, obj );

    ## here we should add to do list... 
    
    AddObject( category, homotopy_obj );
    
    return homotopy_obj;
    
end );
###########################
##
##  View and Display
##
###########################

InstallMethod( ViewObj,
      [ IsHomotopyCategoryObject ], 
    function( obj )
    
    Print( "<An object in the homotopy category of ", Name( UnderlyingCategory( CapCategory( obj ) ) ), ">" );
    
    end );
      

InstallMethod( ViewObj,
      [ IsHomotopyCategoryMorphism ], 
    function( mor )
    
    Print( "<A morphism in the homotopy category of ", Name( UnderlyingCategory( CapCategory( mor ) ) ), ">" );
    
    end );
    
InstallMethod( Display,
      [ IsHomotopyCategoryObject ], 
    function( obj )
    
    Print( "An object in the homotopy category of ", UnderlyingCategory( CapCategory( obj ) ), " with underlying object\n" );
    Display( UnderlyingComplex( obj ) );
    
    end );
      

InstallMethod( Display,
      [ IsHomotopyCategoryMorphism ], 
    function( mor )
    
    Print( "A morphism in the homotopy category of ", UnderlyingCategory( CapCategory( mor ) ), " with underlying morphism\n" );
    Display( UnderlyingMorphism( mor ) );
    
    end );
