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

IsLiftableThroughLiftingObject := rec(
  installation_name := "IsLiftableThroughLiftingObject",
  filter_list := [ "morphism" ],
  cache_name := "IsLiftableThroughLiftingObject",
  return_type := "bool" ),

WitnessForBeingLiftableThroughLiftingObject := rec(
  installation_name := "WitnessForBeingLiftableThroughLiftingObject",
  filter_list := [ "morphism" ],
  cache_name := "WitnessForBeingLiftableThroughLiftingObject",
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

IsColiftableThroughColiftingObject := rec(
  installation_name := "IsColiftableThroughColiftingObject",
  filter_list := [ "morphism" ],
  cache_name := "IsColiftableThroughColiftingObject",
  return_type := "bool" ),

WitnessForBeingColiftableThroughColiftingObject := rec(
  installation_name := "WitnessForBeingColiftableThroughColiftingObject",
  filter_list := [ "morphism" ],
  cache_name := "WitnessForBeingColiftableThroughColiftingObject",
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
    local congruency_test_function, to_be_finalized, name, name_membership_function, special_filters, stable_category;
    
    if not HasIsAdditiveCategory( category ) or not IsAdditiveCategory( category ) then
      
      Error( "The category in the input should be additive category" );
    
    fi;
    
    if not HasIsFinalized( category ) then
      
      Error( "The category in the input should be finalized category" );
    
    fi;
    
    congruency_test_function := function( alpha, beta ) return membership_function( alpha - beta ); end;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    name := ValueOption( "NameOfCategory" );
    
    if name = fail then
      
      name := Name( category );
      
      name_membership_function := NameFunction( membership_function );
      
      if name_membership_function = "unknown" then
        
        name_membership_function := "a congruency test function";
        
      fi;
      
      name := Concatenation( "Stable category( ", name, " ) defined by ", name_membership_function );
    
    fi;
    
    special_filters := ValueOption( "SpecialFilters" );
    
    if special_filters = fail then
      
      special_filters := [ IsStableCategory, IsStableCategoryObject, IsStableCategoryMorphism ];
    
    fi;
    
    stable_category := QuotientCategory( category, congruency_test_function: NameOfCategory := name,
                                                                             FinalizeCategory := false,
                                                                             SpecialFilters := special_filters );
    
    # It can be derived, but this is better, because the function membership_function may have been implemented
    # to set some attributes, for example HomotopyMorphism in case the stable category is some homotopy category.
    AddIsZeroForMorphisms( stable_category, phi -> membership_function( UnderlyingCell( phi ) ) );
    
    SetCongruencyTestFunctionForStableCategory( stable_category, membership_function );
    
    if to_be_finalized = true then
      
      Finalize( stable_category );
      
    fi;
    
    return stable_category;
    
end );

##
InstallMethod( StableCategoryObject,
            [ IsStableCategory, IsCapCategoryObject ],
  function( stable_category, a )
    local stable_a;
    
    stable_a := QuotientCategoryObject( stable_category, a );
    
    SetFilterObj( stable_a, IsStableCategoryObject );
    
    return stable_a;
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryObject, IsStableCategory ],
  {a,Q} -> StableCategoryObject( Q, a )
);


##
InstallMethod( StableCategoryMorphism,
            [ IsStableCategory, IsCapCategoryMorphism ],
  function( stable_category, alpha )
    local stable_alpha;
    
    stable_alpha := QuotientCategoryMorphism( stable_category, alpha );
    
    SetFilterObj( stable_alpha, IsStableCategoryMorphism );
    
    return stable_alpha;
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryMorphism, IsStableCategory ],
  {a,Q} -> StableCategoryMorphism( Q, a )
);


########################
#
# constructor
#
########################

InstallMethod( StableCategoryByColiftingStructure,
            [ IsCapCategory ],
  function( category )
    local name, can_be_factored_through_colifting_object, special_filters, stable_category,
      SpecialFilters, with_hom_structure, category_of_hom_structure, to_be_finalized;
    
    if not CanCompute( category, "MorphismIntoColiftingObject" ) then
      
      Error( "The method 'MorphismIntoColiftingObject' should be added to ", Name( category ) );
    
    fi;
    
    if not CanCompute( category, "Colift" ) then
      
      Error( "The method 'Colift' should be added to ", Name( category ) );
    
    fi;
    
    name := ValueOption( "NameOfCategory" );
    
    can_be_factored_through_colifting_object := IsColiftableThroughColiftingObject;
     
    stable_category := StableCategory( category, can_be_factored_through_colifting_object : FinalizeCategory := false, NameOfCategory := name );
    
    with_hom_structure := ValueOption( "WithHomomorphismStructure" );
    
    if with_hom_structure <> false and
         CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
           CanCompute( category, "HomomorphismStructureOnObjects" ) and
             CanCompute( category, "HomomorphismStructureOnMorphismsWithGivenObjects" ) and
               CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
                 CanCompute( category, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) and
                   CanCompute( category, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) then
                   
                    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
                   
                    if HasIsAbelianCategory( category_of_hom_structure ) and IsAbelianCategory( category_of_hom_structure ) then
                     
                      ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT( stable_category );
                  
                    elif  LoadPackage( "FreydCategories" ) = true then
                      
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
    local name, can_be_factored_through_lifting_object, stable_category, with_hom_structure, category_of_hom_structure, to_be_finalized;
    
    if not CanCompute( category, "MorphismFromLiftingObject" ) then
      
      Error( "The method 'MorphismFromLiftingObject' should be added to ", Name( category ) );
    
    fi;
    
    if not CanCompute( category, "Lift" ) then
      
      Error( "The method 'Lift' should be added to ", Name( category ) );
    
    fi;
     
    name := ValueOption( "NameOfCategory" );
    
    can_be_factored_through_lifting_object := IsLiftableThroughLiftingObject;
    
    stable_category := StableCategory( category, can_be_factored_through_lifting_object : FinalizeCategory := false, NameOfCategory := name );
    
    with_hom_structure := ValueOption( "WithHomomorphismStructure" );
    
    if with_hom_structure <> false and
         CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
           CanCompute( category, "HomomorphismStructureOnObjects" ) and
             CanCompute( category, "HomomorphismStructureOnMorphismsWithGivenObjects" ) and
               CanCompute( category, "DistinguishedObjectOfHomomorphismStructure" ) and
                 CanCompute( category, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) and
                   CanCompute( category, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) then
                    
                    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
                    
                    if HasIsAbelianCategory( category_of_hom_structure ) and IsAbelianCategory( category_of_hom_structure ) then
                     
                      ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT( stable_category );
                    
                    elif LoadPackage( "FreydCategories" ) = true then
                      
                      ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE( stable_category );
                    
                    fi;
    
    fi;
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    if to_be_finalized = false then
      
      return stable_category;
      
    fi;
    
    Finalize( stable_category );
    
    return stable_category;
    
end );

#########################
#
#  Homomorphism structure
#
##########################

InstallMethodWithCrispCache( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS,
  [ IsStableCategoryObject, IsStableCategoryObject ],
  function( stable_a, stable_b )
    local a, b, a_to_I_a;
        
    a := UnderlyingCell( stable_a );
        
    b := UnderlyingCell( stable_b );
        
    a_to_I_a := MorphismIntoColiftingObject( a );
        
    return HomomorphismStructureOnMorphisms( a_to_I_a, IdentityMorphism( b ) );
  
end );

InstallMethodWithCrispCache( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS,
  [ IsStableCategoryObject, IsStableCategoryObject ],
  function( stable_a, stable_b )
    local a, b, P_b_to_b;
        
    a := UnderlyingCell( stable_a );
        
    b := UnderlyingCell( stable_b );
        
    P_b_to_b := MorphismFromLiftingObject( b );
        
    return HomomorphismStructureOnMorphisms( IdentityMorphism( a ), P_b_to_b );
  
end );



InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT,
  
  function( stable_category )
    local category, category_of_hom_structure;
    
    category := UnderlyingCategory( stable_category );
    
    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, category_of_hom_structure );
    
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         
         return DistinguishedObjectOfHomomorphismStructure( category );
    
    end );
    
    ##
    ##                              a -----------> I(a)
    ##
    ##   _hom_(_a_,_b_ ) <<-----  hom(a,b) <---- hom(I(a),b)
    ##

    AddHomomorphismStructureOnObjects( stable_category,
      function( stable_a, stable_b )
        
        return CokernelObject( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( stable_a, stable_b ) );
    
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
        
        a := UnderlyingCell( Source( stable_alpha ) );
        
        b := UnderlyingCell( Range( stable_alpha ) );
        
        c := UnderlyingCell( Source( stable_beta ) );
        
        d := UnderlyingCell( Range( stable_beta ) );
        
        alpha := UnderlyingCell( stable_alpha );
        
        beta := UnderlyingCell( stable_beta );
        
        hom_b_to_I_b_id_c := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( Range( stable_alpha ),  Source( stable_beta ) );
        
        hom_a_to_I_a_id_d := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( Source( stable_alpha ), Range( stable_beta ) );
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
        
        return CokernelObjectFunctorial( hom_b_to_I_b_id_c, hom_alpha_beta, hom_a_to_I_a_id_d );
        
    end );

    ##
    ##                              a -----------> I(a)
    ##
    ##   _hom_(_a_,_b_ ) <<-----  hom(a,b) <---- hom(I(a),b)
    ##

    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, h, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
         
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( stable_a, stable_b );
        
        alpha := UnderlyingCell( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
        
        return PreCompose( i, CokernelProjection( h ) );
        
    end );

    ##
    ##                              a -----------> I(a)
    ##
    ##   _hom_(_a_,_b_ ) <<-----  hom(a,b) <---- hom(I(a),b)
    ##

    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
      function( stable_a, stable_b, iota )
        local a, b, h, l, i;
        
        a := UnderlyingCell( stable_a );
        
        b := UnderlyingCell( stable_b );
        
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( stable_a, stable_b );
        
        l := Lift( iota, CokernelProjection( h ) );
        
        i := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, l );
        
        return StableCategoryMorphism( stable_category, i );
        
    end );
    
end );

InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE,
  
  function( stable_category )
    local category, range_category, freyd_cat;
    
    category := UnderlyingCategory( stable_category );
    
    range_category := RangeCategoryOfHomomorphismStructure( category );
    
    freyd_cat := ValueGlobal( "FreydCategory" )( range_category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, freyd_cat );
    
    ##  -1       0       1
    ## 
    ##   0 <---- D <---- 0 <-----
    ##
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         local D;
         
         D := DistinguishedObjectOfHomomorphismStructure( category );
         
         return ValueGlobal( "AsFreydCategoryObject" )( D );
         
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
        local h;
        
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS( stable_a, stable_b );
        
        return ValueGlobal( "FreydCategoryObject" )( h );
    
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
        
        alpha := UnderlyingCell( stable_alpha );
        
        beta := UnderlyingCell( stable_beta );
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
                
        return ValueGlobal( "FreydCategoryMorphism" )( s, hom_alpha_beta, r );
        
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, hom_stable_a_stable_b, D, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        D := DistinguishedObjectOfHomomorphismStructure( stable_category );
        
        alpha := UnderlyingCell( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
        
        return ValueGlobal( "FreydCategoryMorphism" )( D, i, hom_stable_a_stable_b );
        
    end );
    #    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
      function( stable_a, stable_b, iota )
        local a, b, h, i;
        
        a := UnderlyingCell( stable_a );
        
        b := UnderlyingCell( stable_b );
        
        h := ValueGlobal( "MorphismDatum" )( iota );
        
        i := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, h );
        
        return StableCategoryMorphism( stable_category, i );
        
    end );
    
end );

InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT,
  
  function( stable_category )
    local category, category_of_hom_structure;
    
    category := UnderlyingCategory( stable_category );
    
    category_of_hom_structure := RangeCategoryOfHomomorphismStructure( category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, category_of_hom_structure );
    
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         
         return DistinguishedObjectOfHomomorphismStructure( category );
    
    end );
       
    ##
    ##                              b <----------- P(b)
    ##
    ##  _hom_(_a_,_b_ ) <<-----   hom(a,b) <---- hom(a,P(b))
    ##
 
    AddHomomorphismStructureOnObjects( stable_category,
      function( stable_a, stable_b )
        
        return CokernelObject( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( stable_a, stable_b ) );
    
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
    ##  d <-------- c         Hom( a, P(d) )                  Hom( b, P(c) )
    ##      beta
    ##
    
    AddHomomorphismStructureOnMorphismsWithGivenObjects( stable_category,
      function( s, stable_alpha, stable_beta, r )
        local a, b, c, d, alpha, beta, hom_id_b_P_c_to_c, hom_id_a_P_d_to_d, hom_alpha_beta;
        
        a := UnderlyingCell( Source( stable_alpha ) );
        
        b := UnderlyingCell( Range( stable_alpha ) );
        
        c := UnderlyingCell( Source( stable_beta ) );
        
        d := UnderlyingCell( Range( stable_beta ) );
        
        alpha := UnderlyingCell( stable_alpha );
        
        beta := UnderlyingCell( stable_beta );
        
        hom_id_b_P_c_to_c := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( Range( stable_alpha ),  Source( stable_beta ) );
        
        hom_id_a_P_d_to_d := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( Source( stable_alpha ), Range( stable_beta ) );
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
        
        return CokernelObjectFunctorial( hom_id_b_P_c_to_c, hom_alpha_beta, hom_id_a_P_d_to_d );
        
    end );

    ##
    ##                              b <----------- P(b)
    ##
    ##  _hom_(_a_,_b_ ) <<-----   hom(a,b) <---- hom(a,P(b))
    ##
    
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, hom_stable_a_stable_b, h, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( stable_a, stable_b );
        
        alpha := UnderlyingCell( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
        
        return PreCompose( i, CokernelProjection( h ) );
        
    end );
    
    ##
    ##                              b <----------- P(b)
    ##
    ##  _hom_(_a_,_b_ ) <<-----   hom(a,b) <---- hom(a,P(b))
    ##
    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
      function( stable_a, stable_b, iota )
        local a, b, h, l, i;
        
        a := UnderlyingCell( stable_a );
        
        b := UnderlyingCell( stable_b );
            
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( stable_a, stable_b );
        
        l := Lift( iota, CokernelProjection( h ) );
        
        i := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, l );
        
        return StableCategoryMorphism( stable_category, i );
        
    end );
    
end );

InstallGlobalFunction( ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE,
  
  function( stable_category )
    local category, range_category, freyd_cat;
     
    category := UnderlyingCategory( stable_category );
    
    range_category := RangeCategoryOfHomomorphismStructure( category );
    
    freyd_cat := ValueGlobal( "FreydCategory" )( range_category );
    
    SetRangeCategoryOfHomomorphismStructure( stable_category, freyd_cat );
    
    ##  -1       0       1
    ## 
    ##   0 <---- D <---- 0 <-----
    ##
    AddDistinguishedObjectOfHomomorphismStructure( stable_category,
       function( )
         local D;
         
         D := DistinguishedObjectOfHomomorphismStructure( category );
         
         return ValueGlobal( "AsFreydCategoryObject" )( D );
         
    end );
    
    ##
    ##                b <---------- P(b)
    ##            hom(a,b) <---- hom(a,P(b))
    ##
    ##
    ##   -1          0               1                2
    ##
    ##    0 <---- hom(a,b) <---- hom(a,P(b)) <------ 0 <---
    ##
    AddHomomorphismStructureOnObjects( stable_category,
      function( stable_a, stable_b )
        local h;
        
        h := HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS( stable_a, stable_b );
        
        return ValueGlobal( "FreydCategoryObject" )( h );
    
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
    ##  d <-------- c         Hom( a, P(d) )                  Hom( b, P(c) )
    ##      beta
    ##
    
   AddHomomorphismStructureOnMorphismsWithGivenObjects( stable_category,
      function( s, stable_alpha, stable_beta, r )
        local alpha, beta, hom_alpha_beta; 
        
        alpha := UnderlyingCell( stable_alpha );
        
        beta := UnderlyingCell( stable_beta );
        
        hom_alpha_beta := HomomorphismStructureOnMorphisms( alpha, beta );
                
        return ValueGlobal( "FreydCategoryMorphism" )( s, hom_alpha_beta, r );
        
    end );
    
    ##
    ##                              b <----------- P(b)
    ##
    ##  _hom_(_a_,_b_ )  := Freyd( hom(a,b) <---- hom(a,P(b)) )
    ##
 
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( stable_category,
      function( stable_alpha )
        local stable_a, stable_b, hom_stable_a_stable_b, D, alpha, i;
        
        stable_a := Source( stable_alpha );
        
        stable_b := Range( stable_alpha );
        
        hom_stable_a_stable_b := HomomorphismStructureOnObjects( stable_a, stable_b );
        
        D := DistinguishedObjectOfHomomorphismStructure( stable_category );
        
        alpha := UnderlyingCell( stable_alpha );
        
        i := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
        
        return ValueGlobal( "FreydCategoryMorphism" )( D, i, hom_stable_a_stable_b );
        
    end );
    #    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( stable_category,
      function( stable_a, stable_b, iota )
        local a, b, h, i;
        
        a := UnderlyingCell( stable_a );
        
        b := UnderlyingCell( stable_b );
        
        h := ValueGlobal( "MorphismDatum" )( iota );
        
        i := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, h );
        
        return StableCategoryMorphism( stable_category, i );
        
    end );
    
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
      
    Print( "An object in a stable category defined by:\n\n" );
         
    Display( UnderlyingCell( a ) );
    
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
    
    Print( "A morphism in a stable category defined by:\n\n" );
    
    Display( UnderlyingCell( alpha ) );
    
    Print( "\nmodulo ", name );
  
end );

