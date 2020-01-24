if IsPackageMarkedForLoading( "BBGG", ">= 2019.12.06" ) then
    
  ##
  InstallMethod( BeilinsonFunctor,
            [ IsHomalgGradedRing ],
    function( S )
      local n, A, cat, full, add_full, collection, iso, inc_1, inc_2, reps, homotopy_reps, name, BB, r, i;
      
      n := Size( Indeterminates( S ) );
      
      A := KoszulDualRing( S );
      
      cat := GradedLeftPresentations( S );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      add_full := AdditiveClosure( full );
      
      DeactivateCachingOfCategory( add_full );
      
      CapCategorySwitchLogicOff( add_full );
      
      DisableSanityChecks( add_full );
      
      name := "quiver{";
      
      for i in [ 0 .. n - 1 ] do
        
        if i <> n - 1 then
          name := Concatenation( name, "Ω^", String( i ),"(", String( i ) , "), " );
        else
          name := Concatenation( name, "Ω^", String( i ),"(", String( i ) , ")" );
        fi;
        
      od;
      
      name := Concatenation( name, "}" );
      
      collection := CreateExceptionalCollection( full : name_for_underlying_quiver := name );
      
      iso := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
      
      inc_1 := InclusionFunctor( AsCapCategory( Range( iso ) ) );
      
      inc_2 := InclusionFunctor( AsCapCategory( Range( inc_1 ) ) );
      
      iso := PreCompose( [ iso, inc_1, inc_2 ] );
      
      iso := ExtendFunctorToAdditiveClosureOfSource( iso );
      
      reps := AsCapCategory( Range( iso ) );
      
      homotopy_reps := HomotopyCategory( reps );
      
      r := RandomTextColor( );
      
      name := Concatenation( "Cotangent Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( cat ), " ",
                  r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_reps ) );
      
      BB := CapFunctor( name, cat, homotopy_reps );
      
      AddObjectFunction( BB,
        function( a )
          local T, diffs, C;
          
          T := TateResolution( a );
          
          diffs := List( [ - n + 2 .. n - 1 ], i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_CELL( T ^ i ) ) );
          
          C := ChainComplex( diffs, - n + 2 );
          
          return C / homotopy_reps;
          
      end );
      
      AddMorphismFunction( BB,
        function( s, alpha, r )
          local T, maps;
          
          s := UnderlyingCell( s );
          
          r := UnderlyingCell( r );
          
          T := TateResolution( alpha );
          
          maps := List( [ - n + 1 .. n - 1 ], i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_CELL( T[ i ] ) ) );
          
          return ChainMorphism( s, r, maps, - n + 1 ) / homotopy_reps;
          
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
      
      r := RandomTextColor( );
      
      name := Concatenation( "Cotangent Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( cat ), " ",
                  r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_cat ) );
      
      BB := CapFunctor( name, cat, homotopy_cat );
      
      AddObjectFunction( BB,
        function( a )
          local T, diffs, C;
          
          T := TateResolution( a );
          
          diffs := List( [ - n + 2 .. n - 1 ], i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_CELL( T ^ i ) ) );
          
          C := ChainComplex( diffs, - n + 2 );
          
          return C / homotopy_cat;
          
      end );
      
      AddMorphismFunction( BB,
        function( s, alpha, r )
          local T, maps;
          
          s := UnderlyingCell( s );
          
          r := UnderlyingCell( r );
          
          T := TateResolution( alpha );
          
          maps := List( [ - n + 1 .. n - 1 ], i -> ApplyFunctor( iso, CAN_TWISTED_OMEGA_CELL( T[ i ] ) ) );
          
          return ChainMorphism( s, r, maps, - n + 1 ) / homotopy_cat;
          
      end );
      
      return BB;
      
  end );

  ##
  #InstallMethod( 
  BindGlobal( "BeilinsonFunctor3",
     #       [ IsHomalgGradedRing ],
    function( S )
      local n, A, cat, full, add_full, homotopy_cat, r, name, BB;
      
      n := Size( Indeterminates( S ) );
      
      A := KoszulDualRing( S );
      
      cat := GradedLeftPresentations( S );
      
      full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
      
      add_full := AdditiveClosure( full );
      
      DeactivateCachingOfCategory( add_full );
       
      homotopy_cat := HomotopyCategory( add_full );
      
      r := RandomTextColor( );
      
      name := Concatenation( "Cotangent Beilinson functor ", r[ 1 ], "from", r[ 2 ], " ", Name( cat ), " ",
                  r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_cat ) );
      
      BB := CapFunctor( name, cat, homotopy_cat );
      
      AddObjectFunction( BB,
        function( a )
          local T, diffs, C;
          
          T := TateResolution( a );
          
          diffs := List( [ - n + 2 .. n - 1 ], i -> CAN_TWISTED_OMEGA_CELL( T ^ i ) );
          
          C := ChainComplex( diffs, - n + 2 );
          
          return C / homotopy_cat;
          
      end );
      
      AddMorphismFunction( BB,
        function( s, alpha, r )
          local T, maps;
          
          s := UnderlyingCell( s );
          
          r := UnderlyingCell( r );
          
          T := TateResolution( alpha );
          
          maps := List( [ - n + 1 .. n - 1 ], i -> CAN_TWISTED_OMEGA_CELL( T[ i ] ) );
          
          return ChainMorphism( s, r, maps, - n + 1 ) / homotopy_cat;
          
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
      
      r := RandomTextColor( );
      
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
    
fi;
