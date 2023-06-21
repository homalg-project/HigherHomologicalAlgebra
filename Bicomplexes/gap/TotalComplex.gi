# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#



BindGlobal( "TOTAL_COMPLEX_OF_BICOMPLEX",
  
  function( obj, sign )
    local bicomplexes_cat, complexes_cat, cat, l, b, r, a, indices, direct_summands, objs, diffs;
    
    bicomplexes_cat := CapCategory( obj );
    complexes_cat := UnderlyingCategory( ModelingCategory( bicomplexes_cat ) );
    cat := UnderlyingCategory( complexes_cat );
    
    l := LeftBound( obj );
    b := BelowBound( obj );
    r := RightBound( obj );
    a := AboveBound( obj );
    
    if IsInt( l ) and IsInt( b ) then
        indices := AsZFunction( index -> List( [ 0 .. index - l - b ], i -> [ l + i, index - l - i ] ) );
    elif IsInt( r ) and IsInt( a ) then
        indices := AsZFunction( index -> List( [ 0 .. r + a - index ], i -> [ r - i, index - r + i ] ) );
    elif IsInt( l ) and IsInt( r ) then
        indices := AsZFunction( index -> List( [ l .. r ], i -> [ i, index - i ] ) );
    elif IsInt( b ) and IsInt( a ) then
        indices := AsZFunction( index -> List( [ b .. a ], j -> [ index - j, j ] ) );
    else
        Error( "the total complex can not be computed!" );
    fi;
    
    direct_summands := ApplyMap( indices, list_of_pairs -> List( list_of_pairs, p -> ObjectAt( obj, p[1], p[2] ) ) );
    
    objs := ApplyMap( direct_summands, list_of_objects -> DirectSum( cat, list_of_objects ) );
    
    diffs := AsZFunction(
                index -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              objs[ index ],
                              direct_summands[index],
                              List( indices[index],
                                s -> List( indices[index+sign],
                                  function (r)
                                    if s[1] = r[1] then
                                      return VerticalDifferentialAt( obj, s[1], s[2] );
                                    elif s[2] = r[2] then
                                      return HorizontalDifferentialAt( obj, s[1], s[2] );
                                    else
                                      return ZeroMorphism( cat, ObjectAt( obj, s[1], s[2] ), ObjectAt( obj, r[1], r[2] ) );
                                    fi;
                              end ) ),
                              direct_summands[index+sign],
                              objs[index+sign]
                            ) );
    
    return CreateComplex( complexes_cat, objs, diffs, l+b, r+a );
    
end );

##
InstallMethod( TotalComplex,
          [ IsCochainBicomplex ],
  
  obj -> TOTAL_COMPLEX_OF_BICOMPLEX( obj, 1 )
);

##
InstallMethod( TotalComplex,
          [ IsChainBicomplex ],
  
  obj -> TOTAL_COMPLEX_OF_BICOMPLEX( obj, -1 )
);

##
InstallMethod( TotalComplexFunctorial,
          [ IsChainOrCochainComplex, IsChainOrCochainBicomplexMorphism, IsChainOrCochainComplex ],
  
  function( source, mor, range )
    local bicomplexes_cat, complexes_cat, cat, s_objs, s_direct_summands, s_indices, r_objs, r_direct_summands, r_indices, mors;
    
    bicomplexes_cat := CapCategory( mor );
    complexes_cat := UnderlyingCategory( ModelingCategory( bicomplexes_cat ) );
    cat := UnderlyingCategory( complexes_cat );
    
    s_objs := Objects( source );
    s_direct_summands := BaseZFunctions( s_objs )[1];
    s_indices := BaseZFunctions( s_direct_summands )[1];
    
    r_objs := Objects( range );
    r_direct_summands := BaseZFunctions( r_objs )[1];
    r_indices := BaseZFunctions( r_direct_summands )[1];
    
    mors := AsZFunction(
              index -> MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                              s_objs[ index ],
                              s_direct_summands[index],
                              ListN( s_direct_summands[index], s_indices[index],
                                {direct_summand_s, s} -> ListN( r_direct_summands[index], r_indices[index],
                                  function (direct_summand_r, r)
                                    if s = r then
                                      return MorphismAt( mor, s[1], s[2] );
                                    else
                                      return ZeroMorphism( cat, direct_summand_s, direct_summand_r );
                                    fi;
                              end ) ),
                              r_direct_summands[index],
                              r_objs[index]
                            ) );
    
    return CreateComplexMorphism( complexes_cat, source, mors, range );
    
end );

