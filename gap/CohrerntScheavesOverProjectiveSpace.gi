if IsPackageMarkedForLoading( "BBGG", ">= 2019.12.06" ) then
  
  ##
  InstallMethod( FullSubcategoryGeneratedByTwistedOmegaModules,
            [ IsExteriorRing ],
    function( A )
      local k, n, cat, omegas, full, FinalizeCategory;
      
      k := UnderlyingNonGradedRing( CoefficientsRing( A ) );
      
      if IsRationalsForHomalg( k ) then
        
        k := HomalgFieldOfRationals( );
        
      else
        
        Error( "This should not happen!" );
        
      fi;
      
      n := Size( Indeterminates( A ) );
      
      cat := GradedLeftPresentations( A );
      
      omegas := List( [ 0 .. n - 1 ], i -> TwistedOmegaModule( A, i ) );
      
      full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
      
      SetIsLinearCategoryOverCommutativeRing( full, true );
      
      SetCommutativeRingOfLinearCategory( full, k );
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
        function( e, alpha )
          local mat;
          
          alpha := UnderlyingCell( alpha );
          
          mat := UnderlyingMatrix( alpha );
          
          mat := ( e / A ) * mat;
          
          return GradedPresentationMorphism( Source( alpha ), mat, Range( alpha ) ) / full;
          
      end );
      
      ##
      AddBasisOfExternalHom( full,
        function( a, b )
          local cell_a, cell_b, twist_a, twist_b, B; 
          
          cell_a := UnderlyingCell( a );
          
          cell_b := UnderlyingCell( b );
          
          twist_a := HomalgElementToInteger( - GeneratorDegrees( cell_a )[ 1 ] ) + n;
          
          twist_b := HomalgElementToInteger( - GeneratorDegrees( cell_b )[ 1 ] ) + n;
          
          B := BasisBetweenTwistedOmegaModules( A, twist_a, twist_b );
          
          return List( B, m -> m / full );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( alpha, B )
          
          if IsEmpty( B ) then
            
            return [ ];
            
          fi;
          
          alpha := UnderlyingMatrix( UnderlyingCell( alpha ) );
          
          if IsZero( alpha ) then
            
            return ListWithIdenticalEntries( Size( B ), Zero( k ) );
            
          fi;
          
          B := List( B, UnderlyingCell );
          
          B := List( B, UnderlyingMatrix );
          
          B := UnionOfRows( B );
          
          return EntriesOfHomalgMatrixAttr( RightDivide( alpha, B ) * k );
  
      end );
      
      #SetCachingOfCategoryCrisp( full );
      #DeactivateCachingOfCategory( full );
      CapCategorySwitchLogicOff( full );
      DisableSanityChecks( full );
      
      Finalize( full );
      
      return full;
      
  end );  
  
  ##
  BindGlobal( "CAN_TWISTED_OMEGA_OBJECT",
    function( a )
      local A, full, add_full, n, degrees, pos;
      
      A := UnderlyingHomalgRing( a );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      add_full := AdditiveClosure( full );
      
      n := Length( Indeterminates( A ) );
      
      degrees := GeneratorDegrees( a );
      
      degrees := List( degrees, HomalgElementToInteger );
      
      pos := PositionsProperty( degrees, d -> d in [ 1 .. n ] );
      
      degrees := List( degrees{ pos }, d -> - d + n );
      
      return AdditiveClosureObject( List( degrees, d -> TwistedOmegaModule( A, d ) / full ), add_full );
      
  end );
  
  ##
  BindGlobal( "CAN_TWISTED_OMEGA_MORPHISM",
    function( alpha )
      local A, full, n, a, can_a, b, can_b, degrees_a, pos_a, degrees_b, pos_b, matrix;
      
      A := UnderlyingHomalgRing( alpha );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      n := Length( Indeterminates( A ) );
      
      a := Source( alpha );
      
      can_a := CAN_TWISTED_OMEGA_OBJECT( a );
      
      b := Range( alpha );
      
      can_b := CAN_TWISTED_OMEGA_OBJECT( b );
      
      degrees_a := GeneratorDegrees( a );
      
      degrees_a := List( degrees_a, HomalgElementToInteger );
      
      pos_a := PositionsProperty( degrees_a, d -> d in [ 1 .. n ] );
      
      degrees_a := List( degrees_a{ pos_a }, d -> - d + n );
     
      degrees_b := GeneratorDegrees( b );
      
      degrees_b := List( degrees_b, HomalgElementToInteger );
      
      pos_b := PositionsProperty( degrees_b, d -> d in [ 1 .. n ] );
      
      degrees_b := List( degrees_b{ pos_b }, d -> - d + n );
     
      matrix := UnderlyingMatrix( alpha );
      
      matrix := CertainColumns( CertainRows( matrix, pos_a ), pos_b );
      
      if NrCols( matrix ) = 0 then
        
        matrix := [ ];
        
      else
        
        matrix := List( [ 1 .. NrRows( matrix ) ],
                  i -> List( [ 1 .. NrCols( matrix ) ],
                    j ->
                      GradedPresentationMorphism(
                          TwistedOmegaModule( A, degrees_a[ i ] ),
                          HomalgMatrix( [ [ matrix[ i, j ] ] ], 1, 1, A ),
                          TwistedOmegaModule( A, degrees_b[ j ] ) ) / full
                        ) );
     fi;
     
     return AdditiveClosureMorphism( can_a, matrix, can_b );
     
  end );
   
  ##
  InstallMethod( BeilinsonFunctor,
            [ IsHomalgGradedRing ],
    function( S )
      local n, A, cat, full, add_full, collection, iso, inc_1, inc_2, reps, homotopy_reps, name, BB, r;
      
      n := Size( Indeterminates( S ) );
      
      A := KoszulDualRing( S );
      
      cat := GradedLeftPresentations( S );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      add_full := AdditiveClosure( full );
      
      DeactivateCachingOfCategory( add_full );
      
      CapCategorySwitchLogicOff( add_full );
      
      DisableSanityChecks( add_full );
      
      collection := CreateExceptionalCollection( full );
      
      iso := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
      
      inc_1 := InclusionFunctor( AsCapCategory( Range( iso ) ) );
      
      inc_2 := InclusionFunctor( AsCapCategory( Range( inc_1 ) ) );
      
      iso := PreCompose( [ iso, inc_1, inc_2 ] );
      
      iso := ExtendFunctorToAdditiveClosureOfSource( iso );
      
      reps := AsCapCategory( Range( iso ) );
      
      homotopy_reps := HomotopyCategory( reps );
      
      r := RANDOM_TEXT_ATTR( );
      
      name := Concatenation( "Cotangent Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( cat ), " ",
                  r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_reps ) );
      
      BB := CapFunctor( name, cat, homotopy_reps );
      
      AddObjectFunction( BB,
        function( a )
          local T, diffs, C;
          
          T := TateResolution( a );
          
          diffs := MapLazy( IntegersList, i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_MORPHISM( T ^ i ) ), 1 );
          
          C := ChainComplex( reps, diffs );
          
          SetLowerBound( C, -n );
          
          SetUpperBound( C, n );
          
          return C / homotopy_reps;
          
      end );
      
      AddMorphismFunction( BB,
        function( s, alpha, r )
          local T, maps;
          
          s := UnderlyingCell( s );
          
          r := UnderlyingCell( r );
          
          T := TateResolution( alpha );
          
          maps := MapLazy( IntegersList, i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_MORPHISM( T[ i ] ) ), 1 );
          
          return ChainMorphism( s, r, maps ) / homotopy_reps;
          
      end );
      
      return BB;
      
  end );
  
  ##
  #InstallMethod( 
  BindGlobal( "BeilinsonFunctor2",
     #       [ IsHomalgGradedRing ],
    function( S )
      local n, A, cat, full, add_full, iso, add_cotangent_modules, homotopy_cat, r, name, BB;
      
      n := Size( Indeterminates( S ) );
      
      A := KoszulDualRing( S );
      
      cat := GradedLeftPresentations( S );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      add_full := AdditiveClosure( full );
      
      DeactivateCachingOfCategory( add_full );
      
      CapCategorySwitchLogicOff( add_full );
      
      DisableSanityChecks( add_full );
           
      iso := IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentModules( S );
      
      iso := ExtendFunctorToAdditiveClosures( iso );
      
      add_cotangent_modules:= AsCapCategory( Range( iso ) );
      
      homotopy_cat := HomotopyCategory( add_cotangent_modules);
      
      r := RANDOM_TEXT_ATTR( );
      
      name := Concatenation( "Cotangent Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( cat ), " ",
                  r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_cat ) );
      
      BB := CapFunctor( name, cat, homotopy_cat );
      
      AddObjectFunction( BB,
        function( a )
          local T, diffs, C;
          
          T := TateResolution( a );
          
          diffs := MapLazy( IntegersList, i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_MORPHISM( T ^ i ) ), 1 );
          
          C := ChainComplex( add_cotangent_modules, diffs );
          
          SetLowerBound( C, -n );
          
          SetUpperBound( C, n );
          
          return C / homotopy_cat;
          
      end );
      
      AddMorphismFunction( BB,
        function( s, alpha, r )
          local T, maps;
          
          s := UnderlyingCell( s );
          
          r := UnderlyingCell( r );
          
          T := TateResolution( alpha );
          
          maps := MapLazy( IntegersList, i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_MORPHISM( T[ i ] ) ), 1 );
          
          return ChainMorphism( s, r, maps ) / homotopy_cat;
          
      end );
      
      return BB;
      
  end );
  
  ##
  InstallMethod( RestrictionOfBeilinsonFunctorToFullSubcategoryGeneratedByTwistsOfStructureSheaf,
            [ IsHomalgGradedRing ],
    function( S )
      local BB, homotopy_reps, full, name, F, r;
      
      BB := BeilinsonFunctor( S );
      
      homotopy_reps := AsCapCategory( Range( BB ) );
      
      full := FullSubcategoryGeneratedByTwistsOfStructureSheaf( S );
      
      r := RANDOM_TEXT_ATTR( );
      
      name := Concatenation( "Restriction of Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( full ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_reps ) );
      
      F := CapFunctor( name, full, homotopy_reps );
      
      AddObjectFunction( F,
        o -> ApplyFunctor( BB, UnderlyingHonestObject( UnderlyingCell( o ) ) )
      );
      
      AddMorphismFunction( F,
        { s, alpha, r } -> ApplyFunctor( BB, HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( alpha ) ) ) )
      );
      
      return F;
      
  end );
  
  ############################################################
  #
  # Twists of structure sheaves over the projective space
  #
  ############################################################
  
  ##
  InstallMethod( FullSubcategoryGeneratedByTwistsOfStructureSheaf,
            [ IsHomalgGradedRing and IsFreePolynomialRing ],
    function( S )
      local graded_pres, k, coh, generalized_morphism_cat, sh, name, full, is_additive;
      
      graded_pres := GradedLeftPresentations( S );
      
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
      
      if not IsRationalsForHomalg( k ) then
        
        Error( "The coefficient ring should be a rational homalg field" );
        
      fi;
      
      k := GLOBAL_FIELD_FOR_QPA!.default_field;
      
      coh := CoherentSheavesOverProjectiveSpace( S );
      
      DisableSanityChecks( coh );
      DeactivateCachingOfCategory( coh );
      CapCategorySwitchLogicOff( coh );
     
      generalized_morphism_cat := UnderlyingGeneralizedMorphismCategory( coh );
      
      DisableSanityChecks( generalized_morphism_cat );
      DeactivateCachingOfCategory( generalized_morphism_cat );
      CapCategorySwitchLogicOff( generalized_morphism_cat );
      
      sh := CanonicalProjection( coh );
      
      name := "Full subcategory generated by twists of the structure sheaf in ";
      
      full := FullSubcategory( coh, name : FinalizeCategory := false );
      
      SetSetOfKnownObjects( full, MapLazy( IntegersList, i -> ApplyFunctor( sh, TwistedStructureSheaf( S, i ) ) / full, 1 ) );
      
      ##
      AddIsEqualForObjects( full,
        function( M, N )
          
          return IsIdenticalObj( M, N )
                  or GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( M ) ) )
                      = GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( N ) ) );
      end, 99 );
      
      ##
      AddIsEqualForMorphisms( full,
        function( alpha, beta )
          
          if IsIdenticalObj( alpha, beta ) then
            
            return true;
            
          fi;
          
          if not ( IsEqualForObjects( Source( alpha ), Source( beta ) ) and IsEqualForObjects( Range( alpha ), Range( beta ) ) ) then
            
            return false;
            
          fi;
          
          return EntriesOfHomalgMatrixAttr( UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( alpha ) ) ) ) )[ 1 ]
                      = EntriesOfHomalgMatrixAttr( UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( beta ) ) ) ) )[ 1 ];
      end, 99 );
      
      ##
      AddIsEqualForCacheForObjects( full, IsEqualForObjects, 99 );
      AddIsEqualForCacheForMorphisms( full, IsEqualForMorphisms, 99 );
     
      ##
      AddPreCompose( full,
        function( alpha, beta )
        
          alpha := UnderlyingCell( alpha );
          
          beta := UnderlyingCell( beta );
          
          alpha := HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          return ApplyFunctor( sh, PreCompose( alpha, beta ) ) / full;
          
      end, 99 );
      
      ##
      AddAdditionForMorphisms( full,
        function( alpha, beta )
          local coeff, mor;
          
          coeff := fail;
          
          if HasCoefficientsOfMorphism( alpha ) and HasCoefficientsOfMorphism( beta ) then
            
            coeff := CoefficientsOfMorphism( alpha ) + CoefficientsOfMorphism( beta );
            
          fi;
          
          alpha := UnderlyingCell( alpha );
          
          beta := UnderlyingCell( beta );
          
          alpha := HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          mor := ApplyFunctor( sh, AdditionForMorphisms( alpha, beta ) ) / full;
          
          if not IsIdenticalObj( coeff, fail ) then
            
            SetCoefficientsOfMorphism( mor, coeff );
            
          fi;
          
          return mor;
          
      end, 99 );
     
      AddIsWellDefinedForObjects( full,
        function( M )
          
          M := UnderlyingCell( M );
          
          M := UnderlyingHonestObject( M );
          
          return NrRows( UnderlyingMatrix( M ) ) = 0 and NrCols( UnderlyingMatrix( M ) ) = 1;
          
      end );
      
      AddIsWellDefinedForMorphisms( full,
        function( alpha )
          return IsWellDefined( Source( alpha ) ) and IsWellDefined( Range( alpha ) )
                  and IsWellDefined( UnderlyingCell( alpha ) );
                  
      end, 99 );
      
      SetIsLinearCategoryOverCommutativeRing( full, true );
      
      SetCommutativeRingOfLinearCategory( full, k );
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
        function( r, alpha )
          local coeff, beta;
          
          coeff := fail;
          
          if HasCoefficientsOfMorphism( alpha ) then
            
            coeff := r * CoefficientsOfMorphism( alpha );
            
          fi;
          
          beta := UnderlyingCell( alpha );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
          
          beta := ApplyFunctor( sh, beta ) / full;
          
          if not IsIdenticalObj( coeff, fail ) then
            
            SetCoefficientsOfMorphism( beta, coeff );
            
          fi;
          
          return beta;
          
      end, 99 );
      
      AddAdditiveInverseForMorphisms( full,
        alpha -> MinusOne( k ) * alpha, 99 );
      
      AddBasisOfExternalHom( full,
        function( M, N )
          local twist_M, twist_N, B, identity_matrix;
          
          twist_M := HomalgElementToInteger( -GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( M ) ) )[ 1 ] );
          
          twist_N := HomalgElementToInteger( -GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( N ) ) )[ 1 ] );
          
          B := BasisBetweenTwistedStructureSheaves( S, twist_M, twist_N );
          
          B := List( B, b -> ApplyFunctor( sh, b ) / full );
          
          identity_matrix := EntriesOfHomalgMatrixAsListListAttr( HomalgIdentityMatrix( Size( B ), k ) );
          
          ListN( B, identity_matrix, function( b, c ) SetCoefficientsOfMorphism( b, c ); return true; end );
          
          return B;
          
      end, 99 );
      
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( phi, B )
          local entry, sol, coeff_mat, current_coeff, current_mono, position_in_basis, j;
          
          if B = [  ] then
            
            return [  ];
            
          fi;
          
          phi := UnderlyingCell( phi );
          
          phi := HonestRepresentative( UnderlyingGeneralizedMorphism( phi ) );
          
          entry := UnderlyingMatrix( phi )[ 1, 1 ];
          
          B := List( B, UnderlyingCell );
          
          B := List( B, b -> HonestRepresentative( UnderlyingGeneralizedMorphism( b ) ) );
          
          B := List( B, b -> EntriesOfHomalgMatrixAttr( UnderlyingMatrix( b ) )[ 1 ] );
          
          sol := ListWithIdenticalEntries( Size( B ), Zero( k ) );
          
          coeff_mat := Coefficients( EvalRingElement( entry ) );
            
          for j in [ 1 .. NrRows( coeff_mat ) ] do
              
              current_coeff := coeff_mat[ j, 1 ];
              
              current_mono := coeff_mat!.monomials[ j ] / S;
              
              position_in_basis := Position( B, current_mono );
              
              sol[ position_in_basis ] := current_coeff / k;
              
          od;
          
          return sol;
          
      end, 99 );
      
      Finalize( full );
      
      DisableSanityChecks( full );
      SetCachingOfCategoryCrisp( full );
      #DeactivateCachingOfCategory( full );
      CapCategorySwitchLogicOff( full );
     
      return full;
      
  end );

  ##
  InstallMethod( FullSubcategoryGeneratedByTwistedCotangentModules,
            [ IsHomalgGradedRing and IsFreePolynomialRing ],
    function( S )
      local graded_pres, k, coh, generalized_morphism_cat, sh, indeterminates, n, omegas, mats, dims, full;
      
      graded_pres := GradedLeftPresentations( S );
      
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
      
      if not IsRationalsForHomalg( k ) then
        
        Error( "The coefficient ring should be a rational homalg field" );
        
      fi;
      
      k := GLOBAL_FIELD_FOR_QPA!.default_field;
           
      indeterminates := Indeterminates( S );
      
      n := Size( indeterminates );
      
      omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentSheaf( S, i ) );
      
      mats := List( omegas, UnderlyingMatrix );
      
      dims := List( mats, d -> [ NrRows( d ), NrCols( d ) ] );
      
      if not IsDuplicateFree( dims ) then
        
        Error( "This should not happen, please report this!\n" );
        
      fi;
      
      full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
                 
      SetIsLinearCategoryOverCommutativeRing( full, true );
      
      SetCommutativeRingOfLinearCategory( full, k );
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
        function( r, alpha )
          local coeff, beta;
                   
          beta := UnderlyingCell( alpha );
          
          beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
          
          beta := beta / full;
                    
          return beta;
          
      end, 99 );
     
      AddBasisOfExternalHom( full,
        function( M, N )
          local mat_M, dim_M, index_M, mat_N, dim_N, index_N, B;
          
          mat_M := UnderlyingMatrix( UnderlyingCell( M ) );
          dim_M := [ NrRows( mat_M ), NrCols( mat_M ) ];
          index_M := Position( dims, dim_M ) - 1;
          
          mat_N := UnderlyingMatrix( UnderlyingCell( N ) );
          dim_N := [ NrRows( mat_N ), NrCols( mat_N ) ];
          index_N := Position( dims, dim_N ) - 1;
          
          if index_M = fail or index_N = fail then
            
            Error( "This should not happen!" );
            
          fi;
          
          B := BasisBetweenTwistedCotangentSheaves( S, index_M, index_N );
          
          B := List( B, b -> b / full );
          
          return B;
          
      end, 99 );
      
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( phi, B )
          local mat, sol;
          
          if B = [  ] then
            
            return [  ];
            
          fi;
          
          phi := UnderlyingCell( phi );
          
          mat := UnderlyingMatrix( phi ) * k;
          
          mat := ConvertMatrixToRow( mat );
          
          B := List( B, UnderlyingCell );
          
          B := List( B, b -> UnderlyingMatrix( b ) * k );
          
          B := UnionOfRows( List( B, ConvertMatrixToRow ) );
          
          sol := RightDivide( mat, B );
          
          return EntriesOfHomalgMatrix( sol );
          
      end );
      
      Finalize( full );
      
      return full;
      
  end );

  ##
  InstallMethod( FullSubcategoryGeneratedByTwistedCotangentSheaves,
            [ IsHomalgGradedRing and IsFreePolynomialRing ],
    function( S )
      local graded_pres, k, coh, generalized_morphism_cat, sh, indeterminates, n, omegas, mats, dims, full;
      
      graded_pres := GradedLeftPresentations( S );
      
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
      DisableSanityChecks( graded_pres );
      DeactivateCachingOfCategory( graded_pres );
      CapCategorySwitchLogicOff( graded_pres );
      
      k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
      
      if not IsRationalsForHomalg( k ) then
        
        Error( "The coefficient ring should be a rational homalg field" );
        
      fi;
      
      k := GLOBAL_FIELD_FOR_QPA!.default_field;
      
      coh := CoherentSheavesOverProjectiveSpace( S );
      
      DisableSanityChecks( coh );
      DeactivateCachingOfCategory( coh );
      CapCategorySwitchLogicOff( coh );
     
      generalized_morphism_cat := UnderlyingGeneralizedMorphismCategory( coh );
      
      DisableSanityChecks( generalized_morphism_cat );
      DeactivateCachingOfCategory( generalized_morphism_cat );
      CapCategorySwitchLogicOff( generalized_morphism_cat );
      
      sh := CanonicalProjection( coh );
           
      indeterminates := Indeterminates( S );
      
      n := Size( indeterminates );
      
      omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentSheaf( S, i ) );
      
      mats := List( omegas, UnderlyingMatrix );
      
      dims := List( mats, d -> [ NrRows( d ), NrCols( d ) ] );
      
      if not IsDuplicateFree( dims ) then
        
        Error( "This should not happen, please report this!\n" );
        
      fi;
      
      omegas := List( omegas, omega -> ApplyFunctor( sh, omega ) );
      
      full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
      
      ##
      AddPreCompose( full,
        function( alpha, beta )
        
          alpha := UnderlyingCell( alpha );
          
          beta := UnderlyingCell( beta );
          
          alpha := HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          return ApplyFunctor( sh, PreCompose( alpha, beta ) ) / full;
          
      end, 99 );
      
      ##
      AddAdditionForMorphisms( full,
        function( alpha, beta )
          local coeff, mor;
          
          coeff := fail;
          
          if HasCoefficientsOfMorphism( alpha ) and HasCoefficientsOfMorphism( beta ) then
            
            coeff := CoefficientsOfMorphism( alpha ) + CoefficientsOfMorphism( beta );
            
          fi;
          
          alpha := UnderlyingCell( alpha );
          
          beta := UnderlyingCell( beta );
          
          alpha := HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          mor := ApplyFunctor( sh, AdditionForMorphisms( alpha, beta ) ) / full;
          
          if not IsIdenticalObj( coeff, fail ) then
            
            SetCoefficientsOfMorphism( mor, coeff );
            
          fi;
          
          return mor;
          
      end, 99 );
           
      SetIsLinearCategoryOverCommutativeRing( full, true );
      
      SetCommutativeRingOfLinearCategory( full, k );
      
      AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
        function( r, alpha )
          local coeff, beta;
          
          coeff := fail;
          
          if HasCoefficientsOfMorphism( alpha ) then
            
            coeff := r * CoefficientsOfMorphism( alpha );
            
          fi;
          
          beta := UnderlyingCell( alpha );
          
          beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
          
          beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
          
          beta := ApplyFunctor( sh, beta ) / full;
          
          if not IsIdenticalObj( coeff, fail ) then
            
            SetCoefficientsOfMorphism( beta, coeff );
            
          fi;
          
          return beta;
          
      end, 99 );
      
      AddAdditiveInverseForMorphisms( full,
        alpha -> MinusOne( k ) * alpha, 99 );
     
      AddBasisOfExternalHom( full,
        function( M, N )
          local mat_M, dim_M, index_M, mat_N, dim_N, index_N, B;
          
          mat_M := UnderlyingMatrix( UnderlyingHonestObject( UnderlyingCell( M ) ) );
          dim_M := [ NrRows( mat_M ), NrCols( mat_M ) ];
          index_M := Position( dims, dim_M ) - 1;
          
          mat_N := UnderlyingMatrix( UnderlyingHonestObject( UnderlyingCell( N ) ) );
          dim_N := [ NrRows( mat_N ), NrCols( mat_N ) ];
          index_N := Position( dims, dim_N ) - 1;
          
          if index_M = fail or index_N = fail then
            
            Error( "This should not happen!" );
            
          fi;
          
          B := BasisBetweenTwistedCotangentSheaves( S, index_M, index_N );
          
          B := List( B, b -> ApplyFunctor( sh, b ) / full );
          
          return B;
          
      end, 99 );
      
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( full,
        function( phi, B )
          local mat, sol;
          
          if B = [  ] then
            
            return [  ];
            
          fi;
          
          phi := UnderlyingCell( phi );
          
          phi := HonestRepresentative( UnderlyingGeneralizedMorphism( phi ) );
          
          mat := UnderlyingMatrix( phi ) * k;
          
          mat := ConvertMatrixToRow( mat );
          
          B := List( B, UnderlyingCell );
          
          B := List( B, b -> HonestRepresentative( UnderlyingGeneralizedMorphism( b ) ) );
          
          B := List( B, b -> UnderlyingMatrix( b ) * k );
          
          B := UnionOfRows( List( B, ConvertMatrixToRow ) );
          
          sol := RightDivide( mat, B );
          
          return EntriesOfHomalgMatrix( sol );
          
      end );
      
      Finalize( full );
      
      return full;
      
  end );
  
  InstallMethod( IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentModules,
            [ IsHomalgGradedRing and IsFreePolynomialRing ],
    function( S )
      local A, omegas, objects_omegas, Omegas, objects_Omegas, object_func, morphism_func, name;
      
      A := KoszulDualRing( S );
      
      omegas := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      objects_omegas := SetOfKnownObjects( omegas );
      
      Omegas := FullSubcategoryGeneratedByTwistedCotangentModules( S );
      
      objects_Omegas := SetOfKnownObjects( Omegas );
      
      object_func := w -> objects_Omegas[ Position( objects_omegas, w ) ];
      
      morphism_func := alpha -> 
        BasisOfExternalHom( object_func( Source( alpha ) ), object_func( Range( alpha ) ) )
          [ Position( BasisOfExternalHom( Source( alpha ), Range( alpha ) ), alpha ) ];
          
      name := "Isomorphism functor from 𝛚_E(i)'s into 𝛀^i(i)'s";
      
      return FunctorFromLinearCategoryByTwoFunctions( name, omegas, Omegas, object_func, morphism_func );
      
  end );
  
  ########################################
  #
  # View & Display methods
  #
  #######################################
  
  ## 𝒪, 𝓞, 𝛀, 𝛚 ⨁,, ⊕, Ω
  
  ##
  InstallMethod( ViewObj,
            [ IsSerreQuotientCategoryObject ],
    function( M )
      local o, S, n, omegas, p;
       
      o := UnderlyingHonestObject( M );
      
      S := UnderlyingHomalgRing( o );
      
      n := Size( Indeterminates( S ) );
      
      omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentSheaf( S, i ) );
      
      p := Position( omegas, o );
      
      if p = fail then
        
        TryNextMethod( );
        
      fi;
      
      Print( "Ω^", p - 1, "(", p - 1, ")" );
      
  end );

  InstallMethod( ViewObj,
            [ IsSerreQuotientCategoryObject ],
    function( M )
      local o, twists, c, p;
      
      o := UnderlyingHonestObject( M );
      
      if not IsZero( NrRows( UnderlyingMatrix( o ) ) ) then
        
        TryNextMethod( );
        
      fi;
      
      twists := -GeneratorDegrees( o );
      
      #Print( "An object in Serre quotient category defined by: " );
      
      if IsEmpty( twists ) then
        
        Print( "0" );
        
      fi;
      
      c := [ ];
      
      while true do
        
        p := PositionProperty( twists, i -> i <> twists[ 1 ] );
        
        if p = fail then
          
          if Size( twists ) > 1 then
            
            Print( "𝓞(", twists[ 1 ], ")^", Size( twists ) );
            
          else
            
            Print( "𝓞(", twists[ 1 ], ")" );
            
          fi;
          
          break;
          
        else
          
          if p > 2 then
            
            Print( "𝓞(", twists[ 1 ], ")^", p - 1, "⊕" );
          
          else
            
            Print( "𝓞(", twists[ 1 ], ")⊕" );
            
          fi;
         
          twists := twists{ [ p .. Size( twists ) ] };
        
        fi;
        
      od;
       
  end );
    
  ##
  InstallMethod( ViewObj,
            [ IsSerreQuotientCategoryMorphism ],
    function( alpha )
      local s, mat_s, r, mat_r;
      
      s := Source( alpha );
      
      mat_s := UnderlyingMatrix( UnderlyingHonestObject( s ) );
      
      if not IsZero( NrRows( mat_s ) ) then
      
        TryNextMethod( );
      
      fi;
      
      r := Range( alpha );
      
      mat_r := UnderlyingMatrix( UnderlyingHonestObject( r ) );
   
      if not IsZero( NrRows( mat_r ) ) then
      
        TryNextMethod( );
      
      fi;

      ViewObj( s );
      
      Print( "--" );
      
      if NrCols( mat_s ) = 1 and NrCols( mat_r ) = 1 then
        
        Print( "{",UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( alpha ) ) )[ 1, 1 ],"}" );
        
      fi;
       
      Print( "--> " );
      
      ViewObj( r );
      
  end );

fi;
