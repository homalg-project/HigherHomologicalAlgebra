
##
InstallMethod( AsPresentationInCAP,
                [ IsHomalgGradedModule ],
    function( M )
      local N, s;
      s := PositionOfTheDefaultPresentation( M );
      SetPositionOfTheDefaultPresentation( M, 1 );
      if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        N := AsGradedRightPresentation( MatrixOfRelations( M ), DegreesOfGenerators( M ) );
        SetPositionOfTheDefaultPresentation( M, s );
        SetAsPresentationInHomalg( N, M );
        return N;
      else
        N := AsGradedLeftPresentation( MatrixOfRelations( M ), DegreesOfGenerators( M ) );
        SetPositionOfTheDefaultPresentation( M, s );
        SetAsPresentationInHomalg( N, M );
        return N;
      fi;
end );

##
InstallMethod( AsPresentationInHomalg,
    [ IsGradedLeftOrRightPresentation ],
    function( M )
      local N;
      if IsGradedRightPresentation( M ) then
        N := RightPresentationWithDegrees( UnderlyingMatrix( M ), GeneratorDegrees( M ) );
        SetAsPresentationInCAP( N, M );
        return N;
      else
        N := LeftPresentationWithDegrees( UnderlyingMatrix( M ), GeneratorDegrees( M ) );
        SetAsPresentationInCAP( N, M );
        return N;
      fi;
end );

##
InstallMethod( AsPresentationMorphismInCAP,
                [ IsHomalgGradedMap ],
    function( f )
      local g, M, N, s, t;
      s := PositionOfTheDefaultPresentation( Source( f ) );
      t := PositionOfTheDefaultPresentation( Range( f ) );
    
      SetPositionOfTheDefaultPresentation( Source( f ), 1 );
      SetPositionOfTheDefaultPresentation( Range( f ), 1 );
    
      M := AsPresentationInCAP( Source( f ) );
      N := AsPresentationInCAP( Range( f ) );
      
      g := GradedPresentationMorphism( M, MatrixOfMap( f ), N );

      SetPositionOfTheDefaultPresentation( Source( f ), s );
      SetPositionOfTheDefaultPresentation( Range( f ), t );
      SetAsPresentationInHomalg( g, f );

      return g;
end );

##
InstallMethod( AsPresentationMorphismInHomalg,
                [ IsGradedLeftOrRightPresentationMorphism ],
    function( f )
      local M, N, g;
      M := AsPresentationInHomalg( Source( f ) );
      N := AsPresentationInHomalg( Range( f ) );
      g :=  GradedMap( UnderlyingMatrix( f ), M, N );
      SetAsPresentationMorphismInCAP( g, f );
      return g;
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
                [ IsCapCategoryObject and IsGradedLeftOrRightPresentation ],
    function( M )
    return CastelnuovoMumfordRegularity( AsPresentationInHomalg( M ) );
end );

##
InstallMethod( TruncationFunctorOp,
    [ IsHomalgGradedRing, IsInt ],
    function( R, i )
      local cat, F;

      cat := GradedLeftPresentations( R );
      F := CapFunctor( "Truncation functor", cat, cat );
      
      AddObjectFunction( F,
      function( M )
        local hM;
        hM := AsPresentationInHomalg( M );
        hM := TruncatedModule( i, hM );
        return AsPresentationInCAP( hM );
      end );
      
      AddMorphismFunction( F,
      function( new_source, phi, new_range )
        local h_phi;
        h_phi := AsPresentationMorphismInHomalg( phi );
        h_phi := TruncatedModule( i, h_phi );
        return AsPresentationMorphismInCAP( h_phi );
      end );
      
      return F;
end);

##
InstallMethod( HomogeneousPartOverCoefficientsRingFunctorOp,
    [ IsHomalgGradedRing, IsInt ],
    function( R, i )
      local field, cat, vec, F, name;

      field := CoefficientsRing( R );
      cat := GradedLeftPresentations( R );
      vec := MatrixCategory( field );
      name := Concatenation( "Homogeneous part functor from ", Name( cat ), " to ", Name( cat ) );
      F := CapFunctor( name, cat, vec );
      
      AddObjectFunction( F,
      function( M )
        local hM;
        hM := AsPresentationInHomalg( M );
        hM := HomogeneousPartOverCoefficientsRing( i, hM );
        return VectorSpaceObject( RankOfObject( hM ), field );
      end );
      
      AddMorphismFunction( F,
      function( new_source, phi, new_range )
        local h_phi;
        h_phi := AsPresentationMorphismInHomalg( phi );
        h_phi := HomogeneousPartOverCoefficientsRing( i, h_phi );
        return VectorSpaceMorphism( new_source, MatrixOfMap( h_phi ), new_range );
      end );
      
      return F;
end);

InstallMethod( RepresentationMapOfRingElement, 
    [ IsRingElement, IsGradedLeftOrRightPresentation, IsInt ],
    function( r, M, i )
      local field, rep, source, range;
      field := CoefficientsRing( UnderlyingHomalgRing( M ) );
      rep := RepresentationMapOfRingElement( r, AsPresentationInHomalg( M ), i );
      source := VectorSpaceObject( RankOfObject( Source( rep ) ), field );
      range := VectorSpaceObject( RankOfObject( Range( rep ) ), field );
      return VectorSpaceMorphism( source, MatrixOfMap( rep ), range );
end );

#### methods to be replaced later

InstallMethod( GradedLeftPresentationGeneratedByHomogeneousPartOp,
        [ IsGradedLeftPresentation, IsInt ],
    function( M, n )
    local Mn, Mn_in_homalg;
    Mn_in_homalg := SubmoduleGeneratedByHomogeneousPart( n, AsPresentationInHomalg(M) );
    Mn := AsPresentationInCAP( UnderlyingObject( Mn_in_homalg ) );
    SetEmbeddingInSuperObject( Mn, AsPresentationMorphismInCAP( EmbeddingInSuperObject( Mn_in_homalg ) ) );
    return Mn;
end );

InstallMethod( EmbeddingInSuperObject,
      [ IsGradedLeftPresentation ],
    function( M )
    Error( "This attribute should be set by: GradedLeftPresentationGeneratedByHomogeneousPart" );
end );
