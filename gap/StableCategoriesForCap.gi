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
       
         return IsEqualForObjects( UnderlyingObject( obj1 ), UnderlyingObject( obj1 ) );
       
    end );
    
    # TO DO AddIsCongruentForMorphisms
    # TO DO Is Zero
    
     ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingMorphism( morphism1 ),
                                   UnderlyingMorphism( morphism2 ) );
        
        return AsStableCategoryMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
        
        return AsStableCategoryMorphism( category, IdentityMorphism( UnderlyingObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingMorphism( morphism1 ),
                                     UnderlyingMorphism( morphism2 ) );
        
        return AsStableCategoryMorphism( category, sum );
        
    end );
    
    ## TO DO IsZeroForMorphisms
    
    
    
    
    
    
    ## Additive inverse for morphisms
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local new_mor;
        
        new_mor := AdditiveInverseForMorphisms( UnderlyingMorphism( morphism ) );
        
        return AsStableCategoryMorphism( category, new_mor );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local zero_mor;
        
        zero_mor := ZeroMorphism( UnderlyingObject( source ), UnderlyingObject( range ) );
        
        return AsStableCategoryMorphism( category, zero_mor );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local zero_obj;
        
        zero_obj := ZeroObject( UnderlyingCategory( category ) );
        
        return AsStableCategoryObject( category, zero_obj );
        
    end );
    
    end );
    
    
#########################
#
# constructor
#
########################

InstallMethod( StableCategory,
                                  [ IsCapCategory, IsFunction, IsString ],
                                  
  function( category, test_function, function_name )
    local stable_category, gen_category, name, preconditions, category_weight_list, i;
    
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
    
    name := Concatenation( "The stable category of ", name, " by ", function_name );
    
    stable_category := CreateCapCategory( name );
    
    SetFilterObj( stable_category, WasCreatedAsStableCategory );
    
    SetUnderlyingCategory( stable_category, category );
    
    SetTestFunctionForStableCategories( stable_category, test_function );
    
    SetIsAdditiveCategory( stable_category, true );
     
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_STABLE_CATEGORY( stable_category );
    
    Finalize( stable_category );
    
    return stable_category;
    
end );

##
InstallMethodWithCache( AsStableCategoryMorphism,
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
    
    SetUnderlyingMorphism( stable_morphism, mor );
    
    ## here we should add to do list... 
    
    AddMorphism( category, stable_morphism );
    
    return stable_morphism;
    
end );
    
    
##
InstallMethodWithCache( AsStableCategoryObject,
               [ IsCapCategory and WasCreatedAsStableCategory, IsCapCategoryObject ],
               
    function( category, obj )
    local underlying_category, stable_obj;
    underlying_category := UnderlyingCategory( category );
    
    if not IsIdenticalObj( underlying_category, CapCategory( obj ) ) then 
    
       Error( "The object does not belong to the underlying category of the stable category" );
       
    fi;
    
    stable_obj := rec( );
    
    ObjectifyWithAttributes( stable_obj, TheTypeOfStableCategoryObject );
    
    SetUnderlyingObject( stable_obj, obj );
    
    ## here we should add to do list... 
    
    AddObject( category, stable_obj );
    
    return stable_obj;
    
end );
    
    
    
    
    
               
