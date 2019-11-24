
AddRandomMethodsToQuiverRepresentations :=
  function( cat )
    local A, field;
    
    A := AlgebraOfCategory( cat );
    
    field := UnderlyingField( VectorSpaceCategory( cat ) );
    
    AddRandomObjectByList( cat,
    
      function( C, l )
        local indec_proj, s, r, source, range, L;
        
        indec_proj := IndecProjRepresentations( A );
        
        s := l[ 1 ];
        
        r := l[ 2 ];
        
        source := List( [ 1 .. s ], i -> Random( indec_proj ) );
        
        range := List( [ 1 .. r ], i -> Random( indec_proj ) );
        
        L := List( [ 1 .. s ],
          i -> List( [ 1 .. r ],
            j -> Random(
              Concatenation(
                BasisOfExternalHom( source[ i ], range[ j ] ),
                [ ZeroMorphism(source[ i ], range[ j ] ) ]
                           )
              ) ) );
        
        return CokernelObject( MorphismBetweenDirectSums( L ) );
        
    end );

    AddRandomObjectByInteger( cat,
    
      function( C, n )
        
        return RandomObjectByList( C, [ n, n ] );
        
    end );
   
    AddRandomMorphismWithFixedRangeByList( cat,
    
      function( M, L )
        local pi, K, H;
        
        if not ForAll( L, l -> l in field ) then
          
          Error( "All entries should belong to the acting field of the algebra" );
          
        fi;
        
        pi := ProjectiveCover( M );
        
        K := KernelObject( pi );
        
        if IsZero( K ) then
          
          K := Source( pi );
          
        fi;
        
        H := BasisOfExternalHom( K, M );
        
        H := Concatenation( H, [ ZeroMorphism( K, M ) ] );
        
        return Sum( List( L, l -> l * Random( H ) ) );
        
     end );
    
    AddRandomMorphismWithFixedRangeByInteger( cat,
     
      function( M, n )
        
        return RandomMorphismWithFixedRangeByList( M, [ 1 .. n ] * One( field ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceByList( cat,
    
      function( M, L )
        local iota, K, H;
        
        if not ForAll( L, l -> l in field ) then
          
          Error( "All entries should belong to the acting field of the algebra" );
          
        fi;
        
        iota := InjectiveEnvelope( M );
        
        K := CokernelObject( iota );
        
        if IsZero( K ) then
          
          K := Range( iota );
          
        fi;
        
        H := BasisOfExternalHom( M, K );
        
        H := Concatenation( H, [ ZeroMorphism( M, K ) ] );
        
        return Sum( List( L, l -> l * Random( H ) ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceByInteger( cat,
     
      function( M, n )
        
        return RandomMorphismWithFixedSourceByList( M, [ 1 .. n ] * One( field ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceAndRangeByList( cat,
      
      function( M, N, L )
        local H;
        
        H := BasisOfExternalHom( M, N );
        
        if H = [ ] then
          
          return ZeroMorphism( M, N );
          
        fi;
        
        return Sum( List( H, h -> Random( L ) * h ) );
        
    end );
    
    AddRandomMorphismWithFixedSourceAndRangeByInteger( cat,
      
      function( M, N, n )
        
        return RandomMorphismWithFixedSourceAndRangeByList( M, N, [ 1 .. n ] * One( field ) );
        
    end );

end;

