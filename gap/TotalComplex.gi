
# concentrated in
# x0 =< x =< x1
#
InstallGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX",
function( C, x0, x1 )
  local d, cat, diff;

  if x0 > x1 then return TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, x1, x0 );fi;
  cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( C ) ) ) ); 

  diff := MapLazy( IntegersList, 
        function( m )
        local list;
        C!.IndicesOfTotalComplex.( String( m ) ) := [ x0, x1 ];
        list := List( [ 1 .. x1 - x0 + 1 ], 
                        i ->   List( [ 1 .. x1 - x0 + 1 ], 
                                function( j )
                                local zero;
                                zero := ZeroMorphism( ObjectAt( C, x0 + i - 1, m - x0 - i + 1  ), 
                                                      ObjectAt( C, x0 + j - 1, m - x0 - j ) );
                                if i <> j and i - 1 <> j then return zero;
                                elif i = j then return VerticalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                                else return HorizontalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                                fi;
                                end ) );
        return MorphismBetweenDirectSums( list );
        end, 1 );
  return ChainComplex( cat, diff );;

end );

# concentrated in
# y >= y0 and y =< y1
#
InstallGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX",
  function( C, y0, y1 )
  local d, cat, diff;
    
  if y0 > y1 then return TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, y1, y0 );fi;
  cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( C ) ) ) );

  diff := MapLazy( IntegersList, 
        function( m )
        local list;
        C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y1, m - y0 ];
        list := List( [ 1 .. y1 - y0 + 1 ], 
                i ->   List( [ 1 .. y1 - y0 + 1 ], 
                function( j )
                local zero;
                zero := ZeroMorphism( ObjectAt( C, m -y1 + i - 1, y1 - i + 1  ), 
                                      ObjectAt( C, m -y1 + j - 2, y1 - j + 1 ) );
                if i <> j and i + 1 <> j then return zero;
                elif i = j then return HorizontalDifferentialAt( C, m -y1 + i - 1, y1 - i + 1 );
                else return VerticalDifferentialAt( C, m -y1 + i - 1, y1 - i + 1 );
                fi;
                end ) );
        return MorphismBetweenDirectSums( list );
        end, 1 );
  return ChainComplex( cat, diff );

end );

# concentrated in
# x >= x0 and y >= y0
#
InstallGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_HOMOLOGICAL_BICOMPLEX",
function( C, x0, y0 )
  local cat, zero_object, diff;

  cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( C ) ) ) ); 

  zero_object := ZeroObject( cat );

  diff := MapLazy( IntegersList, 
        function( m )
        local l;
        C!.IndicesOfTotalComplex.( String( m ) ) := [ x0, m - y0 ];
        if m = x0 + y0 then 
           return UniversalMorphismIntoZeroObject( ObjectAt( C, x0, y0 ) );
        elif m < x0 + y0 then
           return UniversalMorphismIntoZeroObject( zero_object );
        fi;
        l := List( [ 1 .. m - x0 - y0 + 1 ], 
                i -> List( [ 1 .. m - x0 - y0 ], 
                function( j )
                local zero;
                zero := ZeroMorphism( ObjectAt( C, x0 + i - 1, m - x0 - i + 1  ), 
                                      ObjectAt( C, x0 + j - 1, m - x0 - j ) );
                if i <> j and i - 1 <> j then return zero;
                elif i-1=j then return HorizontalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
                else return VerticalDifferentialAt(C, x0 + i - 1, m - x0 - i + 1 );
                fi;
                end ) );
        return MorphismBetweenDirectSums( l );
        end, 1 );
  return ChainComplex( cat, diff );

end );

# concentrated in
# x <= x0 and y <= y0
#
InstallGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX",
  function( C, x0, y0 )
  local d, cat, zero_object, diff;

  cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( C ) ) ) ); 

  zero_object := ZeroObject( cat );

  diff := MapLazy( IntegersList, 
        function( m )
        local l;
        
        C!.IndicesOfTotalComplex.( String( m ) ) := [ m - y0, x0 ];
        
        if m = x0 + y0 + 1 then 
           return UniversalMorphismFromZeroObject( ObjectAt( C, x0, y0 ) );
        elif m > x0 + y0 + 1 then
           return UniversalMorphismFromZeroObject( zero_object );
        fi;
        l := List( [ 1 .. x0 + y0 -m + 1 ], 
                i -> List( [ 1 .. x0 + y0 -m + 2 ], 
                function( j )
                local zero;
                zero := ZeroMorphism( ObjectAt( C, -y0 + m + i - 1 , y0 - i + 1  ), 
                                      ObjectAt( C, -y0 + m + j - 2 , y0 - j + 1 ) );
                if i <> j and j - 1 <> i then return zero;
                elif i = j then return HorizontalDifferentialAt( C, -y0 + m + i - 1 , y0 - i + 1 );
                else return VerticalDifferentialAt( C, -y0 + m + i - 1 , y0 - i + 1 );
                fi;
                end ) );
        return MorphismBetweenDirectSums( l );
        end, 1 );
  return ChainComplex( cat, diff );
end );

# # concentrated in
# #  x0 =< x =< x1
# #        y =< y1
# 
# BindGlobal( "TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX",
# function( C, x0, x1, y1 )
# local d, cat, diff;
# 
# cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( C ) ) ) ); 
# 
# diff := MapLazy( IntegersList, function( m )
#                                local list;
#                                
#                                
#                                C!.IndicesOfTotalComplex.( String( m ) ) := [ x0, x1 ];
#                                
#                                list := List( [ 1 .. x1 - x0 + 1 ], i ->   List( [ 1 .. x1 - x0 + 1 ], 
#                                                                      function( j )
#                                                                      local zero;
#                                                                      zero := ZeroMorphism( ObjectAt( C, x0 + i - 1, m - x0 - i + 1  ), 
#                                                                                            ObjectAt( C, x0 + j - 1, m - x0 - j ) );
#                                                                      if i <> j and i - 1 <> j then return zero;
#                                                                      elif i = j then return VerticalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
#                                                                      else return HorizontalDifferentialAt( C, x0 + i - 1, m - x0 - i + 1 );
#                                                                      fi;
#                                                                      end ) );
#                                
#                                return MorphismBetweenDirectSums( list );
#                                end, 1 );
# d := ChainComplex( cat, diff );
# 
# #AddToGenesis( d, "UnderlyingDoubleComplex", [ C ] );
# 
# return d;
# 
# end );

InstallMethod( TotalComplex,
               [ IsCapCategoryBicomplexObject and IsCapCategoryHomologicalBicomplexObject ],
    function( C )
    local T;
    
    if HasLeft_Bound( C ) and HasRight_Bound( C ) and HasAbove_Bound( C ) and HasBelow_Bound( C ) then 
       
       if Right_Bound( C ) - Left_Bound( C ) < Above_Bound( C ) - Below_Bound( C ) then 
       
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Left_Bound( C ) + 1, Right_Bound( C ) - 1 );
       
       else
    
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Below_Bound( C ) + 1, Above_Bound( C ) - 1 );
       
       fi;
    
    elif HasLeft_Bound( C ) and HasRight_Bound( C ) then
    
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Left_Bound( C ) + 1, Right_Bound( C ) - 1 );
    
    elif HasAbove_Bound( C ) and HasBelow_Bound( C ) then 
    
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Below_Bound( C ) + 1, Above_Bound( C ) - 1 );
    
    elif HasAbove_Bound( C ) and HasRight_Bound( C ) then 
    
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Right_Bound( C ), Above_Bound( C ) );
    
    elif HasBelow_Bound( C ) and HasLeft_Bound( C ) then 
    
            T :=  TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_HOMOLOGICAL_BICOMPLEX( C, Left_Bound( C ), Below_Bound( C ) );
    else
    
            Error( "The given bicomplex doesn't have the needed bounds" );
        
    fi;
    
    AddToToDoList( ToDoListEntry( [ [ C, "Left_Bound" ], [ C, "Below_Bound" ] ], function( ) 
                                                                                    SetLowerBound( T, Left_Bound( C ) + Below_Bound( C ) + 1 );
                                                                                 end ) );
    
    AddToToDoList( ToDoListEntry( [ [ C, "Right_Bound" ], [ C, "Above_Bound" ] ], function( ) 
                                                                                    SetUpperBound( T, Right_Bound( C ) + Above_Bound( C ) - 1 );
                                                                                  end ) );
    return T;

end );


##

InstallMethod( IndicesUsedToComputeTotalComplexOfBicomplexAtOp,
               [ IsCapCategoryBicomplexObject, IsInt ],
    function( B, m )
    local obj;
    
    # computing obj make it possible to read the indices used to compute obj.
    # which are what we want.
    obj := TotalComplex( B )[ m ];
    
    return B!.IndicesOfTotalComplex.( String( m ) );
    
end );

InstallMethod( TotalComplexFunctorial,
                [ IsCapCategoryBicomplexMorphism and IsCapCategoryHomologicalBicomplexMorphism ],
        
        function( phi )
        local S, tS, R, tR, l;
     
        S := Source( phi );
        tS := TotalComplex( S );
        R := Range( phi );
        tR := TotalComplex( R );
     
        l := MapLazy( IntegersList, 
                function( m )
                local ind_r, ind_s, morphisms;
                ind_s := IndicesUsedToComputeTotalComplexOfBicomplexAt( S, m );
                ind_r := IndicesUsedToComputeTotalComplexOfBicomplexAt( R, m );
                morphisms := List( [ ind_s[1] .. ind_s[2] ],
                        i-> List( [ ind_r[1] .. ind_r[2] ],
                                function( j )
                                
                                if i=j then
                                    return MorphismAt( phi, i, m - i );
                                else
                                    return ZeroMorphism( ObjectAt( S, i, m-i ), ObjectAt( R, j, m-j ) );
                                fi;
                                end ) );
           
                if morphisms = [] or morphisms = [[]] then
                     return ZeroMorphism( tS[m], tR[m] );
                else
                     return MorphismBetweenDirectSums( morphisms );
                fi;
                end, 1 );

        return ChainMorphism( tS, tR, l );
end );

InstallMethod( TotalComplex,
               [ IsCapCategoryBicomplexObject and IsCapCategoryCohomologicalBicomplexObject ],
        function( C )
        local CohCat, HCat, cat, convert, Ch_to_Coch, T;
        CohCat := CapCategory( C );
        cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CohCat ) ) );
        HCat := AsCategoryOfBicomplexes( ChainComplexCategory( ChainComplexCategory( cat ) ) );
        convert := CohomologicalToHomologicalBicomplexsFunctor( CohCat, HCat );
        Ch_to_Coch := ChainToCochainComplexFunctor( ChainComplexCategory( cat ), CochainComplexCategory( cat ) );
        T := TotalComplex( ApplyFunctor( convert, C ) );
        return ApplyFunctor( Ch_to_Coch, T );
end );

InstallMethod( TotalComplexFunctorial,
               [ IsCapCategoryBicomplexMorphism and IsCapCategoryCohomologicalBicomplexMorphism ],
        function( phi )
        local CohCat, HCat, cat, convert, Ch_to_Coch, T;
        CohCat := CapCategory( phi );
        cat := UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CohCat ) ) );
        HCat := AsCategoryOfBicomplexes( ChainComplexCategory( ChainComplexCategory( cat ) ) );
        convert := CohomologicalToHomologicalBicomplexsFunctor( CohCat, HCat );
        Ch_to_Coch := ChainToCochainComplexFunctor( ChainComplexCategory( cat ), CochainComplexCategory( cat ) );
        T := TotalComplexFunctorial( ApplyFunctor( convert, phi ) );
        return ApplyFunctor( Ch_to_Coch, T );
end );