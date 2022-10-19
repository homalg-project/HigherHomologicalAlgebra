# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
#InstallMethod( UnitOfTensorHomAdjunction,
#          [ IsStrongExceptionalCollection, IsCapFunctor, IsCapFunctor ],
#          
#  function( collection, tensorT, HomT )
#    local full, ambient_cat, reps, name, nat;
#    
#    full := FullSubcategory( collection );
#    
#    ambient_cat := AmbientCategory( full );
#    
#    if not ( HasIsAbelianCategory( ambient_cat ) and IsAbelianCategory( ambient_cat ) ) then
#      
#      TryNextMethod( );
#      
#    fi;
#    
#    reps := SourceOfFunctor( tensorT );
#     
#    name := "Id => Hom(T,-⊗ T)";
#    
#    nat := NaturalTransformation( name, IdentityFunctor( reps ), PreCompose( tensorT, HomT ) );
#    
#    AddNaturalTransformationFunction( nat,
#      function( s, R, r )
#        local pi_R, PR, PR_summands, RT, defining_morphism, coker_epi,
#          objs, injections, maps, coeffs, min_gen, positions, HomT_RT,
#            vec_spaces, zero_vectors, e, map, m, i;
#        
#        if IsObjectInFunctorCategory( R ) then
#          
#          R := ConvertToCellInCategoryOfQuiverRepresentations( R );
#          
#        fi;
#        
#        pi_R := EpimorphismFromSomeProjectiveObject( R );
#        
#        PR := Source( pi_R );
#        
#        PR_summands := UnderlyingProjectiveSummands( PR );
#        
#        RT := TensorFunctorFromCategoryOfQuiverRepresentations( collection )( R );
#         
#        defining_morphism := RT!.embedded_defining_morphism_of_cokernel_object;
#        
#        coker_epi := CokernelProjection( defining_morphism );
#        
#        objs := List( ObjectList( Range( RT!.defining_morphism_of_cokernel_object ) ), UnderlyingCell );
#        
#        coeffs := List( [ 1 .. Length( objs ) ], i -> CoefficientsOfMorphism( PreCompose( InjectionOfCofactorOfDirectSum( objs, i ), coker_epi ) ) );
#         
#        min_gen := MinimalGeneratingSet( R );
#        
#        min_gen := List( min_gen, g -> ElementVectors( g ) );
#        
#        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
#        
#        HomT_RT := HomFunctorToCategoryOfQuiverRepresentations( collection )( RT );
#        
#        vec_spaces := VectorSpacesOfRepresentation( HomT_RT );
#        
#        zero_vectors := List( vec_spaces, Zero );
#        
#        maps := [ ];
#        
#        for i in [ 1 .. Length( min_gen ) ] do
#          
#          if IsZero( coeffs[ i ] ) then
#            
#            Add( maps, ZeroMorphism( PR_summands[ i ], HomT_RT ) );
#            
#          else
#            
#            e := ShallowCopy( zero_vectors );
#            
#            e[ positions[ i ] ] := Vector( vec_spaces[ positions[ i ] ], coeffs[ i ] );
#            
#            Add( maps, HomFromProjective( QuiverRepresentationElementNC( HomT_RT, e ), HomT_RT ) );
#            
#          fi;
#          
#        od;
#        
#        if IsEmpty( maps ) then
#            
#            map := ZeroMorphism( PR, HomT_RT );
#            
#        else
#            
#            map := MorphismBetweenDirectSums( TransposedMat( [ maps ] ) );
#            
#        fi;
#        
#        m := ColiftAlongEpimorphism( pi_R, map );
#        
#        if IsObjectInFunctorCategory( s ) then
#          
#          return ConvertToCellInFunctorCategory( s, m, r );
#          
#        else
#          
#          return m;
#          
#        fi;
#          
#    end );
#    
#    return nat;
#    
#end );

##
InstallMethodWithCache( CounitOfTensorHomAdjunction,
          [ IsStrongExceptionalCollection, IsCapFunctor, IsCapFunctor ],
          
  function( collection, tensorT, HomT )
    local full, ambient_cat, category, k, name, nat;
    
    full := FullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
    
    if not ( HasIsAbelianCategory( ambient_cat ) and IsAbelianCategory( ambient_cat ) ) then
      
      TryNextMethod( );
      
    fi;
    
    category := SourceOfFunctor( HomT );
    
    k := CommutativeRingOfLinearCategory( category );
    
    name := "Hom(T,-) ⊗ T => Id";
    
    nat := NaturalTransformation(   
              name,
              PreCompose( HomT, tensorT ),
              IdentityFunctor( category )
            );
    
    AddNaturalTransformationFunction( nat,
      function( s, a, r )
        local HomT_a, min_gen, positions, vectors, positions_of_non_zeros, mor;
        
        HomT_a := HomFunctorToCategoryOfQuiverRepresentations( collection )( a );
        
        min_gen := MinimalGeneratingSet( HomT_a );
        
        if IsEmpty( min_gen ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        min_gen := List( min_gen, g -> ElementVectors( g ) );
        
        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
        
        vectors := ListN( min_gen, positions, { g, p } -> AsList( g[ p ] ) );
        
        positions_of_non_zeros := List( vectors, v -> PositionsProperty( v, e -> not IsZero( e ) ) );
        
        mor := List( [ 1 .. Length( min_gen ) ],
          i -> vectors[ i ]{ positions_of_non_zeros[ i ] } * 
                  BasisOfExternalHom(
                    UnderlyingCell( collection[ positions[ i ] ] ), a )
                      { positions_of_non_zeros[ i ] }
              );
              
        mor := MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
        
        return CokernelColift( s!.embedded_defining_morphism_of_cokernel_object, mor );
        
      end );
      
    return nat;
    
end );

##
InstallMethod( UnitOfConvolutionReplacementAdjunction,
          [ IsStrongExceptionalCollection ],
          
  function( collection )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( collection );
    
    F := ConvolutionFunctor( collection );
    
    G := ReplacementFunctor( collection );
    
    name := "Id => Rep(Conv(-))";
    
    nat := NaturalTransformation( name, IdentityFunctor( ambient_cat ), PostCompose( G, F ) );
    
    AddNaturalTransformationFunction( nat,
      ReturnNothing # It must be similar to counit, it must use the octahedral axiom!
    );
    
    return;
    
end );

##
InstallMethod( CounitOfConvolutionReplacementAdjunction,
          [ IsStrongExceptionalCollection ],
          
  function( collection )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( collection );
    
    F := ConvolutionFunctor( collection );
    
    G := ReplacementFunctor( collection );
    
    name := "Conv( Rep( - ) ) => Id";
    
    nat := NaturalTransformation( name, PreCompose( G, F ), IdentityFunctor( ambient_cat ) );
    
    AddNaturalTransformationFunction( nat,
    
      { F_o_G_A, A, id_A } -> COMPUTE_ISOMORPHISM( A, collection )
    );
    
    return nat;
    
end );

## This method is for all objects, it uses the standard isomorphisms bellow
##
InstallMethod( COMPUTE_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
        
  function( a, collection )
    local N, iota;
    
    N := MaximalExceptionalShift( a, collection );
    
    iota := Shift( COMPUTE_STANDARD_ISOMORPHISM( Shift( a, N ), collection ), -N );
    
    Assert( 2, IsEqualForObjects( Source( iota ), PreCompose( ReplacementFunctor( collection ), ConvolutionFunctor( collection ) )( a ) ) );
    
    return iota;
    
end );

## This method is for objects whose maximal exceptional shift is 0.
##
InstallMethodWithCache( COMPUTE_STANDARD_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
        
  function( A, collection )
    local ambient_cat, complexes_cat, I, data, R, z_func, func;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    if not IsIdenticalObj( CapCategory( A ), ambient_cat ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    data := ExceptionalReplacementData( A, collection );
    
    R := UnderlyingCell( I( ExceptionalReplacement( A, collection, true ) ) );
    
    complexes_cat := CapCategory( R );
    
    z_func := VoidZFunction( );
    
    func :=
      function( n )
        local r_1, st_r_1, r_0, st_r_0, uvw, j_1, st_j_1, r_n, st_r_n, shift_st_r_n, t, j_n, st_j_n, shift_st_j_n;
        
        if n < 1 then
          
          return true;
          
        elif n = 1 then
          
          r_1 := data[ 1 ][ 1 ];
          st_r_1 := StandardExactTriangle( r_1 );
          
          r_0 := data[ 0 ][ 1 ];
          
          uvw := ExactTriangle(
                    Shift( MorphismFromStandardConeObject( r_0 ), -1 ),
                    r_0,
                    AdditiveInverseForMorphisms( MorphismToStandardConeObject( r_0 ) )
                  );
                  
          j_1 := BackwardPostnikovSystemAt( R, 0 )^1;
          st_j_1 := StandardExactTriangle( j_1 );
          
          Assert( 2, IsCongruentForMorphisms( PreCompose( st_r_1^0, uvw^0 ), st_j_1^0 ) );
          
          # Create octahedral input to compute the next triangle uvw:
          return [ st_r_1, uvw, st_j_1 ];
          
        elif n <= ActiveUpperBound( R ) + 1 then
          
          r_n := data[ n ][ 1 ];
          st_r_n := StandardExactTriangle( r_n );
          shift_st_r_n := Shift( st_r_n, n - 1 );
          
          t := z_func[ n - 1 ];
          
          uvw := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          j_n := BackwardPostnikovSystemAt( R, n - 1 )^n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, n - 1 );
          
          Assert( 2, IsCongruentForMorphisms(
                          PreCompose( [ shift_st_r_n^0, uvw^0, t[ 3 ]^2 ] ),
                          PreCompose( shift_st_j_n^0, t[ 3 ]^2 )
                        ) );
                        
          # Create octahedral input to compute the next triangle uvw:
          return [ shift_st_r_n, uvw, shift_st_j_n ];
          
        else
          
          return true;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    return z_func[ ActiveUpperBound( R ) + 1 ][ 2 ]^1;
    
end );

## This method is for objects whose maximal exceptional shift is 0.
##
InstallMethodWithCache( COMPUTE_STANDARD_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
        
  function( A, collection )
    local ambient_cat, complexes_cat, I, data, R, z_func, func;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    if not IsIdenticalObj( CapCategory( A ), ambient_cat ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    data := ExceptionalReplacementData( A, collection );
    
    R := UnderlyingCell( I( ExceptionalReplacement( A, collection, true ) ) );
    
    complexes_cat := CapCategory( R );
    
    z_func := VoidZFunction( );
    
    func :=
      function( n )
        local r_m1, st_r_m1, r_0, uvw, j_m1, st_j_m1, r_n, st_r_n, shift_st_r_n, t, j_n, st_j_n, shift_st_j_n;
        
        if n > -1 then
          
          return true;
          
        elif n = -1 then
          
          r_m1 := data[ -1 ][ 1 ];
          st_r_m1 := StandardExactTriangle( r_m1 );
          
          r_0 := data[ 0 ][ 1 ];
          uvw := ExactTriangle(
                    Shift( MorphismFromStandardConeObject( r_0 ), -1 ),
                    r_0,
                    AdditiveInverseForMorphisms( MorphismToStandardConeObject( r_0 ) )
                  );
                  
          j_m1 := BackwardPostnikovSystemAt( R, 0 )^-1;
          st_j_m1 := StandardExactTriangle( j_m1 );
          
          Assert( 2, IsCongruentForMorphisms( PreCompose( st_r_m1^0, uvw^0 ), st_j_m1^0 ) );
          
          # Create octahedral input to compute the next triangle uvw:
          return [ st_r_m1, uvw, st_j_m1 ];
          
        elif n >= ActiveLowerBound( R ) - 1 then
          
          r_n := data[ n ][ 1 ];
          st_r_n := StandardExactTriangle( r_n );
          shift_st_r_n := Shift( st_r_n, -n - 1 );
          
          t := z_func[ n + 1 ];
          
          uvw := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          j_n := BackwardPostnikovSystemAt( R, n + 1 )^n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, -n - 1 );
          
          Assert( 2, IsCongruentForMorphisms(
                          PreCompose( [ shift_st_r_n^0, uvw^0, t[ 3 ]^2 ] ),
                          PreCompose( shift_st_j_n^0, t[ 3 ]^2 )
                        ) );
                        
          # Create input for the octahedral axiom to compute the next triangle uvw:
          return [ shift_st_r_n, uvw, shift_st_j_n ];
          
        else
          
          return true;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    return z_func[ ActiveLowerBound( R ) - 1 ][ 2 ]^1;
    
end );

##############################################################################################
#
# Simplify objects in homotopy categories of quiver rows and additive closures of algebroids
# 
##############################################################################################


## Quiver rows are currently very suitable for such computations than additive closures
##
InstallOtherMethod( SimplifyObject_IsoToInputObject,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsObject ],
          
  function( homotopy_category, a, index )
    local over_cochains, additive_closure, algebroid, A_rows, I, J;
    
    if IsCochainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      over_cochains := true;
    else
      over_cochains := false;
    fi;
    
    additive_closure := DefiningCategory( homotopy_category );
    
    if not ( IsAdditiveClosureCategory( additive_closure ) ) then
        
        TryNextMethod( );
        
    fi;
    
    algebroid := UnderlyingCategory( additive_closure );
    
    if not IsAlgebroid( algebroid ) then
      
        TryNextMethod( );
        
    fi;
    
    A_rows := QuiverRows( UnderlyingQuiverAlgebra( algebroid ) );
    
    I := IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, A_rows );
    I := ExtendFunctorToHomotopyCategories( I, over_cochains );
    
    J := IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( A_rows, additive_closure );
    J := ExtendFunctorToHomotopyCategories( J, over_cochains );
    
    return J( SimplifyObject_IsoToInputObject( I( a ), index ) );
    
end );


##
InstallOtherMethod( SimplifyObject,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsObject ],
          
  function( homotopy_category, a, index )
    local over_cochains, additive_closure, algebroid, A_rows, I, J;
    
    if IsCochainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      over_cochains := true;
    else
      over_cochains := false;
    fi;
    
    additive_closure := DefiningCategory( homotopy_category );
    
    if not ( IsAdditiveClosureCategory( additive_closure ) ) then
        
        TryNextMethod( );
        
    fi;
    
    algebroid := UnderlyingCategory( additive_closure );
    
    if not IsAlgebroid( algebroid ) then
      
        TryNextMethod( );
        
    fi;
    
    A_rows := QuiverRows( UnderlyingQuiverAlgebra( algebroid ) );
    
    I := IsomorphismFromAdditiveClosureOfAlgebroidIntoQuiverRows( additive_closure, A_rows );
    I := ExtendFunctorToHomotopyCategories( I, over_cochains );
    
    J := IsomorphismFromQuiverRowsIntoAdditiveClosureOfAlgebroid( A_rows, additive_closure );
    J := ExtendFunctorToHomotopyCategories( J, over_cochains );
    
    return J( SimplifyObject( I( a ), index ) );
    
end );

##
InstallOtherMethod( SimplifyObject_IsoToInputObject,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsObject ],
          
  function( homotopy_category, a, index )
    local cat, collection;
     
    cat := DefiningCategory( homotopy_category );
    
    if not ( IsQuiverRowsCategory( cat ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if IsBound( homotopy_category!.full_strong_exceptional_for_simplifying_objects ) then
      
      collection := homotopy_category!.full_strong_exceptional_for_simplifying_objects;
      
    else
      
      collection := 
        CreateStrongExceptionalCollection(
          List( Vertices( UnderlyingQuiver( cat ) ), v -> v / cat / homotopy_category )
      );
      
      homotopy_category!.full_strong_exceptional_for_simplifying_objects := collection;
      
    fi;
    
    return COMPUTE_ISOMORPHISM( a, collection );
    
end );

##
InstallOtherMethod( SimplifyObject,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsObject ],
          
  function( homotopy_category, a, index )
    local cat, collection;
    
    cat := DefiningCategory( homotopy_category );
    
    if not ( IsQuiverRowsCategory( cat ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if IsBound( homotopy_category!.full_strong_exceptional_for_simplifying_objects ) then
      
      collection := homotopy_category!.full_strong_exceptional_for_simplifying_objects;
      
    else
      
      collection := 
        CreateStrongExceptionalCollection(
          List( Vertices( UnderlyingQuiver( cat ) ), v -> v / cat / homotopy_category )
      );
      
      homotopy_category!.full_strong_exceptional_for_simplifying_objects := collection;
      
    fi;
    
    return ConvolutionFunctor( collection )( ReplacementFunctor( collection )( a ) );
    
end );

##
InstallOtherMethod( SimplifyObject_IsoToInputObject,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsObject ],
          
  function( homotopy_category, a, index )
    local cat, collection;
     
    cat := DefiningCategory( homotopy_category );
    
    if not ( IsQuiverRowsCategory( cat ) ) then
        
        TryNextMethod( );
        
    fi;
    
    if IsBound( homotopy_category!.full_strong_exceptional_for_simplifying_objects ) then
      
      collection := homotopy_category!.full_strong_exceptional_for_simplifying_objects;
      
    else
      
      collection := 
        CreateStrongExceptionalCollection(
          List( Vertices( UnderlyingQuiver( cat ) ), v -> v / cat / homotopy_category )
      );
      
      homotopy_category!.full_strong_exceptional_for_simplifying_objects := collection;
      
    fi;
    
    return COMPUTE_ISOMORPHISM( a, collection );
    
end );
