

# There are still a lot of things to do in this code!
BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY",

  function( cat, shift_index )
  local name, complex_cat, complex_constructor, morphism_constructor, finite_com_constructor;
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

                                   morphisms := MapLazy( [ Objects( C1 ), Objects( C2 ) ], ZeroMorphism, 2 );

                                   return morphism_constructor( C1, C2, morphisms );

                                   end );

     AddAdditionForMorphisms( complex_cat, function( m1, m2 )

                                           return morphism_constructor( Source( m1 ), Range( m1 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], AdditionForMorphisms, 2 ) );

                                           end );

     AddAdditiveInverseForMorphisms( complex_cat, function( m )

                                      return morphism_constructor( Source( m ), Range( m ), MapLazy( Morphisms( m ), AdditiveInverseForMorphisms, 1 ) );

                                      end );

     AddPreCompose( complex_cat, function( m1, m2 )

                                 return morphism_constructor( Source( m1 ), Range( m2 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], PreCompose, 2 ) );

                                 end );
   
     AddIdentityMorphism( complex_cat, function( C )

                                       return morphism_constructor( C, C, MapLazy( Objects( C ), IdentityMorphism, 1 ) );

                                       end );

     AddInverse( complex_cat, function( m )

                              return morphism_constructor( Range( m ), Source( m ), MapLazy( Morphisms( m ), Inverse, 1 ) );

                              end );

     AddLiftAlongMonomorphism( complex_cat, function( mono, test )
                                            local morphisms;

                                            morphisms := MapLazy( [ Morphisms( mono ), Morphisms( test ) ], LiftAlongMonomorphism, 2 );

                                            return morphism_constructor( Source( test ), Source( mono ), morphisms );

                                            end );

     AddColiftAlongEpimorphism( complex_cat, function( epi, test )
                                             local morphisms;

                                             morphisms := MapLazy( [ Morphisms( epi ), Morphisms( test ) ], ColiftAlongEpimorphism, 2 );

                                             return morphism_constructor( Range( epi ), Range( test ), morphisms );

                                             end );

     AddDirectSum( complex_cat, function( L )
                                local diffs;

                                diffs := MapLazy( List( L, Differentials ), DirectSumFunctorial, 1 );

                                return complex_constructor( cat, diffs );

                                end );

     AddInjectionOfCofactorOfDirectSum( complex_cat, function( L, n )
                                          local objects, list, morphisms;

                                          objects := CombineZLazy( List( L, Objects ) );

                                          morphisms := MapLazy( objects, function( l )
                                                                         return InjectionOfCofactorOfDirectSum( l, n );
                                                                         end, 1 );

                                          return morphism_constructor( L[ n ], DirectSum( L ), morphisms );

                                          end );
  fi;

  if IsAbelianCategory( cat ) then

     SetIsAbelianCategory( complex_cat, true );

  fi;


SetUnderlyingCategory( complex_cat, cat );

Finalize( complex_cat );

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


