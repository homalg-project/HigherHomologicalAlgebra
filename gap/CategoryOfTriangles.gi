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
    local r, name, triangles;
    
    if IsBound( RandomTextColor ) then
      
      r := ValueGlobal( "RandomTextColor" )( Name( category ) );
      
      name := Concatenation( r[ 1 ], "Category of exact triangles( ", r[ 2 ], Name( category ), r[ 1 ], " )", r[ 2 ] );
      
    else
      
      name := Concatenation( "Category of exact triangles( ", Name( category ), " )" );
      
    fi;
    
    triangles := CreateCapCategory( name );
    
    SetUnderlyingCategory( triangles, category );
    
    SetFilterObj( triangles, IsCapCategoryOfExactTriangles );
    
    AddObjectRepresentation( triangles, IsCapExactTriangleRep );
    
    AddMorphismRepresentation( triangles, IsCapExactTrianglesMorphismRep );
    
    AddIsEqualForCacheForObjects( triangles, IsIdenticalObj );
    
    AddIsEqualForCacheForMorphisms( triangles, IsIdenticalObj );
   
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

##
InstallMethod( StandardExactTriangle,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local triangle, iota_alpha, pi_alpha;
    
    iota_alpha := MorphismIntoStandardConeObject( alpha );
    
    pi_alpha := MorphismFromStandardConeObject( alpha );
    
    triangle := ExactTriangle( alpha, iota_alpha, pi_alpha );
    
    SetIsStandardExactTriangle( triangle, true );
    
    SetWitnessIsomorphismIntoStandardExactTriangle( triangle, IdentityMorphism( triangle ) );
    
    SetWitnessIsomorphismFromStandardExactTriangle( triangle, IdentityMorphism( triangle ) );
    
    return triangle;
    
end );

##
InstallOtherMethod( ExactTriangle,
        [ IsCapCategoryMorphism ],
  alpha -> StandardExactTriangle( alpha )
);

##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta )
    
    return
      ExactTriangle(
        DomainMorphismByOctahedralAxiom( alpha, beta ),
        MorphismIntoConeObjectByOctahedralAxiom( alpha, beta ),
        MorphismFromConeObjectByOctahedralAxiom( alpha, beta )
      );
     
end );
##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsBool ],
  function( alpha, beta, b )
    local triangle, st_triangle, T, i;
    
    triangle := ExactTriangleByOctahedralAxiom( alpha, beta );
    
    if not b then
      
      return triangle;
      
    fi;
    
    st_triangle := StandardExactTriangle( triangle );
    
    T := CapCategory( alpha );
    
    if not( CanCompute( T, "WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects" ) and
              CanCompute( T, "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects" )
          ) then
          
      Error( "The octahedral methods must be installed in the category of the arguments" );
      
    else
      
      i := WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects( triangle[ 2 ], alpha, beta, st_triangle[ 2 ] );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( triangle,
        MorphismOfExactTriangles(
          triangle,
          IdentityMorphism( triangle[ 0 ] ),
          IdentityMorphism( triangle[ 1 ] ),
          i,
          st_triangle
        ) );
      
      i := WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( st_triangle[ 2 ], alpha, beta, triangle[ 2 ] );
      
      SetWitnessIsomorphismFromStandardExactTriangle( triangle,
        MorphismOfExactTriangles(
          st_triangle,
          IdentityMorphism( triangle[ 0 ] ),
          IdentityMorphism( triangle[ 1 ] ),
          i,
          triangle
        ) );
    
    fi;
    
    return triangle;
    
end );

##
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

##
InstallMethod( IsStandardExactTriangle,
          [ IsCapExactTriangle ],
    triangle -> IsEqualForObjects( triangle, StandardExactTriangle( triangle ^ 0 ) )
);

##
InstallMethod( StandardExactTriangle,
          [ IsCapExactTriangle ],
    triangle -> StandardExactTriangle( triangle ^ 0 )
);

##
InstallMethod( Rotation,
          [ IsCapExactTriangle ],
    triangle -> ExactTriangle( triangle ^ 1, triangle ^ 2, AdditiveInverse( ShiftOnMorphism( triangle ^ 0 ) ) )
);

##  
##  A ---> B ---> C ---> Σ A
##
##  B ---> C ---> Σ A ---> Σ B
##
InstallMethod( Rotation,
          [ IsCapExactTriangle, IsBool ],
  function( triangle, bool )
    local rotation, st_rotation, i, st_triangle, w_1, v_1;
     
    rotation := Rotation( triangle );
    
    if not bool then
      
      return rotation;
      
    fi;
    
    st_rotation := StandardExactTriangle( rotation );
    
    if IsStandardExactTriangle( triangle ) then
      
      i := WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects( rotation[ 2 ], triangle ^ 0, st_rotation[ 2 ] );
      
      i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, st_rotation );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
      
      i := WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( st_rotation[ 2 ], triangle ^ 0, rotation[ 2 ] );
      
      i := MorphismOfExactTriangles( st_rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, rotation );
     
      SetWitnessIsomorphismFromStandardExactTriangle( rotation, i );
      
    else
      
      i := WitnessIsomorphismFromStandardExactTriangle( triangle );
      
      st_triangle := Source( i );
      
      w_1 := WitnessIsomorphismIntoStandardConeObjectByRotationAxiom( st_triangle ^ 0 );
      
      v_1 := MorphismBetweenStandardConeObjects( st_triangle ^ 1, IdentityMorphism( st_triangle[ 1 ] ), i[ 2 ], triangle ^ 1 );
      
      i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), PreCompose( w_1, v_1 ), st_rotation );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
            
    fi;
    
    return rotation;
    
end );

##  
##  A ---> B ---> C ---> Σ A
##
##  Σ^-1 C  ---> A ---> B ---> Σ Σ^-1 C
##
InstallMethod( InverseRotation,
          [ IsCapExactTriangle ],
  function( triangle )
  
    return ExactTriangle(
              PreCompose(
                AdditiveInverse( InverseShiftOnMorphism( triangle ^ 2 ) ),
                IsomorphismFromInverseShiftOfShift( triangle[ 0 ] )
                        ),
              triangle ^ 0,
              PreCompose(
                triangle ^ 1,
                IsomorphismIntoShiftOfInverseShift( triangle[ 2 ] )
                        )
                    );
    
end );

InstallMethod( InverseRotation,
          [ IsCapExactTriangle, IsBool ],
  function( triangle, bool )
    local rotation, st_rotation, i, st_triangle, w_1, v_1;
    
    rotation := InverseRotation( triangle );
    
    if not bool then
      
      return rotation;
      
    fi;
    
    st_rotation := StandardExactTriangle( rotation );
    
    if IsStandardExactTriangle( triangle ) then
      
      i := WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( rotation[ 2 ], triangle ^ 0, st_rotation[ 2 ] );
      
      i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, st_rotation );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
      
      i := WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( st_rotation[ 2 ], triangle ^ 0, rotation[ 2 ] );
      
      i := MorphismOfExactTriangles( st_rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, rotation );
     
      SetWitnessIsomorphismFromStandardExactTriangle( rotation, i );
      
    else
      
      i := WitnessIsomorphismFromStandardExactTriangle( triangle );
      
      st_triangle := Source( i );
      
      w_1 := WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom( st_triangle ^ 0 );
      
      v_1 := MorphismBetweenStandardConeObjects(
                PreCompose(
                  AdditiveInverse( InverseShiftOnMorphism( st_triangle ^ 2 ) ),
                  IsomorphismFromInverseShiftOfShift( triangle[ 0 ] )
                ),
                InverseShiftOnMorphism( i[ 2 ] ),
                IdentityMorphism( triangle[ 0 ] ),
                PreCompose(
                  AdditiveInverse( InverseShiftOnMorphism( triangle ^ 2 ) ),
                  IsomorphismFromInverseShiftOfShift( triangle[ 0 ] )
                )
              );
      
      i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), PreCompose( w_1, v_1 ), st_rotation );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
     
    fi;
    
    return rotation;
   
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardExactTriangle,
          [ IsCapExactTriangle ],
  function( triangle )
    local cat, st_triangle, i;
    
    if IsStandardExactTriangle( triangle ) then
      
      return IdentityMorphism( triangle );
      
    fi;
    
    # This could happen only if the user manually have set this attribute
    if HasWitnessIsomorphismFromStandardExactTriangle( triangle ) then
      
      i := WitnessIsomorphismFromStandardExactTriangle( triangle );
      
      return MorphismOfExactTriangles(
                triangle,
                IdentityMorphism( triangle[ 0 ] ),
                IdentityMorphism( triangle[ 1 ] ),
                Inverse( i[ 2 ] ),
                Source( i )
              );
              
    fi;
     
    cat := UnderlyingCategory( CapCategory( triangle ) );
    
    if not CanCompute( cat, "WitnessIsomorphismIntoStandardConeObjectByExactTriangle" ) then
      
      TryNextMethod( );
      
    fi;
    
    st_triangle := StandardExactTriangle( triangle ^ 0 );
    
    i := WitnessIsomorphismIntoStandardConeObjectByExactTriangle( triangle ^ 0, triangle ^ 1, triangle ^ 2 );
    
    if i = fail then
      
      return fail;
      
    else
      
      return MorphismOfExactTriangles( triangle, IdentityMorphism( triangle[ 0 ] ), IdentityMorphism( triangle[ 1 ] ), i, st_triangle );
      
    fi;
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardExactTriangle,
          [ IsCapExactTriangle ],
  function( triangle )
    local cat, st_triangle, i;
    
    if IsStandardExactTriangle( triangle ) then
      
      return IdentityMorphism( triangle );
      
    fi;
    
    i := WitnessIsomorphismIntoStandardExactTriangle( triangle );
    
    if i = fail then
      
      return fail;
      
    else
      
      return MorphismOfExactTriangles(
                Range( i ),
                IdentityMorphism( triangle[ 0 ] ),
                IdentityMorphism( triangle[ 1 ] ),
                Inverse( i[ 2 ] ),
                triangle
              );
    
    fi;
    
end );
    
##    
InstallMethod( MorphismBetweenConeObjects,
          [ IsCapExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapExactTriangle ],
  function( triangle_1, mu_0, mu_1, triangle_2 )
    local st_triangle_1, st_triangle_2, i_1, j_1, i_2, j_2, u, v, w;
    
    st_triangle_1 := StandardExactTriangle( triangle_1 );
    
    st_triangle_2 := StandardExactTriangle( triangle_2 );
    
    i_1 := WitnessIsomorphismIntoStandardExactTriangle( triangle_1 );
    
    j_1 := WitnessIsomorphismFromStandardExactTriangle( triangle_1 );
    
    i_2 := WitnessIsomorphismIntoStandardExactTriangle( triangle_2 );
    
    j_2 := WitnessIsomorphismFromStandardExactTriangle( triangle_2 );
    
    u := PreCompose( [ j_1[ 0 ], mu_0, i_2[ 0 ] ] );
    
    v := PreCompose( [ j_1[ 1 ], mu_1, i_2[ 1 ] ] );
    
    w := MorphismBetweenStandardConeObjects( st_triangle_1 ^ 0, u, v, st_triangle_2 ^ 0 );
    
    return PreCompose( [ i_1[ 2 ], w, j_2[ 2 ] ] );
    
end );

#################
#
# Display
#
#################

##
InstallMethod( Display,
          [ IsCapExactTriangle ],
  function( triangle )

    Print( "       T^0          T^1          T^2            \n" );
    Print( "T[0] ------> T[1] ------> T[2] ------> Σ( T[0] )\n" );
    
end );

##
InstallMethod( Display,
          [ IsCapExactTrianglesMorphism ],
  function( nu )

    Print( "T[0] ------> T[1] ------> T[2] ------> Σ( T[0] )      \n" );
    Print( " |            |            |              |           \n" );
    Print( " | nu[0]      | nu[1]      | nu[2]        | Σ( nu[0] )\n" );
    Print( " V            V            V              V           \n" );
    Print( "Q[0] ------> Q[1] ------> Q[2] ------> Σ( Q[0] )      \n" );
  
end );

