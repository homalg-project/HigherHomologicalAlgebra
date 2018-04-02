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
    
    test_function := TestFunctionForStableCategories( UnderlyingCategory( category ) );
    
    ## Equalities
    
    AddIsEqualForObjects( category, 
          
        function( obj1, obj2 )
       
        return IsEqualForObjects( UnderlyingUnstableObject( obj1 ), UnderlyingUnstableObject( obj2 ) );
       
    end );
    
    AddIsWellDefinedForObjects( category,
        function( obj )
        
        return IsWellDefinedForObjects( UnderlyingUnstableObject( obj ) );
        
        end );
    
    AddIsEqualForMorphisms( category, 
    
       function( morphism1, morphism2 )
       
       return IsEqualForMorphisms( UnderlyingUnstableMorphism( morphism1 ), UnderlyingUnstableMorphism( morphism2 ) );
    end );
    
    AddIsCongruentForMorphisms( category, 
    
        function( morphism1, morphism2 )
       
        return test_function( UnderlyingUnstableMorphism( morphism1 ) - UnderlyingUnstableMorphism( morphism2 ) );
    end );
    
    AddIsWellDefinedForMorphisms( category,
        function( mor )
        
        return IsWellDefinedForMorphisms( UnderlyingUnstableMorphism( mor ) );
        
        end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingUnstableMorphism( morphism1 ),
                                   UnderlyingUnstableMorphism( morphism2 ) );
        
        return AsStableMorphism( composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
      
        return AsStableMorphism( IdentityMorphism( UnderlyingUnstableObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingUnstableMorphism( morphism1 ),
                                     UnderlyingUnstableMorphism( morphism2 ) );
        
        return AsStableMorphism( sum );
        
    end );
    
    ## IsZeroForMorphisms
    AddIsZeroForMorphisms( category, 
    
       function( morphism )
       local underlying_mor;
       
       underlying_mor := UnderlyingUnstableMorphism( morphism );
       
       if HasIsZero( underlying_mor ) and IsZero( underlying_mor ) then
        
          return true;
          
       else 
       
          return test_function( underlying_mor );
          
       fi;
       
    end );
    
    ## IsZeroForObjects
    AddIsZeroForObjects( category, 
    
    function( obj )
    local underlying_obj;
       
       underlying_obj := UnderlyingUnstableObject( obj );
       
       if HasIsZero( underlying_obj ) and IsZero( underlying_obj ) then
        
          return true;
        
       else 
       
          return IsZeroForMorphisms( IdentityMorphism( obj ) );
       
       fi;
       
    end );
    
    ## Additive inverse for morphisms
    
    AddAdditiveInverseForMorphisms( category,
      
    function( morphism )
      
        return AsStableMorphism( AdditiveInverseForMorphisms( UnderlyingUnstableMorphism( morphism ) ) );
    
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
    function( source, range )

        return AsStableMorphism( ZeroMorphism( UnderlyingUnstableObject( source ), UnderlyingUnstableObject( range ) ) );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        
        return AsStableObject( ZeroObject( UnderlyingCategory( category ) ) );
        
    end );
    
    AddUniversalMorphismIntoZeroObject( category,
        function( obj )
        return AsStableMorphism( UniversalMorphismIntoZeroObject( UnderlyingUnstableObject( obj ) ) );
    end );
    
    AddUniversalMorphismFromZeroObject( category,
        function( obj )
        return AsStableMorphism( UniversalMorphismFromZeroObject( UnderlyingUnstableObject( obj ) ) );
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
        function( obj_list )
        
        return AsStableObject( DirectSum( List( obj_list, UnderlyingUnstableObject ) ) );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
        function( list, n, D )
        
        return AsStableMorphism( InjectionOfCofactorOfDirectSumWithGivenDirectSum( List( list, UnderlyingUnstableObject ), n, UnderlyingUnstableObject( D ) ) );
    
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
        function( list, n, D )
        
        return AsStableMorphism( ProjectionInFactorOfDirectSumWithGivenDirectSum( List( list, UnderlyingUnstableObject ), n, UnderlyingUnstableObject( D ) ) );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
        function( list, product_morphism, direct_sum )
        return AsStableMorphism( UniversalMorphismIntoDirectSumWithGivenDirectSum(
                                        List( list, UnderlyingUnstableObject ),
                                        List( product_morphism, UnderlyingUnstableMorphism ),
                                        UnderlyingUnstableObject( direct_sum ) ) );
        
        end );
        
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
        function( list, product_morphism, direct_sum )
        return AsStableMorphism( UniversalMorphismFromDirectSumWithGivenDirectSum(
                                        List( list, UnderlyingUnstableObject ),
                                        List( product_morphism, UnderlyingUnstableMorphism ),
                                        UnderlyingUnstableObject( direct_sum ) ) );
        
        end );
        
        
end );
    
#########################
#
# constructor
#
########################

InstallMethod( StableCategory,
                 [ IsCapCategory ],
                                  
  function( category )
    local stable_category, test_function, gen_category, name, preconditions,
          category_weight_list, i, to_be_finalized;
    
    test_function := TestFunctionForStableCategories( category );
    
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
                       "UniversalMorphismIntoDirectSum" ];
    
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

AddObjectRepresentation( stable_category, IsStableCategoryObject );
    
AddMorphismRepresentation( stable_category, IsStableCategoryMorphism );
    
SetFilterObj( stable_category, WasCreatedAsStableCategory );
    
SetUnderlyingCategory( stable_category, category );
    
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
InstallMethod( AsStableMorphism,
               [ IsCapCategoryMorphism ],
               
    function( mor )
    local underlying_category, stable_morphism, category;
    
    category := StableCategory( CapCategory( mor ) );
    
    stable_morphism := rec( );
    
    ObjectifyMorphismForCAPWithAttributes( stable_morphism, category,
                             Source, AsStableObject( Source( mor ) ),
                             Range,  AsStableObject( Range( mor ) ),
                             UnderlyingUnstableMorphism, mor );
    
    if HasUnderlyingMatrix( mor ) then 
    
        SetUnderlyingMatrix( stable_morphism, UnderlyingMatrix( mor ) );

    fi;
    
    return stable_morphism;
    
end );
    
    
##
InstallMethod( AsStableObject,
               [ IsCapCategoryObject ],
               
    function( obj )
    local stable_obj, category;
    
    category := StableCategory( CapCategory( obj ) );
    
    stable_obj := rec( );
    
    ObjectifyObjectForCAPWithAttributes( stable_obj, category,
                                         UnderlyingUnstableObject, obj );
    
    if HasUnderlyingMatrix( obj ) then 
    
        SetUnderlyingMatrix( stable_obj, UnderlyingMatrix( obj ) );
    
    fi;
    
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
    
    Print( "An object in the stable category of ", UnderlyingCategory( CapCategory( obj ) ), "\nwith underlying object\n\n" );
    Display( UnderlyingUnstableObject( obj ) );
    
    end );
      

InstallMethod( Display,
      [ IsStableCategoryMorphism ], 
    function( mor )
    
    Print( "A morphism in the stable category of ", UnderlyingCategory( CapCategory( mor ) ), "\nwith underlying morphism\n\n" );
    Display( UnderlyingUnstableMorphism( mor ) );
    
    end );
