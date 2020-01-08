#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
##
#############################################################################

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
          
          return EntriesOfHomalgMatrix( RightDivide( alpha, B ) * k );
  
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
      
      matrix := List( [ 1 .. NrRows( matrix ) ],
                  i -> List( [ 1 .. NrCols( matrix ) ],
                    j ->
                      GradedPresentationMorphism(
                          TwistedOmegaModule( A, degrees_a[ i ] ),
                          HomalgMatrix( [ [ matrix[ i, j ] ] ], 1, 1, A ),
                          TwistedOmegaModule( A, degrees_b[ j ] ) ) / full
                        ) );
     
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

fi;

