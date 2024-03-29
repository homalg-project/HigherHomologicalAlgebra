# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
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
InstallOtherMethod( CohomologyFunctorOp,
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, Hn, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := CochainComplexCategory( cat );
  
  Hn := CohomologyFunctor( complex_cat, n );
  
  name := Concatenation( String( n ), "-th cohomology functor" );
  
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
  
  complex_cat := UnderlyingCategory( homotopy_category );
  
  T := ShiftFunctor( complex_cat, n );
  
  name := Concatenation( "Shift by ", String( n ), " autoequivalence" );
  
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
  
  complex_cat := UnderlyingCategory( homotopy_category );
  
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
InstallMethod( EmbeddingFunctorInHomotopyCategory,
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
    
    I := EmbeddingFunctorInHomotopyCategory( C );
    
    full := FullSubcategoryGeneratedByObjectsConcentratedInDegree( homotopy_cat, i );
    
    return ValueGlobal( "RestrictFunctorToFullSubcategoryOfRange" )( I, full );
    
end );

##
InstallMethod( ExtendFunctorToHomotopyCategoriesOp,
               [ IsCapFunctor, IsBool ],
  function( F, over_cochains )
    local S, T, ChF, name, sigma_S, sigma_T, F_o_sigma_S, sigma_T_o_F, eta;
    
    S := HomotopyCategory( AsCapCategory( Source( F ) ), over_cochains );
    
    T := HomotopyCategory( AsCapCategory(  Range( F ) ), over_cochains );
    
    if over_cochains then
      
      ChF := ExtendFunctorToCochainComplexCategories( F );
      
    else
      
      ChF := ExtendFunctorToChainComplexCategories( F );
      
    fi;
    
    name := ValueOption( "name_for_functor" );
    
    if name = fail then
      
      name := Concatenation(
                "Extension of ( ",
                Name( F ),
                " ) to homotopy categories"
              );
      
    fi;
    
    F := CapFunctor( name, S, T );
    
    AddObjectFunction( F,
      function( C )
        
        return ApplyFunctor( ChF, UnderlyingCell( C ) ) / T;
        
      end );
    
    AddMorphismFunction( F,
      function( new_source, phi, new_range ) 
        
        return ApplyFunctor( ChF, UnderlyingCell( phi ) ) / T;
        
      end );
      
    sigma_S := ShiftFunctor( S );
    
    sigma_T := ShiftFunctor( T );
    
    F_o_sigma_S := PostCompose( F, sigma_S );
    
    sigma_T_o_F := PostCompose( sigma_T, F );
    
    name := "Natural isomorphism F o Σ => Σ o F";
    
    eta := NaturalTransformation( name, F_o_sigma_S, sigma_T_o_F );
    
    AddNaturalTransformationFunction( eta,
      { F_o_sigma_S_a, a, sigma_T_o_F_a } -> IdentityMorphism( F_o_sigma_S_a )
    );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( F, eta );
    
    return F;
    
end );

##
InstallMethod( ExtendFunctorToHomotopyCategoriesAttr,
          [ IsCapFunctor ],
  F -> ExtendFunctorToHomotopyCategories( F, false )
);

##
InstallOtherMethod( ExtendFunctorToHomotopyCategories,
          [ IsCapFunctor ],
    ExtendFunctorToHomotopyCategoriesAttr
);

##
BindGlobal( "ExtendFunctorToHomotopyCategoriesByChains",
  F -> ExtendFunctorToHomotopyCategories( F, false )
);

##
BindGlobal( "ExtendFunctorToHomotopyCategoriesByCochains",
  F -> ExtendFunctorToHomotopyCategories( F, true )
);


##
InstallMethod( ExtendFunctorFromProductCategoryToHomotopyCategories,
          [ IsCapFunctor ],
  function( F )
    local source, cat_1, cat_2, range, ChF, source_ChF, homotopy_cat_1, homotopy_cat_2, homotopy_cat_1_cat_2, homotopy_range, name, U;
    
    source := AsCapCategory( Source( F ) );
    
    cat_1 := Components( source )[ 1 ];
    
    cat_2 := Components( source )[ 2 ];
    
    range := AsCapCategory( Range( F ) );
    
    ChF := ExtendFunctorFromProductCategoryToChainComplexCategories( F );
    
    source_ChF := AsCapCategory( Source( ChF ) );
    
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
        
        return ApplyFunctor( ChF, [ C, D ] / source_ChF ) / homotopy_range;
        
    end );
    
    AddMorphismFunction( U,
      function( S, phi_x_psi, R )
        local phi, psi;
        
        phi := UnderlyingCell( Components( phi_x_psi )[ 1 ] );
        
        psi := UnderlyingCell( Components( phi_x_psi )[ 2 ] );
        
        return ApplyFunctor( ChF, [ phi, psi ] / source_ChF ) / homotopy_range;
        
    end );
   
   return U;
   
end );

##
InstallMethod( ExtendNaturalTransformationToHomotopyCategoriesOp,
          [ IsCapNaturalTransformation, IsBool ],
  function( eta, over_cochains )
    local F, G, homotopy_cat, HF, HG, C_eta, r1, r2, name, H_eta;
    
    F := Source( eta );
    
    G := Range( eta );
    
    homotopy_cat := HomotopyCategory( AsCapCategory( Range( G ) ), over_cochains );
    
    HF := ExtendFunctorToHomotopyCategories( F, over_cochains );
    
    HG := ExtendFunctorToHomotopyCategories( G, over_cochains );
    
    if over_cochains = false then
      C_eta := ExtendNaturalTransformationToChainComplexCategories( eta );
    else
      C_eta := ExtendNaturalTransformationToCochainComplexCategories( eta );
    fi;
    
    r1 := RandomBoldTextColor( );
    
    r2 := RandomTextColor( "" );
    
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
InstallMethod( ExtendNaturalTransformationToHomotopyCategoriesByChain,
          [ IsCapNaturalTransformation ],
          
  eta -> ExtendNaturalTransformationToHomotopyCategories( eta, false )
);

##
InstallMethod( ExtendNaturalTransformationToHomotopyCategoriesByCochains,
          [ IsCapNaturalTransformation ],
          
  eta -> ExtendNaturalTransformationToHomotopyCategories( eta, true )
);

##
InstallMethod( LocalizationFunctorByProjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, projs, homotopy_category_projs, oper, name, F, sigma_S, sigma_T, F_o_sigma_S, sigma_T_o_F, eta, epsilon, epsilon_m1;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then
      
      Error( "The defining category should be abelian with computable enough projective objects!\n" );
      
    fi;
    
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      homotopy_category_projs := HomotopyCategory( projs, false );
      
      oper := AsChainMorphismOverCapFullSubcategory;
      
    else
      
      homotopy_category_projs := HomotopyCategory( projs, true );
      
      oper := AsCochainMorphismOverCapFullSubcategory;
      
    fi;
    
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
        
        psi := oper( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
        return psi / homotopy_category_projs;
        
    end );
    
    sigma_S := ShiftFunctor( homotopy_category );
    
    sigma_T := ShiftFunctor( homotopy_category_projs );
    
    F_o_sigma_S := PostCompose( F, sigma_S );
    
    sigma_T_o_F := PostCompose( sigma_T, F );
    
    name := "Natural isomorphism F o Σ => Σ o F";
    
    eta := NaturalTransformation( name, F_o_sigma_S, sigma_T_o_F );
    
    epsilon := NaturalIsomorphismFromIdentityIntoMinusOneFunctor( homotopy_category );
    
    epsilon_m1 := NaturalIsomorphismFromMinusOneFunctorIntoIdentity( homotopy_category_projs );
    
    AddNaturalTransformationFunction( eta,
      { F_o_sigma_S_a, a, sigma_T_o_F_a } -> PreCompose( F( epsilon( Shift( a ) ) ), epsilon_m1( Shift( F( a ) ) ) )
    );
    
    SetCommutativityNaturalTransformationWithShiftFunctor( F, eta );
    
    return F;
    
end );

functor :=
  [
    IsHomotopyCategory,
    IsHomotopyCategory,
    function( homotopy_cat, homotopy_cat_projs )
      local cat, projs;
      cat := DefiningCategory( homotopy_cat );
      projs := DefiningCategory( homotopy_cat_projs );
      if not ValueGlobal( "HasFullSubcategoryGeneratedByProjectiveObjects" )( cat ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat ) ) then
        return false;
      fi;
      return true;
    end,
    { homotopy_cat, homotopy_cat_projs } -> LocalizationFunctorByProjectiveObjects( homotopy_cat ),
    "Localization functor by projective objects",
    "Localization functor from homotopy category onto homotopy category of full subcategory of projectives"
  ];
  
AddFunctor( functor );

##
InstallOtherMethod( LocalizationFunctorByProjectiveObjects,
              [ IsCapCategory and IsAbelianCategory ],
  function( C )
    local Ho_C, I, L;
    
    Ho_C := HomotopyCategory( C );
    
    I := EmbeddingFunctorInHomotopyCategory( C );
    
    L := LocalizationFunctorByProjectiveObjects( Ho_C );
    
    I := PreCompose( I, L );
    
    I!.Name := "Embedding of an abelian category in homotopy category of the additive full subcategory generated by projective objects";
    
    return I;
    
end );

functor :=
  [
    IsHomotopyCategory,
    IsHomotopyCategory,
    function( homotopy_cat, homotopy_cat_projs )
      local cat, projs;
      
      cat := DefiningCategory( homotopy_cat );
      projs := DefiningCategory( homotopy_cat_projs );
      if not ValueGlobal( "HasFullSubcategoryGeneratedByInjectiveObjects" )( cat ) then
        return false;
      fi;
      if not IsIdenticalObj( projs, ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat ) ) then
        return false;
      fi;
      return true;
    end,
    { homotopy_cat, homotopy_cat_projs } -> LocalizationFunctorByInjectiveObjects( homotopy_cat ),
    "Localization functor by injective objects",
    "Localization functor from homotopy category onto homotopy category of full subcategory of injectives"
  ];
  
AddFunctor( functor );

##
InstallMethod( LocalizationFunctorByInjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, injs, homotopy_category_injs, oper, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The input should be abelian with computable enough injective objects!\n" );
      
    fi;
    
    injs := ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      homotopy_category_injs := HomotopyCategory( injs, false );
      
      oper := AsChainMorphismOverCapFullSubcategory;
      
    else
      
      homotopy_category_injs := HomotopyCategory( injs, true );
      
      oper := AsCochainMorphismOverCapFullSubcategory;
      
    fi;
    
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
        
        psi := oper( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
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
    
    I := EmbeddingFunctorInHomotopyCategory( C );
    
    L := LocalizationFunctorByInjectiveObjects( Ho_C );
    
    I := PreCompose( I, L );
    
    I!.Name := "Embedding of an abelian category in homotopy category of the additive full subcategory generated by injective objects";
    
    return I;
    
end );

##
InstallMethod( MinusOneFunctor,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local complex_cat, F, H;
    
    complex_cat := UnderlyingCategory( homotopy_category );
    
    F := MinusOneFunctor( complex_cat );
    
    H := CapFunctor( Name( F ), homotopy_category, homotopy_category );
    
    AddObjectFunction( H,
      a -> ApplyFunctor( F, UnderlyingCell( a ) ) / homotopy_category
    );
    
    AddMorphismFunction( H,
      { s, alpha, r } -> ApplyFunctor( F, UnderlyingCell( alpha ) ) / homotopy_category
    );
    
    return H;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityIntoMinusOneFunctor,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local complex_cat, eta, Id, F, name, nat;
    
    complex_cat := UnderlyingCategory( homotopy_category );
    
    eta := NaturalIsomorphismFromIdentityIntoMinusOneFunctor( complex_cat );
    
    Id := IdentityFunctor( homotopy_category );
    
    F := MinusOneFunctor( homotopy_category );
    
    name := "Natural isomorphism: Id => ⊝ ";
    
    nat := NaturalTransformation( name, Id, F );
    
    AddNaturalTransformationFunction( nat,
      { s, a, r } -> ApplyNaturalTransformation( eta, UnderlyingCell( a ) ) / homotopy_category
    );
    
    return nat;
    
end );

##
InstallMethod( NaturalIsomorphismFromMinusOneFunctorIntoIdentity,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local complex_cat, eta, Id, F, name, nat;
    
    complex_cat := UnderlyingCategory( homotopy_category );
    
    eta := NaturalIsomorphismFromMinusOneFunctorIntoIdentity( complex_cat );
    
    Id := IdentityFunctor( homotopy_category );
    
    F := MinusOneFunctor( homotopy_category );
    
    name := "Natural isomorphism: ⊝  => Id";
    
    nat := NaturalTransformation( name, F, Id );
    
    AddNaturalTransformationFunction( nat,
      { s, a, r } -> ApplyNaturalTransformation( eta, UnderlyingCell( a ) ) / homotopy_category
    );
    
    return nat;
    
end );

##
InstallMethod( EquivalenceFromHomotopyCategoryByCochainComplexes,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, source_category, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      source_category := HomotopyCategory( cat, true );
      
    else
      
      return IdentityFunctor( homotopy_category );
      
    fi;
    
    F := CapFunctor( "homotopy category by cochains -> homotopy category by chains", source_category, homotopy_category );
    
    AddObjectFunction( F, AsChainComplex );
    
    AddMorphismFunction( F, AsChainMorphism );
    
    return F;
    
end );

##
InstallMethod( EquivalenceOntoHomotopyCategoryByCochainComplexes,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, range_category, homotopy_category_, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      range_category := HomotopyCategory( cat, true );
      
    else
      
      return IdentityFunctor( homotopy_category );
      
    fi;
    
    F := CapFunctor( "homotopy category by chains -> homotopy category by cochains", homotopy_category, range_category );
    
    AddObjectFunction( F, AsCochainComplex );
    
    AddMorphismFunction( F, AsCochainMorphism );
    
    return F;
    
end );

##
InstallMethod( EquivalenceFromHomotopyCategoryByChainComplexes,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat;
    
    cat := DefiningCategory( homotopy_category );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      return IdentityFunctor( homotopy_category );
      
    else
      
      return EquivalenceOntoHomotopyCategoryByCochainComplexes( HomotopyCategory( cat ) );
      
    fi;
    
end );

##
InstallMethod( EquivalenceOntoHomotopyCategoryByChainComplexes,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat;
    
    cat := DefiningCategory( homotopy_category );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      return IdentityFunctor( homotopy_category );
      
    else
      
      return EquivalenceFromHomotopyCategoryByCochainComplexes( HomotopyCategory( cat ) );
      
    fi;
    
end );

##
InstallMethod( ExtendFunctorMethodToHomotopyCategories,
          [ IsDenseList ],
          
  function( E )
    
    ExtendFunctorMethod(
      E,
      category -> IsHomotopyCategory( category ) and IsChainComplexCategory( UnderlyingCategory( category ) ),
      DefiningCategory,
      functor -> ExtendFunctorToHomotopyCategories( functor, false ),
      "ExtendFunctorToHomotopyCategoriesByChains"
    );
    
    ExtendFunctorMethod(
      E,
      category -> IsHomotopyCategory( category ) and IsCochainComplexesCategory( UnderlyingCategory( category ) ),
      DefiningCategory,
      functor -> ExtendFunctorToHomotopyCategories( functor, true ),
      "ExtendFunctorToHomotopyCategoriesByCochains"
    );
    
end );
