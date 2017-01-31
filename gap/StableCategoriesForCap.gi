#####################################################################
#
#   StableCategoriesForCapi.gi              StableCategoriesForCap
#                                           Siegen University
#   29.09.2016                              Kamal Saleh
#
#####################################################################

########################
##
## Declarations
##
########################
DeclareRepresentation( "IsStableCategoryRep",
                       IsCapCategoryRep and IsStableCategory,
                       [ ] );

BindGlobal( "TheTypeOfStableCategory",
        NewType( TheFamilyOfCapCategories,
                IsStableCategoryRep ) );


DeclareRepresentation( "IsStableCategoryObjectRep",
                       IsCapCategoryObjectRep and IsStableCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfStableCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsStableCategoryObjectRep ) );

DeclareRepresentation( "IsStableCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsStableCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfStableCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsStableCategoryMorphismRep ) );

########################
##
## Installer
##
########################


BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_STABLE_CATEGORY",
  
  function( category )
    local test_function;
    
    test_function := TestFunctionForStableCategories( category );
    
    ## Equalities
    
    AddIsEqualForObjects( category, 
          
       function( obj1, obj2 )
       
         return IsEqualForObjects( UnderlyingObjectOfTheStableObject( obj1 ), UnderlyingObjectOfTheStableObject( obj2 ) );
       
    end );
    
    AddIsEqualForMorphisms( category, 
    
       function( morphism1, morphism2 )
       
       return test_function( morphism1 - morphism2 );
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingMorphismOfTheStableMorphism( morphism1 ),
                                   UnderlyingMorphismOfTheStableMorphism( morphism2 ) );
        
        return AsStableCategoryMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
      
        return AsStableCategoryMorphism( category, IdentityMorphism( UnderlyingObjectOfTheStableObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingMorphismOfTheStableMorphism( morphism1 ),
                                     UnderlyingMorphismOfTheStableMorphism( morphism2 ) );
        
        return AsStableCategoryMorphism( category, sum );
        
    end );
    
    ## IsZeroForMorphisms
    AddIsZeroForMorphisms( category, 
    
       function( morphism )
       local underlying_mor;
       
       underlying_mor := UnderlyingMorphismOfTheStableMorphism( morphism );
       
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
       
       underlying_obj := UnderlyingObjectOfTheStableObject( obj );
       
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
        
        new_mor := AdditiveInverseForMorphisms( UnderlyingMorphismOfTheStableMorphism( morphism ) );
        
        return AsStableCategoryMorphism( category, new_mor );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local zero_mor;
        
        zero_mor := ZeroMorphism( UnderlyingObjectOfTheStableObject( source ), UnderlyingObjectOfTheStableObject( range ) );
        
        return AsStableCategoryMorphism( category, zero_mor );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local zero_obj;
        
        zero_obj := ZeroObject( UnderlyingCategory( category ) );
        
        return AsStableCategoryObject( category, zero_obj );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local underlying_list, underlying_sum;
        
        underlying_list := List( obj_list, UnderlyingObjectOfTheStableObject );
        
        underlying_sum := CallFuncList( DirectSum, underlying_list );
        
        return AsStableCategoryObject( category, underlying_sum );
        
    end );

end );
    
#########################
#
# constructor
#
########################

InstallMethod( StableCategory,
                 [ IsCapCategory, IsFunction ],
                                  
  function( category, test_function )
    local stable_category, gen_category, name, preconditions,
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
    
    name := Concatenation( "The stable category of ", name ); # , " by ", function_name
    
    stable_category := CreateCapCategory( name );
    
    SetFilterObj( stable_category, WasCreatedAsStableCategory );
    
    SetUnderlyingCategory( stable_category, category );
    
    SetTestFunctionForStableCategories( stable_category, test_function );
    
    SetIsAdditiveCategory( stable_category, true );
     
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_STABLE_CATEGORY( stable_category );
    
       to_be_finalized := ValueOption( "FinalizeStableCategory" );
   
    if to_be_finalized = true then
      
       Finalize( stable_category );
      
    fi;
   
    return stable_category;
   
end );

# StableCategory( category, funk: FinalizeStableCategory := false );

##
InstallMethod( AsStableCategoryMorphism,
               [ IsCapCategory and WasCreatedAsStableCategory, IsCapCategoryMorphism ],
               
    function( category, mor )
    local underlying_category, stable_morphism;
    underlying_category := UnderlyingCategory( category );
    
    if not IsIdenticalObj( underlying_category, CapCategory( mor ) ) then 
    
       Error( "The morphism does not belong to the underlying category of the stable category" );
       
    fi;
    
    stable_morphism := rec( );
    
    ObjectifyWithAttributes( stable_morphism, TheTypeOfStableCategoryMorphism,
                             Source, AsStableCategoryObject( category, Source( mor ) ),
                             Range,  AsStableCategoryObject( category, Range( mor ) )
                             );
    
    SetUnderlyingMorphismOfTheStableMorphism( stable_morphism, mor );
    
    if HasUnderlyingMatrix( mor ) then 
    
    SetUnderlyingMatrix( stable_morphism, UnderlyingMatrix( mor ) );

    fi;
    
    ## here we should add to do list... 
    
    AddMorphism( category, stable_morphism );
    
    return stable_morphism;
    
end );
    
    
##
InstallMethod( AsStableCategoryObject,
               [ IsCapCategory and WasCreatedAsStableCategory, IsCapCategoryObject ],
               
    function( category, obj )
    local underlying_category, stable_obj;
    underlying_category := UnderlyingCategory( category );
    
    if not IsIdenticalObj( underlying_category, CapCategory( obj ) ) then 
    
       Error( "The object does not belong to the underlying category of the stable category" );
       
    fi;
    
    stable_obj := rec( );
    
    ObjectifyWithAttributes( stable_obj, TheTypeOfStableCategoryObject );
    
    SetUnderlyingObjectOfTheStableObject( stable_obj, obj );
    
    if HasUnderlyingMatrix( obj ) then 
    
      SetUnderlyingMatrix( stable_obj, UnderlyingMatrix( obj ) );
    
    fi;
    
    ## here we should add to do list... 
    
    AddObject( category, stable_obj );
    
    return stable_obj;
    
end );
###########################
##
##  View and Display
##
###########################

InstallMethod( ViewObj,
      [ IsStableCategoryObject ], 
    function( obj )
    
    Print( "<An object in the stable category of ", Name( UnderlyingCategory( CapCategory( obj ) ) ), ">" );
    
    end );
      

InstallMethod( ViewObj,
      [ IsStableCategoryMorphism ], 
    function( mor )
    
    Print( "<A morphism in the stable category of ", Name( UnderlyingCategory( CapCategory( mor ) ) ), ">" );
    
    end );
    
InstallMethod( Display,
      [ IsStableCategoryObject ], 
    function( obj )
    
    Print( "An object in the stable category of ", UnderlyingCategory( CapCategory( obj ) ), " with underlying object\n" );
    Display( UnderlyingObjectOfTheStableObject( obj ) );
    
    end );
      

InstallMethod( Display,
      [ IsStableCategoryMorphism ], 
    function( mor )
    
    Print( "A morphism in the stable category of ", UnderlyingCategory( CapCategory( mor ) ), " with underlying morphism\n" );
    Display( UnderlyingMorphismOfTheStableMorphism( mor ) );
    
    end );
