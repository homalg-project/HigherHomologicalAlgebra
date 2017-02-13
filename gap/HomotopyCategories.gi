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

    test_function := TestFunctionForHomotopyCategory(  UnderlyingCategory( category ) );

    ## Equalities

    AddIsEqualForObjects( category, 

       function( obj1, obj2 )

         if IsIdenticalObj( obj1, obj2 ) then return true; fi;

         return IsEqualForObjects( UnderlyingObject( obj1 ), UnderlyingObject( obj2 ) );

    end );

    ##
    AddIsEqualForMorphisms( category, 

       function( morphism1, morphism2 )

    return IsEqualForMorphisms( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) );

    end );

    ##
    AddIsCongruentForMorphisms( category, 

       function( morphism1, morphism2 )

       return test_function( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) );

    end );

    ## PreCompose

    AddPreCompose( category,

    function( morphism1, morphism2 )
        local composition;

        composition := PreCompose( UnderlyingMorphism( morphism1 ),
                                   UnderlyingMorphism( morphism2 ) );

        return AsHomotopyCategoryMorphism( composition );

    end );

    ## IdentityMorphism

    AddIdentityMorphism( category,

      function( object )

        return AsHomotopyCategoryMorphism( IdentityMorphism( UnderlyingObject( object ) ) );

    end );

    ## Addition for morphisms

    AddAdditionForMorphisms( category,

      function( morphism1, morphism2 )
        local sum;

        sum := AdditionForMorphisms( UnderlyingMorphism( morphism1 ),
                                     UnderlyingMorphism( morphism2 ) );

        return AsHomotopyCategoryMorphism( sum );

    end );

    ## IsZeroForMorphisms
    AddIsZeroForMorphisms( category, 

       function( morphism )
       local underlying_mor;

       underlying_mor := UnderlyingMorphism( morphism );

       if HasIsZero( underlying_mor ) and IsZero( underlying_mor ) then

          return true;

       else 

          return test_function( UnderlyingMorphism( morphism ) );

       fi;

    end );

    ## IsZeroForObjects
    AddIsZeroForObjects( category, 

    function( obj )
    local underlying_obj;

       underlying_obj := UnderlyingObject( obj );

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

        return AsHomotopyCategoryMorphism( new_mor );

    end );

    ## Zero morphism

    AddZeroMorphism( category,

      function( source, range )
        local zero_mor;

        zero_mor := ZeroMorphism( UnderlyingObject( source ), UnderlyingObject( range ) );

        return AsHomotopyCategoryMorphism( zero_mor );

    end );

    ## Zero object

    AddZeroObject( category,

      function( )
        local zero_obj;
        
        zero_obj := ZeroObject( UnderlyingCategory( category ) );
        
        return AsHomotopyCategoryObject( zero_obj );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local underlying_list, underlying_sum;
        
        underlying_list := List( obj_list, UnderlyingObject );
        
        underlying_sum := CallFuncList( DirectSum, underlying_list );
        
        return AsHomotopyCategoryObject( underlying_sum );
        
    end );


end );
    
#########################
#
# constructor
#
########################

InstallMethod( HomotopyCategory,
                 [ IsCapCategory ],

function( category )
    local homotopy_category, gen_category, name, preconditions,
          category_weight_list, i, to_be_finalized;

    #   IMPORTANT
    #   if category has test function as attribute ...

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
    
    name := Concatenation( "The homotopy category of ", name );
    
    homotopy_category := CreateCapCategory( name );
    
    SetFilterObj( homotopy_category, WasCreatedAsHomotopyCategory );
    
    SetUnderlyingCategory( homotopy_category, category );

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
               [ IsChainOrCochainMorphism ],

    function( mor )
    local category, homotopy_morphism;

    category := HomotopyCategory( CapCategory( mor ) );

    homotopy_morphism := rec( );

    ObjectifyWithAttributes( homotopy_morphism, TheTypeOfHomotopyCategoryMorphism,
                             Source, AsHomotopyCategoryObject( Source( mor ) ),
                             Range,  AsHomotopyCategoryObject( Range( mor ) )
                             );

    SetUnderlyingMorphism( homotopy_morphism, mor );

    SetMorphisms( homotopy_morphism, Morphisms( mor ) );

    AddMorphism( category, homotopy_morphism );

    return homotopy_morphism;

end );

##
InstallMethod( AsHomotopyCategoryObject,
               [ IsChainOrCochainComplex ],

    function( obj )
    local category, homotopy_obj;

    category := HomotopyCategory( CapCategory( obj ) );

    homotopy_obj := rec( );

    ObjectifyWithAttributes( homotopy_obj, TheTypeOfHomotopyCategoryObject,
                             Differentials, Differentials( obj ),
                             UnderlyingObject, obj );

    if IsChainComplex( obj ) then

       SetFilterObj( homotopy_obj, IsChainComplex );

    else

       SetFilterObj( homotopy_obj, IsCochainComplex );

    fi;

    ## here we should add to do list... 

    AddObject( category, homotopy_obj );

    TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED( homotopy_obj );

    return homotopy_obj;

end );

###########################
##
##  View and Display
##
###########################
#
# InstallMethod( ViewObj,
#       [ IsHomotopyCategoryObject ], 
#     function( obj )
#     
#     Print( "<An object in the homotopy category of ", Name( UnderlyingCategory( CapCategory( obj ) ) ), ">" );
#     
#     end );
#       
# 
# InstallMethod( ViewObj,
#       [ IsHomotopyCategoryMorphism ], 
#     function( mor )
#     
#     Print( "<A morphism in the homotopy category of ", Name( UnderlyingCategory( CapCategory( mor ) ) ), ">" );
#     
#     end );
#     
# InstallMethod( Display,
#       [ IsHomotopyCategoryObject ], 
#     function( obj )
#     
#     Print( "An object in the homotopy category of ", UnderlyingCategory( CapCategory( obj ) ), " with underlying object\n" );
#     Display( UnderlyingObject( obj ) );
#     
#     end );
#       
# 
# InstallMethod( Display,
#       [ IsHomotopyCategoryMorphism ], 
#     function( mor )
#     
#     Print( "A morphism in the homotopy category of ", UnderlyingCategory( CapCategory( mor ) ), " with underlying morphism\n" );
#     Display( UnderlyingMorphism( mor ) );
#     
#     end );
