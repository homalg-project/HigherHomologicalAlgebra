# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#





##
InstallMethod( DerivedCategoryByCochains,
          [ IsCapCategory ],
          
  function ( cat )
    local name, homotopy_cat, derived_cat;
    
    name := Concatenation( "Derived category by cochains( ", Name( cat ), " )" );
    
    homotopy_cat := HomotopyCategoryByCochains( cat );
    
    derived_cat := CreateCapCategory( name, IsDerivedCategoryByCochains, IsDerivedCategoryByCochainsObject, IsDerivedCategoryByCochainsMorphism, IsCapCategoryTwoCell );
    
    derived_cat!.category_as_first_argument := true;
    
    SetDefiningCategory( derived_cat, cat );
    
    SetUnderlyingCategory( derived_cat, HomotopyCategoryByCochains( cat ) );
    
    SetIsAbCategory( derived_cat, true );
    
    AddObjectConstructor( derived_cat, { derived_cat, object_in_homotopy_category } -> CreateCapCategoryObjectWithAttributes( derived_cat, UnderlyingCell, object_in_homotopy_category ) );
    
    AddMorphismConstructor( derived_cat, { derived_cat, S, pair, R } ->  CreateCapCategoryMorphismWithAttributes( derived_cat, S, R, DefiningPairOfMorphisms, pair ) );

    AddIsEqualForObjects( derived_cat, { derived_cat, C1, C2 } -> IsEqualForObjects( UnderlyingCell( C1 ), UnderlyingCell( C2 ) ) );
    
    ##
    AddIsEqualForMorphisms( derived_cat,
      function( derived_cat, alpha, beta )
        local pair_alpha, pair_beta;
        
        pair_alpha := DefiningPairOfMorphisms( alpha );
        pair_beta := DefiningPairOfMorphisms( beta );
        
        return IsEqualForMorphisms( pair_alpha[1], pair_beta[1] ) and IsEqualForMorphisms( pair_alpha[2], pair_beta[2] );
        
    end );
    
    ##
    AddIsZeroForObjects( derived_cat, { derived_cat, C } -> IsExact( UnderlyingCell( UnderlyingCell( C ) ) ) );
    
    ##
    AddIdentityMorphism( derived_cat, { derived_cat, C } -> MorphismConstructor( C, [ IdentityMorphism( UnderlyingCell( C ) ), IdentityMorphism( UnderlyingCell( C ) ) ], C ) );
    
    ##
    AddZeroObject( derived_cat, derived_cat  -> ObjectConstructor( derived_cat, ZeroObject( UnderlyingCategory( derived_cat ) ) ) );
    
    ##
    AddZeroMorphism( derived_cat, { derived_cat, C1, C2 } -> MorphismConstructor( C1, [ IdentityMorphism( C1 ), ZeroMorphism( C1, C2 ) ], C2 ) );
    
    ##
    AddIsIsomorphism( derived_cat, { derived_cat, alpha } -> IsQuasiIsomorphism( UnderlyingCell( DefiningPairOfMorphisms( alpha )[2] ) ) );
    
    ##
    AddInverseForMorphisms( derived_cat, { derived_cat, alpha } -> MorphismConstructor( Range( alpha ), Reversed( DefiningPairOfMorphisms( alpha ) ), Source( alpha ) ) );
    
    ##
    AddIsWellDefinedForObjects( derived_cat,  { derived_cat, C } -> IsWellDefined( UnderlyingCell( C ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( derived_cat,
      function( derived_cat, alpha )
        local pair;
        
        pair := DefiningPairOfMorphisms( alpha );
        
        return IsEqualForObjects( Source( pair[1] ), Source( pair[2] ) ) and ForAll( pair, IsWellDefined ) and IsQuasiIsomorphism( UnderlyingCell( pair[1] ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( derived_cat, { derived_cat, alpha } -> MorphismConstructor( Source( alpha ), [ DefiningPairOfMorphisms( alpha )[1], -DefiningPairOfMorphisms( alpha )[2] ], Range( alpha ) ) );
    
    #       Z
    #      / \
    #    X     Y
    #   / \   / \
    # A     B     C
    #
    AddPreCompose( derived_cat,
      function( derived_cat, alpha_1, alpha_2 )
        local pair_1, pair_2, A, B, C, X, Y, objs_func, diff_func, Z, morphisms_q, q, morphisms_r, r;
        
        pair_1 := DefiningPairOfMorphisms( alpha_1 );
        pair_2 := DefiningPairOfMorphisms( alpha_2 );
        
        A := Range( pair_1[1] );
        B := Range( pair_1[2] );
        C := Range( pair_2[2] );

        X := Source( pair_1[1] );
        Y := Source( pair_2[1] );
        
        objs_func := AsZFunction( i -> DirectSum( cat, [ X[i], Y[i], B[i-1] ] ) );
        diff_func := AsZFunction( i -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                                                  objs_func[i],
                                                  [ X[i], Y[i], B[i-1] ],
                                                  [ [ X^i, ZeroMorphism( cat, X[i], Y[i+1] ), -(pair_1[2][i]) ],
                                                    [ ZeroMorphism( cat, Y[i], X[i+1] ), Y^i, -(pair_2[1][i]) ],
                                                    [ ZeroMorphism( cat, B[i-1], X[i+1]), ZeroMorphism( cat, B[i-1], Y[i+1] ), -B^(i-1) ] ],
                                                  [ X[i+1], Y[i+1], B[i] ],
                                                  objs_func[i+1] ) );
        
        Z := CreateComplex( homotopy_cat, [ objs_func, diff_func, Minimum( [ LowerBound( X ), LowerBound( Y ), LowerBound( B ) + 1 ] ), Maximum( [ UpperBound( X ), UpperBound( Y ), UpperBound( B ) + 1 ] ) ] );
        
        morphisms_q := AsZFunction( i -> UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
                                                  [ X[i], Y[i], B[i-1] ],
                                                  A[i],
                                                  [ -(pair_1[1][i]), ZeroMorphism( cat, Y[i], A[i] ), ZeroMorphism( cat, B[i-1], A[i] ) ],
                                                  objs_func[i] ) );
        
        q := CreateComplexMorphism( homotopy_cat, Z, morphisms_q, A );
        
        morphisms_r := AsZFunction( i -> UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
                                                  [ X[i], Y[i], B[i-1] ],
                                                  C[i],
                                                  [ ZeroMorphism( cat, X[i], C[i] ), pair_2[2][i], ZeroMorphism( cat, B[i-1], C[i] ) ],
                                                  objs_func[i] ) );
        
        r := CreateComplexMorphism( homotopy_cat, Z, morphisms_r, C );
        
        return MorphismConstructor( Source( alpha_1 ), [ q, r ], Range( alpha_2 ) );
        
    end );
    
    
    if HasIsLinearCategoryOverCommutativeRing( cat ) and IsLinearCategoryOverCommutativeRing( cat ) then
        
        SetIsLinearCategoryOverCommutativeRing( derived_cat, true );
        
        SetCommutativeRingOfLinearCategory( derived_cat, CommutativeRingOfLinearCategory( cat ) );
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( derived_cat,
          function( derived_cat, r, alpha )
            local pair;
            
            pair := DefiningPairOfMorphisms( alpha );
            
            return MorphismConstructor( Source( alpha ), [ pair[1], r * pair[2] ], Range( alpha ) );
            
          end );
          
    fi;

    derived_cat!.is_computable := false;
    
    if HasIsAbelianCategoryWithEnoughProjectives( cat ) and IsAbelianCategoryWithEnoughProjectives( cat ) then
      
      ADD_EXTRA_FUNCTIONS_TO_DERIVED_CATEGORY_VIA_LOCALIZATION_BY_PROJECTIVE_OBJECTS( derived_cat );
      
    elif HasIsAbelianCategoryWithEnoughInjectives( cat ) and IsAbelianCategoryWithEnoughInjectives( cat ) then
      
      #ADD_EXTRA_FUNCTIONS_TO_DERIVED_CATEGORY_VIA_LOCALIZATION_BY_INJECTIVE_OBJECTS( derived_cat );
      
    fi;
    
    Finalize( derived_cat );
    
    return derived_cat;
    
end );

##
InstallGlobalFunction( ADD_EXTRA_FUNCTIONS_TO_DERIVED_CATEGORY_VIA_LOCALIZATION_BY_PROJECTIVE_OBJECTS,
  function ( derived_cat )
    local homotopy_cat, LP, cat, range_cat;
    
    derived_cat!.is_computable := true;
    
    homotopy_cat := UnderlyingCategory( derived_cat );
    
    LP := LocalizationFunctorByProjectiveObjects( UnderlyingCategory( derived_cat ) );
    
    cat := DefiningCategory( derived_cat );
    
    AddIsCongruentForMorphisms( derived_cat,
      
      function( derived_cat, alpha, beta )
        local U;
        
        U := UniversalFunctorFromDerivedCategory( LP );
        
        return IsCongruentForMorphisms( RangeOfFunctor( U ), ApplyFunctor( U, alpha ), ApplyFunctor( U, beta ) );
        
    end );
    
    AddIsZeroForMorphisms( derived_cat,
      function( derived_cat, alpha )
        local U;
        
        U := UniversalFunctorFromDerivedCategory( LP );
        
        return IsZeroForMorphisms( RangeOfFunctor( U ), ApplyFunctor( U, alpha ) );
        
    end );
    
    AddAdditionForMorphisms( derived_cat,
      function( derived_cat, alpha, beta )
        local qS, qR, U, m;
        
        qS := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( Source( alpha ) ), true );
        
        qR := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( Range( alpha ) ), true );
        
        U := UniversalFunctorFromDerivedCategory( LP );
        
        m := AdditionForMorphisms( RangeOfFunctor( U ), ApplyFunctor( U, alpha ), ApplyFunctor( U, beta ) );
        
        m := ApplyFunctor( ExtendFunctorToHomotopyCategoriesByCochains( InclusionFunctor( DefiningCategory( CapCategory( m ) ) ) ), m );
        
        return MorphismConstructor( derived_cat, Source( alpha ), [ qS, PreCompose( homotopy_cat, m, qR ) ], Range( alpha ) );
        
    end );
    
    if HasRangeCategoryOfHomomorphismStructure( homotopy_cat ) then
      
      range_cat := RangeCategoryOfHomomorphismStructure( homotopy_cat );
      
      if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
        
        SetIsEquippedWithHomomorphismStructure( derived_cat, true );
        
        SetRangeCategoryOfHomomorphismStructure( derived_cat, range_cat );
        
        AddDistinguishedObjectOfHomomorphismStructure( derived_cat,
          derived_cat -> DistinguishedObjectOfHomomorphismStructure( homotopy_cat )
        );
        
        AddHomomorphismStructureOnObjects( derived_cat,
          function( derived_cat, B, C )
            local PB, PC;
            
            PB := ProjectiveResolution( UnderlyingCell( B ), true );
            PC := ProjectiveResolution( UnderlyingCell( C ), true );
            
            return HomomorphismStructureOnObjects( homotopy_cat, PB, PC );
            
        end );
        
        AddHomomorphismStructureOnMorphismsWithGivenObjects( derived_cat,
          function( derived_cat, S, phi, psi, R )
            local pair_1, pair_2;
            
            pair_1 := List( DefiningPairOfMorphisms( phi ), m -> MorphismBetweenProjectiveResolutions( m, true ) );
            pair_2 := List( DefiningPairOfMorphisms( psi ), m -> MorphismBetweenProjectiveResolutions( m, true ) );
            
            phi := PreCompose( homotopy_cat, InverseForMorphisms( homotopy_cat, pair_1[1] ), pair_1[2] );
            psi := PreCompose( homotopy_cat, InverseForMorphisms( homotopy_cat, pair_2[1] ), pair_2[2] );
            
            return HomomorphismStructureOnMorphismsWithGivenObjects( homotopy_cat, S, phi, psi, R );
            
        end );
        
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( derived_cat,
          function( derived_cat, distinguished_object, phi, hom_BC )
            local pair;
            
            pair := List( DefiningPairOfMorphisms( phi ), m -> MorphismBetweenProjectiveResolutions( m, true ) );
            
            phi := PreCompose( homotopy_cat, InverseForMorphisms( homotopy_cat, pair[1] ), pair[2] );
            
            return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( homotopy_cat, distinguished_object, phi, hom_BC );
            
        end );
        
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( derived_cat,
          function( derived_cat, B, C, eta )
            local qB, qC, phi;
            
            qB := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( B ), true );
            qC := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( C ), true );
            
            phi := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( homotopy_cat, Source( qB ), Source( qC ), eta );
            
            return MorphismConstructor( derived_cat, B, [ qB, PreCompose( homotopy_cat, phi, qC  ) ], C );
            
        end );
       
     fi;
      
    fi;
    
    if CanCompute( homotopy_cat, "BasisOfExternalHom" ) and CanCompute( homotopy_cat, "CoefficientsOfMorphism" )
          and HasRangeCategoryOfHomomorphismStructure( homotopy_cat ) then
        
        SetIsEquippedWithHomomorphismStructure( derived_cat, true );
        
        SetRangeCategoryOfHomomorphismStructure( derived_cat, RangeCategoryOfHomomorphismStructure( homotopy_cat ) );
        
        SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( derived_cat, true );
        
        AddBasisOfExternalHom( derived_cat,
          function( derived_cat, B, C )
            local qB, qC, basis;
            
            qB := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( B ), true );
            qC := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( C ), true );
            
            basis := BasisOfExternalHom( homotopy_cat, Source( qB ), Source( qC ) );
            
            return List( basis, m -> MorphismConstructor( B, [ qB, PreCompose( homotopy_cat, m, qC ) ], C ) );
            
        end );
        
        AddCoefficientsOfMorphism( derived_cat,
          function( derived_cat, phi )
            local pair;
            
            pair := List( DefiningPairOfMorphisms( phi ), m -> MorphismBetweenProjectiveResolutions( m, true ) );
            phi := PreCompose( homotopy_cat, InverseForMorphisms( homotopy_cat, pair[1] ), pair[2] );
            
            return CoefficientsOfMorphism( homotopy_cat, phi );
            
        end );
        
    fi;
    
end );


