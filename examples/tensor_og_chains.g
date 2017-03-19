LoadPackage( "ModulePresentations" );
LoadPackage( "complex" );

tensor_product_on_chain_complexes := 
 function( C1, C2 )
 local R, V, C;

 R := function( i, j )
      return TensorProductOnMorphisms( C1^i, IdentityMorphism( C2[ j ] ) );
      end;

 V := function( i, j )
      return (-1)^i*TensorProductOnMorphisms( IdentityMorphism( C1[ i ] ), C2^j );
      end;

 C := DoubleChainComplex( R, V );

 if HasActiveUpperBound( C1 ) then 
    SetRightBound( C, ActiveUpperBound( C1 ) - 1 );
 fi;

 if HasActiveLowerBound( C1 ) then 
    SetLeftBound( C, ActiveLowerBound( C1 ) + 1 );
 fi;

 if HasActiveUpperBound( C2 ) then 
    SetAboveBound( C, ActiveUpperBound( C2 ) - 1 );
 fi;

 if HasActiveLowerBound( C2 ) then 
    SetBelowBound( C, ActiveLowerBound( C2 ) + 1 );
 fi;

 return TotalChainComplex( C );

end;


