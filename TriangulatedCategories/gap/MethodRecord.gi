# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

###############################
##
##  Methods record
##
###############################

InstallValue( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, rec(

StandardConeObject:= rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object"
),

MorphismIntoStandardConeObject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_range", "cone" ] ],
  with_given_object_position := "Range",
  return_type := "morphism"
),

MorphismIntoStandardConeObjectWithGivenStandardConeObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "cone" ], [ "alpha_range", "cone" ] ],
  return_type := "morphism"
),

MorphismFromStandardConeObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "StandardConeObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "StandardConeObject", 1 ] ],
  output_range_getter_string := "ShiftOfObject( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "ShiftOfObject", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism"
),

MorphismFromStandardConeObjectWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "cone_alpha", "alpha", "sh_source_alpha" ],
  output_source_getter_string := "cone_alpha",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "sh_source_alpha",
  output_range_getter_preconditions := [ ],
  return_type := "morphism"
),

ShiftOfObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object"
),

ShiftOfMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

InverseShiftOfObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object"
),

InverseShiftOfMorphismWithGivenObjects := rec(
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

ShiftOfObjectByInteger := rec(
  filter_list := [ "category", "object", "integer" ],
  return_type := "object"
),

ShiftOfMorphismByIntegerWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "integer", "object" ],
  return_type := "morphism"
),

ShiftOfMorphismByInteger := rec(
  filter_list := [ "category", "morphism", "integer" ],
  return_type := "morphism"
),

WitnessIsomorphismIntoStandardConeObject := rec(
  io_type := [ [ "alpha", "iota", "pi" ], [ "range_iota", "cone_alpha" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

WitnessIsomorphismFromStandardConeObject := rec(
  io_type := [ [ "alpha", "iota", "pi" ], [ "cone_alpha", "range_iota" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

IsExactTriangle := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "bool"
),

UnitOfShiftAdjunctionWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseOfCounitOfShiftAdjunctionWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseOfUnitOfShiftAdjunctionWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "r" ], [ "r", "s" ] ],
  return_type := "morphism"
),

CounitOfShiftAdjunctionWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "r" ], [ "r", "s" ] ],
  return_type := "morphism"
),

MorphismBetweenStandardConeObjectsWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "cone_alpha", "list", "cone_alpha_prime" ], [ "cone_alpha", "cone_alpha_prime" ] ],
  return_type := "morphism",
),

DomainMorphismByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismFromConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "cone_g", "f", "g", "h", "st_cone" ], [ "cone_g", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "g", "h", "cone_g" ], [ "st_cone", "cone_g" ] ],
  return_type := "morphism",
),

WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

ShiftExpandingIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

ShiftFactoringIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftExpandingIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftFactoringIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
)

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD,
    "TriangulatedCategories",
    "MethodRecord.autogen.gd",
    "operations for triangulated categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, "TriangulatedCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


###########################################
#
# Convenient methods
#
##########################################

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    ShiftOfMorphism :=
      [ [ "ShiftOfMorphismWithGivenObjects", 1 ], [ "ShiftOfObject", 2 ] ]
  )
);

InstallMethod( ShiftOfMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> ShiftOfMorphismWithGivenObjects(
              ShiftOfObject( Source( alpha ) ),
              alpha,
              ShiftOfObject( Range( alpha ) )
            )
);

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    InverseShiftOfMorphism :=
      [ [ "InverseShiftOfMorphismWithGivenObjects", 1 ], [ "InverseShiftOfObject", 2 ] ]
  )
);

InstallMethod( InverseShiftOfMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> InverseShiftOfMorphismWithGivenObjects(
              InverseShiftOfObject( Source( alpha ) ),
              alpha,
              InverseShiftOfObject( Range( alpha ) )
            )
);

##
InstallMethod( ConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    
    return StandardConeObject( beta );
    
end );

##
InstallMethod( MorphismBetweenStandardConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    local cone_alpha, cone_beta;
    
    cone_alpha := StandardConeObject( alpha );

    cone_beta := StandardConeObject( beta );
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects(
            cone_alpha, [ alpha, mu, nu, beta ], cone_beta );
end );

##
InstallMethod( MorphismBetweenStandardConeObjectsWithGivenObjects,
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
  function( cone_alpha, alpha, mu, nu, beta, cone_beta )
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects(
            cone_alpha, [ alpha, mu, nu, beta ], cone_beta );
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    s := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
    
    r := StandardConeObject( u );
    
    return WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    s := StandardConeObject( u );

    r := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
    
    return WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( ConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return ShiftOfObject( Source( alpha ) );
    
end );

##
InstallMethod( DomainMorphismByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismIntoStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismIntoConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismFromStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismFromConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return AdditiveInverseForMorphisms( ShiftOfMorphism( alpha ) );
    
end );

##
InstallMethod( ConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return Range( alpha );
    
end );

##
InstallMethod( DomainMorphismByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local u;
    
    u := MorphismFromStandardConeObject( alpha );
    
    return PreCompose(
              AdditiveInverseForMorphisms( InverseShiftOfMorphism( u ) ),
              CounitOfShiftAdjunction( Source( alpha ) )
            );
    
end );

##
InstallMethod( MorphismIntoConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ], IdFunc
);

##
InstallMethod( MorphismFromConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return PreCompose(
              MorphismIntoStandardConeObject( alpha ),
              UnitOfShiftAdjunction( StandardConeObject( alpha ) )
            );
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    return WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    r := ConeObjectByRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByInverseRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    return WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    r := ConeObjectByInverseRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( DomainMorphismByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( alpha );
    
    r := StandardConeObject( gamma );
    
    return DomainMorphismByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
  
end );

##
InstallMethod( MorphismIntoConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( gamma );
    
    r := StandardConeObject( beta );
    
    return MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( MorphismFromConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
     
    s := StandardConeObject( beta );
    
    r := ShiftOfObject( StandardConeObject( alpha ) );
    
    return MorphismFromConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( StandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOfObject( StandardConeObject( alpha ) );
    
end );

##
InstallMethod( MorphismFromStandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOfMorphism(
                  MorphismFromStandardConeObject( alpha )
                );
    
end );

##
InstallMethod( MorphismBetweenStandardCoConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    
    return InverseShiftOfMorphism(
              MorphismBetweenStandardConeObjects(
                    alpha,
                    mu,
                    nu,
                    beta
                  )
              );
    
end );

##
InstallMethod( CounitOfShiftAdjunction,
          [ IsCapCategoryObject ],
  IdentityMorphism
  #a -> CounitOfShiftAdjunctionWithGivenObject( a, InverseShiftOfObject( ShiftOfObject( a ) ) )
);

##
InstallMethod( InverseOfCounitOfShiftAdjunction,
          [ IsCapCategoryObject ],
  IdentityMorphism
  #a -> InverseOfCounitOfShiftAdjunctionWithGivenObject( a, InverseShiftOfObject( ShiftOfObject( a ) ) )
);

##
InstallMethod( UnitOfShiftAdjunction,
          [ IsCapCategoryObject ],
  IdentityMorphism
  #a -> UnitOfShiftAdjunctionWithGivenObject( a, ShiftOfObject( InverseShiftOfObject( a ) ) )
);

##
InstallMethod( InverseOfUnitOfShiftAdjunction,
          [ IsCapCategoryObject ],
  IdentityMorphism
  #a -> InverseOfUnitOfShiftAdjunctionWithGivenObject( a, ShiftOfObject( InverseShiftOfObject( a ) ) )
);

###
#InstallMethod( ShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return ShiftExpandingIsomorphismWithGivenObjects( ShiftOfObject( DirectSum( L ) ), L, DirectSum( List( L, ShiftOfObject ) ) );
#end );
#
###
#InstallMethod( InverseShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return InverseShiftExpandingIsomorphismWithGivenObjects(
#            InverseShiftOfObject( DirectSum( L ) ),
#            L,
#            DirectSum( List( L, InverseShiftOfObject ) )
#          );
#end );
#
###
#InstallMethod( ShiftFactoringIsomorphism,
#                [ IsList ],
#    function( L )
#    return ShiftFactoringIsomorphismWithGivenObjects(
#            DirectSum(
#            List( L, ShiftOfObject ) ),
#            L,
#            ShiftOfObject( DirectSum( L ) )
#          );
#end );
#
###
#InstallMethod( InverseShiftFactoringIsomorphism,
#          [ IsList ],
#    function( L )
#    return InverseShiftFactoringIsomorphismWithGivenObjects(
#              DirectSum( List( L, InverseShiftOfObject ) ),
#              L,
#              InverseShiftOfObject( DirectSum( L ) )
#          );
#end );

###
#InstallMethod( IsomorphismFromStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismFromStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismFromStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#
###
#InstallMethod( IsomorphismIntoStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismIntoStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismIntoStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#

##
InstallMethod( ShiftOp,
          [ IsCapCategoryCell, IsInt ],
  function( cell, n )
    
    if IsCapCategoryObject( cell ) then
        return ShiftOfObjectByInteger( cell, n );
    else
        return ShiftOfMorphismByInteger( cell, n );
    fi;
    
end );

