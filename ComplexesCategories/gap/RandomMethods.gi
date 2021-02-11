# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##
InstallMethod( RandomObjectByList,
          [ IsCochainComplexCategory, IsList ],
  function( cochains, L )
    return
      AsCochainComplex(
          RandomObjectByList(
              ChainComplexCategory( UnderlyingCategory( cochains ) ),
              [ -L[2], -L[1], L[3] ]
          )
      );
end );

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
        
        Add( diffs, map );
        
      od;
      
      return ChainComplex( diffs, m + 1 );
      
    fi;
    
end, -1 );

##
InstallMethod( RandomObjectByInteger,
          [ IsCochainComplexCategory, IsInt ],
  function( cochains, n )
    
    return RandomObjectByList( cochains, [ -AbsInt( n ), AbsInt( n ), Int( n / 2 ) + 1 ] );
    
end, -1 );

##
InstallMethod( RandomObjectByInteger,
          [ IsChainComplexCategory, IsInt ],
  function( chains, n )
    
    return RandomObjectByList( chains, [ -AbsInt( n ), AbsInt( n ), Int( n / 2 ) + 1 ] );
    
end, -1 );

## L is list with one integer entry
##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsBoundedChainOrCochainComplex, IsBoundedChainOrCochainComplex, IsList ],
  function( C, D, L )
    local b;
    
    if not CanCompute( CapCategory( C ), "BasisOfExternalHom" ) then
      
      TryNextMethod( );
      
    fi;
    
    b := BasisOfExternalHom( C, D );
    
    if IsEmpty( b ) then
      return ZeroMorphism( C, D );
    fi;
    
    return Sum( List( [ 0 .. AbsInt( L[ 1 ] ) ], i -> Random( b ) ) );
    
end, -1 );


## L is list with one integer entry
##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsBoundedChainOrCochainComplex, IsBoundedChainOrCochainComplex, IsList ],
  function( C, D, L )
    local complexes, range_cat, H_CD, U, r;
    
    complexes := CapCategory( C );
    
    if not CanCompute( complexes, "HomomorphismStructureOnObjects" ) then
      
      TryNextMethod( );
      
    fi;
    
    range_cat := RangeCategoryOfHomomorphismStructure( complexes );
    
    #if not CanCompute( range_cat, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
    #  TryNextMethod( );
      
    #fi;
      
    H_CD := HomomorphismStructureOnObjects( C, D );
    
    U := DistinguishedObjectOfHomomorphismStructure( complexes );
    
    r := RandomMorphismWithFixedSourceAndRangeByInteger( U, H_CD, L[ 1 ] );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C, D, r );
    
end, -1 );


##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsBoundedChainOrCochainComplex, IsBoundedChainOrCochainComplex, IsInt ],
  function( C, D, n )
    
    return RandomMorphismWithFixedSourceAndRangeByList( C, D, [ n ] );
    
end, -1 );

##
InstallMethod( RandomMorphismWithFixedSourceByList,
          [ IsBoundedChainOrCochainComplex, IsList ],
  function( C, L )
    local D;
    
    D := RandomObjectByList( CapCategory( C ), L[ 1 ] );
    
    return RandomMorphismWithFixedSourceAndRangeByList( C, D, L[ 2 ] );
    
end, -1 );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsBoundedChainOrCochainComplex, IsInt ],
  function( C, n )
    
    return RandomMorphismWithFixedSourceByList( C,
            [ [ -AbsInt( n ), AbsInt( n ), Int( n / 2 ) + 1 ], [ Int( n / 2 ) + 1 ] ]
              );
    
end, -1 );

##
InstallMethod( RandomMorphismWithFixedRangeByList,
          [ IsBoundedChainOrCochainComplex, IsList ],
  function( D, L )
    local C;
    
    C := RandomObjectByList( CapCategory( D ), L[ 1 ] );
    
    return RandomMorphismWithFixedSourceAndRangeByList( C, D, L[ 2 ] );
    
end, -1 );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsBoundedChainOrCochainComplex, IsInt ],
  function( D, n )
    
    return RandomMorphismWithFixedRangeByList( D,
            [ [ -AbsInt( n ), AbsInt( n ), Int( n / 2 ) + 1 ], [ Int( n / 2 ) + 1 ] ]
              );
    
end, -1 );

##
InstallMethod( RandomMorphismByList,
          [ IsChainOrCochainComplexCategory, IsList ],
  function( complex_cat, L )
    local C;
    
    C := RandomObjectByList( complex_cat, L[ 1 ] );
    
    return RandomMorphismWithFixedSourceByList( C, [ L[ 2 ], L[ 3 ] ] );
    
end, -1 );

##
InstallMethod( RandomMorphismByInteger,
          [ IsChainOrCochainComplexCategory, IsInt ],
  function( complex_cat, n )
    local C;
    
    C := RandomObjectByInteger( complex_cat, n );
    
    return RandomMorphismWithFixedSourceByInteger( C, n );
    
end, -1 );

