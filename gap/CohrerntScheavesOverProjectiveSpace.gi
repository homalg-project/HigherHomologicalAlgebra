    
  
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules,
          [ IsHomalgGradedRing ],
  function( S )
    local n, A, cat, full, labels, collection, vertices_labels, homotopy_cat, BB;
  
    n := Size( Indeterminates( S ) );
    
    A := KoszulDualRing( S );
    
    cat := GradedLeftPresentations( S );
    
    full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
    
    labels := List( Reversed( [ 0 .. n - 1 ] ), i -> Concatenation( "Ω^", String( i ),"(", String( i ) , ")" ) );
    
    collection := CreateExceptionalCollection( full : vertices_labels := labels );
    
    homotopy_cat := HomotopyCategory( collection );
    
    BB := CapFunctor( "Cotangent Beilinson functor", cat, homotopy_cat );
    
    AddObjectFunction( BB,
      function( a )
        local T, diffs, C;
        
        T := TateResolution( a );
        
        diffs := Differentials( T );
        
        diffs := ApplyMap( diffs, CAN_TWISTED_OMEGA_CELL );
        
        C := HomotopyCategoryObject( homotopy_cat, diffs );
        
        SetLowerBound( C, - n + 1 );
        
        SetUpperBound( C, n - 1 );
        
        return C;
        
    end );
    
    AddMorphismFunction( BB,
      function( s, alpha, r )
        local T, maps;
        
        T := TateResolution( alpha );
        
        maps := Morphisms( T );
        
        maps := ApplyMap( maps, CAN_TWISTED_OMEGA_CELL );
        
        return HomotopyCategoryMorphism( s, r, maps );
        
    end );
    
    return BB;

end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
    
    C := AsCapCategory( Range( B ) );
    
    C := DefiningCategory( C );
    
    C := UnderlyingCategory( C );
    
    C := ExceptionalCollection( C );
    
    C := IsomorphismOntoAlgebroid( C );
    
    C := ExtendFunctorToAdditiveClosures( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C, QRows, A, r, name;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( S );
    
    C := AsCapCategory( Range( B ) );
    
    C := DefiningCategory( C );
    
    C := IsomorphismOntoQuiverRows( C );
    
    QRows := AsCapCategory( Range( C ) );
    
    A := UnderlyingQuiverAlgebra( QRows );
    
    r := RandomTextColor( Name( QRows ) );
    
    name := Concatenation( r[ 1 ], "QuiverRows( ", r[ 2 ], Name( A ), r[ 1 ], " )", r[ 2 ] );
    
    QRows!.Name := name;
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
    
end );


##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfIndecProjectiveObjects,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
    
    C := AsCapCategory( Range( B ) );
    
    C := DefiningCategory( C );
    
    C := UnderlyingCategory( C );
    
    C := ExceptionalCollection( C );
  
    C := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( C );
    
    C := ExtendFunctorToAdditiveClosures( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
         
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfProjectiveObjects,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfIndecProjectiveObjects( S );
    
    C := AsCapCategory( Range( B ) );
    
    C := DefiningCategory( C );
    
    C := UnderlyingCategory( C );
    
    C := AmbientCategory( C );
    
    C := EquivalenceFromAdditiveClosureOfIndecProjectiveObjectsIntoFullSubcategoryGeneratedByProjectiveObjects( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
    
end );

##
InstallMethod( BeilinsonFunctorIntoDerivedCategory,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C, H;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfProjectiveObjects( S );
    
    C := AsCapCategory( Range( B ) );

    C := DefiningCategory( C );
    
    C := InclusionFunctor( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    H := AsCapCategory( Range( C ) );
    
    H := LocalizationFunctor( H );
    
    C := PreCompose( [ B, C, H ] );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;

end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
    
    C := IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentModules( S );
    
    C := ExtendFunctorToAdditiveClosures( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
    
end );

##
InstallMethod( BeilinsonFunctor,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfProjectiveObjects( S );
    
    C := AsCapCategory( Range( B ) );
    
    C := DefiningCategory( C );
    
    C := InclusionFunctor( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    C := PreCompose( B, C );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;
    
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
    
    name := "Cotangent Beilinson functor";
    
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
    
    name := "Cotangent Beilinson functor";
    
    F := CapFunctor( name, full, homotopy_reps );
    
    AddObjectFunction( F,
      o -> ApplyFunctor( BB, UnderlyingHonestObject( UnderlyingCell( o ) ) )
    );
    
    AddMorphismFunction( F,
      { s, alpha, r } -> ApplyFunctor( BB, HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( alpha ) ) ) )
    );
    
    return F;
    
end );
  
;
