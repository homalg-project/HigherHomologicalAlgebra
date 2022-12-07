# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##
BindGlobal( "_complexes_ExtendNaturalTransformationToComplexesCategories",
  
  function( chF, eta, chG )
    local name, ch_eta;
    
    if IsChainComplexCategory( SourceOfFunctor( chF ) ) then
      name := "";
    else
      name := "co";
    fi;
    
    name := Concatenation( "Extention of (", Name( eta ), ") to ", name, "chain complexes" );
    
    ch_eta := NaturalTransformation( name, chF, chG );
    
    AddNaturalTransformationFunction( ch_eta,
      { chF_C, C, chG_C } -> CreateComplexMorphism(
                                      chF_C,
                                      chG_C,
                                      ApplyMap( Objects( C ), o -> ApplyNaturalTransformation( eta, o ) ) ) );
    
    return ch_eta;
    
end );

##
InstallMethod( ExtendNaturalTransformationToComplexesCategoriesByChains,
          [ IsCapNaturalTransformation ],
  
  eta -> _complexes_ExtendNaturalTransformationToComplexesCategories(
                      ExtendFunctorToComplexesCategoriesByChains( Source( eta ) ),
                      eta,
                      ExtendFunctorToComplexesCategoriesByChains( Range( eta ) ) )
);

##
InstallMethod( ExtendNaturalTransformationToComplexesCategoriesByCochains,
          [ IsCapNaturalTransformation ],
  
  eta -> _complexes_ExtendNaturalTransformationToComplexesCategories(
                      ExtendFunctorToComplexesCategoriesByCochains( Source( eta ) ),
                      eta,
                      ExtendFunctorToComplexesCategoriesByCochains( Range( eta ) ) )
);

##
#InstallMethod( NaturalIsomorphismFromIdentityIntoMinusOneFunctor,
#          [ IsChainOrCochainComplexCategory ],
#  function( complexes )
#    local morphism_constructor, Id, F, name, nat;
#    
#    if IsChainComplexCategory( complexes ) then
#      
#      morphism_constructor := ChainMorphism;
#      
#    else
#      
#      morphism_constructor := CochainMorphism;
#      
#    fi;
#    
#    Id := IdentityFunctor( complexes );
#    
#    F := MinusOneFunctor( complexes );
#    
#    name := "Natural isomorphism: Id => ⊝ ";
#    
#    nat := NaturalTransformation( name, Id, F );
#    
#    AddNaturalTransformationFunction( nat,
#      function( s, C, r )
#        local maps;
#        
#        maps := AsZFunction(
#                  function( i )
#                    if i mod 2 = 1 then
#                      return IdentityMorphism( C[ i ] );
#                    else
#                      return AdditiveInverse( IdentityMorphism( C[ i ] ) );
#                    fi;
#                  end );
#        
#        return morphism_constructor( s, r, maps );
#        
#    end );
#    
#    return nat;
#    
#end );
#
#
###
#InstallMethod( NaturalIsomorphismFromMinusOneFunctorIntoIdentity,
#          [ IsChainOrCochainComplexCategory ],
#  function( complexes )
#    local morphism_constructor, Id, F, name, nat;
#    
#    if IsChainComplexCategory( complexes ) then
#      
#      morphism_constructor := ChainMorphism;
#      
#    else
#      
#      morphism_constructor := CochainMorphism;
#      
#    fi;
#    
#    Id := IdentityFunctor( complexes );
#    
#    F := MinusOneFunctor( complexes );
#    
#    name := "Natural isomorphism: ⊝  => Id";
#    
#    nat := NaturalTransformation( name, F, Id );
#    
#    AddNaturalTransformationFunction( nat,
#      function( s, C, r )
#        local maps;
#        
#        maps := AsZFunction(
#                  function( i )
#                    if i mod 2 = 1 then
#                      return IdentityMorphism( C[ i ] );
#                    else
#                      return AdditiveInverse( IdentityMorphism( C[ i ] ) );
#                    fi;
#                  end );
#        
#        return morphism_constructor( s, r, maps );
#        
#    end );
#    
#    return nat;
#    
#end );
