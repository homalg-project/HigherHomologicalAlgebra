#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2020,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


##
InstallMethod( ShiftFunctorAttr,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local name, Sigma, G, eta;
    
    name := "Shift auto-equivalence on a triangulated category";
    
    Sigma := CapFunctor( name, category, category );
    
    if not ( CanCompute( category, "ShiftOnObject" )
              and CanCompute( category, "ShiftOnMorphismWithGivenObjects" ) ) then
              
        Error( "ShiftOnObject and ShiftOnMorphism should be added to the category" );
        
    fi;
    
    AddObjectFunction( Sigma, ShiftOnObject );
    
    AddMorphismFunction( Sigma, ShiftOnMorphismWithGivenObjects );
        
    return Sigma;
    
end );

##
InstallOtherMethod( ShiftFunctor,
          [ IsCapCategory and IsTriangulatedCategory ],
  ShiftFunctorAttr
);

InstallMethod( InverseShiftFunctor,
          [ IsCapCategory and IsTriangulatedCategory ],  
  function( category )
    local name, rev_Sigma, Sigma, G_1, G_2, eta;
    
    name := "Inverse Shift auto-equivalence on a triangulated category";
    
    rev_Sigma := CapFunctor( name, category, category );
    
    if not ( CanCompute( category, "InverseShiftOnObject" )
              and CanCompute( category, "InverseShiftOnMorphismWithGivenObjects" ) ) then
              
      Error( "InverseShiftOnObject and InverseShiftOnMorphism should be added to the category" );
      
    fi;
    
    AddObjectFunction( rev_Sigma, InverseShiftOnObject );
    
    AddMorphismFunction( rev_Sigma, InverseShiftOnMorphismWithGivenObjects );
        
    return rev_Sigma;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityIntoShiftOfInverseShift,
          [ IsCapCategory and IsTriangulatedCategory ],        
  function( category )
    local id, shift, reverse_shift, shift_after_reverse_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    reverse_shift := InverseShiftFunctor( category );
    
    shift_after_reverse_shift := PreCompose( reverse_shift, shift );
    
    name := "Autoequivalence from identity functor to Σ o Σ^-1 in ";
    
    name := Concatenation( name, Name( category ) );
    
    nat := NaturalTransformation( name, id, shift_after_reverse_shift );
    
    AddNaturalTransformationFunction( nat, IsomorphismIntoShiftOfInverseShiftWithGivenObject );
    
    return nat;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityIntoInverseShiftOfShift,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, reverse_shift, reverse_shift_after_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    reverse_shift := InverseShiftFunctor( category );
    
    reverse_shift_after_shift := PreCompose( shift, reverse_shift);
    
    name := "Autoequivalence from identity functor to Σ^-1 o Σ in  ";
    
    name := Concatenation( name, Name( category ) );
    
    nat := NaturalTransformation( name, id, reverse_shift_after_shift );
    
    AddNaturalTransformationFunction( nat, IsomorphismIntoInverseShiftOfShiftWithGivenObject );
    
    return nat;
    
end );

##
InstallMethod( NaturalIsomorphismFromShiftOfInverseShiftIntoIdentity,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, reverse_shift, shift_after_reverse_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    reverse_shift := InverseShiftFunctor( category );
    
    shift_after_reverse_shift := PreCompose( reverse_shift, shift );
    
    name := "Autoequivalence from Σ o Σ^-1 to identity functor in ";
    
    name := Concatenation( name, Name( category ) );
    
    nat := NaturalTransformation( name, id, shift_after_reverse_shift );
    
    AddNaturalTransformationFunction( nat, IsomorphismFromShiftOfInverseShiftWithGivenObject );
    
    return nat;
    
end );

##
InstallMethod( NaturalIsomorphismFromInverseShiftOfShiftIntoIdentity,
                      [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, reverse_shift, reverse_shift_after_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    reverse_shift := InverseShiftFunctor( category );
    
    reverse_shift_after_shift := PreCompose( shift, reverse_shift);
    
    name := "Autoequivalence from Σ^-1 o Σ to identity functor in ";
    
    name := Concatenation( name, Name( category ) );
    
    nat := NaturalTransformation( name, id, reverse_shift_after_shift );
    
    AddNaturalTransformationFunction( nat, IsomorphismFromInverseShiftOfShiftWithGivenObject );
    
    return nat;
    
end );

##
InstallMethod( ExtendFunctorToCategoryOfTriangles,
          [ IsCapFunctor and HasCommutativityNaturalIsomorphismForExactFunctor ],
  function( F )
    local eta, S, R, name, TF;
    
    eta := CommutativityNaturalIsomorphismForExactFunctor( F );
    
    S := AsCapCategory( Source( F ) );
    
    R := AsCapCategory( Range( F ) );
    
    S := CategoryOfExactTriangles( S );
    
    R := CategoryOfExactTriangles( R );
    
    name := "Extension of a functor to categories of exact triangles";
    
    TF := CapFunctor( name, S, R );
    
    AddObjectFunction( TF,
      function( triangle )
        
        return ExactTriangle(
                  ApplyFunctor( F, triangle ^ 0 ),
                  ApplyFunctor( F, triangle ^ 1),
                  PreCompose( ApplyFunctor( F, triangle ^ 2 ), eta( triangle[ 0 ] ) )
                );
                
      end );
      
    AddMorphismFunction( TF,
      function( s, phi, r )
        
        return MorphismOfExactTriangles( 
                  s,
                  ApplyFunctor( F, phi[ 0 ] ),
                  ApplyFunctor( F, phi[ 1 ] ),
                  ApplyFunctor( F, phi[ 2 ] ),
                  r
                );
                
        end );
        
    return TF;
    
end );

##
InstallMethod( RotationFunctorOp,
          [ IsCapCategoryOfExactTriangles, IsBool ],
  function( triangles, bool )
    local name, rot;
  
    name := "Rotation functor";
    
    rot := CapFunctor( name, triangles, triangles );
    
    AddObjectFunction( rot,
      t -> Rotation( t, bool )
    );
    
    AddMorphismFunction( rot,
      { s, phi, r } -> MorphismOfExactTriangles( s, phi[ 1 ], phi[ 2 ], ShiftOnMorphism( phi[ 0 ] ), r )
    );
    
    return rot;
    
end );

##
InstallMethod( InverseRotationFunctorOp,
          [ IsCapCategoryOfExactTriangles, IsBool ],
  function( triangles, bool )
    local name, rot;
    
    name := "Inverse rotation functor";
    
    rot := CapFunctor( name, triangles, triangles );
    
    AddObjectFunction( rot,
      t -> InverseRotation( t, bool )
    );
    
    AddMorphismFunction( rot,
      { s, phi, r } -> MorphismOfExactTriangles( s, InverseShiftOnMorphism( phi[ 2 ] ), phi[ 0 ], phi[ 1 ], r )
    );
    
    return rot;
    
end );

