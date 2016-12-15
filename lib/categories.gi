

# There are still a lot of things to do in this code!
BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY",

  function( cat, shift_index )

  if shift_index = -1 then 

     name := Concatenation( "Chain complexes category over ", Name( cat ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsChainComplexCategory );

     complex_constructor := ChainComplexByDifferentialList;

#     maps_constructor := ChainMapByMorphismList;

  elif shift_index = 1 then

     name := Concatenation( "Cochain complexes category over ", Name( cat ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsCochainComplexCategory );

     complex_constructor := CochainComplex;

#     maps_constructor := CochainMapByMorphismList;

  fi;

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
