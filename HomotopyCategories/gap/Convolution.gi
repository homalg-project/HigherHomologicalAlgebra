# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#



##
InstallMethod( PostnikovSystemAtOp,
          [ IsCochainComplex, IsInt ],
  
  function ( C, m )
    local complexes_cat, underlying_cat, cat, u, st_cocone, l, f, g, w, delta;
    
    complexes_cat := CapCategory( C );
    underlying_cat := UnderlyingCategory( complexes_cat );
    cat := DefiningCategory( underlying_cat );
    
    u := UpperBound( C );
    
    if m <= u-2 then
        
        return PostnikovSystemAt( PostnikovSystemAt( C, m+1 ), m );
        
    elif m = u-1 then
      
      st_cocone := StandardCoConeObject( C^(u-1) );
      
      l := LowerBound( C );
      
      if l <= u-2 then
        
        f := C^(u-2);
        g := C^(u-1);
        
        w := WitnessForBeingHomotopicToZeroMorphism( AdditiveInverseForMorphisms( underlying_cat, PreCompose( underlying_cat, f, g ) ) );
        
        delta := CreateComplexMorphism(
                    underlying_cat,
                    C[u-2],
                    i -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, [ C[u-1][i], C[u][i-1] ], C[u-2][i], [ f[i], w[i] ], st_cocone[i] ),
                    st_cocone );
        
        return CreateComplex( complexes_cat, Concatenation( List( [ l .. u-3 ], i -> C^i ), [ delta ] ), l ); # supported at [ l .. u-1 ] = [ l .. m ]
        
      else
        
        return CreateComplex( complexes_cat, st_cocone, m );
        
      fi;
    
    else
      
      return C;
      
    fi;
    
end );

##
InstallOtherMethod( PostnikovSystemAt,
            [ IsHomotopyCategoryObject, IsInt ],
  
  { C, m } -> PostnikovSystemAt( UnderlyingCell( C ), m )
);

##
InstallMethod( Convolution,
          [ IsCochainComplex ],
  
  C ->  ApplyShift( PostnikovSystemAt( C, LowerBound( C ) )[LowerBound( C )], -LowerBound( C ) )
);

##
InstallOtherMethod( Convolution,
          [ IsHomotopyCategoryObject ],
  
  C ->  Convolution( UnderlyingCell( C ) )
);

##
InstallMethod( PostnikovSystemAtOp,
          [ IsCochainMorphism, IsInt ],
  
  function ( alpha, m )
    local complexes_cat, underlying_cat, u, st_cocone_morphism, s, r, l, morphisms;
    
    complexes_cat := CapCategory( alpha );
    underlying_cat := UnderlyingCategory( complexes_cat );
    
    u := UpperBound( alpha );
    
    if m <= u-2 then
      
      return PostnikovSystemAt( PostnikovSystemAt( alpha, m+1 ), m );
      
    elif m = u-1 then
      
      st_cocone_morphism := InverseShiftOfMorphism( MorphismBetweenStandardConeObjects( Source( alpha )^m, alpha[m], alpha[m+1], Range( alpha )^m ) );
      
      l := LowerBound( alpha );
      
      return CreateComplexMorphism(
                complexes_cat,
                PostnikovSystemAt( Source( alpha ), m ),
                PostnikovSystemAt( Range( alpha ), m ),
                Concatenation( List( [ l .. u-2 ], i -> alpha[i] ), [ st_cocone_morphism ] ),
                Minimum( l, m ) );
    
    else
      
      return alpha;
      
    fi;
    
end );

##
InstallOtherMethod( PostnikovSystemAt,
            [ IsHomotopyCategoryMorphism, IsInt ],
  
  { alpha, m } -> PostnikovSystemAt( UnderlyingCell( alpha ), m )
);

##
InstallMethod( Convolution,
          [ IsCochainMorphism ],
  
  alpha ->  ApplyShift( PostnikovSystemAt( alpha, LowerBound( alpha ) )[LowerBound( alpha )], -LowerBound( alpha ) )
);

##
InstallOtherMethod( Convolution,
          [ IsHomotopyCategoryMorphism ],
  
  alpha ->  Convolution( UnderlyingCell( alpha ) )
);

