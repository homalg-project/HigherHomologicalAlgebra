# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

##
InstallMethod( ShiftFunctorAttr,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local name, Sigma, G, eta;
    
    name := "Shift auto-equivalence on a triangulated category";
    
    Sigma := CapFunctor( name, category, category );
    
    AddObjectFunction( Sigma, ShiftOfObject );
    
    AddMorphismFunction( Sigma, ShiftOfMorphismWithGivenObjects );
    
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
    
    AddObjectFunction( rev_Sigma, InverseShiftOfObject );
    
    AddMorphismFunction( rev_Sigma, InverseShiftOfMorphismWithGivenObjects );
    
    return rev_Sigma;
    
end );

##
InstallMethod( UnitOfShiftAdjunction,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, ishift, shift_after_ishift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    ishift := InverseShiftFunctor( category );
    
    shift_after_ishift := PreCompose( ishift, shift );
    
    name := "The unit η: 1 => Σ o Σ^-1 of the adjunction Σ^-1 ⊣  Σ";
    
    nat := NaturalTransformation( name, id, shift_after_ishift );
    
    AddNaturalTransformationFunction( nat,
      {s, a, r} -> UnitOfShiftAdjunctionWithGivenObject( a, r )
    );
    
    return nat;
    
end );

##
InstallMethod( InverseOfUnitOfShiftAdjunction,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, ishift, shift_after_ishift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    ishift := InverseShiftFunctor( category );
    
    shift_after_ishift := PreCompose( ishift, shift );
    
    name := "The inverse-unit η^-1: Σ o Σ^-1 => 1 of the adjunction Σ^-1 ⊣  Σ";
    
    nat := NaturalTransformation( name, id, shift_after_ishift );
    
    AddNaturalTransformationFunction( nat,
      {s, a, r} -> InverseOfUnitOfShiftAdjunctionWithGivenObject( a, s )
    );
    
    return nat;
    
end );

##
InstallMethod( CounitOfShiftAdjunction,
          [ IsCapCategory and IsTriangulatedCategory ],
          
  function( category )
    local id, shift, ishift, ishift_of_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    ishift := InverseShiftFunctor( category );
    
    ishift_of_shift := PreCompose( shift, ishift);
    
    name := "The counit ϵ : Σ^-1 o Σ => 1 of the adjunction Σ^-1 ⊣  Σ";
    
    nat := NaturalTransformation( name, id, ishift_of_shift );
    
    AddNaturalTransformationFunction( nat,
      {s, a, r} -> CounitOfShiftAdjunctionWithGivenObject( a, s )
    );
    
    return nat;
    
end );

##
InstallMethod( InverseOfCounitOfShiftAdjunction,
          [ IsCapCategory and IsTriangulatedCategory ],
  function( category )
    local id, shift, ishift, ishift_of_shift, name, nat;
    
    id := IdentityFunctor( category );
    
    shift := ShiftFunctor( category );
    
    ishift := InverseShiftFunctor( category );
    
    ishift_of_shift := PreCompose( shift, ishift);
    
    name := "The inverse-counit ϵ ^ -1 : 1 => Σ^-1 o Σ of the adjunction Σ^-1 ⊣  Σ";
    
    nat := NaturalTransformation( name, id, ishift_of_shift );
    
    AddNaturalTransformationFunction( nat,
      {s, a, r} -> InverseOfCounitOfShiftAdjunctionWithGivenObject( a, r )
    );
    
    return nat;
    
end );

##
InstallMethod( ExtendFunctorToCategoryOfTriangles,
          [ IsCapFunctor and HasCommutativityNaturalTransformationWithShiftFunctor ],
  function( F )
    local eta, S, R, name, TF;
    
    eta := CommutativityNaturalTransformationWithShiftFunctor( F );
    
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
          [ IsCategoryOfExactTriangles, IsBool ],
  function( triangles, bool )
    local name, rot;
    
    name := "Rotation functor";
    
    rot := CapFunctor( name, triangles, triangles );
    
    AddObjectFunction( rot,
      t -> Rotation( t, bool )
    );
    
    AddMorphismFunction( rot,
      { s, phi, r } -> MorphismOfExactTriangles( s, phi[ 1 ], phi[ 2 ], ShiftOfMorphism( phi[ 0 ] ), r )
    );
    
    return rot;
    
end );

##
InstallMethod( InverseRotationFunctorOp,
          [ IsCategoryOfExactTriangles, IsBool ],
  function( triangles, bool )
    local name, rot;
    
    name := "Inverse rotation functor";
    
    rot := CapFunctor( name, triangles, triangles );
    
    AddObjectFunction( rot,
      t -> InverseRotation( t, bool )
    );
    
    AddMorphismFunction( rot,
      { s, phi, r } -> MorphismOfExactTriangles( s, InverseShiftOfMorphism( phi[ 2 ] ), phi[ 0 ], phi[ 1 ], r )
    );
    
    return rot;
    
end );

