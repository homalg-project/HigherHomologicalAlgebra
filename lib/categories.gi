############################################
#
# Categories.gi               Kamal Saleh
#
# Gap package: complex        2016 
###########################################

BindGlobal( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY",

  function( cat, shift_index )
  local name, complex_cat, complex_constructor, morphism_constructor, to_be_finalized;
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

  if HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) then
     
        SetIsAdditiveCategory( complex_cat, true );
  
  fi;
  
  if HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) then
     
        SetIsAbelianCategory( complex_cat, true );
  
  fi;
  
  
  if HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) then
         
         SetIsStrictMonoidalCategory( complex_cat, true );
      
  fi;
  
  if HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) then
         
         SetIsMonoidalCategory( complex_cat, true );
      
  fi;
  
  if HasIsBraidedMonoidalCategory( cat ) and IsBraidedMonoidalCategory( cat ) then
         
         SetIsBraidedMonoidalCategory( complex_cat, true );
      
  fi;
  
  if HasIsSymmetricMonoidalCategory( cat ) and IsSymmetricMonoidalCategory( cat ) then
         
         SetIsSymmetricMonoidalCategory( complex_cat, true );
      
  fi;
  
  if HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) then
         
         SetIsSymmetricClosedMonoidalCategory( complex_cat, true );
      
  fi;
  
## This may be changed ...
## changing it to IsEqualForObjects, IsEqualForMorphisms instead 
## of IsIdenticalObj may slow down computations.
AddIsEqualForCacheForObjects( complex_cat, IsIdenticalObj );
AddIsEqualForCacheForMorphisms( complex_cat, IsIdenticalObj );
##

AddIsEqualForObjects( complex_cat, 
    function( C1, C2 )
    local l, u, i;

    if IsIdenticalObj( C1, C2 ) then 

       return true;

    fi;

    if not ForAll( [ C1, C2 ], IsBoundedChainOrCochainComplex ) then

       Error( "Complexes must be bounded" );

    fi;

    l := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) );

    u := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) );

    for i in [ l .. u ] do

       if not IsEqualForObjects( C1[ i ], C2[ i ] ) then

          return false;

       fi;

    od;

    for i in [ l .. u ] do

       if not IsCongruentForMorphisms( C1^i, C2^i ) then

          return false;

       fi;

    od;

    return true;

end );

AddIsEqualForMorphisms( complex_cat, 
    function( m1, m2 )
    local l, u, i;

    if IsIdenticalObj( m1, m2 ) then 

       return true;

    fi;

    if not ForAll( [ m1, m2 ], IsBoundedChainOrCochainMorphism ) then

       Error( "Complex morphisms must be bounded" );

    fi;


    l := Minimum( ActiveLowerBound( m1 ), ActiveLowerBound( m2 ) );

    u := Maximum( ActiveUpperBound( m1 ), ActiveUpperBound( m2 ) );

    for i in [ l .. u ] do

       if not IsEqualForMorphisms( m1[ i ], m2[ i ] ) then

          return false;

       fi;

    od;

    return true;

end );

AddIsCongruentForMorphisms( complex_cat, 
    function( m1, m2 )
    local l, u, i;

    if IsIdenticalObj( m1, m2 ) then 

       return true;

    fi;

    if not ForAll( [ m1, m2 ], IsBoundedChainOrCochainMorphism ) then

       Error( "Complex morphisms must be bounded" );

    fi;


    l := Minimum( ActiveLowerBound( m1 ), ActiveLowerBound( m2 ) );

    u := Maximum( ActiveUpperBound( m1 ), ActiveUpperBound( m2 ) );

    for i in [ l .. u ] do

       if not IsCongruentForMorphisms( m1[ i ], m2[ i ] ) then

          return false;

       fi;

    od;

    return true;

end );

AddIsWellDefinedForObjects( complex_cat, 
   function( C )
   if not IsBoundedChainOrCochainComplex( C ) then 
      Error( "The complex must be bounded" );
   else
      return IsWellDefined( C, ActiveLowerBound( C  ), ActiveUpperBound( C ) );
   fi;
   end );

AddIsWellDefinedForMorphisms( complex_cat, 
   function( phi )
   if not IsBoundedChainOrCochainMorphism( phi ) then 
      Error( "The morphism must be bounded" );
   else
      return IsWellDefined( phi, ActiveLowerBound( phi  ), ActiveUpperBound( phi ) );
   fi;
   end );
   

if HasIsAdditiveCategory( complex_cat ) and IsAdditiveCategory( complex_cat ) then 

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

    for obj in ComputedObjectAts( C ) do

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

        for mor in ComputedMorphismAts( phi ) do

             if IsCapCategoryMorphism( mor ) and not IsZero( mor ) then

               return false;

            fi;

        od;

        for i in [ ActiveLowerBound( phi ) + 1 .. ActiveUpperBound( phi ) - 1 ] do

             if IsZero( phi[ i ] ) then

                SetLowerBound( phi, i );

            else

                return false;

            fi;

        od;

        return true;

end );

AddAdditionForMorphisms( complex_cat, function( m1, m2 )
            local phi;

            phi:= morphism_constructor( Source( m1 ), Range( m1 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ],AdditionForMorphisms, 2 ));

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

                   phi := morphism_constructor( Source( m ), Range( m ), MapLazy( Morphisms( m ),AdditiveInverseForMorphisms, 1 ) );

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
                              
                              return phi;

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


AddDirectSumFunctorialWithGivenDirectSums( complex_cat, function( source, L, range )
 local maps, morphism, u, l;

 maps := MapLazy( List( L, Morphisms ), DirectSumFunctorial, 1 );

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

  if HasIsAbelianCategory( complex_cat ) and IsAbelianCategory( complex_cat ) then

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

  # This monoidal structure is yet only for chain complex categories ( shift_index = -1 )
  #
  if HasIsMonoidalCategory( complex_cat ) and IsMonoidalCategory( complex_cat ) and shift_index = -1 then
      
      ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES( complex_cat );
      
      ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES( complex_cat );
  
      ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS( complex_cat );
      
      ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS( complex_cat );
      
      ADD_TENSOR_UNIT_CHAIN( complex_cat );
      
      if HasIsBraidedMonoidalCategory( complex_cat ) and IsBraidedMonoidalCategory( complex_cat ) then 
         
         ADD_BRAIDING_FOR_CHAINS( complex_cat );
         
      fi;
      
      if IsSymmetricClosedMonoidalCategory( complex_cat ) then
      
         ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP( complex_cat );
         
         ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP( complex_cat );
      
      fi;
    
  fi;

    SetUnderlyingCategory( complex_cat, cat );

    to_be_finalized := ValueOption( "FinalizeCategory" );

    if to_be_finalized = false then

       return complex_cat;

    else

       Finalize( complex_cat );

    fi;

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

##########################################
#
# Adding monoidal methods
#
##########################################

InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES,

  function( category )

  AddTensorProductOnObjects( category, 
      function( C, D )
      local H, V, d;
 
              if not ( HasActiveUpperBound( C ) and HasActiveUpperBound( D ) ) then 
                 if not ( HasActiveLowerBound( C ) and HasActiveLowerBound( D ) ) then
                    if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                        if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                           Error( "To tensor two complexes they should have one of the following cases 1. One of them is bounded, 2. Both are upper bounded, 3. Both are lower bounded");
                        fi;
                    fi;
                 fi;
              fi;

      H := function( i, j )
              return TensorProductOnMorphisms( C^i, IdentityMorphism( D[ j ] ) );
           end;

      V := function( i, j )
              return (-1)^i*TensorProductOnMorphisms( IdentityMorphism( C[ i ] ), D^j );
           end;

      d := DoubleChainComplex( UnderlyingCategory( category ), H, V );

      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetRightBound( d, ActiveUpperBound( C ) - 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetLeftBound( d, ActiveLowerBound( C ) + 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) - 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) + 1 ); end ) );

      return TotalChainComplex( d );

      end );

end );

InstallGlobalFunction( ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES,

  function( category )

  AddInternalHomOnObjects( category, 
      function( C, D )
      local H, V, d;
 
              if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( D ) ) then 
                 if not ( HasActiveUpperBound( C ) and HasActiveLowerBound( D ) ) then
                    if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                        if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                           Error( "To complete the error string");
                        fi;
                    fi;
                 fi;
              fi;

      H := function( i, j )
              return ( -1 )^( i + j  + 1 ) * InternalHomOnMorphisms( C^( -i + 1 ), IdentityMorphism( D[ j ] ) );
           end;

      V := function( i, j )
              return InternalHomOnMorphisms( IdentityMorphism( C[ -i ] ), D^j );
           end;

      d := DoubleChainComplex( UnderlyingCategory( category), H, V );

      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetLeftBound( d, -ActiveUpperBound( C ) + 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetRightBound( d, -ActiveLowerBound( C ) - 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) - 1 ); end ) );
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) + 1 ); end ) );

      return TotalChainComplex( d );

      end );

end );


InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS,
    function( category )
    
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
         function( S, phi, psi, T )
         local ss, tt, l;
         
         ss := S!.UnderlyingDoubleComplex;

         tt := T!.UnderlyingDoubleComplex;

         l := MapLazy( IntegersList, function( m )
                                     local ind_s, ind_t, morphisms, obj;
                                     
                                     # this is important to write the used indices.
                                     obj := ObjectAt( S, m );
                                     obj := ObjectAt( T, m );
                                     ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
                                     ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
                                     # correct this
                                     morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                                                          function( i )
                                                          return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                                                                       function( j )
                                                                         if i=j then 
                                                                         return TensorProductOnMorphisms( phi[ i ], psi[ m - i ] );
                                                                         else
                                                                         return ZeroMorphism( ObjectAt( ss, i, m - i), ObjectAt( tt, j, m - j ) );
                                                                         fi;
                                                                         end );
                                                          
                                                          end );
                                     return MorphismBetweenDirectSums( morphisms );
                                     end, 1 );
                                     
         return ChainMorphism( S, T, l );
         end );
end );

InstallGlobalFunction( ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS,
   function( category )
   
   AddInternalHomOnMorphismsWithGivenInternalHoms( category,
         function( S, phi, psi, T )
         local ss, tt, l;
         
         ss := S!.UnderlyingDoubleComplex;

         tt := T!.UnderlyingDoubleComplex;

         l := MapLazy( IntegersList, function( m )
                                     local ind_s, ind_t, morphisms, obj;
                                     
                                     obj := ObjectAt( S, m );
                                     obj := ObjectAt( T, m );
                                     ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
                                     ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
                                     morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                                                          function( i )
                                                          return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                                                                       function( j )
                                                                         if i=j then 
                                                                         return InternalHomOnMorphisms( phi[ -i ], psi[ m - i ] );
                                                                         else
                                                                         return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                                                                         fi;
                                                                         end );
                                                          end );
                                     return MorphismBetweenDirectSums( morphisms );
                                     end, 1 );
                                     
         return ChainMorphism( S, T, l );
         
         end );

end );

InstallGlobalFunction( ADD_TENSOR_UNIT_CHAIN,
   function( category )
   
   AddTensorUnit( category, function( )

       return StalkChainComplex( TensorUnit( UnderlyingCategory( category ) ), 0 );
       
   end );
   
end );

InstallGlobalFunction( ADD_BRAIDING_FOR_CHAINS,
   function( category )
   
   AddBraidingWithGivenTensorProducts( category,
      function( s, a, b, t )
      local ss, tt, l;
      
      ss := s!.UnderlyingDoubleComplex;
      tt := t!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList, function( m )
                                  local ind_s, ind_t, morphisms, obj;
                                     
                                  obj := ObjectAt( s, m );
                                  obj := ObjectAt( t, m );
                                  ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
                                  ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
                                  if  IsOddInt( m ) then
                                      morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                                                          function( i )
                                                          return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                                                                       function( j )
                                                                         if i = m - j then 
                                                                         return Braiding( a[ i ], b[ m - i ] );
                                                                         else
                                                                         return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                                                                         fi;
                                                                         end );
                                                          end );
                                  else
                                      morphisms :=  List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                                                          function( i )
                                                          return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                                                                       function( j )
                                                                         if i = m - j then 
                                                                         return (-1)^i*Braiding( a[ i ], b[ m - i ] );
                                                                         else
                                                                         return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                                                                         fi;
                                                                         end );
                                                          end );
                                  fi;
                                      
                                  return MorphismBetweenDirectSums( morphisms );
                                  end, 1 );
                                  
      return ChainMorphism( s, t, l );
      end );

end );

InstallGlobalFunction( ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP,
   function( category )
   
   AddTensorProductToInternalHomAdjunctionMap( category, 
      function( A, B, phi )
      local tensor_A_B, C, hom_B_C, hh, tt, l;
      
      tensor_A_B := TensorProductOnObjects( A, B );
      
      if not IsEqualForObjects( tensor_A_B, Source( phi ) ) then
      
         Error( "The inputs are not compatible" );
        
      fi;
      
      C := Range( phi );
      
      hom_B_C := InternalHomOnObjects( B, C );
      
      hh := hom_B_C!.UnderlyingDoubleComplex;
      
      tt := tensor_A_B!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList, function( m )
                                  local obj, ind_hh, morphisms;
                                  
                                  obj := ObjectAt( hom_B_C, m );
                                  
                                  ind_hh := hh!.IndicesOfTotalComplex.( String( m ) );
                                  
                                  morphisms := List( [ ind_hh[ 1 ] .. ind_hh[ 2 ] ],
                                                     function( j )
                                                     local obj2, ind_tt, ll, f;
                                                     
                                                     obj2 := ObjectAt( tensor_A_B, m - j );
                                                     
                                                     ind_tt := tt!.IndicesOfTotalComplex.( String( m - j ) );
                                                     
                                                     ll := List( [ ind_tt[ 1 ] .. ind_tt[ 2 ] ], 
                                                               function( i )
                                                               if m = i then 
                                                                  return IdentityMorphism( ObjectAt( tt, m, -j ) );
                                                               else 
                                                                  return ZeroMorphism( ObjectAt( tt, m, -j ), ObjectAt( tt, i, m - j - i ) );
                                                               fi;
                                                               end );
                                                               
                                                     f := PreCompose( MorphismBetweenDirectSums( [ ll ] ), phi[ m - j ] );
                                                     
                                                     return TensorProductToInternalHomAdjunctionMap( A[ m ], B[ - j ], f );
                                                     end );
                                                     
                                   return MorphismBetweenDirectSums( [ morphisms ] );
                                   
                                   end, 1 );
                                   
       return ChainMorphism( A, hom_B_C, l );
       end );
       
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP,
   function( category )
   
   AddInternalHomToTensorProductAdjunctionMap( category, 
      function( B, C, psi )
      local hom_B_C, A, tensor_A_B, tt, l, hh;
      
      hom_B_C := InternalHomOnObjects( B, C );
      
      if not IsEqualForObjects( hom_B_C, Range( psi ) ) then
      
         Error( "The inputs are not compatible" );
        
      fi;
      
      A := Source( psi );
      
      tensor_A_B := TensorProductOnObjects( A, B );
      
      hh := hom_B_C!.UnderlyingDoubleComplex;
      
      tt := tensor_A_B!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList, function( m )
                                  local obj, ind_tt, morphisms;
                                  
                                  obj := ObjectAt( tensor_A_B, m );
                                  
                                  ind_tt := tt!.IndicesOfTotalComplex.( String( m ) );
                                  
                                  morphisms := List( [ ind_tt[ 1 ] .. ind_tt[ 2 ] ],
                                                     function( i )
                                                     local obj2, ind_hh, ll, f;
                                                     
                                                     obj2 := ObjectAt( hom_B_C, i );
                                                     
                                                     ind_hh := hh!.IndicesOfTotalComplex.( String( i ) );
                                                     
                                                     ll := List( [ ind_hh[ 1 ] .. ind_hh[ 2 ] ], 
                                                               function( j )
                                                               if j = i - m then 
                                                                  return [ IdentityMorphism( ObjectAt( hh, i - m, m ) ) ];
                                                               else 
                                                                  return [ ZeroMorphism( ObjectAt( hh, j, i - j ), ObjectAt( hh, i - m, m ) ) ];
                                                               fi;
                                                               
                                                               end );
                                                               
                                                     f := PreCompose( psi[ i ], MorphismBetweenDirectSums( ll ) );
                                                     
                                                     return [ InternalHomToTensorProductAdjunctionMap( B[ m - i], C[ m ], f ) ];
                                                     
                                                     end );
                                                     
                                   return MorphismBetweenDirectSums( morphisms );
                                   
                                   end, 1 );
                                   
       return ChainMorphism( tensor_A_B, C, l );
       
       end );
       
end );