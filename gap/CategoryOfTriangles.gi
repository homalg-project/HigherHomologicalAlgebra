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

DeclareRepresentation( "IsCapExactTriangleRep",
          IsCapExactTriangle and IsAttributeStoringRep,
          [ ] );
                      
DeclareRepresentation( "IsCapExactTrianglesMorphismRep",
          IsCapExactTrianglesMorphism and IsAttributeStoringRep, 
          [ ] );

##############################
##
## Family and type 
##
##############################
 
BindGlobal( "IsCapExactTrianglesMorphismsFamily",
  NewFamily( "IsCapExactTrianglesMorphismsFamily", IsObject )
);

BindGlobal( "TheTypeCapExactTrianglesMorphism", 
  NewType( IsCapExactTrianglesMorphismsFamily, IsCapExactTrianglesMorphismRep )
);

BindGlobal( "IsCapExactTriangleFamily",
  NewFamily( "IsCapExactTriangleFamily", IsObject )
);

BindGlobal( "TheTypeCapExactTriangle", 
  NewType( IsCapExactTriangleFamily, IsCapExactTriangleRep )
);
                      
InstallMethod( CategoryOfExactTriangles,
          [ IsTriangulatedCategory ],
  function( category )
    local name, triangles;
    
    name := Concatenation( "Exact triangles category( ", Name( category ), " )" );
    
    triangles := CreateCapCategory( name );
    
    SetFilterObj( triangles, IsCapCategoryOfExactTriangles );
    
    AddObjectRepresentation( triangles, IsCapExactTriangleRep );
    
    AddMorphismRepresentation( triangles, IsCapExactTrianglesMorphismRep );
    
    AddIsEqualForObjects( triangles,
      function( triangle_1, triangle_2 )
        return IsEqualForObjects( triangle_1[ 0 ], triangle_2[ 0 ] ) and 
                IsEqualForObjects( triangle_1[ 1 ], triangle_2[ 1 ] ) and
                 IsEqualForObjects(  triangle_1[ 2 ], triangle_2[ 2 ] ) and
                  IsEqualForMorphisms( triangle_1 ^ 0, triangle_2 ^ 0 ) and 
                   IsEqualForMorphisms( triangle_1 ^ 1, triangle_2 ^ 1 ) and
                    IsEqualForMorphisms( triangle_1 ^ 2, triangle_2 ^ 2 );
      end );
      
    AddIsEqualForMorphisms( triangles,
      function( phi_1, phi_2 )
        return IsEqualForMorphisms( phi_1[ 0 ], phi_2[ 0 ] ) and 
                  IsEqualForMorphisms( phi_1[ 1 ], phi_2[ 1 ] ) and
                    IsEqualForMorphisms( phi_1[ 2 ], phi_2[ 2 ] );
      end );
      
    AddIsCongruentForMorphisms( triangles,
      function( phi_1, phi_2 )
        return IsCongruentForMorphisms( phi_1[ 0 ], phi_2[ 0 ] ) and 
                  IsCongruentForMorphisms( phi_1[ 1 ], phi_2[ 1 ] ) and
                    IsCongruentForMorphisms( phi_1[ 2 ], phi_2[ 2 ] );
      end );
      
    AddIsZeroForObjects( triangles,
      function( triangle )
        return ForAll( [ 0 .. 3 ], i -> IsZeroForObjects( triangle[ i ] ) );
      end );
      
    AddIsZeroForMorphisms( triangles,
      function( phi )
        return ForAll( [ 0 .. 3 ], i -> IsZeroForMorphisms( phi[ i ] ) );
      end );
      
    AddIdentityMorphism( triangles,
      function( triangle )
        local maps;
        
        maps := List( [ 0 .. 2 ], i -> IdentityMorphism( triangle[ i ] ) );
        
        return MorphismOfExactTriangles( triangle, maps[ 1 ], maps[ 2 ], maps[ 3 ], triangle );
        
      end );
      
    AddPreCompose( triangles,
      function( phi, psi )
        local maps_phi, maps_psi, maps;
        
        maps_phi := List( [ 0 .. 2 ], i -> phi[ i ] );
        
        maps_psi := List( [ 0 .. 2 ], i -> psi[ i ] );
        
        maps := ListN( maps_phi, maps_psi, PreCompose );
        
        return MorphismOfExactTriangles( Source( phi ), maps[ 1 ], maps[ 2 ], maps[ 3 ], Range( psi ) );
       
    end );
    
    AddIsIsomorphism( triangles,
      function( phi )
        if ForAll( [ 0 .. 3 ], i -> IsIsomorphism( phi[ i ] ) ) then
          
          return true;
          
        else
          
          return false;
          
        fi;
        
    end );
    
    AddIsWellDefinedForObjects( triangles,
      function( triangle )
        
        if not ( IsWellDefined( triangle[ 0 ] ) and
                  IsWellDefined( triangle[ 1 ] ) and
                    IsWellDefined( triangle[ 2 ] ) and
                      IsWellDefined( triangle[ 3 ] )
                        ) then
                        
          return false;
          
        fi;
        
        if not ( IsWellDefined( triangle ^ 0 ) and
                  IsWellDefined( triangle ^ 1 ) and
                    IsWellDefined( triangle ^ 2 )
                      ) then
                      
          return false;
          
        fi;
        
        if not ( IsEqualForObjects( Range( triangle ^ 0 ), Source( triangle ^ 1 ) ) and
                  IsEqualForObjects( Range( triangle ^ 1 ), Source( triangle ^ 2 ) ) and
                    IsEqualForObjects( ShiftOnObject( Source( triangle ^ 0 ) ), Range( triangle ^ 2 ) )
                      ) then
                      
          return false;
          
        fi;
        
        if not ( IsZeroForMorphisms( PreCompose( triangle ^ 0, triangle ^ 1 ) ) and
                  IsZeroForMorphisms( PreCompose( triangle ^ 1, triangle ^ 2 ) )
                    ) then
                    
          return false;
          
        fi;
        
        return true;
        
    end );
    
    AddIsWellDefinedForMorphisms( triangles, 
      function( phi )
        local triangle_1, triangle_2;
        
        if not IsWellDefined( Source( phi ) ) or not IsWellDefined( Range( phi) ) then
          
          return false;
          
        fi;
        
        if not ForAll( [ 0 .. 3 ], i -> IsWellDefined( phi[ i ] ) ) then
          
          return false;
          
        fi;
        
        triangle_1 := Source( phi );
        
        triangle_2 := Range( phi );
        
        if not ( IsEqualForObjects( Source( phi[ 0 ] ), triangle_1[ 0 ] ) and 
                  IsEqualForObjects( Range( phi[ 0 ] ), triangle_2[ 0 ] )
              ) then
              
          return false;
          
        fi;
        
        if not ( IsEqualForObjects( Source( phi[ 1 ] ), triangle_1[ 1 ] ) and
                  IsEqualForObjects( Range( phi[ 1 ] ), triangle_2[ 1 ] )
              ) then
              
          return false;
          
        fi;
        
        if not ( IsEqualForObjects( Source( phi[ 2 ] ), triangle_1[ 2 ] ) and
                  IsEqualForObjects( Range( phi[ 2 ] ), triangle_2[ 2 ] )
                ) then
                
          return false;
        
        fi;
        
        # Is the diagram commutative?
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 0, MorphismAt( phi, 1 ) ), 
                    PreCompose( phi[ 0 ], triangle_2 ^ 0 )
                ) then
                
          return false;
            
        fi;
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 1, phi[ 2 ] ),
                    PreCompose( phi[ 1 ], triangle_2 ^ 1 )
                ) then
                
          return false;
          
        fi;
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 2, phi[ 3 ] ),
                    PreCompose( phi[ 2 ], triangle_2 ^ 2 )
                ) then
                
            return false;
            
        fi;
        
        return true;
        
    end );
    
    Finalize( triangles );
    
    return triangles;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( ExactTriangle,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, iota_alpha, pi_alpha )
    local cat, triangles, tr;
    
    cat := CapCategory( alpha );
    
    triangles := CategoryOfExactTriangles( cat );
    
    tr := rec( );
    
    ObjectifyObjectForCAPWithAttributes(
                tr, triangles,
                DomainMorphism, alpha,
                MorphismIntoConeObject, iota_alpha,
                MorphismFromConeObject, pi_alpha
              );
    
    return tr;

end );


#
InstallMethod( MorphismOfExactTriangles, 
        [ IsCapExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapExactTriangle ],
  function( s, mu, nu, lambda, r )
    local triangles, phi;
    
    triangles := CapCategory( s );
    
    phi := rec( 0 := mu, 1 := nu, 2 := lambda );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( phi, triangles, s, r );
    
    return phi;
    
end );


##
InstallMethod( MorphismAtOp, 
          [ IsCapExactTriangle, IsInt ],
  function( triangle, i )
    
    if i = 0 then
      
      return DomainMorphism( triangle );
      
    elif i = 1 then
      
      return MorphismIntoConeObject( triangle );
      
    elif i = 2 then
      
      return MorphismFromConeObject( triangle );
      
    else
      
      Error( "Wrong index!\n" );
    
    fi;

end );

##
InstallMethod( ObjectAtOp, 
          [ IsCapExactTriangle, IsInt ],
  function( triangle, i )
    
    if i < 0 or i > 3 then
      
      Error( "Wrong index!\n" );
      
    elif i = 3 then
    
      return Range( MorphismAt( triangle, 2 ) );
      
    else
      
      return Source( MorphismAt( triangle, i ) );
      
    fi;
    
end );

##
InstallMethod( MorphismAtOp, 
                [ IsCapExactTrianglesMorphism, IsInt ],
  function( phi, i )
    
    if i < 0 or i > 3 then
      
      Error( "Wrong index!\n" );
      
    elif i = 3 then
    
      return ShiftOnMorphism( phi!.0 );
      
    else
      
      return phi!.( i );
      
    fi;

end );

##
InstallMethod( \^,
          [ IsCapExactTriangle, IsInt ],
  function( triangle, i )
    
    return MorphismAt( triangle, i );

end );

##
InstallMethod( \[\],
          [ IsCapExactTriangle, IsInt ],
  function( triangle, i )
    
    return ObjectAt( triangle, i );

end );

##
InstallMethod( \[\],
          [ IsCapExactTrianglesMorphism, IsInt ],
  function( phi, i )
    
    return MorphismAt( phi, i );

end );

###
#InstallMethod( AddtriangleoUnderlyingLazyMethods, 
#            [ IsCapCategoryCell, IsOperation, IsFunction, IsList ],
#    function( C, method_name, F, l )
#    
#    Add( C!.UnderlyingLazyMethods, method_name );
#    Add( C!.UnderlyingLazyMethods, F );
#    Add( C!.UnderlyingLazyMethods, l );
#
#end );
#
###
#InstallMethod( ExtendFunctorToTrianglesCategory, [ IsCapFunctor ],
#
#    function( F )
#    local source, range, name, functor;
#    
#    # Note: F must commute with the Shift functor.
#
#    source := AsCapCategory( Source( F ) );
#    range := AsCapCategory( Range( F ) );
#    
#    source := CategoryOfTriangles( source );
#    range := CategoryOfTriangles( range );
#    
#    name := Concatenation( "Extension of ", Name( F ) );
#    
#    functor := CapFunctor( name, source, range );
#
#    AddObjectFunction( functor, 
#    
#        function( T )
#          
#        return CreateTriangle( ApplyFunctor(F, T^0), ApplyFunctor(F, T^1), ApplyFunctor(F, T^2) );
#          
#        end );
#          
#    AddMorphismFunction( functor, 
#    
#        function( new_source, phi, new_range )
#          
#        return CreateTrianglesMorphism( new_source, new_range, ApplyFunctor(F,phi[0]), ApplyFunctor(F,phi[1]), ApplyFunctor(F,phi[2]) );
#          
#        end );
#          
#    return functor;
#
#end );
#
###
#InstallMethod( MappingCone,
#                [ IsCapCategoryTrianglesMorphism ],
#
#    function( phi )
#    local T1, T2, t0, t1, t2;
#
#    T1 := Source( phi );
#    
#    T2 := Range( phi );
#    
#    t0 := MorphismBetweenDirectSums( 
#                                    [
#                                        [ AdditiveInverse( T1^1 ), phi[1] ],
#                                        [ ZeroMorphism( T2[0], T1[2]), T2^0]
#                                    ]
#                                    );
#    t1 := MorphismBetweenDirectSums( 
#                                    [
#                                        [ AdditiveInverse( T1^2 ), phi[2] ],
#                                        [ ZeroMorphism( T2[1], T1[3]), T2^1]
#                                    ]
#                                    );
#    t2 := MorphismBetweenDirectSums( 
#                                    [
#                                        [ AdditiveInverse( ShiftOfMorphism( T1^0 ) ), ShiftOfMorphism( phi[0] ) ],
#                                        [ ZeroMorphism( T2[2], ShiftOfObject( T1[1]) ) , T2^2]
#                                    ]
#                                    );
#    return CreateTriangle( t0, t1, t2 );
#
#end );
###############################
###
###  View
###
###############################
#
#InstallMethod( ViewObj,
#               
#               [ IsCapCategoryTriangle ], 
#               
#    function( triangle )
#
#    if IsCapCategoryStandardExactTriangle( triangle ) then 
#        Print( "<A standard exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
#    elif IsCapExactTriangle( triangle ) then 
#        if HasIsStandardExactTriangle( triangle ) and not IsStandardExactTriangle( triangle ) then
#            Print( "<An exact (not canonical) triangle in ", Name( CapCategory( ObjectAt( triangle, 0) ) ), ">");
#        else
#            Print( "<An exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">");
#        fi;
#    else
#        Print( "<A triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
#    fi;
#
#end );
#  
#InstallMethod( ViewObj, 
#
#               [ IsCapCategoryTrianglesMorphism ], 
#               
#    function( morphism )
#  
#        Print( "<A morphism of triangles in ", CapCategory( MorphismAt( morphism, 0 ) ), ">" );
#  
#end );
#
#
###############################
###
###  Display
###
###############################
#
#
#InstallMethod( Display,
#
#        [ IsCapCategoryTriangle ],
#
#    function( triangle )
#    if IsCapCategoryStandardExactTriangle( triangle ) then
#        Print( "A standard exact triangle given by the sequence\n\n");
#    elif IsCapCategoryExactTriangle( triangle ) then
#        Print( "An exact triangle given by the sequence\n\n");
#    else
#        Print( "A triangle given by the sequence\n\n" );
#    fi;
#
#    Print( TextAttr.bold, TextAttr.1, "          τ0         τ1         τ2           \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "     T0 ------> T1 ------> T2 ------> Σ(T0)  \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\n\nT0:\n\n" , TextAttr.reset );
#    Display( ObjectAt( triangle, 0 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ0:\n\n", TextAttr.reset );
#    Display( MorphismAt( triangle, 0 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "T1:\n\n" , TextAttr.reset );
#    Display( ObjectAt( triangle, 1 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ1:\n\n", TextAttr.reset );
#    Display( MorphismAt( triangle, 1 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "T2:\n\n" , TextAttr.reset );
#    Display( ObjectAt( triangle, 2 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ2:\n\n", TextAttr.reset );
#    Display( MorphismAt( triangle, 2 ) );
#    Print(      "\n------------------------------------\n\n" );
#    Print(     TextAttr.bold, TextAttr.1, TextAttr.underscore,  "Σ(T0):\n\n" , TextAttr.reset );
#    Display( ShiftOfObject( ObjectAt( triangle, 0 ) ) );
#
#end, 5 );
#
###
#InstallMethod( Display,
#        [ IsCapCategoryTrianglesMorphism ],
#
#    function( morphism )
#
#    Print( "A morphism of triangles:\n");
#
#    Print( TextAttr.bold, TextAttr.1, "                τ0          τ1           τ2             \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "     Tr  : T0 -------> T1 -------> T2 -------> Σ(T0)    \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "           |           |           |             |      \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "           | m0        | m1        | m2          | Σ(m0)\n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "           |           |           |             |      \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "           V           V           V             V      \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "     Tr' : T'0 ------> T'1 ------> T'2 ------> Σ(T'0)    \n", TextAttr.reset );
#    Print( TextAttr.bold, TextAttr.1, "                τ'0         τ'1          τ'2             \n", TextAttr.reset );
#    Print( "\n---------------------------------------------\n" );
#    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm0:\n\n", TextAttr.reset );
#    Display( MorphismAt( morphism, 0 ) );
#    Print( "-----------------------------------------------\n" );
#    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm1:\n\n", TextAttr.reset );
#    Display( MorphismAt( morphism, 1 ) );
#    Print( "-----------------------------------------------\n" );
#    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm2:\n\n", TextAttr.reset );
#    Display( MorphismAt( morphism, 2 ) );
#    Print( "-----------------------------------------------\n" );
#    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nΣ(m0):\n\n", TextAttr.reset );
#    Display( MorphismAt( morphism, 3 ) );
#    Print( "-----------------------------------------------\n" );
#
# end );
