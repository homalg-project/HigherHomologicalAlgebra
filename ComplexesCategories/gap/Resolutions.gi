





###############################
#
# Resolutions
#
###############################

##
BindGlobal( "_complexes_QuasiIsomorphismFromProjectiveResolution",
  
  function( C )
    local ch_cat, cat, u, zero_object, data, PC;
    
    ch_cat := CapCategory( C );
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not ( HasIsAbelianCategory( cat )
              and IsAbelianCategory( cat )
                and CanCompute( cat, "SomeProjectiveObject" )
                  and CanCompute( cat, "EpimorphismFromSomeProjectiveObject" )
                    ) then
      
      Error( "the category, ", TextAttr.4, Name( cat ), TextAttr.reset, ", must be 'computable' abelian with enough projectives!\n" );
      
    fi;
    
    u := UpperBound( C );
    
    if u = infinity then
      
      Error( "the upper bound of the given cochain complex should be an integer!\n" );
      
    fi;
    
    data :=
      AsZFunction(
        function( k )
          local h, m, iota, pi, p;
          
          if k > u then
            
            return [ ZeroObjectFunctorial( cat ), UniversalMorphismFromZeroObject( cat, C[k] ), ZeroObjectFunctorial( cat ) ];
            
          else
            
            h := data[k+1][1];
            
            m := MorphismBetweenDirectSums(
                          [ [ h, -data[k+1][2] ],
                            [ ZeroMorphism( cat, C[k], Range( h ) ), C^k ] ] );
            
            iota := KernelEmbedding( m );
            
            pi := EpimorphismFromSomeProjectiveObject( Source( iota ) );
            
            p := List( [ 1, 2 ], i -> ProjectionInFactorOfDirectSum( [ Source( h ), C[k] ], i ) );
            
            return [ PreCompose( [ pi, iota, p[1] ] ), PreCompose( [ pi, iota, p[2] ] ), m ];
            
          fi;
          
    end );
    
    PC := CreateComplex( ch_cat, ApplyMap( data, j -> j[1] ), -infinity, u );
    
    return CreateComplexMorphism( ch_cat, PC, C, ApplyMap( data, j -> j[2] ) );
    
end );

##
InstallMethod( QuasiIsomorphismFromProjectiveResolutionOp,
      [ IsCochainComplex, IsBool ],
      
  function( C, bool )
    local PC, nu;
    
    if bool then
      
      nu := QuasiIsomorphismFromProjectiveResolution( C, false );
      
      PC := ProjectiveResolution( C, true );
      
      return CreateComplexMorphism( CapCategory( C ), PC, C, Morphisms( nu ), LowerBound( PC ), UpperBound( nu ) );
      
    else
      
      return _complexes_QuasiIsomorphismFromProjectiveResolution( C );
      
    fi;
    
end );

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
      [ IsCochainComplex ],
  
  C -> QuasiIsomorphismFromProjectiveResolution( C, false )
);

##
InstallMethod( ProjectiveResolutionOp,
      [ IsCochainComplex, IsBool ],
      
  function( C, bool )
    local PC, i;
     
    if bool then
        
        PC := ProjectiveResolution( C, false );
        
        i := LowerBound( C );
        
        repeat i := i - 1; until IsZeroForObjects( PC[i] );
        
        return CreateComplex( CapCategory( C ), Objects( PC ), Differentials( PC ), i + 1, UpperBound( PC ) );
        
    else
        
        return Source( QuasiIsomorphismFromProjectiveResolution( C, false ) );
        
    fi;
    
end );

##
InstallOtherMethod( ProjectiveResolution,
      [ IsCochainComplex ],
  
  C -> ProjectiveResolution( C, false )
);

##
InstallMethod( MorphismBetweenProjectiveResolutionsOp,
          [ IsCochainMorphism, IsBool ],
  
  function( phi, bool )
    local ch_cat, cat, B, C, PB, PC, morphisms;
    
    ch_cat := CapCategory( phi );
    cat := UnderlyingCategory( ch_cat );
    
    B := Source( phi );
    C := Range( phi );
    
    PB := ProjectiveResolution( B, bool );
    PC := ProjectiveResolution( C, bool );
    
    morphisms := AsZFunction(
      function( k )
        local mB, mC, m, kappa, pi_B, pi_C;
        
        if k > UpperBoundOfSourceAndRange( phi ) then
          
          return ZeroMorphism( cat, PB[ k ], PC[ k ] );
          
        else
          
          mB := BaseZFunctions( Differentials( PB ) )[ 1 ][ k ][ 3 ];
          mC := BaseZFunctions( Differentials( PC ) )[ 1 ][ k ][ 3 ];
          
          m := DirectSumFunctorialWithGivenDirectSums( cat, Source( mB ), [ morphisms[ k + 1 ], phi[ k ] ], Source( mC ) );
          
          kappa := KernelObjectFunctorial( cat, mB, m, mC );
          
          pi_B := EpimorphismFromSomeProjectiveObject( Source( kappa ) );
          pi_C := EpimorphismFromSomeProjectiveObject( Range( kappa ) );
          
          return ProjectiveLift( cat, PreCompose( cat, pi_B, kappa ), pi_C );
          
         fi;
         
      end );
      
    return CreateComplexMorphism( ch_cat, PB, PC, morphisms );
    
end );

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsCochainMorphism ],
  
  phi -> MorphismBetweenProjectiveResolutions( phi, false )
);

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsCochainComplex ],
  
  C -> AsComplexMorphismOverOppositeCategory(
          QuasiIsomorphismFromProjectiveResolution(
            AsComplexOverOppositeCategory( C ) ) )
);

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolutionOp,
          [ IsCochainComplex, IsBool ],
  
  { C, bool } -> AsComplexMorphismOverOppositeCategory(
                    QuasiIsomorphismFromProjectiveResolution(
                      AsComplexOverOppositeCategory( C ), bool ) )
);

##
InstallOtherMethod( InjectiveResolution,
          [ IsCochainComplex ],
  
  C -> AsComplexOverOppositeCategory(
          ProjectiveResolution(
            AsComplexOverOppositeCategory( C ) ) )
);

##
InstallMethod( InjectiveResolutionOp,
          [ IsCochainComplex, IsBool ],
  
  { C, bool } -> AsComplexOverOppositeCategory(
                    ProjectiveResolution(
                      AsComplexOverOppositeCategory( C ), bool ) )
);

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsCochainMorphism ],
  
  phi -> AsComplexMorphismOverOppositeCategory(
          MorphismBetweenProjectiveResolutions(
            AsComplexMorphismOverOppositeCategory( phi ) ) )
);

##
InstallMethod( MorphismBetweenInjectiveResolutionsOp,
          [ IsCochainMorphism, IsBool ],
  
  { phi, bool } -> AsComplexMorphismOverOppositeCategory(
                    MorphismBetweenProjectiveResolutions(
                      AsComplexMorphismOverOppositeCategory( phi ), bool ) )
);

