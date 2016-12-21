#

####################################
#
#    Functors 
#
####################################

# Homology and Cohomology functors

BindGlobal( "HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR", 
     function( cat, i, string )

     local functor, complex_cat, name;
     
     if string = "Homology" then
     
     complex_cat := ChainComplexCategory( cat );
     
     name := Concatenation( String( i ), "-th homology functor in ", Name( cat ) );
     
     else
     
     complex_cat := CochainComplexCategory( cat );
     
     name := Concatenation( String( i ), "-th cohomology functor in ", Name( cat ) );
     
     fi;
     
     functor := CapFunctor( name, complex_cat, cat );

     AddObjectFunction( functor, 

     function( complex )

     return HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX( complex, i );

     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

     return HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL( map, i );

     end );
     
     return functor;

end );


BindGlobal( "SHIFT_AS_FUNCTOR",
   function( complex_cat, n )
   local name, shift, morphism_constructor;
   
   if IsChainComplexCategory( complex_cat ) then 

      morphism_constructor := ChainMorphism;

   elif IsCochainComplexCategory( complex_cat ) then 

      morphism_constructor := CochainMorphism;

   else 

      Error( "The category should be either chain or cochain complexes category" );

   fi;
   
   if n = 0 then 

      return IdentityFunctor( complex_cat );

   elif n>0 then 

      name := Concatenation( "Shift (", String( n ), " times to the left) functor in ", Name( complex_cat ) );

   else

      name := Concatenation( "Shift (", String( -n ), " times to the right) functor in ", Name( complex_cat ) );

   fi;
   
   shift := CapFunctor( name, complex_cat, complex_cat );
   
   AddObjectFunction( shift, 

     function( complex )

       return ShiftLazy( complex, n );

     end );

   AddMorphismFunction( shift, 

     function( new_source, map, new_range )

     local morphisms;

     morphisms := Morphisms( map );

     morphisms := ShiftLazy( morphisms, n );

     morphisms := morphism_constructor( new_source, new_range, morphisms );

     return morphisms;

     end );

   return shift;

end );

BindGlobal( "UNSIGNED_SHIFT_AS_FUNCTOR",
   function( complex_cat, n )
   local name, shift, morphism_constructor;
   
   if IsChainComplexCategory( complex_cat ) then 

      morphism_constructor := ChainMorphism;

   elif IsCochainComplexCategory( complex_cat ) then 

      morphism_constructor := CochainMorphism;

   else 

      Error( "The category should be either chain or cochain complexes category" );

   fi;
   
   if n = 0 then 

      return IdentityFunctor( complex_cat );

   elif n>0 then 

      name := Concatenation( "Unsigned shift (", String( n ), " times to the left) functor in ", Name( complex_cat ) );

   else

      name := Concatenation( "Unsigned shift (", String( -n ), " times to the right) functor in ", Name( complex_cat ) );

   fi;
   
   shift := CapFunctor( name, complex_cat, complex_cat );
   
   AddObjectFunction( shift, 

     function( complex )

       return ShiftUnsignedLazy( complex, n );

     end );

   AddMorphismFunction( shift, 

     function( new_source, map, new_range )

     local morphisms;

     morphisms := Morphisms( map );

     morphisms := ShiftLazy( morphisms, n );

     morphisms := morphism_constructor( new_source, new_range, morphisms );

     return morphisms;

     end );

   return shift;

end );

BindGlobal( "FUNCTORS_INSTALLER",
   function( )

InstallMethod( HomologyFunctor, 
               [ IsChainComplexCategory, IsCapCategory, IsInt ], 
  function( complex_cat, cat, i )

  return HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR( cat, i, "Homology" );

  end );

InstallMethod( CohomologyFunctor, 
               [ IsCochainComplexCategory, IsCapCategory, IsInt ],
  function( complex_cat, cat, i )

  return HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR( cat, i, "Cohomology" );

end );

InstallMethod( ShiftFunctor, 
                [ IsChainOrCochainComplexCategory, IsInt ], 
  function( complex_cat, n )

  return SHIFT_AS_FUNCTOR( complex_cat, n );

end );

InstallMethod( UnsignedShiftFunctor, 
                [ IsChainOrCochainComplexCategory, IsInt ], 
  function( complex_cat, n )

  return UNSIGNED_SHIFT_AS_FUNCTOR( complex_cat, n );

end );


# InstallMethod( UnsignedShiftAsFunctor, [ IsCapCategory, IsInt ], UNSIGNED_SHIFT_AS_FUNCTOR );



end );

FUNCTORS_INSTALLER( );
