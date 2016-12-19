

# There are still a lot of things to do in this code!
BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY",

  function( cat, shift_index )
  local name, complex_cat, complex_constructor, morphism_constructor, finite_com_constructor, addition_for_morphisms;
  if shift_index = -1 then 

     name := Concatenation( "Chain complexes category over ", Name( cat ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsChainComplexCategory );

     complex_constructor := ChainComplex;
     
     finite_com_constructor := FiniteChainComplex;

     morphism_constructor := ChainMorphism;

  elif shift_index = 1 then

     name := Concatenation( "Cochain complexes category over ", Name( cat ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsCochainComplexCategory );

     complex_constructor := CochainComplex;

     finite_com_constructor := FiniteCochainComplex;

     morphism_constructor := CochainMorphism;

  fi;

  if IsAdditiveCategory( cat ) then 

     SetIsAdditiveCategory( complex_cat, true );

     AddZeroObject( complex_cat, function( )

                                 return finite_com_constructor( [ ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) ) ], 0 );

                                 end );

     AddZeroMorphism( complex_cat, function( C1, C2 )
                                   local morphisms;

                                   morphisms := MapLazy( [ Objects( C1 ), Objects( C2 ) ], ZeroMorphism );

                                   return morphism_constructor( C1, C2, morphisms );

                                   end );

     addition_for_morphisms := function( m1, m2 )

                                 return morphism_constructor( Source( m1 ), Range( m1 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], AdditionForMorphisms ) );

                               end;

     AddAdditionForMorphisms( complex_cat, addition_for_morphisms );

  fi;

  if IsAbelianCategory( cat ) then

     SetIsAbelianCategory( complex_cat, true );

  fi;

SetUnderlyingCategory( complex_cat, cat );

return complex_cat;

end );

#########################################
#
#  Constructors of (Co)complexes category
#
#########################################

InstallMethod( ChainComplexCategory, 
                 [ IsCapCategory ],
  function( cat )
  return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, -1 );
end );

InstallMethod( CochainComplexCategory, 
                 [ IsCapCategory ],
  function( cat )
  return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, 1 );
end );
