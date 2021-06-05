# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#
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

IsLiftingObject := rec(
  installation_name := "IsLiftingObject",
  filter_list := [ "category", "object" ],
  return_type := "bool" ),

LiftingObject := rec(
  installation_name := "LiftingObject",
  filter_list := [ "category", "object" ],
  return_type := "object" ),

LiftingMorphismWithGivenLiftingObjects := rec(
    installation_name := "LiftingMorphismWithGivenLiftingObjects",
    filter_list := [ "category", "object", "morphism", "object" ],
    return_type := "morphism" ),
    
MorphismFromLiftingObjectWithGivenLiftingObject := rec(
  installation_name := "MorphismFromLiftingObjectWithGivenLiftingObject",
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism" ),

MorphismFromLiftingObject := rec(
  installation_name := "MorphismFromLiftingObject",
  filter_list := [ "category", "object" ],
  with_given_object_position := "Source",
  return_type := "morphism" ),

SectionOfMorphismFromLiftingObjectWithGivenLiftingObject := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism" ),

SectionOfMorphismFromLiftingObject := rec(
  filter_list := [ "category", "object" ],
  with_given_object_position := "Range",
  return_type := "morphism" ),

IsLiftableAlongMorphismFromLiftingObject := rec(
  installation_name := "IsLiftableAlongMorphismFromLiftingObject",
  filter_list := [ "category", "morphism" ],
  return_type := "bool" ),

WitnessForBeingLiftableAlongMorphismFromLiftingObject := rec(
  installation_name := "WitnessForBeingLiftableAlongMorphismFromLiftingObject",
  filter_list := [ "category", "morphism" ],
  return_type := "morphism" ),

IsColiftingObject := rec(
  installation_name := "IsColiftingObject",
  filter_list := [ "category", "object" ],
  return_type := "bool" ),

ColiftingObject := rec(
  installation_name := "ColiftingObject",
  filter_list := [ "category", "object" ],
  return_type := "object" ),

ColiftingMorphismWithGivenColiftingObjects := rec(
  installation_name := "ColiftingMorphismWithGivenColiftingObjects",
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism" ),
  
MorphismToColiftingObjectWithGivenColiftingObject := rec(
  installation_name := "MorphismToColiftingObjectWithGivenColiftingObject",
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism" ),

MorphismToColiftingObject := rec(
  installation_name := "MorphismToColiftingObject",
  filter_list := [ "category", "object" ],
  with_given_object_position := "Range",
  return_type := "morphism" ),

RetractionOfMorphismToColiftingObjectWithGivenColiftingObject := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism" ),

RetractionOfMorphismToColiftingObject := rec(
  filter_list := [ "category", "object" ],
  with_given_object_position := "Source",
  return_type := "morphism" ),

IsColiftableAlongMorphismToColiftingObject := rec(
  installation_name := "IsColiftableAlongMorphismToColiftingObject",
  filter_list := [ "category", "morphism" ],
  return_type := "bool" ),

WitnessForBeingColiftableAlongMorphismToColiftingObject := rec(
  installation_name := "WitnessForBeingColiftableAlongMorphismToColiftingObject",
  filter_list := [ "category", "morphism" ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( STABLE_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( STABLE_CATEGORIES_METHOD_NAME_RECORD );

########################
#
# convenience methods
#
########################

##
InstallMethod( LiftingMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> LiftingMorphismWithGivenLiftingObjects(
                LiftingObject( Source( alpha ) ),
                alpha,
                LiftingObject( Range( alpha ) )
              )
);

##
InstallMethod( ColiftingMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> ColiftingMorphismWithGivenColiftingObjects(
                ColiftingObject( Source( alpha ) ),
                alpha,
                ColiftingObject( Range( alpha ) )
              )
);

########################
#
# category constructor
#
########################

InstallMethod( StableCategoryBySystemOfColiftingObjects,
            [ IsCapCategory ],
  function( category )
    local name, can_be_factored_through_colifting_object, special_filters, stable_category,
      SpecialFilters, with_hom_structure, category_of_hom_structure, to_be_finalized;
    
    if not CanCompute( category, "MorphismToColiftingObject" ) then
      
      Error( "The method 'MorphismToColiftingObject' should be added to ", Name( category ) );
    
    fi;
    
    if not CanCompute( category, "Colift" ) then
      
      Error( "The method 'Colift' should be added to ", Name( category ) );
    
    fi;
    
    name := ValueOption( "NameOfCategory" );
    
    can_be_factored_through_colifting_object := IsColiftableAlongMorphismToColiftingObject;
     
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

InstallMethod( StableCategoryBySystemOfLiftingObjects,
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
    
    can_be_factored_through_lifting_object := IsLiftableAlongMorphismFromLiftingObject;
    
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

########################
#
# cells constructor
#
########################

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
  function( a, Q )
    
    if not IsIdenticalObj( CapCategory( a ), UnderlyingCategory( Q ) ) then
        TryNextMethod( );
    fi;
    
    return StableCategoryObject( Q, a );
    
end );

InstallMethod( StableCategoryMorphism,
          [ IsStableCategoryObject, IsCapCategoryMorphism, IsStableCategoryObject ],
  function( s, alpha, r )
    
    alpha := QuotientCategoryMorphism( s, alpha, r );
    
    SetFilterObj( alpha, IsStableCategoryMorphism );
    
    return alpha;
    
end );

##
InstallMethod( StableCategoryMorphism,
            [ IsStableCategory, IsCapCategoryMorphism ],
  function( stable_category, alpha )
    
    alpha := QuotientCategoryMorphism( stable_category, alpha );
    
    SetFilterObj( alpha, IsStableCategoryMorphism );
    
    return alpha;
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryMorphism, IsStableCategory ],
  function( a, Q )
    
    if not IsIdenticalObj( CapCategory( a ), UnderlyingCategory( Q ) ) then
        TryNextMethod( );
    fi;
    
    return StableCategoryMorphism( Q, a );
    
end );

############################
#
#  Homomorphism structure
#
###########################

InstallMethodWithCache( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS,
  [ IsStableCategoryObject, IsStableCategoryObject ],
  function( stable_a, stable_b )
    local a, b, a_to_I_a;
        
    a := UnderlyingCell( stable_a );
        
    b := UnderlyingCell( stable_b );
        
    a_to_I_a := MorphismToColiftingObject( a );
        
    return HomomorphismStructureOnMorphisms( a_to_I_a, IdentityMorphism( b ) );
  
end );

InstallMethodWithCache( HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS,
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
    
    Print( "An object in ", Name( CapCategory( a ) ), " defined by the underlying object:\n\n" );
    
    Display( UnderlyingCell( a ) );
    
end );

##
InstallMethod( Display,
            [ IsStableCategoryMorphism ],
  function( alpha )
    
    Print( "A morphism in ", Name( CapCategory( alpha ) ), " defined by the underlying morphism:\n\n" );
    
    Display( UnderlyingCell( alpha ) );
    
end );

