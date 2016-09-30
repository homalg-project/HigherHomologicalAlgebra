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
       
         return IsEqualForObjects(UnderlyingObject( obj1 ), UnderlyingObject( obj1 ) );
       
    end );
    
    # TO DO AddIsCongruentForMorphisms
    # To DO Is Zero
    
     ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingMorphism( morphism1 ),
                                   UnderlyingMorphism( morphism2 ) );
        
        return StableCategoryMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
        
        return StableCategoryMorphism( category, IdentityMorphism( UnderlyingObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingMorphism( morphism1 ),
                                     UnderlyingMorphism( morphism2 ) );
        
        return StableCategoryMorphism( category, sum );
        
    end );
    
    end );
    
    
#########################
#
# constructor
#
########################

InstallMethodWithCacheFromObject( StableCategory,
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
    
#     SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategoryByCospans );
    
#     SetUnderlyingHonestCategory( serre_category, category );
    
#     SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategoryByCospans( category ) );
    
#     SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
#     SetIsAbelianCategory( serre_category, true );
#     
#     CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_COSPANS( serre_category );
    
#     Finalize( serre_category );
    
#     return serre_category;
    
end );