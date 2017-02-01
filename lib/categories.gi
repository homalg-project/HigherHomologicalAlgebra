############################################
#
# Categories.gi               Kamal Saleh
#
# Gap package: complex        2016 
###########################################




BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY",

  function( cat, shift_index )
  local name, complex_cat, complex_constructor, morphism_constructor;
  if shift_index = -1 then 

     name := Concatenation( "Chain complexes category over ", Big_to_Small( Name( cat ) ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsChainComplexCategory );

     complex_constructor := ChainComplex;

     morphism_constructor := ChainMorphism;

  elif shift_index = 1 then

     name := Concatenation( "Cochain complexes category over ", Big_to_Small( Name( cat ) ) );

     complex_cat := CreateCapCategory( name );

     SetFilterObj( complex_cat, IsCochainComplexCategory );

     complex_constructor := CochainComplex;

     morphism_constructor := CochainMorphism;
 
  fi;

  if IsAdditiveCategory( cat ) then 

     SetIsAdditiveCategory( complex_cat, true );

     AddZeroObject( complex_cat, function( )
                                 local C;

                                 C := complex_constructor( [ ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) ) ], 0 );

                                 SetUpperBound( C, 0 );

                                 SetLowerBound( C, 0 );

                                 return C;

                                 end );

     AddIsZeroForObjects( complex_cat, function( C )
                                       local obj, i;

                                       if not HasActiveLowerBound( C ) or not HasActiveUpperBound( C ) then 

                                          Error( "The complex must have lower and upper bounds" );

                                       fi;

                                       for obj in ComputedCertainObjects( C ) do

                                           if IsCapCategoryObject( obj ) and not IsZero( obj ) then

                                              return false;

                                           fi;

                                       od;

                                       for i in [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ] do

                                           if not IsZero( C[ i ] ) then 

                                              SetLowerBound( C, i - 1 );

                                              return false;

                                           fi;

                                       od;

                                       return true;

                                       end );



     AddZeroMorphism( complex_cat, function( C1, C2 )
                                   local morphisms;

                                   morphisms := MapLazy( [ Objects( C1 ), Objects( C2 ) ], ZeroMorphism, 2 );

                                   morphisms := morphism_constructor( C1, C2, morphisms );

                                   SetUpperBound( morphisms, 0 );

                                   SetLowerBound( morphisms, 0 );

                                   return morphisms;

                                   end );

     AddIsZeroForMorphisms( complex_cat, function( phi )
                                         local mor, i;

                                       if not HasActiveLowerBound( phi ) or not HasActiveUpperBound( phi ) then

                                          Error( "The morphism must have lower and upper bounds" );

                                       fi;

                                       for mor in ComputedCertainMorphisms( phi ) do

                                            if IsCapCategoryMorphism( mor ) and not IsZero( mor ) then

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
                                           local phi;

                                           phi:= morphism_constructor( Source( m1 ), Range( m1 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], AdditionForMorphisms, 2 ));

                                           AddToToDoList( ToDoListEntry( [ [ m1, "HAS_FAU_BOUND", true ],  [ m2, "HAS_FAU_BOUND", true ] ], function( )

                                                                         if not HasFAU_BOUND( phi ) then 

                                                                            SetUpperBound( phi, Minimum( FAU_BOUND( m1 ), FAU_BOUND( m2 ) ) );

                                                                         fi;

                                                                     end ) );

                                           AddToToDoList( ToDoListEntry( [ [ m1, "HAS_FAL_BOUND", true ],  [ m2, "HAS_FAL_BOUND", true ] ], function( )

                                                                         if not HasFAL_BOUND( phi ) then 

                                                                            SetLowerBound( phi, Maximum( FAL_BOUND( m1 ), FAL_BOUND( m2 ) ) );

                                                                         fi;

                                                                     end ) );

                                           return phi;

                                           end );

     AddAdditiveInverseForMorphisms( complex_cat, function( m )
                                                  local phi;

                                                  phi := morphism_constructor( Source( m ), Range( m ), MapLazy( Morphisms( m ), AdditiveInverseForMorphisms, 1 ) );

                                                  TODO_LIST_TO_PUSH_PULL_BOUNDS( m, phi );

                                                  return phi;

                                                  end );

     AddPreCompose( complex_cat, function( m1, m2 )
                                 local phi;

                                 phi := morphism_constructor( Source( m1 ), Range( m2 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], PreCompose, 2 ) );

                                 TODO_LIST_TO_PUSH_BOUNDS( m1, phi );

                                 TODO_LIST_TO_PUSH_BOUNDS( m2, phi );

                                 return phi;

                                 end );

     AddIdentityMorphism( complex_cat, function( C )

                                       return morphism_constructor( C, C, MapLazy( Objects( C ), IdentityMorphism, 1 ) );

                                       end );

     AddInverse( complex_cat, function( m )
                              local phi;

                              phi := morphism_constructor( Range( m ), Source( m ), MapLazy( Morphisms( m ), Inverse, 1 ) );

                              TODO_LIST_TO_PUSH_PULL_BOUNDS( m, phi );

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
                                local diffs, complex, u, l;

                                diffs := MapLazy( List( L, Differentials ), DirectSumFunctorial, 1 );

                                complex := complex_constructor( cat, diffs );

                                u := List( L, i-> [ i, "HAS_FAU_BOUND", true ] ); 

                                AddToToDoList( ToDoListEntry( u, function( )
                                                                 local b;

                                                                 b := Maximum( List( L, i-> ActiveUpperBound( i ) ) );

                                                                 SetUpperBound( complex, b );

                                                                 end ) );

                                l := List( L, i-> [ i, "HAS_FAL_BOUND", true ] ); 

                                AddToToDoList( ToDoListEntry( l, function( )
                                                                 local b;

                                                                 b := Minimum( List( L, i-> ActiveLowerBound( i ) ) );

                                                                 SetLowerBound( complex, b );

                                                                 end ) );

                                AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ], function( )
												      local i;

                                                                                                      for i in L do

                                                                                                          SetUpperBound( i, ActiveUpperBound( complex ) );

                                                                                                      od;

                                                                                                      end ) );

                                AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ], function( )
												      local i;

                                                                                                      for i in L do

                                                                                                          SetLowerBound( i, ActiveLowerBound( complex ) );

                                                                                                      od;

                                                                                                      end ) );
 

                                return complex;
 
                                end );


          AddDirectSumFunctorial( complex_cat, function( L )
                                local source, range, maps, morphism, u, l;

                                maps := MapLazy( List( L, Morphisms ), DirectSumFunctorial, 1 );
                                source := DirectSum( List( L, Source ) );

                                range  := DirectSum( List( L, Range ) );

                                morphism := morphism_constructor( source, range, maps );

                                u := List( L, i-> [ i, "HAS_FAU_BOUND", true ] ); 

                                AddToToDoList( ToDoListEntry( u, function( )
                                                                 local b;

                                                                 b := Maximum( List( L, i-> ActiveUpperBound( i ) ) );

                                                                 SetUpperBound( morphism, b );

                                                                 end ) );

                                l := List( L, i-> [ i, "HAS_FAL_BOUND", true ] ); 

                                AddToToDoList( ToDoListEntry( l, function( )
                                                                 local b;

                                                                 b := Minimum( List( L, i-> ActiveLowerBound( i ) ) );

                                                                 SetLowerBound( morphism, b );

                                                                 end ) );

                                AddToToDoList( ToDoListEntry( [ [ morphism, "HAS_FAU_BOUND", true ] ], function( )
                                                                                                      local i;

                                                                                                      for i in L do

                                                                                                          SetUpperBound( i, ActiveUpperBound( morphism ) );

                                                                                                      od;

                                                                                                      end ) );

                                AddToToDoList( ToDoListEntry( [ [ morphism, "HAS_FAL_BOUND", true ] ], function( )
                                                                                                      local i;

                                                                                                      for i in L do

                                                                                                          SetLowerBound( i, ActiveLowerBound( morphism ) );

                                                                                                      od;

                                                                                                      end ) );
 

                                return morphism;
 
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

                                      TODO_LIST_TO_PUSH_BOUNDS( Source( phi ), kernel_complex );

                                      return kernel_emb;

                                      end );

     AddKernelLift( complex_cat,  function( phi, tau )
                                  local morphisms, K;

                                  K := KernelObject( phi );

                                  morphisms := MapLazy( IntegersList, function( i )

                                                                      return KernelLift( phi[ i ], tau[ i ] );

                                                                      end, 1 );

                                  return morphism_constructor( Source( tau ), K, morphisms );

                                  end );

     AddKernelLiftWithGivenKernelObject( complex_cat, function( phi, tau, K )

                                                      local morphisms;

                                                      morphisms := MapLazy( IntegersList, function( i )

                                                                                          return KernelLift( phi[ i ], tau[ i ] );

                                                                                          end, 1 );

                                                      return morphism_constructor( Source( tau ), K, morphisms );

                                                      end );



     AddCokernelProjection( complex_cat, function( phi )
                                         local   projections, range_to_next_cokernel, diffs, cokernel_complex, cokernel_proj;

                                         projections := MapLazy( Morphisms( phi ), CokernelProjection, 1 );

                                         range_to_next_cokernel := MapLazy( [ Differentials( Range( phi ) ), ShiftLazy( projections, shift_index ) ], PreCompose, 2 );

                                         diffs := MapLazy( [ Morphisms( phi ), range_to_next_cokernel ], CokernelColift, 2 );

                                         cokernel_complex := complex_constructor( cat, diffs );

                                         cokernel_proj := morphism_constructor( Range( phi ), cokernel_complex, projections );

                                         TODO_LIST_TO_PUSH_BOUNDS( Range( phi ), cokernel_complex );

                                         return cokernel_proj;

                                         end );


     AddCokernelColift( complex_cat,  function( phi, tau )
                                  local morphisms, K;

                                  K := CokernelObject( phi );

                                  morphisms := MapLazy( IntegersList, function( i )

                                                                      return CokernelColift( phi[ i ], tau[ i ] );

                                                                      end, 1 );

                                  return morphism_constructor( K, Range( tau ), morphisms );

                                  end );

     AddCokernelColiftWithGivenCokernelObject( complex_cat, function( phi, tau, K )

                                                      local morphisms;

                                                      morphisms := MapLazy( IntegersList, function( i )

                                                           return CokernelColift( phi[ i ], tau[ i ] );

                                                      end, 1 );

                                                      return morphism_constructor( K, Range( tau ), morphisms );

                                                      end );
 
  fi;


SetUnderlyingCategory( complex_cat, cat );

Finalize( complex_cat );

return complex_cat;

end );

###########################################
#
#  Constructors of (Co)complexes category
#
###########################################

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

