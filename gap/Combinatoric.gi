
#InstallMethodWithCache( 

##
COEFFICIENTS_OF_MROPHISM :=
  function( phi, B )
    local S, k, list_of_entries, N, sol, current_position, position_of_non_zero_entry, current_entry, current_coeff_mat, current_coeff, current_mono, position_in_basis, j;
    
    S := UnderlyingHomalgRing( phi );
    
    k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
    
    B := List( B, b -> EntriesOfHomalgMatrix( UnderlyingMatrix( b ) ) );
    
    if B = [  ] then
      
      return [  ];

    fi;
    
    list_of_entries := EntriesOfHomalgMatrix( UnderlyingMatrix( phi ) );
    
    N := Size( list_of_entries );
    
    sol := ListWithIdenticalEntries( Size( B ), Zero( k ) );
    
    current_position := 0;
    
    while current_position < N do
      
      position_of_non_zero_entry := PositionProperty( [ current_position + 1.. N ], p -> not IsZero( list_of_entries[ p ] ) );
      
      if position_of_non_zero_entry = fail then
        
        break;
        
      fi;
      
      position_of_non_zero_entry := position_of_non_zero_entry + current_position;
       
      current_entry := list_of_entries[ position_of_non_zero_entry ];
      current_coeff_mat := Coefficients( EvalRingElement( current_entry ) );
      
      for j in [ 1 .. NrRows( current_coeff_mat ) ] do
        
        current_coeff := current_coeff_mat[ j, 1 ];
        current_mono := current_coeff_mat!.monomials[ j ]/S;
        position_in_basis := PositionProperty( B, b -> b[ position_of_non_zero_entry ] = current_mono );
        sol[ position_in_basis ] := current_coeff/k;
        
      od;
      
      current_position := position_of_non_zero_entry;

    od;
    
    return sol;

end;

