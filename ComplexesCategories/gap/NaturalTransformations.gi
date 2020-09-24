#
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##
BindGlobal( "EXTEND_NAT_TRANS_TO_COMPLEX_CAT",
  function( eta, chain_or_cochain )
    local F, G, CF, CG, name, c_eta;
    
    F := Source( eta );
    
    G := Range( eta );
    
    if chain_or_cochain = "chain" then
      
      CF := ExtendFunctorToChainComplexCategories( F );
      
      CG := ExtendFunctorToChainComplexCategories( G );
      
    else
      
      CF := ExtendFunctorToCochainComplexCategories( F );
      
      CG := ExtendFunctorToCochainComplexCategories( G );
    
    fi;
    
    name := Concatenation( "Extention of ", Name( eta ), " to ", chain_or_cochain, " complexes" );
    
    c_eta := NaturalTransformation( name, CF, CG );
    
    AddNaturalTransformationFunction( c_eta,
      function( CF_C, C, CG_C )
        local maps;
        
        maps := ApplyMap( Objects( C ), o -> ApplyNaturalTransformation( eta, o ) );
        
        return CHAIN_OR_COCHAIN_MORPHISM_BY_Z_FUNCTION( CF_C, CG_C, maps );
        
    end );
    
    return c_eta;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityIntoMinusOneFunctor,
          [ IsChainOrCochainComplexCategory ],
  function( complexes )
    local morphism_constructor, Id, F, name, nat;
    
    if IsChainComplexCategory( complexes ) then
      
      morphism_constructor := ChainMorphism;
      
    else
      
      morphism_constructor := CochainMorphism;
      
    fi;
    
    Id := IdentityFunctor( complexes );
    
    F := MinusOneFunctor( complexes );
    
    name := "Natural isomorphism: Id => ⊝ ";
    
    nat := NaturalTransformation( name, Id, F );
    
    AddNaturalTransformationFunction( nat,
      function( s, C, r )
        local maps;
        
        maps := AsZFunction(
                  function( i )
                    if i mod 2 = 1 then
                      return IdentityMorphism( C[ i ] );
                    else
                      return AdditiveInverse( IdentityMorphism( C[ i ] ) );
                    fi;
                  end );
        
        return morphism_constructor( s, r, maps );
        
    end );
    
    return nat;
    
end );


##
InstallMethod( NaturalIsomorphismFromMinusOneFunctorIntoIdentity,
          [ IsChainOrCochainComplexCategory ],
  function( complexes )
    local morphism_constructor, Id, F, name, nat;
    
    if IsChainComplexCategory( complexes ) then
      
      morphism_constructor := ChainMorphism;
      
    else
      
      morphism_constructor := CochainMorphism;
      
    fi;
    
    Id := IdentityFunctor( complexes );
    
    F := MinusOneFunctor( complexes );
    
    name := "Natural isomorphism: ⊝  => Id";
    
    nat := NaturalTransformation( name, F, Id );
    
    AddNaturalTransformationFunction( nat,
      function( s, C, r )
        local maps;
        
        maps := AsZFunction(
                  function( i )
                    if i mod 2 = 1 then
                      return IdentityMorphism( C[ i ] );
                    else
                      return AdditiveInverse( IdentityMorphism( C[ i ] ) );
                    fi;
                  end );
        
        return morphism_constructor( s, r, maps );
        
    end );
    
    return nat;
    
end );


##
InstallMethod( ExtendNaturalTransformationToChainComplexCategories,
          [ IsCapNaturalTransformation ],
      eta -> EXTEND_NAT_TRANS_TO_COMPLEX_CAT( eta, "chain" ) );

##
InstallMethod( ExtendNaturalTransformationToCochainComplexCategories,
          [ IsCapNaturalTransformation ],
      eta -> EXTEND_NAT_TRANS_TO_COMPLEX_CAT( eta, "cochain" ) );

