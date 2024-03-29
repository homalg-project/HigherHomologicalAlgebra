# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

##
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
    
    triangles := CreateCapCategory( name, IsCategoryOfExactTriangles, IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesMorphism, IsCapCategoryTwoCell );
    
    triangles!.category_as_first_argument := true;
    
    SetUnderlyingCategory( triangles, category );
    
    AddIsEqualForObjects( triangles,
      function( cat, triangle_1, triangle_2 )
        return IsEqualForObjects( triangle_1[ 0 ], triangle_2[ 0 ] ) and 
                IsEqualForObjects( triangle_1[ 1 ], triangle_2[ 1 ] ) and
                 IsEqualForObjects(  triangle_1[ 2 ], triangle_2[ 2 ] ) and
                  IsEqualForMorphisms( triangle_1 ^ 0, triangle_2 ^ 0 ) and 
                   IsEqualForMorphisms( triangle_1 ^ 1, triangle_2 ^ 1 ) and
                    IsEqualForMorphisms( triangle_1 ^ 2, triangle_2 ^ 2 );
      end );
      
    AddIsEqualForMorphisms( triangles,
      function( cat, mu, nu )
        return IsEqualForMorphisms( mu[ 0 ], nu[ 0 ] ) and 
                  IsEqualForMorphisms( mu[ 1 ], nu[ 1 ] ) and
                    IsEqualForMorphisms( mu[ 2 ], nu[ 2 ] );
      end );
      
    AddIsCongruentForMorphisms( triangles,
      function( cat, mu, nu )
        return IsCongruentForMorphisms( mu[ 0 ], nu[ 0 ] ) and 
                  IsCongruentForMorphisms( mu[ 1 ], nu[ 1 ] ) and
                    IsCongruentForMorphisms( mu[ 2 ], nu[ 2 ] );
      end );
      
    AddIsZeroForObjects( triangles,
      function( cat, triangle )
        return ForAll( [ 0 .. 3 ], i -> IsZeroForObjects( triangle[ i ] ) );
      end );
      
    AddIsZeroForMorphisms( triangles,
      function( cat, mu )
        return ForAll( [ 0 .. 3 ], i -> IsZeroForMorphisms( mu[ i ] ) );
      end );
      
    AddIdentityMorphism( triangles,
      function( cat, triangle )
        local maps;
        
        maps := List( [ 0 .. 2 ], i -> IdentityMorphism( triangle[ i ] ) );
        
        return MorphismOfExactTriangles( triangle, maps[ 1 ], maps[ 2 ], maps[ 3 ], triangle );
        
      end );
      
    AddPreCompose( triangles,
      function( cat, mu, nu )
        local maps_mu, maps_nu, maps;
        
        maps_mu := List( [ 0 .. 2 ], i -> mu[ i ] );
        
        maps_nu := List( [ 0 .. 2 ], i -> nu[ i ] );
        
        maps := ListN( maps_mu, maps_nu, PreCompose );
        
        return MorphismOfExactTriangles( Source( mu ), maps[ 1 ], maps[ 2 ], maps[ 3 ], Range( nu ) );
       
    end );
    
    AddIsIsomorphism( triangles,
      function( cat, mu )
        if ForAll( [ 0 .. 3 ], i -> IsIsomorphism( mu[ i ] ) ) then
          
          return true;
          
        else
          
          return false;
          
        fi;
        
    end );
    
    AddIsWellDefinedForObjects( triangles,
      function( cat, triangle )
        
        if IsStandardExactTriangle( triangle ) then
          
          return true;
          
        fi;
        
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
                    IsEqualForObjects( ShiftOfObject( Source( triangle ^ 0 ) ), Range( triangle ^ 2 ) )
                      ) then
                      
          return false;
          
        fi;
        
        if not ( IsZeroForMorphisms( PreCompose( triangle ^ 0, triangle ^ 1 ) ) and
                  IsZeroForMorphisms( PreCompose( triangle ^ 1, triangle ^ 2 ) )
                    ) then
                    
          return false;
          
        fi;
        
        if WitnessIsomorphismIntoStandardExactTriangle( triangle ) = fail then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
    AddIsWellDefinedForMorphisms( triangles, 
      function( cat, mu )
        local triangle_1, triangle_2;
        
        if not IsWellDefined( Source( mu ) ) or not IsWellDefined( Range( mu) ) then
          
          return false;
          
        fi;
        
        if not ForAll( [ 0 .. 3 ], i -> IsWellDefined( mu[ i ] ) ) then
          
          return false;
          
        fi;
        
        triangle_1 := Source( mu );
        
        triangle_2 := Range( mu );
        
        if not ( IsEqualForObjects( Source( mu[ 0 ] ), triangle_1[ 0 ] ) and 
                  IsEqualForObjects( Range( mu[ 0 ] ), triangle_2[ 0 ] )
              ) then
              
          return false;
          
        fi;
        
        if not ( IsEqualForObjects( Source( mu[ 1 ] ), triangle_1[ 1 ] ) and
                  IsEqualForObjects( Range( mu[ 1 ] ), triangle_2[ 1 ] )
              ) then
              
          return false;
          
        fi;
        
        if not ( IsEqualForObjects( Source( mu[ 2 ] ), triangle_1[ 2 ] ) and
                  IsEqualForObjects( Range( mu[ 2 ] ), triangle_2[ 2 ] )
                ) then
                
          return false;
        
        fi;
        
        # Is the diagram commutative?
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 0, mu[ 1 ] ),
                    PreCompose( mu[ 0 ], triangle_2 ^ 0 )
                ) then
                
          return false;
            
        fi;
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 1, mu[ 2 ] ),
                    PreCompose( mu[ 1 ], triangle_2 ^ 1 )
                ) then
                
          return false;
          
        fi;
        
        if not IsCongruentForMorphisms(
                  PreCompose( triangle_1 ^ 2, mu[ 3 ] ),
                    PreCompose( mu[ 2 ], triangle_2 ^ 2 )
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
  function( alpha, iota, pi )
    local cat, triangles;
    
    cat := CapCategory( alpha );
    
    triangles := CategoryOfExactTriangles( cat );
    
    return CreateCapCategoryObjectWithAttributes(
             triangles,
             DomainMorphism, alpha,
             MorphismIntoConeObject, iota,
             MorphismFromConeObject, pi
           );
    
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
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    
    return
      ExactTriangle(
        DomainMorphismByOctahedralAxiom( alpha, beta, gamma ),
        MorphismIntoConeObjectByOctahedralAxiom( alpha, beta, gamma ),
        MorphismFromConeObjectByOctahedralAxiom( alpha, beta, gamma )
      );
     
end );
##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsBool ],
  function( alpha, beta, gamma, b )
    local triangle, st_triangle, T, i;
    
    triangle := ExactTriangleByOctahedralAxiom( alpha, beta, gamma );
    
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
      
      i := WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects( triangle[ 2 ], alpha, beta, gamma, st_triangle[ 2 ] );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( triangle,
        MorphismOfExactTriangles(
          triangle,
          IdentityMorphism( triangle[ 0 ] ),
          IdentityMorphism( triangle[ 1 ] ),
          i,
          st_triangle
        ) );
      
      i := WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( st_triangle[ 2 ], alpha, beta, gamma, triangle[ 2 ] );
      
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
        [ IsCategoryOfExactTrianglesObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCategoryOfExactTrianglesObject ],
  function( s, mu_0, mu_1, mu_2, r )
    local triangles, mu;
    
    triangles := CapCategory( s );
    
    mu := CreateCapCategoryMorphismWithAttributes( triangles, s, r );
    
    mu!.0 := mu_0;
    mu!.1 := mu_1;
    mu!.2 := mu_2;
    
    return mu;
    
end );

##
InstallMethod( MorphismAtOp, 
          [ IsCategoryOfExactTrianglesObject, IsInt ],
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
          [ IsCategoryOfExactTrianglesObject, IsInt ],
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
                [ IsCategoryOfExactTrianglesMorphism, IsInt ],
  function( mu, i )
    
    if i < 0 or i > 3 then
      
      Error( "Wrong index!\n" );
      
    elif i = 3 then
    
      return ShiftOfMorphism( mu!.( 0 ) );
      
    else
      
      return mu!.( i );
      
    fi;

end );

##
InstallMethod( \^,
          [ IsCategoryOfExactTrianglesObject, IsInt ],
  function( triangle, i )
    
    return MorphismAt( triangle, i );

end );

##
InstallMethod( \[\],
          [ IsCategoryOfExactTrianglesObject, IsInt ],
  function( triangle, i )
    
    return ObjectAt( triangle, i );

end );

##
InstallMethod( \[\],
          [ IsCategoryOfExactTrianglesMorphism, IsInt ],
  function( mu, i )
    
    return MorphismAt( mu, i );

end );

##
InstallMethod( IsStandardExactTriangle,
          [ IsCategoryOfExactTrianglesObject ],
    triangle -> IsEqualForObjects( triangle, StandardExactTriangle( triangle ^ 0 ) )
);

##
InstallMethod( StandardExactTriangle,
          [ IsCategoryOfExactTrianglesObject ],
    triangle -> StandardExactTriangle( triangle ^ 0 )
);

##
InstallMethod( Rotation,
          [ IsCategoryOfExactTrianglesObject ],
    triangle -> Rotation( triangle, false )
);


##
InstallMethod( ShiftOp,
          [ IsCategoryOfExactTrianglesObject, IsInt ],
  function( t, n )
    local shift_t, st, shift_st, w;
    
    shift_t := ExactTriangle(
                    Shift( t^0, n ),
                    Shift( t^1, n ),
                    (-1)^n * Shift( t^2, n )
                  );
    
    if HasWitnessIsomorphismIntoStandardExactTriangle( t ) or
        HasWitnessIsomorphismFromStandardExactTriangle( t ) then
        
        st := StandardExactTriangle( t );
        
        shift_st := ExactTriangle(
                    Shift( st^0, n ),
                    Shift( st^1, n ),
                    (-1)^n * Shift( st^2, n )
                  );
        
    fi;
    
    if not IsStandardExactTriangle( shift_st ) then
      
      return shift_t;
      
    fi;
   
    if HasWitnessIsomorphismIntoStandardExactTriangle( t ) then
      
      w := WitnessIsomorphismIntoStandardExactTriangle( t );
      
      w := MorphismOfExactTriangles(
                shift_t,
                Shift( w[ 0 ], n ),
                Shift( w[ 1 ], n ),
                Shift( w[ 2 ], n ),
                shift_st
              );
      
      SetWitnessIsomorphismIntoStandardExactTriangle( shift_t, w );
      
    fi;
    
    if HasWitnessIsomorphismFromStandardExactTriangle( t ) then
      
      w := WitnessIsomorphismFromStandardExactTriangle( t );
      
      w := MorphismOfExactTriangles(
                shift_st,
                Shift( w[ 0 ], n ),
                Shift( w[ 1 ], n ),
                Shift( w[ 2 ], n ),
                shift_t
              );
      
      SetWitnessIsomorphismFromStandardExactTriangle( shift_t, w );

    fi;
    
    return shift_t;
    
end );

##
InstallMethod( ShiftOp,
          [ IsCategoryOfExactTrianglesMorphism, IsInt ],
  function( mu, n )
    return MorphismOfExactTriangles(
                    Shift( Source( mu ), n ),
                    Shift( mu[ 0 ], n ),
                    Shift( mu[ 1 ], n ),
                    Shift( mu[ 2 ], n ),
                    Shift( Range( mu ), n )
                  );
end );
##  
##  A ---> B ---> C ---> Σ A
##
##  B ---> C ---> Σ A ---> Σ B
##
InstallMethod( Rotation,
          [ IsCategoryOfExactTrianglesObject, IsBool ],
  function( triangle, bool )
    local rotation, st_rotation, i, st_triangle, w_1, v_1;
     
    rotation := ExactTriangle(
                  triangle ^ 1,
                  triangle ^ 2,
                  AdditiveInverse( ShiftOfMorphism( triangle ^ 0 ) )
                );
    
    if bool then
      
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
    
    fi;
    
    return rotation;
    
end );

##  
##  A ---> B ---> C ---> Σ A
##
##  Σ^-1 C  ---> A ---> B ---> Σ Σ^-1 C
##
InstallMethod( InverseRotation,
          [ IsCategoryOfExactTrianglesObject ],
  triangle -> InverseRotation( triangle, false )
);

##
InstallMethod( InverseRotation,
          [ IsCategoryOfExactTrianglesObject, IsBool ],
  function( t, bool )
    local rotation, st_rotation, i, st_t, w_1, v_1;
    
    rotation :=
        ExactTriangle(
              PreCompose(
                AdditiveInverse( InverseShiftOfMorphism( t ^ 2 ) ),
                CounitOfShiftAdjunction( t[ 0 ] )
                        ),
              t ^ 0,
              PreCompose(
                t ^ 1,
                UnitOfShiftAdjunction( t[ 2 ] )
                        )
                    );
    
    if bool then
      
      st_rotation := StandardExactTriangle( rotation );
      
      if IsStandardExactTriangle( t ) then
        
        i := WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( rotation[ 2 ], t ^ 0, st_rotation[ 2 ] );
        
        i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, st_rotation );
        
        SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
        
        i := WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( st_rotation[ 2 ], t ^ 0, rotation[ 2 ] );
        
        i := MorphismOfExactTriangles( st_rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), i, rotation );
       
        SetWitnessIsomorphismFromStandardExactTriangle( rotation, i );
        
      else
        
        i := WitnessIsomorphismFromStandardExactTriangle( t );
        
        st_t := Source( i );
        
        w_1 := WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom( st_t ^ 0 );
        
        v_1 := MorphismBetweenStandardConeObjects(
                  PreCompose(
                    AdditiveInverse( InverseShiftOfMorphism( st_t ^ 2 ) ),
                    CounitOfShiftAdjunction( t[ 0 ] )
                  ),
                  InverseShiftOfMorphism( i[ 2 ] ),
                  IdentityMorphism( t[ 0 ] ),
                  PreCompose(
                    AdditiveInverse( InverseShiftOfMorphism( t ^ 2 ) ),
                    CounitOfShiftAdjunction( t[ 0 ] )
                  )
                );
        
        i := MorphismOfExactTriangles( rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), PreCompose( w_1, v_1 ), st_rotation );
        
        SetWitnessIsomorphismIntoStandardExactTriangle( rotation, i );
        
      fi;
      
    fi;
    
    return rotation;
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardExactTriangle,
          [ IsCategoryOfExactTrianglesObject ],
  function( t )
    local cat, st_t, i;
    
    if IsStandardExactTriangle( t ) then
      
      return IdentityMorphism( t );
      
    fi;
    
    # This could happen only if the user manually have set this attribute
    if HasWitnessIsomorphismFromStandardExactTriangle( t ) then
      
      i := WitnessIsomorphismFromStandardExactTriangle( t );
      
      return MorphismOfExactTriangles(
                t,
                IdentityMorphism( t[ 0 ] ),
                IdentityMorphism( t[ 1 ] ),
                Inverse( i[ 2 ] ),
                Source( i )
              );
              
    fi;
     
    cat := UnderlyingCategory( CapCategory( t ) );
    
    if not CanCompute( cat, "WitnessIsomorphismIntoStandardConeObject" ) then
      
      TryNextMethod( );
      
    fi;
    
    st_t := StandardExactTriangle( t ^ 0 );
    
    i := WitnessIsomorphismIntoStandardConeObject( t ^ 0, t ^ 1, t ^ 2 );
    
    if i = fail then
      
      return fail;
      
    else
      
      return MorphismOfExactTriangles(
                t,
                IdentityMorphism( t[ 0 ] ),
                IdentityMorphism( t[ 1 ] ),
                i,
                st_t
              );
      
    fi;
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardExactTriangle,
          [ IsCategoryOfExactTrianglesObject ],
  function( t )
    local cat, st_t, i;
    
    if IsStandardExactTriangle( t ) then
      
      return IdentityMorphism( t );
      
    fi;
    
    i := WitnessIsomorphismIntoStandardExactTriangle( t );
    
    if i = fail then
      
      return fail;
      
    else
      
      return MorphismOfExactTriangles(
                Range( i ),
                IdentityMorphism( t[ 0 ] ),
                IdentityMorphism( t[ 1 ] ),
                Inverse( i[ 2 ] ),
                t
              );
    
    fi;
    
end );
    
##    
InstallMethod( MorphismBetweenConeObjects,
          [ IsCategoryOfExactTrianglesObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCategoryOfExactTrianglesObject ],
  function( t_1, mu_0, mu_1, t_2 )
    local st_t_1, st_t_2, i_1, j_1, i_2, j_2, u, v, w;
    
    st_t_1 := StandardExactTriangle( t_1 );
    
    st_t_2 := StandardExactTriangle( t_2 );
    
    i_1 := WitnessIsomorphismIntoStandardExactTriangle( t_1 );
    
    j_1 := WitnessIsomorphismFromStandardExactTriangle( t_1 );
    
    i_2 := WitnessIsomorphismIntoStandardExactTriangle( t_2 );
    
    j_2 := WitnessIsomorphismFromStandardExactTriangle( t_2 );
    
    u := PreCompose( [ j_1[ 0 ], mu_0, i_2[ 0 ] ] );
    
    v := PreCompose( [ j_1[ 1 ], mu_1, i_2[ 1 ] ] );
    
    w := MorphismBetweenStandardConeObjects(
            st_t_1 ^ 0,
            u,
            v,
            st_t_2 ^ 0
          );
    
    return PreCompose( [ i_1[ 2 ], w, j_2[ 2 ] ] );
    
end );

##
InstallMethod( MorphismOfExactTriangles,
          [ IsCategoryOfExactTrianglesObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCategoryOfExactTrianglesObject ],
  function( t_1, mu_0, mu_1, t_2 )
    local mu_2;
    
    mu_2 := MorphismBetweenConeObjects( t_1, mu_0, mu_1, t_2 );
    
    return MorphismOfExactTriangles( t_1, mu_0, mu_1, mu_2, t_2 );
    
end );

##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject ],
    { t_1, t_2, t_3 } -> ExactTriangleByOctahedralAxiom( t_1, t_2, t_3, false )
);

##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject, IsBool ],
  function( t_1, t_2, t_3, bool )
    local i_1, j_1, i_2, j_2, i_3, j_3, t, alpha, iota, pi, triangle, u, v, w, i;
    
    Assert( 2, IsEqualForObjects( t_1[ 0 ], t_3[ 0 ] )
                and IsEqualForObjects( t_2[ 1 ], t_3[ 1 ] )
                  and IsCongruentForMorphisms( PreCompose( t_1^0, t_2^0 ), t_3^0 ) );
                  
    i_1 := WitnessIsomorphismIntoStandardExactTriangle( t_1 );
    
    j_1 := WitnessIsomorphismFromStandardExactTriangle( t_1 );
    
    i_2 := WitnessIsomorphismIntoStandardExactTriangle( t_2 );
    
    j_2 := WitnessIsomorphismFromStandardExactTriangle( t_2 );
    
    i_3 := WitnessIsomorphismIntoStandardExactTriangle( t_3 );
    
    j_3 := WitnessIsomorphismFromStandardExactTriangle( t_3 );
    
    t := ExactTriangleByOctahedralAxiom( t_1 ^ 0, t_2 ^ 0, t_3 ^ 0, true );
    
    alpha := PreCompose( [ i_1[ 2 ], t ^ 0, j_3[ 2 ] ] );
    
    iota := PreCompose( [ i_3[ 2 ], t ^ 1, j_2[ 2 ] ] );
    
    pi := PreCompose( [ i_2[ 2 ], t ^ 2, ShiftOfMorphism( j_1[ 2 ] ) ] );
    
    triangle := ExactTriangle( alpha, iota, pi );
    
    if bool = true then
      
      u := i_2[ 2 ];
      
      v := WitnessIsomorphismIntoStandardExactTriangle( t )[ 2 ];
      
      w := MorphismBetweenStandardConeObjects( t ^ 0, j_1[ 2 ], j_3[ 2 ], triangle ^ 0 );
      
      i := MorphismOfExactTriangles(
              triangle,
              IdentityMorphism( triangle[ 0 ] ),
              IdentityMorphism( triangle[ 1 ] ),
              PreCompose( [ u, v, w ] ),
              StandardExactTriangle( triangle )
            );
            
      SetWitnessIsomorphismIntoStandardExactTriangle( triangle, i );
      
    fi;
    
    Assert( 2, IsWellDefined( triangle ) and IsWellDefined( t_1 ) and IsWellDefined( t_2 ) and IsWellDefined( t_3 ) and
                IsCongruentForMorphisms( PreCompose( t_1^1, triangle^0 ), PreCompose( t_2^0, t_3^1 ) ) and
                  IsCongruentForMorphisms( t_1^2, PreCompose( triangle^0, t_3^2 ) ) and
                    IsCongruentForMorphisms( PreCompose( t_3^1, triangle^1 ), t_2^1 ) and
                      IsCongruentForMorphisms( PreCompose( triangle^1, t_2^2 ), PreCompose(t_3^2, Shift( t_1^0, 1 ) ) ) and
                        IsCongruentForMorphisms( PreCompose( t_2^2, Shift( t_1^1, 1 ) ), triangle^2 )
                );
                
    return triangle;
    
end );

##
InstallMethod( ExactTriangleByOctahedralAxiom,
          [ IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject, IsCategoryOfExactTrianglesObject ],
    { t_1, t_2, t_3 } -> ExactTriangleByOctahedralAxiom( t_1, t_2, t_3, false )
);

#################
#
# Display
#
#################

##
InstallMethod( ViewExactTriangle,
          [ IsCategoryOfExactTrianglesObject ],
  function( T )
    
    Print( "       T ^ 0          T ^ 1          T ^ 2              \n" );
    Print( "T[ 0 ] ------> T[ 1 ] ------> T[ 2 ] ------> Σ( T[ 0 ] )\n" );
    
    Print( "\n", TextAttr.b6, "T[ 0 ]:", TextAttr.reset, "\n\n" );
    ViewObj( T[ 0 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 0:", TextAttr.reset, "\n\n" );
    ViewObj( T ^ 0 );
    
    Print( "\n", TextAttr.b6, "T[ 1 ]:", TextAttr.reset, "\n\n" );
    ViewObj( T[ 1 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 1:", TextAttr.reset, "\n\n" );
    ViewObj( T ^ 1 );
    
    Print( "\n", TextAttr.b6, "T[ 2 ]:", TextAttr.reset, "\n\n" );
    ViewObj( T[ 2 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 2:", TextAttr.reset, "\n\n" );
    ViewObj( T ^ 2 );
    
    Print( "\n", TextAttr.b6, "Σ( T[ 0 ] ):", TextAttr.reset, "\n\n" );
    ViewObj( T[ 3 ] );

    
end );

##
InstallMethod( ViewMorphismOfExactTriangles,
          [ IsCategoryOfExactTrianglesMorphism ],
  function( mu )
    Print( "A morphism of exact triangles\n\n" );
    Print( "T[0] ------> T[1] ------> T[2] ------> Σ( T[0] )      \n" );
    Print( " |            |            |              |           \n" );
    Print( " | mu[0]      | mu[1]      | mu[2]        | Σ( mu[0] )\n" );
    Print( " V            V            V              V           \n" );
    Print( "Q[0] ------> Q[1] ------> Q[2] ------> Σ( Q[0] )      \n" );
    
    Print( "\n\nmu[ 0 ]:\n\n" );
    ViewObj( mu[ 0 ] );
    
    Print( "\n\nmu[ 1 ]:\n\n" );
    ViewObj( mu[ 1 ] );
    
    Print( "\n\nmu[ 2 ]:\n\n" );
    ViewObj( mu[ 2 ] );
    
    Print( "\n\nmu[ 3 ]:\n\n" );
    ViewObj( mu[ 3 ] );
 
end );

##
InstallMethod( Display,
          [ IsCategoryOfExactTrianglesObject ],
  function( T )

    Print( "       T ^ 0          T ^ 1          T ^ 2              \n" );
    Print( "T[ 0 ] ------> T[ 1 ] ------> T[ 2 ] ------> Σ( T[ 0 ] )\n" );
    
    Print( "\n", TextAttr.b6, "T[ 0 ]:", TextAttr.reset, "\n\n" );
    Display( T[ 0 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 0:", TextAttr.reset, "\n\n" );
    Display( T ^ 0 );
    
    Print( "\n", TextAttr.b6, "T[ 1 ]:", TextAttr.reset, "\n\n" );
    Display( T[ 1 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 1:", TextAttr.reset, "\n\n" );
    Display( T ^ 1 );
    
    Print( "\n", TextAttr.b6, "T[ 2 ]:", TextAttr.reset, "\n\n" );
    Display( T[ 2 ] );
    
    Print( "\n", TextAttr.b6, "T ^ 2:", TextAttr.reset, "\n\n" );
    Display( T ^ 2 );
    
    Print( "\n", TextAttr.b6, "Σ( T[ 0 ] ):", TextAttr.reset, "\n\n" );
    Display( T[ 3 ] );
    
end );

##
InstallMethod( Display,
          [ IsCategoryOfExactTrianglesMorphism ],
  function( mu )
    Print( "A morphism of exact triangles\n\n" );
    Print( "T[0] ------> T[1] ------> T[2] ------> Σ( T[0] )      \n" );
    Print( " |            |            |              |           \n" );
    Print( " | mu[0]      | mu[1]      | mu[2]        | Σ( mu[0] )\n" );
    Print( " V            V            V              V           \n" );
    Print( "Q[0] ------> Q[1] ------> Q[2] ------> Σ( Q[0] )      \n" );
    
    Print( "\n", TextAttr.b6, "mu[ 0 ]:", TextAttr.reset, "\n\n" );
    Display( mu[ 0 ] );
    
    Print( "\n", TextAttr.b6, "mu[ 1 ]:", TextAttr.reset, "\n\n" );
    Display( mu[ 1 ] );
    
    Print( "\n", TextAttr.b6, "mu[ 2 ]:", TextAttr.reset, "\n\n" );
    Display( mu[ 2 ] );
    
    Print( "\n", TextAttr.b6, "mu[ 3 ]:", TextAttr.reset, "\n\n" );
    Display( mu[ 3 ] );
 
end );

