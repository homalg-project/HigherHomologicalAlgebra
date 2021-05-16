# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
InstallMethod( \/,
          [ IsCapCategory, IsCapCategory ],
  FindSomeFunctor
);

##
InstallMethod( \/,
          [ IsCapFunctor, IsCapCategory ],
  FindSomeFunctor
);

##
InstallMethod( \/,
          [ IsCapCategory, IsCapFunctor ],
  FindSomeFunctor
);

##
InstallMethod( \*,
          [ IsCapCategoryCell, IsCapCategory ],
  FindSomeFunctorThenApply
);

##
InstallMethod( FindSomeFunctorThenApply,
          [ IsCapCategoryCell, IsCapCategory ],
  { cell, category } -> ApplyFunctor( FindSomeFunctor( CapCategory( cell ), category ), cell )
);

##
InstallMethod( FindSomeFunctor,
          [ IsCapFunctor, IsCapCategory ],
  { F, category } -> PreCompose( F, FindSomeFunctor( RangeOfFunctor( F ), category ) )
);

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsCapFunctor ],
  { category, F } -> PreCompose( FindSomeFunctor( category, SourceOfFunctor( F ) ), F )
);

##
InstallMethod( \/,
          [ IsList, IsCapCategory ],
  function( l, category )
    
    if IsEmpty( l ) then
      TryNextMethod( );
    fi;
    
    if not ForAll( l, IsCapCategoryObject ) then
      TryNextMethod( );
    fi;
    
    if not ForAll( l, o -> IsIdenticalObj( CapCategory( o ), category ) ) then
      TryNextMethod( );
    fi;
    
    return FullSubcategoryGeneratedByListOfObjects( l );
    
end );


##
InstallMethod( \.,
        [ IsAdditiveClosureCategory, IsPosInt ],
        
  function( AC, string_as_int )
    local name, C;
    
    name := NameRNam( string_as_int );
 
    C := UnderlyingCategory( AC );
    
    if IsAlgebroid( C ) then
      return C.( name ) / AC;
    elif IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( C ) then
      return C[ Int( name ) ] / AC;
    else
      Error( "Wrong input!\n" );
    fi;
    
end );

##############################################
#
# Convenience methods for full subcategories
#
##############################################

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( full_1, full_2 )
    local F, I;
    
    if HasDefiningFullyFaithfulFunctor( full_2 ) then
      
      F := DefiningFullyFaithfulFunctor( full_2 );
      
      I := IsomorphismOntoImageOfFullyFaithfulFunctor( F );
      
      if IsIdenticalObj( SourceOfFunctor( I ), full_1 ) then
        
        return I;
        
      fi;
      
    fi;
    
    if HasDefiningFullyFaithfulFunctor( full_1 ) then
      
      F := DefiningFullyFaithfulFunctor( full_1 );
      
      I := IsomorphismFromImageOfFullyFaithfulFunctor( F );
      
      if IsIdenticalObj( RangeOfFunctor( I ), full_2 ) then
        
        return I;
        
      fi;
      
    fi;
   
    TryNextMethod( );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsAlgebroid, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( algebroid, full )
    local I;
    
    if not HasInterpretationIsomorphismFromAlgebroid( algebroid ) then
      TryNextMethod( );
    fi;
    
    I := InterpretationIsomorphismFromAlgebroid( algebroid );
    
    if not IsIdenticalObj( full, RangeOfFunctor( I ) ) then
      TryNextMethod( );
    fi;
    
    return I;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsAlgebroid ],
  function( full, algebroid )
    local I;
    
    if not HasInterpretationIsomorphismOntoAlgebroid( algebroid ) then
      TryNextMethod( );
    fi;
    
    I := InterpretationIsomorphismOntoAlgebroid( algebroid );
    
    if not IsIdenticalObj( full, SourceOfFunctor( I ) ) then
      TryNextMethod( );
    fi;
    
    return I;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsAlgebroid ],
  function( full, algebroid )
    local collection;
    
    if not HasStrongExceptionalCollection( full ) then
      TryNextMethod( );
    fi;
    
    collection := StrongExceptionalCollection( full );
    
    if not IsIdenticalObj( Algebroid( collection ), algebroid ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismOntoAlgebroid( collection );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( full, indec_projs )
    local collection, A;
    
    if not HasStrongExceptionalCollection( full ) then
      TryNextMethod( );
    fi;
    
    collection := StrongExceptionalCollection( full );
    
    if not ( IsBound( indec_projs!.full_subcategory_generated_by_indec_projective_objects ) and
                indec_projs!.full_subcategory_generated_by_indec_projective_objects ) then
                
      TryNextMethod( );
      
    fi;
    
    A := EndomorphismAlgebra( collection );
    
    if not IsIdenticalObj( OppositeAlgebra( A ), AlgebraOfCategory( AmbientCategory( indec_projs ) ) ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsQuiverRepresentationCategory ],
  function( full, reps )
    local collection, A, I;
    
    if not HasStrongExceptionalCollection( full ) then
      TryNextMethod( );
    fi;
    
    collection := StrongExceptionalCollection( full );
    
    A := EndomorphismAlgebra( collection );
    
    if not IsIdenticalObj( OppositeAlgebra( A ), AlgebraOfCategory( reps ) ) then
      TryNextMethod( );
    fi;
    
    I := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
    
    return PreCompose( I, InclusionFunctor( RangeOfFunctor( I ) ) );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( indec_projs, full )
    local collection, A;
    
    if not HasStrongExceptionalCollection( full ) then
      TryNextMethod( );
    fi;
    
    collection := StrongExceptionalCollection( full );
    
    if not ( IsBound( indec_projs!.full_subcategory_generated_by_indec_projective_objects ) and
                indec_projs!.full_subcategory_generated_by_indec_projective_objects ) then
                
      TryNextMethod( );
      
    fi;
    
    A := EndomorphismAlgebra( collection );
    
    if not IsIdenticalObj( OppositeAlgebra( A ), AlgebraOfCategory( AmbientCategory( indec_projs ) ) ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection ); 
    
end );


##
InstallMethod( FindSomeFunctor,
          [ IsAlgebroid, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( algebroid, full )
    local collection;
    
    if not HasStrongExceptionalCollection( full ) then
      TryNextMethod( );
    fi;
    
    collection := StrongExceptionalCollection( full );
    
    if not IsIdenticalObj( Algebroid( collection ), algebroid ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismFromAlgebroid( collection );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsAlgebroid, IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects ],
  function( algebroid, full )
    local A;
  
    if not ( IsBound( full!.full_subcategory_generated_by_indec_projective_objects ) and
                full!.full_subcategory_generated_by_indec_projective_objects ) then
                
      TryNextMethod( );
      
    fi;
    
    A := AlgebraOfCategory( AmbientCategory( full ) );
    
    if not IsIdenticalObj( OppositeAlgebra( UnderlyingQuiverAlgebra( algebroid ) ), A ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects, IsAlgebroid ],
  function( full, algebroid )
    local A;
  
    if not ( IsBound( full!.full_subcategory_generated_by_indec_projective_objects ) and
                full!.full_subcategory_generated_by_indec_projective_objects ) then
                
      TryNextMethod( );
      
    fi;
    
    A := AlgebraOfCategory( AmbientCategory( full ) );
    
    if not IsIdenticalObj( OppositeAlgebra( UnderlyingQuiverAlgebra( algebroid ) ), A ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

end );


##
InstallMethod( FindSomeFunctor,
          [ IsAlgebroid, IsQuiverRepresentationCategory ],
  function( algebroid, category )
    local A, I;
  
    A := AlgebraOfCategory( category );
    
    if not IsIdenticalObj( OppositeAlgebra( UnderlyingQuiverAlgebra( algebroid ) ), A ) then
      TryNextMethod( );
    fi;
    
    I := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
    
    return PreCompose( I, InclusionFunctor( RangeOfFunctor( I ) ) );
 
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapFullSubcategory, IsCapCategory ],
  function( full, category )
    local underlying_category, I, J;
    if IsIdenticalObj( full, category ) then
      return IdentityFunctor( full );
    elif IsIdenticalObj( AmbientCategory( full ), category ) then
      return InclusionFunctor( full );
    elif IsAdditiveClosureCategory( category ) and IsIdenticalObj( UnderlyingCategory( category ), full ) then
      return InclusionFunctorInAdditiveClosure( full );
    elif IsChainComplexCategory( category ) then
      underlying_category := UnderlyingCategory( category );
      if IsIdenticalObj( full, underlying_category ) then
        return StalkChainFunctor( full, 0 );
      fi;
      I := FindSomeFunctor( full, underlying_category );
      J := FindSomeFunctor( underlying_category, category );
      return PreCompose( I, J );
    elif IsHomotopyCategory( category ) then
      I := FindSomeFunctor( full, UnderlyingCategory( category ) );
      return PreCompose( I, ProjectionFunctor( category ) );
    elif IsDerivedCategory( category ) then
      I := FindSomeFunctor( full, HomotopyCategory( DefiningCategory( category ) ) );
      J := LocalizationFunctor( HomotopyCategory( DefiningCategory( category ) ) );
      return PreCompose( I, J );
    else
      TryNextMethod( );
    fi;
end );

##############################################
#
# Convenience methods for additive closures
#
##############################################

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsAdditiveClosureCategory ],
  function( cat, additive_closure )
    local underlying_category;
    
    underlying_category := UnderlyingCategory( additive_closure );
    
    if IsIdenticalObj( underlying_category, cat ) then
      return InclusionFunctorInAdditiveClosure( cat );
    else
      TryNextMethod( );
    fi;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsAdditiveClosureCategory, IsCapCategory ],
  function( additive_closure, cat )
    local underlying_category, I;
    
    if IsIdenticalObj( additive_closure, cat ) then
      return IdentityFunctor( cat );
    fi;
    
    underlying_category := UnderlyingCategory( additive_closure );
    
    I := FindSomeFunctor( underlying_category, cat );
    
    return ExtendFunctorToAdditiveClosureOfSource( I );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsAdditiveClosureCategory, IsAdditiveClosureCategory ],
  function( additive_closure_1, additive_closure_2 )
    local I;
    
    I := FindSomeFunctor( UnderlyingCategory( additive_closure_1 ), UnderlyingCategory( additive_closure_2 ) );
    
    return ExtendFunctorToAdditiveClosures( I );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsAdditiveClosureCategory, IsQuiverRowsCategory ],
  function( add_closure, quiver_rows )
    
    if not IsAlgebroid( UnderlyingCategory( add_closure ) ) then
      TryNextMethod( );
    fi;
    
    if not IsIdenticalObj(
              UnderlyingQuiverAlgebra( UnderlyingCategory( add_closure ) ),
              UnderlyingQuiverAlgebra( quiver_rows )
            ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismOntoQuiverRows( add_closure );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsQuiverRowsCategory, IsAdditiveClosureCategory ],
  function( quiver_rows, add_closure )
    
    if not IsAlgebroid( UnderlyingCategory( add_closure ) ) then
      TryNextMethod( );
    fi;
    
    if not IsIdenticalObj(
              UnderlyingQuiverAlgebra( UnderlyingCategory( add_closure ) ),
              UnderlyingQuiverAlgebra( quiver_rows )
            ) then
      TryNextMethod( );
    fi;
    
    return IsomorphismFromQuiverRows( add_closure );
    
end );

##############################################
#
# Convenience methods to Chain complexes
#
##############################################

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsChainComplexCategory ],
  function( cat, chains_category )
    local underlying_category, I, J;
    
    if IsChainComplexCategory( cat ) then
      TryNextMethod( );
    fi;
    
    underlying_category := UnderlyingCategory( chains_category );
    
    if IsIdenticalObj( cat, underlying_category ) then
      return StalkChainFunctor( cat, 0 );
    else
      I := FindSomeFunctor( cat, UnderlyingCategory( chains_category ) );
      J := FindSomeFunctor( UnderlyingCategory( chains_category ), chains_category );
      return PreCompose( I, J );
    fi;
 
end );

##
InstallMethod( FindSomeFunctor,
          [ IsChainComplexCategory, IsChainComplexCategory ],
  function( cat, chains_category )
    local I;
    I := FindSomeFunctor( UnderlyingCategory( cat ), UnderlyingCategory( chains_category ) );
    return ExtendFunctorToChainComplexCategories( I );
end );

##############################################
#
# Convenience methods to Homotopy categories
#
##############################################

##
InstallMethod( FindSomeFunctor,
          [ IsHomotopyCategory, IsHomotopyCategory ],
  function( homotopy_category_1, homotopy_category_2 )
    local defining_cat_1, underlying_category_1, collection, defining_cat_2, underlying_category_2, I, underlying_category;
    
    if IsIdenticalObj( homotopy_category_1, homotopy_category_2) then
      
      return IdentityFunctor( homotopy_category_1 );
      
    fi;
    
    defining_cat_1 := DefiningCategory( homotopy_category_1 );
    
    if IsAdditiveClosureCategory( defining_cat_1 ) then
      
      underlying_category_1 := UnderlyingCategory( defining_cat_1 );
      
      if IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( underlying_category_1 ) and
          HasStrongExceptionalCollection( underlying_category_1 ) and
            IsIdenticalObj( homotopy_category_2, AmbientCategory( underlying_category_1 ) ) then
            
            collection := StrongExceptionalCollection( underlying_category_1 );
            
            return ConvolutionFunctor( collection );
            
      fi;
      
    fi;
    
    defining_cat_2 := DefiningCategory( homotopy_category_2 );
    
    if IsAdditiveClosureCategory( defining_cat_2 ) then
      
      underlying_category_2 := UnderlyingCategory( defining_cat_2 );
      
      if IsCapFullSubcategoryGeneratedByFiniteNumberOfObjects( underlying_category_2 ) and
          HasStrongExceptionalCollection( underlying_category_2 ) and
            IsIdenticalObj( homotopy_category_1, AmbientCategory( underlying_category_2 ) ) then
            
            collection := StrongExceptionalCollection( underlying_category_2 );
            
            return ReplacementFunctor( collection );
            
      fi;
      
    fi;
    
    if IsCapFullSubcategory( defining_cat_2 ) and HasIsAdditiveCategory( defining_cat_2 ) then
     
      if HasFullSubcategoryGeneratedByProjectiveObjects( defining_cat_1 ) and
            IsIdenticalObj( FullSubcategoryGeneratedByProjectiveObjects( defining_cat_1 ), defining_cat_2 ) then
          
          return LocalizationFunctorByProjectiveObjects( homotopy_category_1 );
         
         
      fi;
      
      if HasFullSubcategoryGeneratedByInjectiveObjects( defining_cat_1 ) and
            IsIdenticalObj( FullSubcategoryGeneratedByInjectiveObjects( defining_cat_1 ), defining_cat_2 ) then
          
          return LocalizationFunctorByInjectiveObjects( homotopy_category_1 );
         
         
      fi;
     
    fi;
    
    if IsFreydCategory( defining_cat_1 ) and IsCategoryOfGradedRows( defining_cat_2 ) then
      
      if IsIdenticalObj( defining_cat_2, UnderlyingCategory( defining_cat_1 ) ) then
        
        I := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsOntoGradedRows( defining_cat_1 );
        
        I := ExtendFunctorToHomotopyCategories( I );
        
        return PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_category_1 ), I );
        
      fi;
      
    fi;
        
    I := FindSomeFunctor( DefiningCategory( homotopy_category_1 ), DefiningCategory( homotopy_category_2 ) );
    
    return ExtendFunctorToHomotopyCategories( I );
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsHomotopyCategory ],
  function( category, homotopy_category )
    local underlying_category, I, J;
    
    if IsIdenticalObj( category, homotopy_category ) then
      
      return IdentityFunctor( category );
      
    fi;
    
    if IsHomotopyCategory( category ) then
      TryNextMethod( );
    fi;
    
    if IsAdditiveClosureCategory( category ) then
      TryNextMethod( );
    fi;
    
    if IsCapFullSubcategory( category ) then
      TryNextMethod( );
    fi;
    
    if IsFreydCategory( category ) and IsQuiverRowsCategory( DefiningCategory( homotopy_category ) ) then
      TryNextMethod( );
    fi;
    
    if IsFreydCategory( category ) and IsAdditiveClosureCategory( DefiningCategory( homotopy_category ) ) then
      underlying_category := UnderlyingCategory( DefiningCategory( homotopy_category ) );
      if IsAlgebroid( underlying_category ) then
        TryNextMethod( );
      fi;
    fi;
    
    if IsCategoryOfGradedRows( category ) and IsQuiverRowsCategory( DefiningCategory( homotopy_category ) ) then
      TryNextMethod( );
    fi;
    
    if IsCategoryOfGradedRows( category ) and IsAdditiveClosureCategory( DefiningCategory( homotopy_category ) ) then
      underlying_category := UnderlyingCategory( DefiningCategory( homotopy_category ) );
      if IsAlgebroid( underlying_category ) then
        TryNextMethod( );
      fi;
    fi;
    
    underlying_category := UnderlyingCategory( homotopy_category );
    
    I := FindSomeFunctor( category, underlying_category );
    
    J := ProjectionFunctor( homotopy_category );
    
    return PreCompose( I, J );
    
end );

#############################################################
#
# Convenience methods to
#   * Freyd categories
#   * Category of graded rows
#   * Graded left presentations
#
############################################################

##
InstallMethod( FindSomeFunctor,
          [ IsCategoryOfGradedRows, IsFreydCategory ],
  function( rows, freyd_category )
    
    if IsIdenticalObj( rows, UnderlyingCategory( freyd_category ) ) then
      return EmbeddingFunctorIntoFreydCategory( rows );
    else
      TryNextMethod( );
    fi;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsFreydCategory ],
  function( category, freyd_category )
    local S;
    
    if IsIdenticalObj( category, freyd_category ) then
      
      return IdentityFunctor( category );
      
    fi;
   
    if IsBound( category!.ring_for_representation_category ) then
      
      S := category!.ring_for_representation_category;
      
      if not IsIdenticalObj( S, UnderlyingGradedRing( UnderlyingCategory( freyd_category ) ) ) then
        TryNextMethod( );
      fi;
      
      return EquivalenceFromGradedLeftPresentationsOntoFreydCategoryOfGradedRows( S );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsFreydCategory, IsCapCategory ],
  function( freyd_category, category )
    local S;
    
    if IsIdenticalObj( category, freyd_category ) then
      
      return IdentityFunctor( category );
      
    fi;
   
    if IsBound( category!.ring_for_representation_category ) then
      
      S := category!.ring_for_representation_category;
      
      if not IsIdenticalObj( S, UnderlyingGradedRing( UnderlyingCategory( freyd_category ) ) ) then
        TryNextMethod( );
      fi;
      
      return EquivalenceFromFreydCategoryOfGradedRowsOntoGradedLeftPresentations( S );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( FindSomeFunctor,
          [ IsCategoryOfGradedRows, IsCapCategory ],
  function( graded_rows, category )
    local S, freyd_category;
    
    if IsIdenticalObj( category, graded_rows ) then
      
      return IdentityFunctor( category );
      
    fi;
   
    if IsBound( category!.ring_for_representation_category ) then
      
      S := category!.ring_for_representation_category;
      
      if not IsIdenticalObj( S, UnderlyingGradedRing( graded_rows ) ) then
        TryNextMethod( );
      fi;
      
      freyd_category := FreydCategory( graded_rows );
      
      return PreCompose( FindSomeFunctor( graded_rows, freyd_category ), FindSomeFunctor( freyd_category, category ) );
      
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( \/,
          [ IsList, IsCategoryOfGradedRows ],
  function( l, rows )
    
    if not IsEmpty( l ) and IsCapCategoryCell( l[ 1 ] ) then
        TryNextMethod( );
    else
        return GradedRow( l, UnderlyingGradedRing( rows ) );
    fi;
    
end );

##
InstallMethod( \/,
          [ IsList , IsCategoryOfGradedRows ],
  function( l, rows )
    
    if IsEmpty( l ) or IsCapCategoryCell( l[ 1 ] ) or IsList( l[ 1 ] ) then
      TryNextMethod( );
    fi;
    
    return GradedRow( [ [ l, 1 ] ], UnderlyingGradedRing( rows ) );
    
end );

##
InstallMethod( \/,
          [ IsGradedLeftPresentation, IsCategoryOfGradedRows ],
  function( o, graded_rows )
    local S, degrees;
    
    if not NrRows( UnderlyingMatrix( o ) ) = 0 then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    S := UnderlyingHomalgRing( o );
    
    if not IsIdenticalObj( S, UnderlyingGradedRing( graded_rows ) ) then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    degrees := GeneratorDegrees( o );
    
    degrees := List( degrees, d -> [ -d, 1 ] );
    
    return GradedRow( degrees, S );
   
end );

##
InstallMethod( \/,
          [ IsGradedLeftPresentationMorphism, IsCategoryOfGradedRows ],
  function( alpha, graded_rows )
    local s, r;
    
    s := Source( alpha ) / graded_rows;
    
    r := Range( alpha ) / graded_rows;
    
    return GradedRowOrColumnMorphism( s, UnderlyingMatrix( alpha ), r );
    
end );

##
InstallMethod( \/,
          [ IsFreydCategoryObject, IsCategoryOfGradedRows ],
          
  function( o, graded_rows )
    local m;
    
    if not IsIdenticalObj( graded_rows, UnderlyingCategory( CapCategory( o ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    m := RelationMorphism( o );
    
    if not Rank( Source( m ) ) = 0 then
      
      Error( "Wrong input!\n" );
      
    fi;
    
    return Range( m );
    
end );

##
InstallMethod( \/,
          [ IsFreydCategoryMorphism, IsCategoryOfGradedRows ],
          
  function( alpha, graded_rows )
    local s;
    
    if not IsIdenticalObj( graded_rows, UnderlyingCategory( CapCategory( alpha ) ) ) then
      
      TryNextMethod( );
      
    fi;
    
    # to make sure the morphism is well-defined
    s := Source( alpha ) / graded_rows;
    
    s := Range( alpha ) / graded_rows;
    
    return MorphismDatum( alpha );
    
end );

##############################################
#
# Convenience methods to Derived Categories
#
##############################################

##
InstallMethod( FindSomeFunctor,
          [ IsCapCategory, IsDerivedCategory ],
  function( category, derived_category )
    local defining_category, homotopy_category, I;
    
    defining_category := DefiningCategory( derived_category );
    
    homotopy_category := HomotopyCategory( defining_category );
    
    I := FindSomeFunctor( category, homotopy_category );
    
    return PreCompose( I, LocalizationFunctor( homotopy_category ) );
    
end );

