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

##################################
##
##  Lifting & Colifting structure
##
##################################

InstallValue( CAP_INTERNAL_STABLE_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( STABLE_CATEGORIES_METHOD_NAME_RECORD, rec(
 
LiftingObject := rec(
  installation_name := "LiftingObject",
  filter_list := [ "object" ],
  cache_name := "LiftingObject",
  return_type := "object" ),

LiftingMorphismWithGivenLiftingObjects := rec(
    installation_name := "LiftingMorphismWithGivenLiftingObjects",
    filter_list := [ "morphism", "object", "object" ],
    cache_name := "LiftingMorphismWithGivenLiftingObjects",
    return_type := "morphism" ),

LiftingMorphism := rec(
    installation_name := "LiftingMorphism",
    filter_list := [ "morphism" ],
    cache_name := "LiftingMorphism",
    return_type := "morphism" ),

MorphismFromLiftingObjectWithGivenLiftingObject := rec(
  installation_name := "MorphismFromLiftingObjectWithGivenLiftingObject",
  filter_list := [ "object", "object" ],
  cache_name := "MorphismFromLiftingObjectWithGivenLiftingObject",
  return_type := "morphism" ),

MorphismFromLiftingObject := rec(
  installation_name := "MorphismFromLiftingObject",
  filter_list := [ "object" ],
  cache_name := "MorphismFromLiftingObject",
  return_type := "morphism" ),


ColiftingObject := rec(
  installation_name := "ColiftingObject",
  filter_list := [ "object" ],
  cache_name := "ColiftingObject",
  return_type := "object" ),

ColiftingMorphismWithGivenColiftingObjects := rec(
  installation_name := "ColiftingMorphismWithGivenColiftingObjects",
  filter_list := [ "morphism", "object", "object" ],
  cache_name := "ColiftingMorphismWithGivenColiftingObjects",
  return_type := "morphism" ),

ColiftingMorphism := rec(
  installation_name := "ColiftingMorphism",
  filter_list := [ "morphism" ],
  cache_name := "ColiftingMorphism",
  return_type := "morphism" ),
  
MorphismIntoColiftingObjectWithGivenColiftingObject := rec(
  installation_name := "MorphismIntoColiftingObjectWithGivenColiftingObject",
  filter_list := [ "object", "object" ],
  cache_name := "MorphismIntoColiftingObjectWithGivenColiftingObject",
  return_type := "morphism" ),

MorphismIntoColiftingObject := rec(
  installation_name := "MorphismIntoColiftingObject",
  filter_list := [ "object" ],
  cache_name := "MorphismIntoColiftingObject",
  return_type := "morphism" ),
 
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( STABLE_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( STABLE_CATEGORIES_METHOD_NAME_RECORD );

########################
##
## Installer
##
########################

InstallMethod( StableCategory,
              [ IsCapCategory, IsFunction ],
  function( category, membership_function )
    local congruency_test_function, to_be_finalized, name, stable_category, name_membership_function;
    
    if not HasIsAdditiveCategory( category ) or not IsAdditiveCategory( category ) then
      
      Error( "The category in the input should be additive category" );
      
    fi;
    
    congruency_test_function := function( alpha, beta ) return membership_function( alpha - beta ); end;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    name := ValueOption( "Name" );
    
    if name = fail then
      
      name := Name( category );
      
      name_membership_function := NameFunction( membership_function );
      
      if name_membership_function = "unknown" then
        
        name_membership_function := "a congruency test function";
        
      fi;
      
      name := Concatenation( "The stable category of ", name, " by ", name_membership_function );
      
    fi;
    
    stable_category := QuotientCategory( category, congruency_test_function: Name := name, FinalizeCategory := to_be_finalized );
    
    SetFilterObj( stable_category, IsStableCategory );
    
    SetCongruencyTestFunctionForStableCategory( stable_category, membership_function );
    
    return stable_category;
    
end );

##
InstallMethod( AsStableCategoryObject,
            [ IsStableCategory, IsCapCategoryObject ],
  function( stable_category, a )
    local stable_a;
    
    stable_a := AsQuotientCategoryObject( stable_category, a );
    
    SetFilterObj( stable_a, IsStableCategoryObject );
    
    return stable_a;
    
end );

##
InstallMethod( AsStableCategoryMorphism,
            [ IsStableCategory, IsCapCategoryMorphism ],
  function( stable_category, alpha )
    local stable_alpha;
    
    stable_alpha := AsQuotientCategoryMorphism( stable_category, alpha );
    
    SetFilterObj( stable_alpha, IsStableCategoryMorphism );
    
    return stable_alpha;
    
end );

########################
#
# constructor
#
########################

InstallMethod( StableCategoryByColiftingStructure,
            [ IsCapCategory ],
  function( category )
    local name, can_be_factored_through_colifting_object, stable_category, FinalizeCategory, Name,
            category_of_hom_structure, to_be_finalized, with_hom_structure;
    
    if not CanCompute( category, "MorphismIntoColiftingObject" ) then
      
      Error( "The method 'MorphismIntoColiftingObject' should be added to ", Name( category ) );
    
    fi;
    
    if not CanCompute( category, "Colift" ) then
      
      Error( "The method 'Colift' should be added to ", Name( category ) );
    
    fi;
    
    name := ValueOption( "Name" );
    
    can_be_factored_through_colifting_object :=
      function( alpha )
        local a, I_a;
        a := Source( alpha );
        I_a := MorphismIntoColiftingObject( a );
        return Colift( I_a, alpha ) <> fail;
      end;
    
    stable_category := StableCategory( category, can_be_factored_through_colifting_object : FinalizeCategory := false, Name := name );
    
    with_hom_structure := ValueOption( "WithHomomorphismStructure" );
    
    if with_hom_structure <> false and
         CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
           CanCompute( category, "HomomorphismStructureOnObjects" ) and
             CanCompute( category, "HomomorphismStructureOnMorphismsWithGivenObjects" ) and
               CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
                 CanCompute( category, "InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure" ) and
                   CanCompute( category, "InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism" ) then
                   
                    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
                   
                    if HasIsAbelianCategory( category_of_hom_structure ) and IsAbelianCategory( category_of_hom_structure ) then
                     
                      ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT( stable_category );
                  
                    else
                    
                      ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE( stable_category );
                    
                    fi;
    
    fi;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    if to_be_finalized = false then
      
      return stable_category;
      
    fi;
    
    Finalize( stable_category );
    
    return stable_category;
    
end );

InstallMethod( StableCategoryByLiftingStructure,
            [ IsCapCategory ],
  function( category )
    local to_be_finalized, name, can_be_factored_through_lifting_object, FinalizeCategory, Name;
    
    if not CanCompute( category, "MorphismFromLiftingObject" ) then
      
      Error( "The method 'MorphismFromLiftingObject' should be added to ", Name( category ) );
    
    fi;
    
    if not CanCompute( category, "Lift" ) then
      
      Error( "The method 'Lift' should be added to ", Name( category ) );
    
    fi;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    name := ValueOption( "Name" );
    
    can_be_factored_through_lifting_object :=
      function( alpha )
        local b, P_b;
        b := Range( alpha );
        P_b := MorphismFromLiftingObject( b );
        return Lift( alpha, P_b ) <> fail;
      end;
    
    return StableCategory( category, can_be_factored_through_lifting_object : FinalizeCategory := false, Name := name ); #Complete this
    
end );

##########################
#
#  Homomorphism structure
#
##########################

InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT,
  
  function( stable_category )
    local category, category_of_hom_structure;
    
    category := UnderlyingCapCategory( stable_category );
    
    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, category_of_hom_structure );
    
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         
         return DistinguishedObjectOfHomomorphismStructure( category );
    
    end );
    
    ##
    ##                a -----------> I(a)
    ##            hom(a,b) <---- hom(I(a),b)
    ##
    AddHomomorphismStructureOnObjects( stable_category,
      function( stable_a, stable_b )
        local a, b, a_to_I_a, hom_a_to_I_a_id_b, hom_object;
        
        a := UnderlyingCapCategoryObject( stable_a );
        
        b := UnderlyingCapCategoryObject( stable_b );
        
        a_to_I_a := MorphismIntoColiftingObject( a );
        
        hom_a_to_I_a_id_b := HomomorphismStructureOnMorphisms( a_to_I_a, IdentityMorphism( b ) );
        
        hom_object := CokernelObject( hom_a_to_I_a_id_b );
        
        hom_object!.UnderlyingMorphism := hom_a_to_I_a_id_b;
        
        return hom_object;
    
    end );
    
    ##                          coker(*)                        coker(*)
    ##
    ##
    ##
    ##      alpha                            hom(alpha,beta)
    ##  a --------> b           Hom( a, d ) <------------------ Hom( b, c )
    ##
    ##                             /|\                            /|\
    ##                              |                              |
    ##                              |                              |
    ##
    ##  d <-------- c         Hom( I(a), d )                  Hom( I(b), c )
    ##      beta
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( stable_category,
      function( s, stable_alpha, stable_beta, r )
        local a, b, c, d, alpha, beta, hom_b_to_I_b_id_c, hom_a_to_I_a_id_d, hom_alpha_beta;
        
        a := UnderlyingCapCategoryObject( Source( stable_alpha ) );
        
        b := UnderlyingCapCategoryObject( Range( stable_alpha ) );
        
        c := UnderlyingCapCategoryObject( Source( stable_beta ) );
        
        d := UnderlyingCapCategoryObject( Range( stable_beta ) );
        
        alpha := UnderlyingCapCategoryMorphism( stable_alpha );
        
        beta := UnderlyingCapCategoryMorphism( stable_beta );
        
        hom_b_to_I_b_id_c := s!.UnderlyingMorphism;
        
        hom_a_to_I_a_id_d := r!.UnderlyingMorphism;
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
        
        return CokernelObjectFunctorial( hom_b_to_I_b_id_c, hom_alpha_beta, hom_a_to_I_a_id_d );
        
    end );
    
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, hom_stable_a_stable_b, h, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        h := hom_stable_a_stable_b!.UnderlyingMorphism;
        
        alpha := UnderlyingCapCategoryMorphism( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha );
        
        return PreCompose( i, CokernelProjection( h ) );
        
    end );
    
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
      function( stable_a, stable_b, iota )
        local a, b, hom_stable_a_stable_b, h, l, i;
        
        a := UnderlyingCapCategoryObject( stable_a );
        
        b := UnderlyingCapCategoryObject( stable_b );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        h := hom_stable_a_stable_b!.UnderlyingMorphism;
        
        l := Lift( iota, CokernelProjection( h ) );
        
        i := InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( a, b, l );
        
        return AsStableCategoryMorphism( stable_category, i );
        
    end );
    
end );

InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE,
  
  function( stable_category )
    local category, range_category, freyd_cat;
     
    category := UnderlyingCapCategory( stable_category );
    
    range_category := RangeCategoryOfHomomorphismStructure( category );
    
    freyd_cat := FreydCategory( range_category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, freyd_cat );
    
    ##  -1       0       1
    ## 
    ##   0 <---- D <---- 0 <-----
    ##
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         local D;
         
         D := DistinguishedObjectOfHomomorphismStructure( category );
         
         return AsFreydCategoryObject( D );
         
    end );
    
    ##
    ##                a -----------> I(a)
    ##            hom(a,b) <---- hom(I(a),b)
    ##
    ##
    ##   -1          0               1                2
    ##
    ##    0 <---- hom(a,b) <---- hom(I(a),b) <------ 0 <---
    ##
    AddHomomorphismStructureOnObjects( stable_category,
      function( stable_a, stable_b )
        local a, b, a_to_I_a, hom_a_to_I_a_id_b, hom_object;
        
        a := UnderlyingCapCategoryObject( stable_a );
        
        b := UnderlyingCapCategoryObject( stable_b );
        
        a_to_I_a := MorphismIntoColiftingObject( a );
        
        hom_a_to_I_a_id_b := HomomorphismStructureOnMorphisms( a_to_I_a, IdentityMorphism( b ) );
        
        return FreydCategoryObject( hom_a_to_I_a_id_b );
    
    end );
    
    ##                          coker(*)                        coker(*)
    ##
    ##
    ##
    ##      alpha                            hom(alpha,beta)
    ##  a --------> b           Hom( a, d ) <------------------ Hom( b, c )
    ##
    ##                             /|\                            /|\
    ##                              |                              |
    ##                              |                              |
    ##
    ##  d <-------- c         Hom( I(a), d )                  Hom( I(b), c )
    ##      beta
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( stable_category,
      function( s, stable_alpha, stable_beta, r )
        local alpha, beta, hom_alpha_beta; 
        
        alpha := UnderlyingCapCategoryMorphism( stable_alpha );
        
        beta := UnderlyingCapCategoryMorphism( stable_beta );
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
                
        return FreydCategoryMorphism( s, hom_alpha_beta, r );
        
    end );
    
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, hom_stable_a_stable_b, D, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        D := DistinguishedObjectOfHomomorphismStructure( stable_category );
        
        alpha := UnderlyingCapCategoryMorphism( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha );
        
        return FreydCategoryMorphism( D, i, hom_stable_a_stable_b );
        
    end );
#    
#    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
#      function( stable_a, stable_b, iota )
#        local a, b, hom_stable_a_stable_b, h, l, i;
#        
#        a := UnderlyingCapCategoryObject( stable_a );
#        
#        b := UnderlyingCapCategoryObject( stable_b );
#        
#        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
#        
#        h := hom_stable_a_stable_b!.UnderlyingMorphism;
#        
#        l := Lift( iota, CokernelProjection( h ) );
#        
#        i := InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( a, b, l );
#        
#        return AsStableCategoryMorphism( stable_category, i );
#        
#    end );
    
end );


#######################
#
# Display
#
######################

##
InstallMethod( Display,
            [ IsStableCategoryObject ],
  function( a )
    local test_function, name;
    
    test_function := CongruencyTestFunctionForStableCategory( CapCategory( a ) );
    
    name := NameFunction( test_function );
    
    if name = "unknown" then
      
      name := "a congruency test function";
    
    fi;
    
    Print( "Stable object defined by:\n\n" );
    
    Display( UnderlyingCapCategoryObject( a ) );
    
    Print( "\nmodulo ", name );
    
end );

##
InstallMethod( Display,
            [ IsStableCategoryMorphism ],
  function( alpha )
    local name, test_function;
    
    test_function := CongruencyTestFunctionForStableCategory( CapCategory( alpha ) );
    
    name := NameFunction( test_function );
    
    if name = "unknown" then
      
      name := "a congruency test function";
      
    fi;
    
    Print( "Stable morphism defined by:\n\n" );
    
    Display( UnderlyingCapCategoryMorphism( alpha ) );
    
    Print( "\nmodulo ", name );
  
end );

