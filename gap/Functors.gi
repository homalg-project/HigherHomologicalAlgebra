#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
InstallOtherMethod( HomologyFunctorOp,
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, Hn, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  Hn := HomologyFunctor( complex_cat, n );
  
  name := Concatenation( String( n ), "-th homology functor" );
  
  functor := CapFunctor( name, homotopy_category, cat );
  
  AddObjectFunction( functor, 
    
    function( complex )
      
      return ApplyFunctor( Hn, UnderlyingCell( complex ) );
      
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( Hn, UnderlyingCell( map ) );
      
  end );
  
  return functor;
  
end );

##
InstallMethod( ShiftFunctorOp, 
          [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, T, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  T := ShiftFunctor( complex_cat, n );
  
  name := Concatenation( "Shift by ", String( n ), " autoequivalence on " );
  
  if n = 0 then
    
    return IdentityFunctor( homotopy_category );
    
  fi;
  
  functor := CapFunctor( name, homotopy_category, homotopy_category );
  
  AddObjectFunction( functor,
    
    function( complex )
      
      return ApplyFunctor( T, UnderlyingCell( complex ) ) / homotopy_category;
      
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( T, UnderlyingCell( map ) ) / homotopy_category;
      
  end );
  
  return functor;
  
end );

##
InstallMethod( UnsignedShiftFunctorOp,
          [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, T, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  T := UnsignedShiftFunctor( complex_cat, n );
  
  name := Concatenation( "Unsigned Shift by ", String( n ), " autoequivalence on " );
  
  functor := CapFunctor( name, homotopy_category, homotopy_category );
  
  AddObjectFunction( functor, 
  
  function( complex )
    
    return ApplyFunctor( T, UnderlyingCell( complex ) ) / homotopy_category;
    
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( T, UnderlyingCell( map ) ) / homotopy_category;
      
  end );
  
  return functor;
  
end );

##
InstallMethod( InclusionFunctorInHomotopyCategory,
          [ IsCapCategory ],
  function( cat )
    local homotopy_cat, chains_cat, name, inc;
    
    if not ( HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) ) then
      Error( "The argument should be at least additive category" );
    fi;
    
    homotopy_cat := HomotopyCategory( cat );
    
    chains_cat := ChainComplexCategory( cat );
    
    name := "Inclusion functor in homotopy category";
    
    inc := CapFunctor( name, cat, homotopy_cat );
    
    AddObjectFunction( inc,
      o -> o/chains_cat/homotopy_cat );
    
    AddMorphismFunction( inc,
      { s, alpha, r } -> alpha/chains_cat/homotopy_cat );
    
    return inc;
    
end );

##
InstallMethod( EquivalenceIntoFullSubcategoryGeneratedByObjectsConcentratedInDegreeOp,
          [ IsHomotopyCategory, IsInt ],
  function( homotopy_cat, i )
    local C, I, full;
    
    C := DefiningCategory( homotopy_cat );
    
    I := InclusionFunctorInHomotopyCategory( C );
    
    full := FullSubcategoryGeneratedByObjectsConcentratedInDegree( homotopy_cat, i );
    
    return ValueGlobal( "RestrictFunctorToFullSubcategoryOfRange" )( I, full );
    
end );

##
InstallMethod( ExtendFunctorToHomotopyCategories,
               [ IsCapFunctor ],
  function( F )
    local S, T, ChF, name, functor;
    
    S := HomotopyCategory( AsCapCategory( Source( F ) ) );
    
    T := HomotopyCategory( AsCapCategory(  Range( F ) ) );
    
    ChF := ExtendFunctorToChainComplexCategories( F );
    
    name := ValueOption( "name_for_functor" );
    
    if name = fail then
      
      name := "Extension of a functor to homotopy categories";
      
    fi;
    
    functor := CapFunctor( name, S, T );
    
    AddObjectFunction( functor,
      function( C )
        
        return ApplyFunctor( ChF, UnderlyingCell( C ) ) / T;
        
      end );
    
    AddMorphismFunction( functor,
      function( new_source, phi, new_range ) 
        
        return ApplyFunctor( ChF, UnderlyingCell( phi ) ) / T;
        
      end );
      
    return functor;
    
end );

##
InstallMethod( ExtendProductFunctorToHomotopyCategories,
          [ IsCapFunctor ],
  function( F )
    local source, cat_1, cat_2, range, ChF, homotopy_cat_1, homotopy_cat_2, homotopy_cat_1_cat_2, homotopy_range, name, U;
    
    source := AsCapCategory( Source( F ) );
    
    cat_1 := Components( source )[ 1 ];
    
    cat_2 := Components( source )[ 2 ];
    
    range := AsCapCategory( Range( F ) );
    
    ChF := ExtendProductFunctorToChainComplexCategoryProductFunctor( F );
    
    homotopy_cat_1 := HomotopyCategory( cat_1 );
    
    homotopy_cat_2 := HomotopyCategory( cat_2 );
    
    homotopy_cat_1_cat_2 := Product( homotopy_cat_1, homotopy_cat_2 );
     
    homotopy_range := HomotopyCategory( range );
    
    name := "Extension of product functor to homotopy categories";
    
    U := CapFunctor( name, homotopy_cat_1_cat_2, homotopy_range );
    
    AddObjectFunction( U,
      function( C_x_D )
        local C, D;
        
        C := UnderlyingCell( Components( C_x_D )[ 1 ] );
        
        D := UnderlyingCell( Components( C_x_D )[ 2 ] );
        
        return ApplyFunctor( ChF, Product( C, D ) ) / homotopy_range;
        
    end );
    
    AddObjectFunction( U,
      function( S, phi_x_psi, R )
        local phi, psi;
        
        phi := UnderlyingCell( Components( phi_x_psi )[ 1 ] );
        
        psi := UnderlyingCell( Components( phi_x_psi )[ 2 ] );
        
        return ApplyFunctor( ChF, Product( phi, psi ) ) / homotopy_range;
        
    end );
   
   return U;
   
end );

##
InstallMethod( ExtendNaturalTransformationToHomotopyCategories,
          [ IsCapNaturalTransformation ],
  function( eta )
    local F, G, homotopy_cat, HF, HG, C_eta, r1, r2, name, H_eta;
    
    F := Source( eta );
    
    G := Range( eta );
    
    homotopy_cat := HomotopyCategory( AsCapCategory( Range( G ) ) );
    
    HF := ExtendFunctorToHomotopyCategories( F );
    
    HG := ExtendFunctorToHomotopyCategories( G );
    
    C_eta := ExtendNaturalTransformationToChainComplexCategories( eta );
    
    r1 := RandomBoldTextColor( );
    
    r2 := RandomTextColor( );
    
    name := Concatenation( r2[ 1 ], "Extention of natural transformation ( ", r2[ 2 ], Name( eta ), " ", r2[ 1 ], ") ",
              r1[ 1 ], ":", r1[ 2 ], " ", Name( HF ), " ", r1[ 1 ], "===>", r1[ 2 ], " ", Name( HG ) );
    
    H_eta := NaturalTransformation( name, HF, HG );
    
    AddNaturalTransformationFunction( H_eta,
      function( HF_a, a, HG_a )
        
        return ApplyNaturalTransformation( C_eta, UnderlyingCell( a ) ) / homotopy_cat;
      
    end );
    
    return H_eta;
    
end );

##
InstallMethod( LocalizationFunctorByProjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, projs, homotopy_category_projs, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then
      
      Error( "The input should be abelian with computable enough projective objects!\n" );
      
    fi;
    
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    homotopy_category_projs := HomotopyCategory( projs );
    
    name := "Localization functor by projective objects";
    
    F := CapFunctor( name, homotopy_category, homotopy_category_projs );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := ProjectiveResolution( UnderlyingCell( a ), true );
        
        p := AsComplexOverCapFullSubcategory( projs, p );
        
        return p / homotopy_category_projs;
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenProjectiveResolutions( UnderlyingCell( phi ), true );
        
        psi := AsChainMorphismOverCapFullSubcategory( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
        return psi / homotopy_category_projs;
        
    end );
    
    return F;
    
end );

##
InstallOtherMethod( LocalizationFunctorByProjectiveObjects,
              [ IsCapCategory and IsAbelianCategory ],
  function( C )
    local Ho_C, I, L;
    
    Ho_C := HomotopyCategory( C );
    
    I := InclusionFunctorInHomotopyCategory( C );
    
    L := LocalizationFunctorByProjectiveObjects( Ho_C );
    
    I := PreCompose( I, L );
    
    I!.Name := "Embedding of an abelian category in homotopy category of the additive full subcategory generated by projective objects";
    
    return I;
    
end );

##
InstallMethod( LocalizationFunctorByInjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, injs, homotopy_category_injs, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The input should be abelian with computable enough injective objects!\n" );
      
    fi;
    
    injs := ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat );
    
    homotopy_category_injs := HomotopyCategory( injs );
    
    name := "Localization functor by injective objects";
    
    F := CapFunctor( name, homotopy_category, homotopy_category_injs );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := InjectiveResolution( UnderlyingCell( a ), true );
        
        p := AsComplexOverCapFullSubcategory( injs, p );
        
        return p / homotopy_category_injs;
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenInjectiveResolutions( UnderlyingCell( phi ), true );
        
        psi := AsChainMorphismOverCapFullSubcategory( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
        return psi / homotopy_category_injs;
        
    end );
    
    return F;
    
end );

##
InstallOtherMethod( LocalizationFunctorByInjectiveObjects,
              [ IsCapCategory and IsAbelianCategory ],
  function( C )
    local Ho_C, I, L;
    
    Ho_C := HomotopyCategory( C );
    
    I := InclusionFunctorInHomotopyCategory( C );
    
    L := LocalizationFunctorByInjectiveObjects( Ho_C );
    
    I := PreCompose( I, L );
    
    I!.Name := "Embedding of an abelian category in homotopy category of the additive full subcategory generated by injective objects";
    
    return I;
    
end );

