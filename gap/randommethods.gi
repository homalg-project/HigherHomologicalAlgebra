
##
InstallMethod( RandomObjectByList,
          [ IsChainComplexCategory, IsList ],
  function( chains, L )
    local m, n, c, cat, o, map, weak, diffs, j, current_map, current_weak, r, k, bool;
    
    m := L[ 1 ];
    
    n := L[ 2 ];
    
    c := L[ 3 ];
    
    cat := UnderlyingCategory( chains );
    
    o := RandomObject( cat, c );
    
    if m > n then
      
      return ZeroObject( chains );
      
    elif m = n then
      
      return StalkChainComplex( o, m );
      
    else
      
      map := UniversalMorphismIntoZeroObject( o );
      
      weak := IdentityMorphism( o );
      
      diffs := [ ];
      
      for r in [ m .. n - 1 ] do
        
        if not IsZeroForMorphisms( weak ) then
          
          bool := false;
          
          for k in [ 1 .. 10 ] do
            
            j := RandomMorphismWithFixedRange( Source( weak ), c + Random( [ 0, 1 ] ) );
            
            current_map := PreCompose( j, weak );
            
            current_weak := _WeakKernelEmbedding( current_map );
            
            if not IsZero( current_map ) and not IsZero( current_weak ) then
              
              bool := true;
              
              map := current_map;
              
              weak := current_weak;
              
              break;
              
            fi;
            
          od;
          
          if bool = false then
            
            map := ZeroMorphism( RandomObject( cat, c ), Source( map ) );
            
            weak := IdentityMorphism( Source( map ) );
           
          fi;
          
        else
          
          map := ZeroMorphism( RandomObject( cat, c ), Source( map ) );
          
          weak := IdentityMorphism( Source( map ) );
          
        fi;
        
        if diffs <> [ ] and not IsZero( PreCompose( map, diffs[0] ) ) then
          Error( "??" );
        fi;
        
        Add( diffs, map );
        
      od;
      
      return ChainComplex( diffs, m + 1 );
      
    fi;
    
end );

