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
  installation_name := "StandardConeObject",
  filter_list := [ "category", "morphism" ],
  return_type := "object"
),

MorphismToStandardConeObjectWithGivenStandardConeObject := rec(
  installation_name := "MorphismToStandardConeObjectWithGivenStandardConeObject",
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "range_alpha", "cone_alpha" ] ],
  return_type := "morphism"
),

MorphismFromStandardConeObjectWithGivenStandardConeObject := rec(
  installation_name := "MorphismFromStandardConeObjectWithGivenStandardConeObject",
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
  return_type := "morphism"
),

MorphismToStandardConeObject := rec(
  installation_name := "MorphismToStandardConeObject",
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "range_alpha", "cone_alpha" ] ],
  with_given_object_position := "Range",
  return_type := "morphism"
),

MorphismFromStandardConeObject := rec(
  installation_name := "MorphismFromStandardConeObject",
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
  with_given_object_position := "Source",
  return_type := "morphism"
),

ShiftOnObject:= rec(
  installation_name := "ShiftOnObject",
  filter_list := [ "category", "object" ],
  return_type := "object"
),

ShiftOnMorphismWithGivenObjects := rec(
  installation_name := "ShiftOnMorphismWithGivenObjects",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

InverseShiftOnObject := rec(
  installation_name := "InverseShiftOnObject",
  filter_list := [ "category", "object" ],
  return_type := "object"
),

InverseShiftOnMorphismWithGivenObjects := rec(
  installation_name := "InverseShiftOnMorphismWithGivenObjects",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

WitnessIsomorphismOntoStandardConeObject := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObject",
  io_type := [ [ "alpha", "iota", "pi" ], [ "range_iota", "cone_alpha" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

WitnessIsomorphismFromStandardConeObject := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObject",
  io_type := [ [ "alpha", "iota", "pi" ], [ "cone_alpha", "range_iota" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

IsExactTriangle := rec(
  installation_name := "IsExactTriangle",
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "bool"
),

UnitIsomorphismWithGivenObject := rec(
  installation_name := "UnitIsomorphismWithGivenObject",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "s", "sh_o_rev_sh_s" ] ],
  return_type := "morphism"
),

#UnitIsomorphism := rec(
#  installation_name := "UnitIsomorphism",
#  filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
#  return_type := "morphism"
#),

InverseOfCounitIsomorphismWithGivenObject := rec(
  installation_name := "InverseOfCounitIsomorphismWithGivenObject",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "s", "rev_sh_o_sh_s" ] ],
  return_type := "morphism"
),

#InverseOfCounitIsomorphism := rec(
#  installation_name := "InverseOfCounitIsomorphism",
#  filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
#  return_type := "morphism"
#),

InverseOfUnitIsomorphismWithGivenObject := rec(
  installation_name := "InverseOfUnitIsomorphismWithGivenObject",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "sh_o_rev_sh_s", "s" ] ],
  return_type := "morphism"
),

#InverseOfUnitIsomorphism := rec(
#  installation_name := "InverseOfUnitIsomorphism",
#  filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ]
#  return_type := "morphism"
#),

CounitIsomorphismWithGivenObject := rec(
  installation_name := "CounitIsomorphismWithGivenObject",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "rev_sh_o_sh_s", "s" ] ],
  return_type := "morphism"
),

#CounitIsomorphism := rec(
#  installation_name := "CounitIsomorphism",
#  filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ]
#  return_type := "morphism"
#),

MorphismBetweenStandardConeObjectsWithGivenObjects := rec(
  installation_name := "MorphismBetweenStandardConeObjectsWithGivenObjects",
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "cone_alpha", "list", "cone_alpha_prime" ], [ "cone_alpha", "cone_alpha_prime" ] ],
  return_type := "morphism",
  is_with_given := false
),

DomainMorphismByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "DomainMorphismByOctahedralAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismToConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "MorphismToConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismFromConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "MorphismFromConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "cone_g", "f", "g", "h", "st_cone" ], [ "cone_g", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "g", "h", "cone_g" ], [ "st_cone", "cone_g" ] ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

ShiftExpandingIsomorphismWithGivenObjects := rec(
  installation_name := "ShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

ShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "ShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftExpandingIsomorphismWithGivenObjects := rec(
  installation_name := "InverseShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "InverseShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
)

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


###########################################
#
# Convenient methods
#
##########################################

##
InstallMethod( ShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> ShiftOnMorphismWithGivenObjects(
              ShiftOnObject( Source( alpha ) ),
              alpha,
              ShiftOnObject( Range( alpha ) )
            )
);

##
InstallMethod( InverseShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> InverseShiftOnMorphismWithGivenObjects(
              InverseShiftOnObject( Source( alpha ) ),
              alpha,
              InverseShiftOnObject( Range( alpha ) )
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
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    s := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    r := StandardConeObject( u );
    
    return WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
      
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
    
    return ShiftOnObject( Source( alpha ) );
    
end );

##
InstallMethod( DomainMorphismByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismToStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismToConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismFromStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismFromConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return AdditiveInverseForMorphisms( ShiftOnMorphism( alpha ) );
    
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
              AdditiveInverseForMorphisms( InverseShiftOnMorphism( u ) ),
              CounitIsomorphism( Source( alpha ) )
            );
    
end );

##
InstallMethod( MorphismToConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ], IdFunc
);

##
InstallMethod( MorphismFromConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return PreCompose(
              MorphismToStandardConeObject( alpha ),
              UnitIsomorphism( StandardConeObject( alpha ) )
            );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
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
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByInverseRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
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
InstallMethod( MorphismToConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( gamma );
    
    r := StandardConeObject( beta );
    
    return MorphismToConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( MorphismFromConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
     
    s := StandardConeObject( beta );
    
    r := ShiftOnObject( StandardConeObject( alpha ) );
    
    return MorphismFromConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( StandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnObject( StandardConeObject( alpha ) );
    
end );

## at some time I was returning the additive inverse of this, but
## it turns out, this new method make things simpler.
##
InstallMethod( MorphismFromStandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnMorphism(
                  MorphismFromStandardConeObject( alpha )
                );
    
end );

##
InstallMethod( MorphismBetweenStandardCoConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    
    return InverseShiftOnMorphism(
              MorphismBetweenStandardConeObjects(
                    alpha,
                    mu,
                    nu,
                    beta
                  )
              );
    
end );

##
InstallMethod( CounitIsomorphism,
          [ IsCapCategoryObject ],
  a -> CounitIsomorphismWithGivenObject( a, Shift( Shift( a, 1 ), -1 ) )
);

##
InstallMethod( InverseOfCounitIsomorphism,
          [ IsCapCategoryObject ],
  a -> InverseOfCounitIsomorphismWithGivenObject( a, Shift( Shift( a, 1 ), -1 ) )
);

##
InstallMethod( UnitIsomorphism,
          [ IsCapCategoryObject ],
  a -> UnitIsomorphismWithGivenObject( a, Shift( Shift( a, -1 ), 1 ) )
);

##
InstallMethod( InverseOfUnitIsomorphism,
          [ IsCapCategoryObject ],
  a -> InverseOfUnitIsomorphismWithGivenObject( a, Shift( Shift( a, -1 ), 1 ) )
);

###
#InstallMethod( ShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return ShiftExpandingIsomorphismWithGivenObjects( ShiftOnObject( DirectSum( L ) ), L, DirectSum( List( L, ShiftOnObject ) ) );
#end );
#
###
#InstallMethod( InverseShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return InverseShiftExpandingIsomorphismWithGivenObjects(
#            InverseShiftOnObject( DirectSum( L ) ),
#            L,
#            DirectSum( List( L, InverseShiftOnObject ) )
#          );
#end );
#
###
#InstallMethod( ShiftFactoringIsomorphism,
#                [ IsList ],
#    function( L )
#    return ShiftFactoringIsomorphismWithGivenObjects(
#            DirectSum(
#            List( L, ShiftOnObject ) ),
#            L,
#            ShiftOnObject( DirectSum( L ) )
#          );
#end );
#
###
#InstallMethod( InverseShiftFactoringIsomorphism,
#          [ IsList ],
#    function( L )
#    return InverseShiftFactoringIsomorphismWithGivenObjects(
#              DirectSum( List( L, InverseShiftOnObject ) ),
#              L,
#              InverseShiftOnObject( DirectSum( L ) )
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
#InstallMethod( IsomorphismOntoStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismOntoStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismOntoStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#

##
InstallMethod( ShiftOp,
          [ IsCapCategoryCell, IsInt ],
  function( cell, n )
    local C;
    
    C := CapCategory( cell );
    
    if not IsTriangulatedCategory( C ) then
      TryNextMethod( );
    fi;
    
    if n = 0 then
      
      return cell;
      
    elif n > 0 then
    
      if IsCapCategoryObject( cell ) then
        
        return ShiftOnObject( Shift( cell, n - 1 ) );
        
      else
        
        return ShiftOnMorphism( Shift( cell, n - 1 ) );
        
      fi;
      
    else
      
      if IsCapCategoryObject( cell ) then
        
        return InverseShiftOnObject( Shift( cell, n + 1 ) );
        
      else
        
        return InverseShiftOnMorphism( Shift( cell, n + 1 ) );
        
      fi;
      
    fi;

end );

##
InstallOtherMethod( Shift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, 1 );
    
end );

##
InstallMethod( InverseShift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, -1 );
    
end );

##
InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY,
               IsCapCategory and IsTriangulatedCategory,
               0,

   function( category )

   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "TriangulatedCategories", "LogicForTriangulatedCategories" ),
        "PredicateImplicationsForTriangulatedCategories.tex" ) );

   TryNextMethod( );

end );
