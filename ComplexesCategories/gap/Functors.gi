# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##
BindGlobal( "_complexes_InclusionFunctorIntoComplexesCategory",
  
  function( cat, over_cochains )
    local ch_cat, F;
    
    if over_cochains = true then
      ch_cat := ComplexesCategoryByCochains( cat );
    else
      ch_cat := ComplexesCategoryByChains( cat );
    fi;
    
    F := CapFunctor( "The natural inclusion functor", cat, ch_cat );
    
    AddObjectFunction( F,
      o -> CreateComplex( ch_cat, o, 0 )
    );
    
    AddMorphismFunction( F,
      { S, phi, R } -> CreateComplexMorphism( ch_cat, S, [ phi ], 0, R )
    );
    
    return F;
    
end );

##
InstallMethod( InclusionFunctorIntoComplexesCategoryByCochains,
          [ IsCapCategory ],
  
  cat -> _complexes_InclusionFunctorIntoComplexesCategory( cat, true )
);

##
InstallMethod( InclusionFunctorIntoComplexesCategoryByChains,
          [ IsCapCategory ],
  
  cat -> _complexes_InclusionFunctorIntoComplexesCategory( cat, false )
);

##
BindGlobal( "_complexes_ExtendFunctorToComplexesCategories",
  
  function( S, F, T )
    local name, ch_F;
    
    if ForAll( [ S, T ], IsComplexesCategoryByCochains ) then
        name := "co";
    else
        name := "";
    fi;
    
    ch_F := CapFunctor( Concatenation( "Extension of ( ", Name( F ), " ) to ", name, "chain complexes" ), S, T );
    
    AddObjectFunction( ch_F, C ->
          CreateComplex(
                T,
                ApplyMap( Objects( C ), o -> ApplyFunctor( F, o ) ),
                ApplyMap( Differentials( C ), delta -> ApplyFunctor( F, delta ) ),
                LowerBound( C ),
                UpperBound( C ) ) );
    
    AddMorphismFunction( ch_F,
      { source, phi, range } ->
          CreateComplexMorphism(
                T,
                source,
                ApplyMap( Morphisms( phi ), m -> ApplyFunctor( F, m ) ),
                range ) );
    
    return ch_F;
    
end );

##
InstallMethod( ExtendFunctorToComplexesCategoriesByChains,
          [ IsCapFunctor ],
  F -> _complexes_ExtendFunctorToComplexesCategories(
              ComplexesCategoryByChains( SourceOfFunctor( F ) ),
              F,
              ComplexesCategoryByChains( RangeOfFunctor( F ) ) ) );

##
InstallMethod( ExtendFunctorToComplexesCategoriesByCochains,
          [ IsCapFunctor ],
  F -> _complexes_ExtendFunctorToComplexesCategories(
              ComplexesCategoryByCochains( SourceOfFunctor( F ) ),
              F,
              ComplexesCategoryByCochains( RangeOfFunctor( F ) ) ) );
 
