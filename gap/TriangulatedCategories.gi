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

DeclareRepresentation( "IsCapCategoryCanonicalExactTriangleRep",
                        IsCapCategoryCanonicalExactTriangle and IsAttributeStoringRep,
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

BindGlobal( "CapCategoryCanonicalExactTrianglesFamily",
  NewFamily( "CapCategoryCanonicalExactTrianglesFamily", IsCapCategoryExactTriangle ) );
  
BindGlobal( "CapCategoryTrianglesMorphismsFamily",
  NewFamily( "CapCategoryTrianglesMorphismsFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryTriangle", 
  NewType( CapCategoryTrianglesFamily, 
                      IsCapCategoryTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactTriangle", 
  NewType( CapCategoryExactTrianglesFamily, 
                      IsCapCategoryExactTriangleRep ) );
                      
BindGlobal( "TheTypeCapCategoryCanonicalExactTriangle", 
  NewType( CapCategoryCanonicalExactTrianglesFamily, 
                      IsCapCategoryCanonicalExactTriangleRep ) );

                      
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
return_type := "object" ),

ShiftOfObject:= rec( 

installation_name := "ShiftOfObject", 
filter_list := [ "object" ],
cache_name := "ShiftOfObject",
return_type := "object" ),


ShiftOfMorphism:= rec( 

installation_name := "ShiftOfMorphism", 
filter_list := [ "morphism" ],
cache_name := "ShiftOfMorphism",
return_type := "morphism" ),

ReverseShiftOfObject:= rec( 

installation_name := "ReverseShiftOfObject", 
filter_list := [ "object" ],
cache_name := "ReverseShiftOfObject",
return_type := "object" ),


ReverseShiftOfMorphism:= rec( 

installation_name := "ReverseShiftOfMorphism", 
filter_list := [ "morphism" ],
cache_name := "ReverseShiftOfMorphism",
return_type := "morphism" ),

IsomorphismToShiftOfReverseShift := rec( 

installation_name := "IsomorphismToShiftOfReverseShift",
filter_list := [ "object" ],
cache_name := "IsomorphismToShiftOfReverseShift",
return_type := "morphism",
post_function := 
    function( obj, return_value )
    if not IsEqualForObjects( Source( return_value), obj ) then
        Error( "The output of your methods is not compatible" );
    fi;
    
    if not IsEqualForObjects( Range( return_value ), ShiftOfObject( ReverseShiftOfObject( obj ) ) ) then
        Error( "The output of your method is not compatible" );
    fi;
    
    if not IsIsomorphism( return_value ) then
        Error( "The output must be isomorphism");
    fi;
    
    end 
),

IsomorphismToReverseShiftOfShift := rec( 

installation_name := "IsomorphismToReverseShiftOfShift",
filter_list := [ "object" ],
cache_name := "IsomorphismToReverseShiftOfShift",
return_type := "morphism",
post_function := 
    function( obj, return_value )
    if not IsEqualForObjects( Source( return_value), obj ) then
        Error( "The output of your methods is not compatible" );
    fi;
    
    if not IsEqualForObjects( Range( return_value ), ReverseShiftOfObject( ShiftOfObject( obj ) ) ) then
        Error( "The output of your method is not compatible" );
    fi;
    
    if not IsIsomorphism( return_value ) then
        Error( "The output must be isomorphism");
    fi;

    end
),

IsomorphismFromShiftOfReverseShift := rec( 

installation_name := "IsomorphismFromShiftOfReverseShift",
filter_list := [ "object" ],
cache_name := "IsomorphismFromShiftOfReverseShift",
return_type := "morphism" ),

IsomorphismFromReverseShiftOfShift := rec( 

installation_name := "IsomorphismFromReverseShiftOfShift",
filter_list := [ "object" ],
cache_name := "IsomorphismFromReverseShiftOfShift",
return_type := "morphism" ),

IsExactTriangle:= rec( 

installation_name := "IsExactTriangle", 
filter_list := [ IsCapCategoryTriangle ],
cache_name := "IsExactTriangle",
return_type := "bool",
post_function := 
    function( obj, return_value )
    if return_value = true then
        SetFilterObj( obj, IsCapCategoryExactTriangle );
    fi;
    end
),

IsCanonicalExactTriangle:= rec( 

installation_name := "IsCanonicalExactTriangle", 
filter_list := [ IsCapCategoryTriangle ],
cache_name := "IsCanonicalExactTriangle",
return_type := "bool",
post_function := 
    function( obj, return_value )
    if return_value = true then
        SetFilterObj( obj, IsCapCategoryCanonicalExactTriangle );
    fi;
    end
),

IsomorphismFromCanonicalExactTriangle := rec(

installation_name := "IsomorphismFromCanonicalExactTriangle",
filter_list := [ IsCapCategoryExactTriangle ],
cache_name := "IsomorphismFromCanonicalExactTriangle",
return_type := [ IsCapCategoryTrianglesMorphism ] ),

IsomorphismToCanonicalExactTriangle := rec(

installation_name := "IsomorphismToCanonicalExactTriangle",
filter_list := [ IsCapCategoryExactTriangle ],
cache_name := "IsomorphismToCanonicalExactTriangle",
return_type := [ IsCapCategoryTrianglesMorphism ] ),

RotationOfCanonicalExactTriangle := rec( 
installation_name := "RotationOfCanonicalExactTriangle",
filter_list := [ IsCapCategoryCanonicalExactTriangle ],
cache_name := "RotationOfCanonicalExactTriangle",
return_type := [ IsCapCategoryExactTriangle ] ),

ReverseRotationOfCanonicalExactTriangle := rec( 
installation_name := "ReverseRotationOfCanonicalExactTriangle",
filter_list := [ IsCapCategoryCanonicalExactTriangle ],
cache_name := "ReverseRotationOfCanonicalExactTriangle",
return_type := [ IsCapCategoryExactTriangle ] ),

CompleteMorphismToCanonicalExactTriangle := rec(

installation_name := "CompleteMorphismToCanonicalExactTriangle", 
filter_list := [ "morphism" ],
cache_name := "CompleteMorphismToCanonicalExactTriangle",
return_type := [ IsCapCategoryCanonicalExactTriangle ] ),

CompleteToMorphismOfCanonicalExactTriangles:= rec(

installation_name := "CompleteToMorphismOfCanonicalExactTriangles", 
filter_list := [ IsCapCategoryCanonicalExactTriangle, IsCapCategoryCanonicalExactTriangle, "morphism", "morphism" ],
cache_name := "CompleteToMorphismOfCanonicalExactTriangles",
return_type := [ IsCapCategoryTrianglesMorphism ] ),

OctahedralAxiom:= rec(

installation_name := "OctahedralAxiom", 
filter_list := [ "morphism", "morphism" ],
cache_name := "OctahedralAxiom",
return_type := [ IsCapCategoryExactTriangle ] ),

RotationOfExactTriangle := rec( 
installation_name := "RotationOfExactTriangle",
filter_list := [ IsCapCategoryExactTriangle ],
cache_name := "RotationOfExactTriangle",
return_type := [ IsCapCategoryExactTriangle ] ),

ReverseRotationOfExactTriangle := rec( 
installation_name := "ReverseRotationOfExactTriangle",
filter_list := [ IsCapCategoryExactTriangle ],
cache_name := "ReverseRotationOfExactTriangle",
return_type := [ IsCapCategoryExactTriangle ] ),

CompleteToMorphismOfExactTriangles:= rec(

installation_name := "CompleteToMorphismOfExactTriangles", 
filter_list := [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, "morphism", "morphism" ],
cache_name := "CompleteToMorphismOfExactTriangles",
return_type := [ IsCapCategoryTrianglesMorphism ] ),

# Testtt:= rec(
# 
# installation_name := "Testtt", 
# filter_list := [ "category" ],
# cache_name := "Testtt",
# return_type := "bool" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

####################################
##
## Constructors
##
####################################

##
InstallMethod( CreateTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
    
    function( mor1, mor2, mor3 )
    local  triangle;
    
    triangle:= rec( T0 := Source( mor1 ),
                    t0 := mor1,
                    T1 := Source( mor2 ),
                    t1 := mor2,
                    T2 := Source( mor3 ),
                    t2 := mor3,
                    T3 :=  Range( mor3 ) 
                  );
    
    ObjectifyWithAttributes( triangle, TheTypeCapCategoryTriangle,
                             UnderlyingCapCategory, CapCategory( mor1 )
                           );
    
    AddObject( CategoryOfTriangles( CapCategory( mor1 ) ), triangle );
    
    AddToToDoList( ToDoListEntry( [ [ triangle, "IsExactTriangle", true ] ], 
                    function( )
                    SetFilterObj( triangle, IsCapCategoryExactTriangle );
                    end ) );

    AddToToDoList( ToDoListEntry( [ [ triangle, "IsCanonicalExactTriangle", true ] ], 
                    function( )
                    SetFilterObj( triangle, IsCapCategoryCanonicalExactTriangle );
                    end ) );

    return triangle;
    
end );

##
InstallMethod( CreateExactTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
   
                       
    function( mor1, mor2, mor3 )
    local  triangle;
        
    triangle:= CreateTriangle( mor1, mor2, mor3 );
    
    SetFilterObj( triangle, IsCapCategoryExactTriangle );
    
    return triangle;
    
end );

##
InstallMethod( CreateCanonicalExactTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
   
                       
    function( mor1, mor2, mor3 )
    local  triangle;
        
    triangle:= CreateTriangle( mor1, mor2, mor3 );
    
    SetFilterObj( triangle, IsCapCategoryCanonicalExactTriangle );
    
    SetIsomorphismFromCanonicalExactTriangle( triangle, IdentityMorphism( triangle ) );
    
    SetIsomorphismToCanonicalExactTriangle( triangle, IdentityMorphism( triangle ) );

    return triangle;
    
end );

##
InstallMethod( CreateTrianglesMorphism, 
               [ IsCapCategoryTriangle, IsCapCategoryTriangle,
               IsCapCategoryMorphism, IsCapCategoryMorphism, 
                       IsCapCategoryMorphism ], 
               
   function( T1, T2, morphism0, morphism1, morphism2 )
   local morphism;
 
   morphism := rec( m0 := morphism0,
                    
                    m1 := morphism1,
                    
                    m2 := morphism2 );
                  
   ObjectifyWithAttributes( morphism, TheTypeCapCategoryTrianglesMorphism,
                            Source, T1,
                            Range, T2,
                            UnderlyingCapCategory, CapCategory( morphism0 )
                          );
   
   AddMorphism( CategoryOfTriangles( CapCategory( morphism0 ) ), morphism );
   
   return morphism;
   
end );


##
InstallMethod( MorphismAtOp, 
                [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    
    if i = 0 then return T!.t0;
    
    elif i = 1 then return T!.t1;
    
    elif i = 2 then return T!.t2;
    
    else Error( "The second entry should be 0, 1 or 2" );
    
    fi;

end );

##
InstallMethod( ObjectAtOp, 
                [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    
    if i = 0 then return T!.T0;
    
    elif i = 1 then return T!.T1;
    
    elif i = 2 then return T!.T2;
    
    elif i = 3 then return T!.T3;
    
    else Error( "The second entry should be 0, 1, 2 or 3" );
    
    fi;

end );

##
InstallMethod( MorphismAtOp, 
                [ IsCapCategoryTrianglesMorphism, IsInt ],
    function( phi, i )
    
    if i = 0 then return phi!.m0;
    
    elif i = 1 then return phi!.m1;
    
    elif i = 2 then return phi!.m2;
    
    elif i = 3 then return ShiftOfMorphism( phi!.m0 );
    
    else
        Error( "Index can be 0,1,2 or 3" );
    fi;

end );

InstallMethod( IsWellDefinedTriangle, 
                [ IsCapCategoryTriangle ],
    function( T )
    
    if not IsWellDefined( ObjectAt( T, 0 ) ) or 
        not IsWellDefined( ObjectAt( T, 1 ) ) or
          not IsWellDefined( ObjectAt( T, 2 ) ) or
            not IsWellDefined( ObjectAt( T, 3 ) ) then 
            return false;
    fi;
    
    if not IsWellDefined( MorphismAt( T, 0 ) ) or 
        not IsWellDefined( MorphismAt( T, 1 ) ) or
          not IsWellDefined( MorphismAt( T,2 ) ) then 
            return false;
    fi;
    
    if not IsEqualForObjects( Range( MorphismAt( T, 0 ) ), Source( MorphismAt( T, 1 ) ) ) or
       not IsEqualForObjects( Range( MorphismAt( T, 1 ) ), Source( MorphismAt( T, 2 ) ) ) or
       not IsEqualForObjects( ShiftOfObject( Source( MorphismAt( T, 0 ) ) ), Range( MorphismAt( T, 2 ) ) ) then
       return false;
    fi;
    
    if not IsZeroForMorphisms( PreCompose( MorphismAt( T, 0), MorphismAt( T, 1 ) ) ) or
        not IsZeroForMorphisms( PreCompose( MorphismAt( T, 1), MorphismAt( T, 2 ) ) ) then 
            return false;
    fi;
    
    return true;
    
end );

InstallMethod( IsWellDefinedTrianglesMorphism,
                [ IsCapCategoryTrianglesMorphism ],
    function( phi )
    local T1, T2;
    
    T1 := Source( phi );
    T2 := Range( phi );
    
    if not IsEqualForObjects( Source( MorphismAt( phi, 0 ) ), ObjectAt( T1, 0 ) ) or 
        not IsEqualForObjects( Range( MorphismAt( phi, 0 ) ), ObjectAt( T2, 0) )  then 
        
        Error( "The morphism m0 is not compatible" );
        
    fi;
     
    if not IsEqualForObjects( Source( MorphismAt( phi, 1 ) ), ObjectAt( T1, 1 ) ) or 
        not IsEqualForObjects( Range( MorphismAt( phi, 1 ) ), ObjectAt( T2, 1) )  then 
        
        Error( "The morphism m1 is not compatible" );
     
    fi;
     
    if not IsEqualForObjects( Source( MorphismAt( phi, 2 ) ), ObjectAt( T1, 2) ) or 
        not IsEqualForObjects( Range( MorphismAt( phi, 2 ) ), ObjectAt( T2, 2) )  then 
        
        Error( "The morphism m2 is not compatible" );
     
    fi;
  
  # Is the diagram commutative?

  
    if not IsEqualForMorphisms( PreCompose( MorphismAt( T1, 0 ), MorphismAt( phi, 1 ) ), PreCompose( MorphismAt( phi, 0 ), MorphismAt( T2, 0) ) ) then
     
        Error( "The first squar is not commutative" );
        
    fi;
     
    if not IsEqualForMorphisms( PreCompose( MorphismAt( T1, 1 ), MorphismAt( phi, 2 ) ), PreCompose( MorphismAt( phi, 1 ), MorphismAt( T2, 1) ) ) then
     
        Error( "The second squar is not commutative" );
        
    fi;
     
    if not IsEqualForMorphisms( PreCompose( MorphismAt( T1, 2), MorphismAt( phi, 3 ) ), 
                                 PreCompose( MorphismAt( phi, 2 ), MorphismAt( T2, 2) ) ) then
     
        Error( "The third squar is not commutative" );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( ConeObject,
                [ IsCapCategoryMorphism ],
                -1000,
   function( mor )
   
   return ObjectAt( CompleteMorphismToCanonicalExactTriangle( mor ), 2 );
   
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
    can_triangle := CompleteMorphismToCanonicalExactTriangle( IdentityMorphism( obj ) );
    
    i := CreateTrianglesMorphism( T, can_triangle, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
                                                    UniversalMorphismFromZeroObject( ObjectAt( can_triangle, 2 ) ) );
    j := CreateTrianglesMorphism( can_triangle, T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
                                                    UniversalMorphismIntoZeroObject( ObjectAt( can_triangle, 2 ) ) );
    SetIsomorphismFromCanonicalExactTriangle( T, j );
    SetIsomorphismToCanonicalExactTriangle( T, i );
    
    return T;
    
end );

##
InstallMethod( UnderlyingCanonicalExactTriangle,
                [ IsCapCategoryExactTriangle ],
    function( T )
   
    if IsCapCategoryCanonicalExactTriangle( T ) then
        return T;
    else
        return CompleteMorphismToCanonicalExactTriangle( MorphismAt( T, 0 ) );
    fi;

end );

##
InstallMethod( RotationOfExactTriangle,
                [ IsCapCategoryExactTriangle ],
                -1000,
    function( T )
    local can_T, T_to_can_T, can_T_to_T, rT, rcan_T, rT_to_rcan_T, rcan_T_to_rT, can_rcan_T,
          rcan_T_to_can_rcan_T, can_rcan_T_to_rcan_T, can_rT, can_rcan_T_to_can_rT, can_rT_to_can_rcan_T;
    
    if IsCapCategoryCanonicalExactTriangle( T ) then
        return RotationOfCanonicalExactTriangle( T );
    fi;
    
    can_T := UnderlyingCanonicalExactTriangle( T );
    T_to_can_T := IsomorphismToCanonicalExactTriangle( T );
    can_T_to_T := IsomorphismFromCanonicalExactTriangle( T );
    
    rT := CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOfMorphism( MorphismAt( T, 0 ) ) ) );
    rcan_T := RotationOfCanonicalExactTriangle( can_T );
    
    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ), MorphismAt( T_to_can_T, 3 ) );
    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ), MorphismAt( can_T_to_T, 3 ) );
    
    can_rcan_T := UnderlyingCanonicalExactTriangle( rcan_T );
    rcan_T_to_can_rcan_T := IsomorphismToCanonicalExactTriangle( rcan_T );
    can_rcan_T_to_rcan_T := IsomorphismFromCanonicalExactTriangle( rcan_T );
    
    can_rT := UnderlyingCanonicalExactTriangle( rT );
    
    can_rcan_T_to_can_rT := CompleteToMorphismOfCanonicalExactTriangles( can_rcan_T, can_rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ) );
    can_rT_to_can_rcan_T := CompleteToMorphismOfCanonicalExactTriangles( can_rT, can_rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ) );
    
    SetIsomorphismToCanonicalExactTriangle(   rT, PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] ) );
    SetIsomorphismFromCanonicalExactTriangle( rT, PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] ) );
    
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

    if IsCapCategoryCanonicalExactTriangle( T ) then
        return ReverseRotationOfCanonicalExactTriangle( T );
    fi;
     
    can_T := UnderlyingCanonicalExactTriangle( T );
    T_to_can_T := IsomorphismToCanonicalExactTriangle( T );
    can_T_to_T := IsomorphismFromCanonicalExactTriangle( T );
     
    rT := CreateExactTriangle( AdditiveInverse(ReverseShiftOfMorphism( MorphismAt( T, 2 ) ) ), MorphismAt( T, 0), MorphismAt( T, 1 ) );
    rcan_T := ReverseRotationOfCanonicalExactTriangle( can_T );
     
    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, ReverseShiftOfMorphism( MorphismAt( T_to_can_T, 2 ) ), 
                                                        MorphismAt( T_to_can_T, 0 ), 
                                                        MorphismAt( T_to_can_T, 1 ) );
                                                          
    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, ReverseShiftOfMorphism( MorphismAt( can_T_to_T, 2 ) ), 
                                                        MorphismAt( can_T_to_T, 0 ), 
                                                        MorphismAt( can_T_to_T, 1 ) );
                                                          
     
    can_rcan_T := UnderlyingCanonicalExactTriangle( rcan_T );
    rcan_T_to_can_rcan_T := IsomorphismToCanonicalExactTriangle( rcan_T );
    can_rcan_T_to_rcan_T := IsomorphismFromCanonicalExactTriangle( rcan_T );
     
    can_rT := UnderlyingCanonicalExactTriangle( rT );
     
    can_rcan_T_to_can_rT := CompleteToMorphismOfCanonicalExactTriangles( can_rcan_T, can_rT, 
                                ReverseShiftOfMorphism( MorphismAt( can_T_to_T, 2 ) ), MorphismAt( can_T_to_T, 0 ) );
    can_rT_to_can_rcan_T := CompleteToMorphismOfCanonicalExactTriangles( can_rT, can_rcan_T, 
                                ReverseShiftOfMorphism( MorphismAt( T_to_can_T, 2 ) ), MorphismAt( T_to_can_T, 0 ) );
    
    SetIsomorphismToCanonicalExactTriangle(   rT, PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] ) );
    SetIsomorphismFromCanonicalExactTriangle( rT, PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] ) );
     
    return rT;
     
end );

InstallMethod( CompleteToMorphismOfExactTriangles,
                [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                -1000,
    function( T1, T2, m0, m1 )
    local can_T1, can_T2, T1_to_can_T1, T2_to_can_T2, can_T1_to_T1, can_T2_to_T2, can_T1_to_can_T2,
        can_T1_to_can_T2_0, can_T1_to_can_T2_1;
    
    if IsCapCategoryCanonicalExactTriangle( T1 ) and IsCapCategoryCanonicalExactTriangle( T2 ) then
        return CompleteToMorphismOfCanonicalExactTriangles( T1, T2, m0, m1 );
    fi;

    can_T1 := UnderlyingCanonicalExactTriangle( T1 );
    can_T2 := UnderlyingCanonicalExactTriangle( T2 );
    
    T1_to_can_T1 := IsomorphismToCanonicalExactTriangle( T1 );
    can_T1_to_T1 := IsomorphismFromCanonicalExactTriangle( T1 );

    T2_to_can_T2 := IsomorphismToCanonicalExactTriangle( T2 );
    can_T2_to_T2 := IsomorphismFromCanonicalExactTriangle( T2 );

    can_T1_to_can_T2_0 := PreCompose( [ MorphismAt( can_T1_to_T1, 0 ), m0, MorphismAt( T2_to_can_T2, 0 ) ] );
    can_T1_to_can_T2_1 := PreCompose( [ MorphismAt( can_T1_to_T1, 1 ), m1, MorphismAt( T2_to_can_T2, 1 ) ] );
    can_T1_to_can_T2 := CompleteToMorphismOfCanonicalExactTriangles( can_T1, can_T2, can_T1_to_can_T2_0, can_T1_to_can_T2_1 );
    return PreCompose( [ T1_to_can_T1, can_T1_to_can_T2, can_T2_to_T2 ] );
    
end );

InstallMethod( ShiftFunctor,
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
InstallMethod( NaturalIsomorphismFromIdentityToShiftOfReverseShift, 
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
              
              return IsomorphismToShiftOfReverseShift( object );
              
           end );
         
        return nat;
        
end );
 
##
InstallMethod( NaturalIsomorphismFromIdentityToReverseShiftOfShift, 
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
              
              return IsomorphismToReverseShiftOfShift( object );
              
           end );
         
        return nat;
        
end );

##
InstallMethod( NaturalIsomorphismFromShiftOfReverseShiftToIdentity, 
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
InstallMethod( NaturalIsomorphismFromReverseShiftOfShiftToIdentity, 
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

##############################
##
##  View
##
##############################

InstallMethod( ViewObj,
               
               [ IsCapCategoryTriangle ], 
               
    function( triangle )

    if IsCapCategoryCanonicalExactTriangle( triangle ) then 
        Print( "<A canonical exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
    elif IsCapCategoryExactTriangle( triangle ) then 
        if HasIsCanonicalExactTriangle( triangle ) and not IsCanonicalExactTriangle( triangle ) then
            Print( "<An exact (not canonical) triangle in ", Name( CapCategory( ObjectAt( triangle, 0) ) ), ">");
        else
            Print( "<An exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">");
        fi;
    else
        Print( "<A triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
    fi;

end );
  
InstallMethod( ViewObj, 

               [ IsCapCategoryTrianglesMorphism ], 
               
    function( morphism )
  
        Print( "<A morphism of triangles in ", CapCategory( MorphismAt( morphism, 0 ) ), ">" );
  
end );
  
##############################
##
##  Display
##
##############################


InstallMethod( Display, 

        [ IsCapCategoryTriangle ],
        
    function( triangle )
    if IsCapCategoryCanonicalExactTriangle( triangle ) then 
        Print( "A canonical exact triangle given by the sequence\n\n");
    elif IsCapCategoryExactTriangle( triangle ) then 
        Print( "An exact triangle given by the sequence\n\n");
    else
        Print( "A triangle given by the sequence\n\n" );
    fi;
  
    Print( "     t0         t1         t2           \n");
    Print( "T0 ------> T1 ------> T2 ------> Σ( T0 )\n" );
    Print( "\n\nT0 is\n\n" ); Display( ObjectAt( triangle, 0 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "t0 is \n\n");Display( MorphismAt( triangle, 0 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "T1 is\n\n" );Display( ObjectAt( triangle, 1 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "t1 is \n\n");Display( MorphismAt( triangle, 1 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "T2 is\n\n" );Display( ObjectAt( triangle, 2 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "t2 is \n\n");Display( MorphismAt( triangle, 2 ) );
    Print( "\n------------------------------------\n\n" );
    Print( "Σ( T0 ) is \n\n" ); Display( ShiftOfObject( ObjectAt( triangle, 0 ) ) );
  
end, 5 );

##
InstallMethod( Display, 
        [ IsCapCategoryTrianglesMorphism ],
    
    function( morphism )
   
    Print( "A morphism of triangles:\n");
 
    Print( "          t0         t1         t2             \n" );
    Print( "Tr1: T0 ------> T1 ------> T2 ------> Σ(T0)    \n" );
    Print( "     |          |          |            |      \n" );
    Print( "     | m0       | m1       | m2         | Σ(m0)\n" );
    Print( "     |          |          |            |      \n" );
    Print( "     V          V          V            V      \n" );
    Print( "Tr2: T0 ------> T1 ------> T2 ------> Σ(T0)    \n" );
    Print( "          t0         t1         t2             \n" );
    Print( "\n---------------------------------------------\n" );
    Print( "\nm0 is\n\n" );
    Display( MorphismAt( morphism, 0 ) );
    Print( "----------------------------------------------\n" );
    Print( "\nm1 is\n\n" );
    Display( MorphismAt( morphism, 1 ) );
    Print( "----------------------------------------------\n" );
    Print( "\nm2 is\n\n" );
    Display( MorphismAt( morphism, 2 ) );
    Print( "----------------------------------------------\n" );
    Print( "\nΣ( m0 ) is\n\n" );
    Display( MorphismAt( morphism, 3 ) );
    Print( "----------------------------------------------\n" );
   
 end );
   
