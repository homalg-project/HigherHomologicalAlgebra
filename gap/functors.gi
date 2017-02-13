#
DeclareOperation( "HomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt  ] );

InstallMethod( HomologyFunctor, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( H_cat, cat, n )
local functor, complex_cat, name, Hn;

     if not IsIdenticalObj( UnderlyingCategory( UnderlyingCategory( H_cat ) ), cat ) then

        Error( "The first argument should be the homotopy category of complex category of the second argument" );

     fi;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     if IsChainComplexCategory( complex_cat ) then

       Hn := HomologyFunctor( complex_cat, cat, n );

       name := Concatenation( String( n ), "-th homology functor" );
     
     else
     
       Error( "the underlying category should be chain complex category, not cochain complex category" );

     fi;
     
     functor := CapFunctor( name, H_cat, cat );
 
     AddObjectFunction( functor, 
  
     function( complex )
  
     return ApplyFunctor( Hn, UnderlyingObject( complex ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

     return ApplyFunctor( Hn, UnderlyingMorphism( map ) );

     end );


    return functor;

end );

#
DeclareOperation( "CohomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt  ] );

InstallMethod( CohomologyFunctor, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( H_cat, cat, n )
local functor, complex_cat, name, Hn;

     if not IsIdenticalObj( UnderlyingCategory( UnderlyingCategory( H_cat ) ), cat ) then

        Error( "The first argument should be the homotopy category of complex category of the second argument" );

     fi;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     if IsCochainComplexCategory( complex_cat ) then

       Hn := CohomologyFunctor( complex_cat, cat, n );

       name := Concatenation( String( n ), "-th cohomology functor" );
     
     else
     
       Error( "the underlying category should be cochain complex category, not chain complex category" );

     fi;
     
     functor := CapFunctor( name, H_cat, cat );

     AddObjectFunction( functor, 
  
     function( complex )
  
     return ApplyFunctor( Hn, UnderlyingObject( complex ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

     return ApplyFunctor( Hn, UnderlyingMorphism( map ) );

     end );

     return functor;

end );
