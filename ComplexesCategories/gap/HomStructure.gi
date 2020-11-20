
##################
#
# For Chains
#
##################

##
InstallMethodWithCache( DoubleChainComplexForHomStructure,
          [ IsChainComplex, IsChainComplex ],
          
  function ( C, D )
    local cat, range_cat, H, V, dComplex;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    H := { i, j } -> (-1) ^ ( i + j + 1 ) * HomStructure( C ^ ( -i + 1), D[ j ] );
    
    V := { i, j } -> HomStructure( C[ -i ], D ^ j );
    
    dComplex := DoubleChainComplex( range_cat, H, V );
    
    if HasActiveUpperBound( C ) then
      SetLeftBound( dComplex, -ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetRightBound( dComplex, -ActiveLowerBound( C ) );
    fi;
    
    if HasActiveUpperBound( D ) then
      SetAboveBound( dComplex, ActiveUpperBound( D ) );
    fi;
    
    if HasActiveLowerBound( D ) then
      SetBelowBound( dComplex, ActiveLowerBound( D ) );
    fi;
    
    return dComplex;
    
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS,
  function( category )
    local cat, range_cat;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
      
        { C, D } -> Source( CyclesAt(
                              TotalComplex( DoubleChainComplexForHomStructure( C, D ) ),
                              0
                            )
                          )
      );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( C, D )
          local d, I;
                    
          d := DoubleChainComplexForHomStructure( C, D );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          return Source( CyclesAt( I(  TotalComplex( d ) ), 0 ) );
          
        end );
        
    else
    
      AddHomomorphismStructureOnObjects( category,
        { C, D } -> TotalComplex( DoubleChainComplexForHomStructure( C, D ) )
      );
     
    fi;
     
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS,
  function( category )
    local cat, range_cat, func;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
          
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap;
          
          dSource := DoubleChainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleChainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleChainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
          
          tMap := TotalMorphism( dMap );
          
          return CyclesFunctorialAt( tMap, 0 );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap, I; 
          
          dSource := DoubleChainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleChainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleChainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          return CyclesFunctorialAt( ApplyFunctor( I, tMap ), 0 );
          
        end );
        
    else
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap;
          
          dSource := DoubleChainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleChainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleChainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          return tMap;
          
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( ADD_INTERPRET_CHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE,
  function( category )
    local cat, range_cat, distinguished_object, func;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    func :=
      function( phi )
        local C, D, l, u, morphisms, morphism, T, i;
        
        C := Source( phi );
        D := Range( phi );
        
        l := ActiveLowerBoundForSourceAndRange( phi );
        u := ActiveUpperBoundForSourceAndRange( phi );
        
        morphisms:= [  ];
        
        for i in Reversed( [ l .. u ] ) do
          
          Add( morphisms,
              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( phi[ i ] )
            );
        
        od;
        
        if IsEmpty( morphisms) then
          
          morphism := UniversalMorphismIntoZeroObject( distinguished_object );
          
        else
          
          morphism := MorphismBetweenDirectSums( [ morphisms] );
          
        fi;
        
        T := TotalComplex( DoubleChainComplexForHomStructure( C, D ) );
        
        Assert( 3, IsZero( PreCompose( morphism, T^0 ) ) );
        
        return [ morphism, T ];
        
    end;
        
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
          
          return KernelLift( T^0, morphism );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
       AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T, I;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
           
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
            
          return KernelLift( ApplyFunctor( I, T^0 ), ApplyFunctor( I, morphism ) );
          
        end );
            
    else
        
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T, U;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
           
          U := StalkChainComplex( Source( morphism ), 0 );
          
          return ChainMorphism( U, T, [ morphism ], 0 );
        
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_CHAIN_MORPHISM,
  function( category )
    local cat, range_cat;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleChainComplexForHomStructure( C, D ) );
          
          phi := PreCompose( psi, CyclesAt( T, 0 ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] ) );
                 
          return ChainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, I, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleChainComplexForHomStructure( C, D ) );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          phi := ValueGlobal( "MorphismDatum" )( PreCompose( psi, CyclesAt( ApplyFunctor( I, T ), 0 ) ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] ) );
          
          return ChainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    else
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleChainComplexForHomStructure( C, D ) );
          
          phi := psi[ 0 ];
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] ) );
                 
          return ChainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    fi;

end );

##
InstallGlobalFunction( ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_CHAINS,
    function( category )
      local cat, range_cat;
      
      cat := UnderlyingCategory( category );
      
      range_cat := RangeCategoryOfHomomorphismStructure( cat );
                
      if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          { } -> DistinguishedObjectOfHomomorphismStructure( cat )
        );  
          
      elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          function( )
            local I;
            
            I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
            
            return I( DistinguishedObjectOfHomomorphismStructure( cat ) );
            
          end );
            
      else
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          {} -> StalkChainComplex( DistinguishedObjectOfHomomorphismStructure( cat ), 0 )
        );
            
      fi;
        
end );

##################
#
# For Cochains
#
##################

##
InstallMethod( DoubleCochainComplexForHomStructure,
          [ IsCochainComplex, IsCochainComplex ],
          
  function ( C, D )
    local cat, range_cat, H, V, dComplex;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    H := { i, j } -> (-1) ^ ( i + j + 1 ) * HomStructure( C ^ ( -i - 1 ), D[ j ] );
    
    V := { i, j } -> HomStructure( C[ -i ], D ^ j );
    
    dComplex := DoubleCochainComplex( range_cat, H, V );
    
    if HasActiveUpperBound( C ) then
      SetLeftBound( dComplex, -ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetRightBound( dComplex, -ActiveLowerBound( C ) );
    fi;
    
    if HasActiveUpperBound( D ) then
      SetAboveBound( dComplex, ActiveUpperBound( D ) );
    fi;
    
    if HasActiveLowerBound( D ) then
      SetBelowBound( dComplex, ActiveLowerBound( D ) );
    fi;
    
    return dComplex;
    
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_COCHAINS,
  function( category )
    local cat, range_cat;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( C, D )
          local d;
          
          d := DoubleCochainComplexForHomStructure( C, D );
          
          return Source( CyclesAt( TotalComplex( d ), 0 ) );
          
        end
      );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( C, D )
          local d, I;
          
          d := DoubleCochainComplexForHomStructure( C, D );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToCochainComplexCategories( I );
          
          return Source( CyclesAt( I(  TotalComplex( d ) ), 0 ) );
          
        end );
        
    else
      
      AddHomomorphismStructureOnObjects( category,
        function ( C, D )
          local d;
          
          d := DoubleCochainComplexForHomStructure( C, D );
          
          return TotalComplex( d );
          
      end );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_COCHAINS_MORPHISMS,
  function( category )
    local cat, range_cat, func;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
          
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap;
          
          dSource := DoubleCochainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleCochainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleCochainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          return CyclesFunctorialAt( tMap, 0 );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap, I;
          
          dSource := DoubleCochainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleCochainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleCochainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToCochainComplexCategories( I );
          
          return CyclesFunctorialAt( ApplyFunctor( I, tMap ), 0 );
          
        end );
        
    else
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap;
          
          dSource := DoubleCochainComplexForHomStructure( Range( phi ), Source( psi ) );
          
          dRange := DoubleCochainComplexForHomStructure( Source( phi ), Range( psi ) );
          
          dMap := DoubleCochainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          return tMap;
          
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( ADD_INTERPRET_COCHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE,
  function( category )
    local cat, range_cat, distinguished_object, func;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    func :=
      function( phi )
        local C, D, l, u, morphisms, morphism, T, I, U, i;
        
        C := Source( phi );
        D := Range( phi );
        
        l := ActiveLowerBoundForSourceAndRange( phi );
        u := ActiveUpperBoundForSourceAndRange( phi );
        
        morphisms:= [  ];
        
        for i in Reversed( [ l .. u ] ) do
          
          Add( morphisms,
              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( phi[ i ] )
            );
            
        od;
        
        if IsEmpty( morphisms) then
          
          morphism := UniversalMorphismIntoZeroObject( distinguished_object );
          
        else
          
          morphism := MorphismBetweenDirectSums( [ morphisms] );
          
        fi;
        
        T := TotalComplex( DoubleCochainComplexForHomStructure( C, D ) );
        
        Assert( 3, IsZero( PreCompose( morphism, T^0 ) ) );
        
        return [ morphism, T ];
        
    end;
      
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
          
          return KernelLift( T^0, morphism );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
       AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T, I;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          return KernelLift( ApplyFunctor( I, T^0 ), ApplyFunctor( I, morphism ) );
          
        end );
        
    else
        
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
        
        function( phi )
          local output, morphism, T, U;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
          
          U := StalkCochainComplex( Source( morphism ), 0 );
          
          return CochainMorphism( U, T, [ morphism ], 0 );
          
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_COCHAIN_MORPHISM,
  function( category )
    local cat, range_cat;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleCochainComplexForHomStructure( C, D ) );
          
          phi := PreCompose( psi, CyclesAt( T, 0 ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, I, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleCochainComplexForHomStructure( C, D ) );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          phi := ValueGlobal( "MorphismDatum" )( PreCompose( psi, CyclesAt( ApplyFunctor( I, T ), 0 ) ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    else
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex( DoubleCochainComplexForHomStructure( C, D ) );
          
          phi := psi[ 0 ];
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( C, D, Reversed( L ), l );
          
      end );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_COCHAINS,
    function( category )
      local cat, range_cat;
      
      cat := UnderlyingCategory( category );
      
      range_cat := RangeCategoryOfHomomorphismStructure( cat );
                
      if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          { } -> DistinguishedObjectOfHomomorphismStructure( cat )
        );  
          
      elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          function( )
            local I;
            
            I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
            
            return I( DistinguishedObjectOfHomomorphismStructure( cat ) );
            
          end );
            
      else
        
        AddDistinguishedObjectOfHomomorphismStructure( category,
        
          {} -> StalkCochainComplex( DistinguishedObjectOfHomomorphismStructure( cat ), 0 )
        );
            
      fi;
        
end );
