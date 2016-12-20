

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
                                 local C;

                                 C := finite_com_constructor( [ ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) ) ], 0 );

                                 SetUpperBound( C, 0 );

                                 SetLowerBound( C, 0 );

                                 return C;

                                 end );

     AddIsZeroForObjects( complex_cat, function( C )
                                       local obj, i;

                                       if not HasActiveLowerBound( C ) or not HasActiveUpperBound( C ) then 

                                          Error( "The complex must have lower and upper bounds" );

                                       fi;

                                       for obj in C!.ListOfComputedObjects do

                                           if HasIsZero( obj ) and not IsZero( obj ) then 

                                              return false;

                                           fi;

                                       od;

                                       for obj in C!.ListOfComputedObjects do

                                           if not IsZero( obj[ 2 ] ) then

                                              return false;

                                           fi;

                                       od;

                                       for i in [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ] do

                                           if not IsZero( C[ i ] ) then 

                                              SetLowerBound( C, i - 1 );

                                              return false;

                                              Print( i - 1 );

                                           fi;

                                       od;

                                       return true;

                                       end );



     AddZeroMorphism( complex_cat, function( C1, C2 )
                                   local morphisms;

                                   morphisms := MapLazy( [ Objects( C1 ), Objects( C2 ) ], ZeroMorphism, 2 );

                                   return morphism_constructor( C1, C2, morphisms );

                                   end );

     AddIsZeroForMorphisms( complex_cat, function( phi )
                                         local mor, i;

                                       if not HasActiveLowerBound( phi ) or not HasActiveUpperBound( phi ) then

                                          Error( "The morphism must have lower and upper bounds" );

                                       fi;

                                       for mor in phi!.ListOfComputedMorphisms do

                                           if HasIsZero( mor[ 2 ] ) and not IsZero( mor[ 2 ] ) then

                                              return false;

                                           fi;

                                       od;

                                       for mor in phi!.ListOfComputedMorphisms do

                                           if not IsZero( mor[ 2 ] ) then

                                              return false;

                                           fi;

                                       od;

                                       for i in [ ActiveLowerBound( phi ) + 1 .. ActiveUpperBound( phi ) - 1 ] do

                                           if not IsZero( phi[ i ] ) then

                                              SetLowerBound( phi, i - 1 );

                                              return false;

                                           fi;

                                       od;

                                       return true;

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

     AddProjectionInFactorOfDirectSum( complex_cat, function( L, n )
                                          local objects, list, morphisms;

                                          objects := CombineZLazy( List( L, Objects ) );

                                          morphisms := MapLazy( objects, function( l )
                                                                         return ProjectionInFactorOfDirectSum( l, n );
                                                                         end, 1 );

                                          return morphism_constructor( DirectSum( L ), L[ n ], morphisms );

                                          end );

     AddTerminalObject( complex_cat, function( )

                                     return complex_constructor( cat, RepeatListZ( [ TerminalObjectFunctorial( cat ) ] ) );

                                     end );

     AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( complex_cat, function( complex, terminal_object )

                                                                    local objects, universal_maps;

                                                                    objects := Objects( complex );

                                                                    universal_maps := MapLazy( objects,  UniversalMorphismIntoTerminalObject, 1 );

                                                                    return morphism_constructor( complex, terminal_object, universal_maps );

                                                                    end );



     AddInitialObject( complex_cat, function( )

                                return complex_constructor( cat, RepeatListZ( [ InitialObjectFunctorial( cat ) ] ) );

                                end );

     AddUniversalMorphismFromInitialObjectWithGivenInitialObject( complex_cat, function( complex, initial_object )

                                                                  local objects, universal_maps;

                                                                  objects := Objects( complex );

                                                                  universal_maps := MapLazy( objects,  UniversalMorphismFromInitialObject, 1 );

                                                                  return morphism_constructor( initial_object, complex, universal_maps );

                                                                  end );


  fi;

  if IsAbelianCategory( cat ) then

     SetIsAbelianCategory( complex_cat, true );

     AddKernelEmbedding( complex_cat, function( phi )
                                      local embeddings, kernel_to_next_source, diffs, kernel_complex, kernel_emb;

                                      embeddings := MapLazy( Morphisms( phi ), KernelEmbedding, 1 );

                                      kernel_to_next_source := MapLazy( [ embeddings, Differentials( Source( phi ) ) ], PreCompose, 2 );

                                      diffs := MapLazy( [ ShiftLazy( Morphisms( phi ), shift_index ), kernel_to_next_source ], KernelLift, 2 );

                                      kernel_complex := complex_constructor( cat, diffs );

                                      kernel_emb := morphism_constructor( kernel_complex, Source( phi ), embeddings );

                                      return kernel_emb;

                                      end );


     AddCokernelProjection( complex_cat, function( phi )
                                         local   projections, range_to_next_cokernel, diffs, cokernel_complex, cokernel_proj;

                                         projections := MapLazy( Morphisms( phi ), CokernelProjection, 1 );

                                         range_to_next_cokernel := MapLazy( [ Differentials( Range( phi ) ), ShiftLazy( projections, shift_index ) ], PreCompose, 2 );

                                         diffs := MapLazy( [ Morphisms( phi ), range_to_next_cokernel ], CokernelColift, 2 );

                                         cokernel_complex := complex_constructor( cat, diffs );

                                         cokernel_proj := morphism_constructor( Range( phi ), cokernel_complex, projections );

                                         return cokernel_proj;

                                         end );
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


