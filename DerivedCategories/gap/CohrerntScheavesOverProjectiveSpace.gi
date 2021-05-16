# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
InstallMethod( FullSubcategoryGeneratedByTwistedCotangentModules,
          [ IsHomalgGradedRing ],
  function( S )
    
    return RangeOfFunctor( IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModules( S ) );
    
end );

##
InstallMethod( IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModules,
          [ IsHomalgGradedRing ],
          1000,
  function( S )
    local F, G;

    F := IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModulesAsGLP( S ); # GLP=GradedLeftPresentations
    
    G := EquivalenceFromGradedLeftPresentationsOntoFreydCategoryOfGradedRows( S );
    
    G := RestrictFunctorToFullSubcategoryOfSource( G, RangeOfFunctor( F ) );
    
    G := PreCompose( F, G );
    
    G := IsomorphismOntoImageOfFullyFaithfulFunctor( G );
    
    G!.Name := "Isomorphism functor from 𝛚_E(i)'s into 𝛀 ^i(i)'s as modules";
    
    return G;
    
end );

##
InstallMethod( IsomorphismFromTwistedCotangentModulesOntoTwistedOmegaModules,
          [ IsHomalgGradedRing ],
  function( S )
    local F, G;
    
    F := IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModulesAsGLP( S );
    
    G := EquivalenceFromGradedLeftPresentationsOntoFreydCategoryOfGradedRows( S );
    
    G := RestrictFunctorToFullSubcategoryOfSource( G, RangeOfFunctor( F ) );
    
    G := PreCompose( F, G );
    
    G := IsomorphismFromImageOfFullyFaithfulFunctor( G );
    
    G!.Name := "Isomorphism functor from 𝛀 ^i(i)'s as modules into 𝛚_E(i)'s";
    
    return G;
    
end );


##
InstallMethod( EndomorphismAlgebraOfCotangentBeilinsonCollection,
          [ IsHomalgGradedRing ],
  function( S )
    local B;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
    
    B := UnderlyingCategory( DefiningCategory( RangeOfFunctor( B ) ) );
    
    return EndomorphismAlgebra( StrongExceptionalCollection( B ) );
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules,
          [ IsHomalgGradedRing ],
  function( S )
    local G, n, A, cat, full, labels, collection, vertices_labels, homotopy_cat, B, I;
    
    G := DegreeGroup( S );
    
    if not ( IsFree( G ) and Rank( G ) = 1 ) then
      Error( "The input should be a polynomial ring whose indeterminates degrees are 1's" );
    fi;
    
    n := Size( Indeterminates( S ) );
    
    A := KoszulDualRing( S );
    
    cat := GradedLeftPresentations( S );
    
    full := FullSubcategoryGeneratedByTwistedOmegaModules( A );
    
    labels := List( Reversed( [ 0 .. n - 1 ] ), i -> Concatenation( "Ω^", String( i ),"(", String( i ) , ")" ) );
    
    collection := CreateStrongExceptionalCollection( full, labels );
    
    homotopy_cat := HomotopyCategory( collection );
    
    B := CapFunctor( "Cotangent Beilinson functor", cat, homotopy_cat );
    
    AddObjectFunction( B,
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
    
    AddMorphismFunction( B,
      function( s, alpha, r )
        local T, maps;
        
        T := TateResolution( alpha );
        
        maps := Morphisms( T );
        
        maps := ApplyMap( maps, CAN_TWISTED_OMEGA_CELL );
        
        return HomotopyCategoryMorphism( s, r, maps );
        
    end );
    
    I := EquivalenceFromFreydCategoryOfGradedRowsOntoGradedLeftPresentations( S );
    
    B := PreCompose( I, B );
    
    B!.Name := "Cotangent Beilinson functor";
    
    ## In this special case I want to set the interpretation isomorphism
    ##
    SetInterpretationIsomorphismFromAlgebroid(
          Algebroid( collection ),
          PreCompose(
              IsomorphismFromAlgebroid( collection ),
              IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModules( S )
            )
        );
        
    SetInterpretationIsomorphismOntoAlgebroid(
          Algebroid( collection ),
          PostCompose(
              IsomorphismOntoAlgebroid( collection ),
              IsomorphismFromTwistedCotangentModulesOntoTwistedOmegaModules( S )
            )
        );
    
    return B;
    
end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C, collection;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
    
    C := RangeOfFunctor( B );
    
    C := DefiningCategory( C );
    
    C := UnderlyingCategory( C );
    
    collection := StrongExceptionalCollection( C );
    
    C := IsomorphismOntoAlgebroid( collection );
    
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
    
    C := RangeOfFunctor( B );
    
    C := DefiningCategory( C );
    
    C := IsomorphismOntoQuiverRows( C );
    
    QRows := RangeOfFunctor( C );
    
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
    
    C := RangeOfFunctor( B );
    
    C := DefiningCategory( C );
    
    C := UnderlyingCategory( C );
    
    C := StrongExceptionalCollection( C );
  
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
    
    C := RangeOfFunctor( B );
    
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
    
    C := RangeOfFunctor( B );

    C := DefiningCategory( C );
    
    C := InclusionFunctor( C );
    
    C := ExtendFunctorToHomotopyCategories( C );
    
    H := RangeOfFunctor( C );
    
    H := LocalizationFunctor( H );
    
    C := PreCompose( [ B, C, H ] );
    
    C!.Name := "Cotangent Beilinson functor";
    
    return C;

end );

##
InstallMethod( BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules,
          [ IsHomalgGradedRing ],
  function( S )
    local B, G;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules( S );
        
    G := IsomorphismFromTwistedOmegaModulesOntoTwistedCotangentModules( S );
    
    G := ExtendFunctorToAdditiveClosures( G );
    
    G := ExtendFunctorToHomotopyCategories( G );
    
    G := PreCompose( B, G );
    
    G!.Name := "Cotangent Beilinson functor";
    
    return G;
    
end );

##
InstallMethod( BeilinsonFunctor,
          [ IsHomalgGradedRing ],
  function( S )
    local B, C;
    
    B := BeilinsonFunctorIntoHomotopyCategoryOfProjectiveObjects( S );
    
    C := RangeOfFunctor( B );
    
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
    
    homotopy_reps := RangeOfFunctor( BB );
    
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
