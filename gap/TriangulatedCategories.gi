#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


###############################
##
##  Representations
##
###############################

DeclareRepresentation( "IsCapCategoryTriangleRep",
                        IsCapCategoryTriangle and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryExactTriangleRep",

                        IsCapCategoryExactTriangle and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryStandardExactTriangleRep",
                        IsCapCategoryStandardExactTriangle and IsAttributeStoringRep,
                        [ ] );
                        
DeclareRepresentation( "IsCapCategoryTrianglesMorphismRep",

                        IsCapCategoryTrianglesMorphism and IsAttributeStoringRep, 
                        [ ] );

##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryTrianglesFamily",
  NewFamily( "CapCategoryTrianglesFamily", IsObject ) );

BindGlobal( "CapCategoryExactTrianglesFamily",
  NewFamily( "CapCategoryExactTrianglesFamily", IsCapCategoryTriangle ) );

BindGlobal( "CapCategoryStandardExactTrianglesFamily",
  NewFamily( "CapCategoryStandardExactTrianglesFamily", IsCapCategoryExactTriangle ) );
  
BindGlobal( "CapCategoryTrianglesMorphismsFamily",
  NewFamily( "CapCategoryTrianglesMorphismsFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryTriangle", 
  NewType( CapCategoryTrianglesFamily, 
                      IsCapCategoryTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactTriangle", 
  NewType( CapCategoryExactTrianglesFamily, 
                      IsCapCategoryExactTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryStandardExactTriangle", 
  NewType( CapCategoryStandardExactTrianglesFamily, 
                      IsCapCategoryStandardExactTriangleRep ) );

                      
BindGlobal( "TheTypeCapCategoryTrianglesMorphism", 
  NewType( CapCategoryTrianglesMorphismsFamily, 
                      IsCapCategoryTrianglesMorphismRep ) );
                      
###############################
##
##  Methods record
##
###############################

InstallValue( CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, rec( 

ConeObject:= rec( 

  installation_name := "ConeObject", 
  filter_list := [ "morphism" ],
  cache_name := "ConeObject",
  return_type := "object"
),

MorphismIntoConeObjectWithGivenConeObject:= rec(

  installation_name := "MorphismIntoConeObjectWithGivenConeObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "MorphismIntoConeObjectWithGivenConeObject",
  return_type := "morphism"
),

MorphismFromConeObjectWithGivenConeObject:= rec(

  installation_name := "MorphismFromConeObjectWithGivenConeObject",
  filter_list := [ "morphism", "object" ],
  cache_name := "MorphismFromConeObjectWithGivenConeObject",
  return_type := "morphism"
),

ShiftOfObject:= rec( 

  installation_name := "ShiftOfObject", 
  filter_list := [ "object" ],
  cache_name := "ShiftOfObject",
  return_type := "object"
),

ShiftOfMorphism:= rec( 

  installation_name := "ShiftOfMorphism", 
  filter_list := [ "morphism" ],
  cache_name := "ShiftOfMorphism",
  return_type := "morphism"
),

ReverseShiftOfObject:= rec( 

  installation_name := "ReverseShiftOfObject", 
  filter_list := [ "object" ],
  cache_name := "ReverseShiftOfObject",
  return_type := "object"
),

ReverseShiftOfMorphism:= rec( 

  installation_name := "ReverseShiftOfMorphism", 
  filter_list := [ "morphism" ],
  cache_name := "ReverseShiftOfMorphism",
  return_type := "morphism"
),

ShiftExpandingIsomorphismWithGivenObjects := rec(

  installation_name := "ShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ShiftExpandingIsomorphismWithGivenObjects",
  return_type := "morphism"
),

ShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "ShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ShiftFactoringIsomorphismWithGivenObjects",
  return_type := "morphism"
),

ReverseShiftExpandingIsomorphismWithGivenObjects := rec(
  installation_name := "ReverseShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ReverseShiftExpandingIsomorphismWithGivenObjects",
  return_type := "morphism"
),

ReverseShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "ReverseShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ReverseShiftFactoringIsomorphismWithGivenObjects",
  return_type := "morphism"
),

IsomorphismIntoShiftOfReverseShift := rec( 

  installation_name := "IsomorphismIntoShiftOfReverseShift",
  filter_list := [ "object" ],
  cache_name := "IsomorphismIntoShiftOfReverseShift",
  return_type := "morphism"
),

IsomorphismIntoReverseShiftOfShift := rec( 

  installation_name := "IsomorphismIntoReverseShiftOfShift",
  filter_list := [ "object" ],
  cache_name := "IsomorphismIntoReverseShiftOfShift",
  return_type := "morphism"
),

IsomorphismFromShiftOfReverseShift := rec( 

  installation_name := "IsomorphismFromShiftOfReverseShift",
  filter_list := [ "object" ],
  cache_name := "IsomorphismFromShiftOfReverseShift",
  return_type := "morphism",
),

IsomorphismFromReverseShiftOfShift := rec( 

  installation_name := "IsomorphismFromReverseShiftOfShift",
  filter_list := [ "object" ],
  cache_name := "IsomorphismFromReverseShiftOfShift",
  return_type := "morphism",
),

IsExactTriangle:= rec( 

  installation_name := "IsExactTriangle", 
  filter_list := [ IsCapCategoryTriangle ],
  cache_name := "IsExactTriangle",
  return_type := "bool",
),

##
LiftColift := rec(

  installation_name := "LiftColift", 
  filter_list := [ "morphism", "morphism", "morphism", "morphism" ],
  cache_name := "LiftColift",
  return_type := "morphism_or_fail",
),

IsStandardExactTriangle:= rec( 

installation_name := "IsStandardExactTriangle",

  filter_list := [ IsCapCategoryTriangle ],
  cache_name := "IsStandardExactTriangle",
  return_type := "bool",
  post_function := 
      function( obj, return_value )
      if return_value = true then
          SetFilterObj( obj, IsCapCategoryStandardExactTriangle );
      fi;
      end
),

IsomorphismFromStandardExactTriangle := rec(

  installation_name := "IsomorphismFromStandardExactTriangle",
  filter_list := [ IsCapCategoryExactTriangle ],
  cache_name := "IsomorphismFromStandardExactTriangle",
  return_type := [ IsCapCategoryTrianglesMorphism ],
),

IsomorphismIntoStandardExactTriangle := rec(

  installation_name := "IsomorphismIntoStandardExactTriangle",
  filter_list := [ IsCapCategoryExactTriangle ],
  cache_name := "IsomorphismIntoStandardExactTriangle",
  return_type := [ IsCapCategoryTrianglesMorphism ],
),

RotationOfStandardExactTriangle := rec( 

  installation_name := "RotationOfStandardExactTriangle",
  filter_list := [ IsCapCategoryStandardExactTriangle ],
  cache_name := "RotationOfStandardExactTriangle",
  return_type := [ IsCapCategoryExactTriangle ]
),

ReverseRotationOfStandardExactTriangle := rec( 

  installation_name := "ReverseRotationOfStandardExactTriangle",
  filter_list := [ IsCapCategoryStandardExactTriangle ],
  cache_name := "ReverseRotationOfStandardExactTriangle",
  return_type := [ IsCapCategoryExactTriangle ]
),

CompleteMorphismToStandardExactTriangle := rec(

  installation_name := "CompleteMorphismToStandardExactTriangle", 
  filter_list := [ "morphism" ],
  cache_name := "CompleteMorphismToStandardExactTriangle",
  return_type := [ IsCapCategoryStandardExactTriangle ]
),

CompleteToMorphismOfStandardExactTriangles:= rec(

  installation_name := "CompleteToMorphismOfStandardExactTriangles", 
  filter_list := [ IsCapCategoryStandardExactTriangle, IsCapCategoryStandardExactTriangle, "morphism", "morphism" ],
  cache_name := "CompleteToMorphismOfStandardExactTriangles",
  return_type := [ "morphism" ] ),

OctahedralAxiom:= rec(

  installation_name := "OctahedralAxiom", 
  filter_list := [ "morphism", "morphism" ],
  cache_name := "OctahedralAxiom",
  return_type := [ IsCapCategoryExactTriangle ],
),

RotationOfExactTriangle := rec( 

  installation_name := "RotationOfExactTriangle",
  filter_list := [ IsCapCategoryExactTriangle ],
  cache_name := "RotationOfExactTriangle",
  return_type := [ IsCapCategoryExactTriangle ]
),

ReverseRotationOfExactTriangle := rec( 

  installation_name := "ReverseRotationOfExactTriangle",
  filter_list := [ IsCapCategoryExactTriangle ],
  cache_name := "ReverseRotationOfExactTriangle",
  return_type := [ IsCapCategoryExactTriangle ]
),

CompleteToMorphismOfExactTriangles:= rec(

  installation_name := "CompleteToMorphismOfExactTriangles", 
  filter_list := [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, "morphism", "morphism" ],
  cache_name := "CompleteToMorphismOfExactTriangles",
  return_type := [ IsCapCategoryTrianglesMorphism ]
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

##
InstallMethod( ConeObject,
                [ IsCapCategoryMorphism ],
                -1000,
   function( mor )
   
   return ObjectAt( CompleteMorphismToStandardExactTriangle( mor ), 2 );
   
end );

##
# InstallMethod( Testtt,
#                 [ IsCapCategory and IsTriangulatedCategory ],
#                 -1000, 
#                 # or any method-value \leq -1
#    function( cat )
#    Print( "I am the default method\n" );
#    return true;
#    
# end );

##
InstallMethod( TrivialExactTriangle,
                [ IsCapCategoryObject ],
    function( obj )
    local T, i, j, can_triangle;
   
    T := CreateExactTriangle( IdentityMorphism( obj ), UniversalMorphismIntoZeroObject( obj ), UniversalMorphismFromZeroObject( ShiftOfObject( obj ) ) );
    can_triangle := CompleteMorphismToStandardExactTriangle( IdentityMorphism( obj ) );
    
    i := CreateTrianglesMorphism( T, can_triangle, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
                                                    UniversalMorphismFromZeroObject( ObjectAt( can_triangle, 2 ) ) );
    j := CreateTrianglesMorphism( can_triangle, T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
                                                    UniversalMorphismIntoZeroObject( ObjectAt( can_triangle, 2 ) ) );
    SetIsomorphismFromStandardExactTriangle( T, j );
    SetIsomorphismIntoStandardExactTriangle( T, i );
    
    return T;
    
end );

##
InstallMethod( UnderlyingStandardExactTriangle,
                [ IsCapCategoryExactTriangle ],
    function( T )
   
    if IsCapCategoryStandardExactTriangle( T ) then
        return T;
    else
        return CompleteMorphismToStandardExactTriangle( MorphismAt( T, 0 ) );
    fi;

end );

##
InstallMethod( RotationOfExactTriangle,
                [ IsCapCategoryExactTriangle ],
                # the following -1000 implies that this method will be called only if there is no other option to compute the isomorphism.
                -1000,
    function( T )
    local rT, iso_from_can_exact_tr, iso_into_can_exact_tr;

    if IsCapCategoryStandardExactTriangle( T ) then
        return RotationOfStandardExactTriangle( T );
    fi;

    rT := CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );
    
    iso_into_can_exact_tr := function( T, rT )
    local can_T, T_to_can_T, rcan_T, rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T, can_rT, can_T_to_T, can_rcan_T_to_can_rT,iso;
    can_T := UnderlyingStandardExactTriangle( T );
    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
    rcan_T := RotationOfStandardExactTriangle( can_T );    
    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ), MorphismAt( T_to_can_T, 3 ) );
    rcan_T_to_can_rcan_T := IsomorphismIntoStandardExactTriangle( rcan_T );
    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
    can_rT := UnderlyingStandardExactTriangle( rT );
    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
    can_rcan_T_to_can_rT := CompleteToMorphismOfStandardExactTriangles( can_rcan_T, can_rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ) );
    iso := PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] );
    Assert( 5, IsIsomorphism( iso[2] ) );
    SetIsIsomorphism( iso, true );
    return iso;
    end;
    AddToUnderlyingLazyMethods( rT, IsomorphismIntoStandardExactTriangle, iso_into_can_exact_tr, [T, rT ] );

    iso_from_can_exact_tr := function( T, rT )
    local rcan_T_to_rT, can_T, T_to_can_T, rcan_T, rT_to_rcan_T, can_rcan_T, can_rT, can_T_to_T, can_rcan_T_to_rcan_T, can_rT_to_can_rcan_T, iso;

    can_T := UnderlyingStandardExactTriangle( T );
    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
    rcan_T := RotationOfStandardExactTriangle( can_T );
    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
    can_rT := UnderlyingStandardExactTriangle( rT );
    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ), MorphismAt( can_T_to_T, 3 ) );
    can_rcan_T_to_rcan_T := IsomorphismFromStandardExactTriangle( rcan_T );
    can_rT_to_can_rcan_T := CompleteToMorphismOfStandardExactTriangles( can_rT, can_rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ) );
    iso := PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] );
    Assert( 5, IsIsomorphism( iso[2] ) );
    SetIsIsomorphism( iso, true );
    return iso;
    end;
    AddToUnderlyingLazyMethods( rT, IsomorphismFromStandardExactTriangle, iso_from_can_exact_tr, [T, rT ] );    

    return rT;
    
end );


#\begin{tikzcd}
#A \arrow[r, "f"] & B \arrow[r, "g"] & C \arrow[r, "h"] \arrow[d, "u", two heads, tail] & A[1] &  &  &  & C[-1] \arrow[r, "{-h[-1]}"] \arrow[d, "{u[-1]}"'] & A \arrow[r, "f"] & B \arrow[r, "g"] & C \arrow[d, "u"] \\
#A \arrow[r, "f"'] & B \arrow[r, "\alpha(f)"'] & C(f) \arrow[r, "\beta(f)"'] & A[1] &  &  &  & C(f)[-1] \arrow[r, "{-\beta(f)[-1]}"'] & A \arrow[r, "f"'] & B \arrow[r, "\alpha(f)"'] \arrow[d, "t"] & C(f) \\
# &  &  &  &  &  &  & C(f)[-1] \arrow[r, "{-\beta(f)[-1]}"] \arrow[d, "{u[-1]^{-1}}"'] & A \arrow[r, "\alpha(*)"] & C(\beta(f)[-1]) \arrow[r, "\beta(*)"] \arrow[d, "s"] & C(f) \arrow[d, "u^{-1}"] \\
# &  &  &  &  &  &  & C[-1] \arrow[r, "{-h[-1]}"'] & A \arrow[r, "{\alpha(-h[-1])}"'] & C(h[-1]) \arrow[r, "{\beta(-h[-1])}"'] & C
#\end{tikzcd}

InstallMethod( ReverseRotationOfExactTriangle,
                [ IsCapCategoryExactTriangle ],
                -1000,
    function( T )
    local can_T, T_to_can_T, can_T_to_T, rT, rcan_T, rT_to_rcan_T, rcan_T_to_rT, can_rcan_T,
       rcan_T_to_can_rcan_T, can_rcan_T_to_rcan_T, can_rT, can_rcan_T_to_can_rT, can_rT_to_can_rcan_T;
    
    if not HasIsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "Its not known wether the shift functor is automorphism!" );
    fi;
     
    if not IsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
        Error( "The shift-functor that defines the triangulated struture must be automorphism!" );
    fi;

    if IsCapCategoryStandardExactTriangle( T ) then
        return ReverseRotationOfStandardExactTriangle( T );
    fi;
     
    can_T := UnderlyingStandardExactTriangle( T );
    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
     
    rT := CreateExactTriangle( AdditiveInverse(ReverseShiftOfMorphism( MorphismAt( T, 2 ) ) ), MorphismAt( T, 0), MorphismAt( T, 1 ) );
    rcan_T := ReverseRotationOfStandardExactTriangle( can_T );
     
    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, ReverseShiftOfMorphism( MorphismAt( T_to_can_T, 2 ) ), 
                                                        MorphismAt( T_to_can_T, 0 ), 
                                                        MorphismAt( T_to_can_T, 1 ) );
                                                          
    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, ReverseShiftOfMorphism( MorphismAt( can_T_to_T, 2 ) ), 
                                                        MorphismAt( can_T_to_T, 0 ), 
                                                        MorphismAt( can_T_to_T, 1 ) );
                                                          
     
    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
    rcan_T_to_can_rcan_T := IsomorphismIntoStandardExactTriangle( rcan_T );
    can_rcan_T_to_rcan_T := IsomorphismFromStandardExactTriangle( rcan_T );
     
    can_rT := UnderlyingStandardExactTriangle( rT );
     
    can_rcan_T_to_can_rT := CompleteToMorphismOfStandardExactTriangles( can_rcan_T, can_rT, 
                                ReverseShiftOfMorphism( MorphismAt( can_T_to_T, 2 ) ), MorphismAt( can_T_to_T, 0 ) );
#    can_rcan_T_to_can_rT := CreateTrianglesMorphism( can_rcan_T, can_rT, 
#                                ReverseShiftOfMorphism( MorphismAt( can_T_to_T, 2 ) ), MorphismAt( can_T_to_T, 0 ), can_rcan_T_to_can_rT );

    can_rT_to_can_rcan_T := CompleteToMorphismOfStandardExactTriangles( can_rT, can_rcan_T, 
                                ReverseShiftOfMorphism( MorphismAt( T_to_can_T, 2 ) ), MorphismAt( T_to_can_T, 0 ) );
#    can_rT_to_can_rcan_T := CreateTrianglesMorphism( can_rT, can_rcan_T, 
#                                ReverseShiftOfMorphism( MorphismAt( T_to_can_T, 2 ) ), MorphismAt( T_to_can_T, 0 ), can_rT_to_can_rcan_T );
    
    SetIsomorphismIntoStandardExactTriangle(   rT, PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] ) );
    SetIsomorphismFromStandardExactTriangle( rT, PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] ) );
     
    return rT;
     
end );

InstallMethod( CompleteToMorphismOfExactTriangles,
                [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                -1000,
    function( T1, T2, m0, m1 )
    local can_T1, can_T2, T1_to_can_T1, T2_to_can_T2, can_T1_to_T1, can_T2_to_T2, can_T1_to_can_T2,
        can_T1_to_can_T2_0, can_T1_to_can_T2_1;
    
    if IsCapCategoryStandardExactTriangle( T1 ) and IsCapCategoryStandardExactTriangle( T2 ) then
        return CompleteToMorphismOfStandardExactTriangles( T1, T2, m0, m1 );
    fi;

    can_T1 := UnderlyingStandardExactTriangle( T1 );
    can_T2 := UnderlyingStandardExactTriangle( T2 );
    
    T1_to_can_T1 := IsomorphismIntoStandardExactTriangle( T1 );
    can_T1_to_T1 := IsomorphismFromStandardExactTriangle( T1 );

    T2_to_can_T2 := IsomorphismIntoStandardExactTriangle( T2 );
    can_T2_to_T2 := IsomorphismFromStandardExactTriangle( T2 );

    can_T1_to_can_T2_0 := PreCompose( [ MorphismAt( can_T1_to_T1, 0 ), m0, MorphismAt( T2_to_can_T2, 0 ) ] );
    can_T1_to_can_T2_1 := PreCompose( [ MorphismAt( can_T1_to_T1, 1 ), m1, MorphismAt( T2_to_can_T2, 1 ) ] );
    can_T1_to_can_T2 := CompleteToMorphismOfStandardExactTriangles( can_T1, can_T2, can_T1_to_can_T2_0, can_T1_to_can_T2_1 );
    return PreCompose( [ T1_to_can_T1, can_T1_to_can_T2, can_T2_to_T2 ] );
    
end );

##
InstallMethod( ShiftExpandingIsomorphism, 
                [ IsList ],
    function( L )
    return ShiftExpandingIsomorphismWithGivenObjects( ShiftOfObject( DirectSum( L ) ), L, DirectSum( List( L, ShiftOfObject ) ) );
end );

##
InstallMethod( ReverseShiftExpandingIsomorphism, 
                [ IsList ],
    function( L )
    return ReverseShiftExpandingIsomorphismWithGivenObjects( ReverseShiftOfObject( DirectSum( L ) ), L, DirectSum( List( L, ReverseShiftOfObject ) ) );
end );

##
InstallMethod( ShiftFactoringIsomorphism, 
                [ IsList ],
    function( L )
    return ShiftFactoringIsomorphismWithGivenObjects( DirectSum( List( L, ShiftOfObject ) ), L, ShiftOfObject( DirectSum( L ) ) );
end );

##
InstallMethod( ReverseShiftFactoringIsomorphism, 
                [ IsList ],
    function( L )
    return ReverseShiftFactoringIsomorphismWithGivenObjects( DirectSum( List( L, ReverseShiftOfObject ) ), L, ReverseShiftOfObject( DirectSum( L ) ) );
end );

##
InstallMethod( ShiftFunctorAttr,
                  [ IsCapCategory and IsTriangulatedCategory ],
                  
    function( category )
    local name, functor;
     
    name := Concatenation( "Shift endofunctor in ", Name( category ) );
     
    functor := CapFunctor( name, category, category );
     
    if not CanCompute( category, "ShiftOfObject" ) or not CanCompute( category, "ShiftOfMorphism" ) then
        
        Error( "ShiftOfObject and ShiftOfMorphism should be added to the category" );
        
    fi;
    
    AddObjectFunction( functor, 
            
           function( obj )
                
                return ShiftOfObject( obj );
                
           end );
           
    AddMorphismFunction( functor, 
     
           function( new_source, mor, new_range )
                
                return ShiftOfMorphism( mor );
                
           end );
           
     return functor;
  
end );

##
InstallOtherMethod( ShiftFunctor,
          [ IsCapCategory and IsTriangulatedCategory ],
  ShiftFunctorAttr
);

InstallMethod( ReverseShiftFunctor,
                  [ IsCapCategory and IsTriangulatedCategory ],
                  
     function( category )
     local name, functor;
     
     name := Concatenation( "Reverse Shift endofunctor in ", Name( category ) );
     
     functor := CapFunctor( name, category, category );
     
     if not CanCompute( category, "ReverseShiftOfObject" ) or not CanCompute( category, "ReverseShiftOfMorphism" ) then
     
        Error( "ReverseShiftOfObject and ReverseShiftOfMorphism should be added to the category" );
        
     fi;
     
     AddObjectFunction( functor, 
     
           function( obj )
           
           return ReverseShiftOfObject( obj );
           
           end );
           
     AddMorphismFunction( functor, 
     
           function( new_source, mor, new_range )
           
           return ReverseShiftOfMorphism( mor );
           
           end );
           
     return functor;
  
end );

##
InstallMethod( NaturalIsomorphismFromIdentityIntoShiftOfReverseShift, 
                      [ IsCapCategory and IsTriangulatedCategory ],
                      
        function( category )
        local id, shift, reverse_shift, shift_after_reverse_shift, name, nat;
        
        id := IdentityFunctor( category );
        
        shift := ShiftFunctor( category );
        
        reverse_shift := ReverseShiftFunctor( category );
        
        shift_after_reverse_shift := PreCompose( reverse_shift, shift );
        
        name := "Autoequivalence from identity functor to Σ o Σ^-1 in ";
        
        name := Concatenation( name, Name( category ) );
        
        nat := NaturalTransformation( name, id, shift_after_reverse_shift );
        
        AddNaturalTransformationFunction( nat, 
         
           function( Id_of_object, object, shift_after_reverse_shift_of_object )
              
              return IsomorphismIntoShiftOfReverseShift( object );
              
           end );
         
        return nat;
        
end );
 
##
InstallMethod( NaturalIsomorphismFromIdentityIntoReverseShiftOfShift, 
                      [ IsCapCategory and IsTriangulatedCategory ],
                      
        function( category )
        local id, shift, reverse_shift, reverse_shift_after_shift, name, nat;
        
        id := IdentityFunctor( category );
        
        shift := ShiftFunctor( category );
        
        reverse_shift := ReverseShiftFunctor( category );
        
        reverse_shift_after_shift := PreCompose( shift, reverse_shift);
        
        name := "Autoequivalence from identity functor to Σ^-1 o Σ in  ";
        
        name := Concatenation( name, Name( category ) );
        
        nat := NaturalTransformation( name, id, reverse_shift_after_shift );
        
        AddNaturalTransformationFunction( nat, 
         
           function( Id_of_object, object, reverse_shift_after_shift_of_object )
              
              return IsomorphismIntoReverseShiftOfShift( object );
              
           end );
         
        return nat;
        
end );

##
InstallMethod( NaturalIsomorphismFromShiftOfReverseShiftIntoIdentity, 
                      [ IsCapCategory and IsTriangulatedCategory ],
                      
        function( category )
        local id, shift, reverse_shift, shift_after_reverse_shift, name, nat;
        
        id := IdentityFunctor( category );
        
        shift := ShiftFunctor( category );
        
        reverse_shift := ReverseShiftFunctor( category );
        
        shift_after_reverse_shift := PreCompose( reverse_shift, shift );
        
        name := "Autoequivalence from Σ o Σ^-1 to identity functor in ";
        
        name := Concatenation( name, Name( category ) );
        
        nat := NaturalTransformation( name, id, shift_after_reverse_shift );
        
        AddNaturalTransformationFunction( nat, 
         
           function( Id_of_object, object, shift_after_reverse_shift_of_object )
              
              return IsomorphismFromShiftOfReverseShift( object );
              
           end );
         
        return nat;
        
end );
 
##
InstallMethod( NaturalIsomorphismFromReverseShiftOfShiftIntoIdentity, 
                      [ IsCapCategory and IsTriangulatedCategory ],
                      
        function( category )
        local id, shift, reverse_shift, reverse_shift_after_shift, name, nat;
        
        id := IdentityFunctor( category );
        
        shift := ShiftFunctor( category );
        
        reverse_shift := ReverseShiftFunctor( category );
        
        reverse_shift_after_shift := PreCompose( shift, reverse_shift);
        
        name := "Autoequivalence from Σ^-1 o Σ to identity functor in ";
        
        name := Concatenation( name, Name( category ) );
        
        nat := NaturalTransformation( name, id, reverse_shift_after_shift );
        
        AddNaturalTransformationFunction( nat, 
         
           function( Id_of_object, object, reverse_shift_after_shift_of_object )
              
              return IsomorphismFromReverseShiftOfShift( object );
              
           end );
         
        return nat;
        
end );   

##
InstallMethod( IsomorphismFromStandardExactTriangle,
                [ IsCapCategoryExactTriangle ],
                -1000,
    function( T )
    local F, p;
    F := T!.UnderlyingLazyMethods;
    if not IsomorphismFromStandardExactTriangle in F then
        TryNextMethod( );
    else 
        p := Position( F, IsomorphismFromStandardExactTriangle );
        return CallFuncList( F[p+1], F[ p+2 ] );
    fi;
end );

##
InstallMethod( IsomorphismIntoStandardExactTriangle,
                [ IsCapCategoryExactTriangle ],
                -1000,
    function( T )
    local F, p;
    F := T!.UnderlyingLazyMethods;
    if not IsomorphismIntoStandardExactTriangle in F then
        TryNextMethod( );
    else 
        p := Position( F, IsomorphismIntoStandardExactTriangle );
        return CallFuncList( F[p+1], F[ p+2 ] );
    fi;
end );

##
InstallMethod( ShiftOp, [ IsCapCategoryCell, IsInt ],
  function( cell, n )
  
    if n = 0 then
      
      return cell;
      
    elif n > 0 then
    
      if IsCapCategoryObject( cell ) then
        
        return ShiftOfObject( Shift( cell, n - 1 ) );
        
      else
        
        return ShiftOfMorphism( Shift( cell, n - 1 ) );
        
      fi;
      
    else
      
      if IsCapCategoryObject( cell ) then
        
        return ReverseShiftOfObject( Shift( cell, n + 1 ) );
        
      else
        
        return ReverseShiftOfMorphism( Shift( cell, n + 1 ) );
        
      fi;
      
    fi;
  
end );

##
InstallMethod( MorphismIntoConeObject,
          [ IsCapCategoryMorphism ],
  phi -> MorphismIntoConeObjectWithGivenConeObject( phi, ConeObject( phi ) )
);

##
InstallMethod( MorphismFromConeObject,
          [ IsCapCategoryMorphism ],
  phi -> MorphismFromConeObjectWithGivenConeObject( phi, ConeObject( phi ) )
);

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
