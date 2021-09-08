# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

##
InstallMethodWithCache( DoubleChainComplexByHomStructure,
          [ IsChainComplex, IsChainComplex ],
          
  function ( B, C )
    local cat, range_cat, H, V, dComplex;
    
    cat := UnderlyingCategory( CapCategory( B ) );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    H := { i, j } -> (-1) ^ ( i + j - 1 ) * HomStructure( B ^ ( -i + 1), C[ j ] );
    
    V := { i, j } -> HomStructure( B[ -i ], C ^ j );
    
    dComplex := DoubleChainComplex( range_cat, H, V );
    
    if HasActiveUpperBound( B ) then
      SetLeftBound( dComplex, -ActiveUpperBound( B ) );
    fi;
    
    if HasActiveLowerBound( B ) then
      SetRightBound( dComplex, -ActiveLowerBound( B ) );
    fi;
    
    if HasActiveUpperBound( C ) then
      SetAboveBound( dComplex, ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetBelowBound( dComplex, ActiveLowerBound( C ) );
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
      
        { B, C } -> Source( CyclesAt(
                              TotalComplex( DoubleChainComplexByHomStructure( B, C ) ),
                              0
                            )
                          )
      );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( B, C )
          local d, I;
                    
          d := DoubleChainComplexByHomStructure( B, C );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          return Source( CyclesAt( I(  TotalComplex( d ) ), 0 ) );
          
        end );
        
    else
    
      AddHomomorphismStructureOnObjects( category,
        { B, C } -> TotalComplex( DoubleChainComplexByHomStructure( B, C ) )
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
      
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM;
          
          DS := DoubleChainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleChainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleChainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
          
          TM := TotalMorphism( DM );
          
          return CyclesFunctorialAt( TM, 0 );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM, I; 
          
          DS := DoubleChainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleChainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleChainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
                    
          TM := TotalMorphism( DM );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          return CyclesFunctorialAt( ApplyFunctor( I, TM ), 0 );
          
        end );
        
    else
      
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM;
          
          DS := DoubleChainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleChainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleChainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
                    
          TM := TotalMorphism( DM );
          
          return TM;
          
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
        local B, C, l, u, morphisms, morphism, T, i;
        
        B := Source( phi );
        C := Range( phi );
        
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
        
        T := TotalComplex( DoubleChainComplexByHomStructure( B, C ) );
        
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
          local output, morphism, T, DO;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
           
          DO := DistinguishedObjectOfHomomorphismStructure( category );
          
          return ChainMorphism( DO, T, [ morphism ], 0 );
        
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
        function( B, C, ell )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleChainComplexByHomStructure( B, C ) );
          
          phi := PreCompose( ell, CyclesAt( T, 0 ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] ) );
                 
          return ChainMorphism( B, C, Reversed( L ), l );
          
      end );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( B, C, ell )
          local l, u, T, I, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleChainComplexByHomStructure( B, C ) );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToChainComplexCategories( I );
          
          phi := ValueGlobal( "MorphismDatum" )( PreCompose( ell, CyclesAt( ApplyFunctor( I, T ), 0 ) ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] ) );
          
          return ChainMorphism( B, C, Reversed( L ), l );
          
      end );
      
    else
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( B, C, ell )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleChainComplexByHomStructure( B, C ) );
          
          phi := ell[ 0 ];
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] ) );
                 
          return ChainMorphism( B, C, Reversed( L ), l );
          
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
InstallMethod( DoubleCochainComplexByHomStructure,
          [ IsCochainComplex, IsCochainComplex ],
          
  function ( B, C )
    local cat, range_cat, H, V, D;
    
    cat := UnderlyingCategory( CapCategory( B ) );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    H := { i, j } -> (-1) ^ ( i + j + 1 ) * HomStructure( B ^ ( -i - 1 ), C[ j ] );
    
    V := { i, j } -> HomStructure( B[ -i ], C ^ j );
    
    D := DoubleCochainComplex( range_cat, H, V );
    
    if HasActiveUpperBound( B ) then
      SetLeftBound( D, -ActiveUpperBound( B ) );
    fi;
    
    if HasActiveLowerBound( B ) then
      SetRightBound( D, -ActiveLowerBound( B ) );
    fi;
    
    if HasActiveUpperBound( C ) then
      SetAboveBound( D, ActiveUpperBound( C ) );
    fi;
    
    if HasActiveLowerBound( C ) then
      SetBelowBound( D, ActiveLowerBound( C ) );
    fi;
    
    return D;
    
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_COCHAINS,
  function( category )
    local cat, range_cat;
    
    cat := UnderlyingCategory( category );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( B, C )
          local D;
          
          D := DoubleCochainComplexByHomStructure( B, C );
          
          return Source( CyclesAt( TotalComplex( D ), 0 ) );
          
        end
      );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddHomomorphismStructureOnObjects( category,
        function ( B, C )
          local D, I;
          
          D := DoubleCochainComplexByHomStructure( B, C );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToCochainComplexCategories( I );
          
          return Source( CyclesAt( I(  TotalComplex( D ) ), 0 ) );
          
        end );
        
    else
      
      AddHomomorphismStructureOnObjects( category,
        function ( B, C )
          local D;
          
          D := DoubleCochainComplexByHomStructure( B, C );
          
          return TotalComplex( D );
          
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
      
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM;
          
          DS := DoubleCochainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleCochainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleCochainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
                    
          TM := TotalMorphism( DM );
          
          return CyclesFunctorialAt( TM, 0 );
          
        end );
        
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
       
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM, I;
          
          DS := DoubleCochainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleCochainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleCochainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
                    
          TM := TotalMorphism( DM );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToCochainComplexCategories( I );
          
          return CyclesFunctorialAt( ApplyFunctor( I, TM ), 0 );
          
        end );
        
    else
      
      AddHomomorphismStructureOnMorphisms( category,
        function( alpha, beta )
          local DS, DR, DM, TM;
          
          DS := DoubleCochainComplexByHomStructure( Range( alpha ), Source( beta ) );
          
          DR := DoubleCochainComplexByHomStructure( Source( alpha ), Range( beta ) );
          
          DM := DoubleCochainMorphism(
                      DS,
                      DR,
                      { i, j } -> HomStructure( alpha[ -i ], beta[ j ] )
                    );
                    
          TM := TotalMorphism( DM );
          
          return TM;
          
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
        local B, C, l, u, morphisms, morphism, T, I, U, i;
        
        B := Source( phi );
        C := Range( phi );
        
        l := ActiveLowerBoundForSourceAndRange( phi );
        u := ActiveUpperBoundForSourceAndRange( phi );
        
        morphisms:= [  ];
        
        for i in [ l .. u ] do
          
          Add( morphisms,
              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( phi[ i ] )
            );
            
        od;
        
        if IsEmpty( morphisms) then
          
          morphism := UniversalMorphismIntoZeroObject( distinguished_object );
          
        else
          
          morphism := MorphismBetweenDirectSums( [ morphisms] );
          
        fi;
        
        T := TotalComplex( DoubleCochainComplexByHomStructure( B, C ) );
        
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
          local output, morphism, T, DO;
          
          output := func( phi );
          
          morphism := output[ 1 ];
          
          T := output[ 2 ];
          
          DO := DistinguishedObjectOfHomomorphismStructure( category );
          
          return CochainMorphism( DO, T, [ morphism ], 0 );
          
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
        function( B, C, ell )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleCochainComplexByHomStructure( B, C ) );
          
          phi := PreCompose( ell, CyclesAt( T, 0 ) );
          
          struc_on_objects := [  ];
          
          indices := [ l .. u ];
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( B, C, L, l );
          
      end );
      
    elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( B, C, ell )
          local l, u, T, I, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleCochainComplexByHomStructure( B, C ) );
          
          I := ValueGlobal( "EmbeddingFunctorIntoFreydCategory" )( range_cat );
          
          I := ExtendFunctorToCochainComplexCategories( I );
          
          phi := ValueGlobal( "MorphismDatum" )( PreCompose( ell, CyclesAt( ApplyFunctor( I, T ), 0 ) ) );
          
          struc_on_objects := [  ];
          
          indices := [ l .. u ];
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( B, C, L, l );
          
      end );
      
    else
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( B, C, ell )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( B ), ActiveLowerBound( C ) );
          
          u := Maximum( ActiveUpperBound( B ), ActiveUpperBound( C ) );
          
          T := TotalComplex( DoubleCochainComplexByHomStructure( B, C ) );
          
          phi := ell[ 0 ];
          
          struc_on_objects := [  ];
          
          indices := [ l .. u ];
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( B[ i ], C[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                  i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( B[ indices[i] ], C[ indices[i] ], L[i] )
                );
                
          return CochainMorphism( B, C, L, l );
          
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
