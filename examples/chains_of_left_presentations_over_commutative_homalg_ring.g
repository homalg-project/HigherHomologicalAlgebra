LoadPackage( "RingsForHomalg" );
LoadPackage( "ModulePresentations" );
LoadPackage( "ComplexesForCAP" );

compute_lifts_in_chains := 
	function( alpha, beta )
	  local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_P_N, internal_hom_id_P_beta, k_internal_hom_id_P_beta_0, alpha_1, lift;
	  cat := CapCategory( alpha );
	  U := TensorUnit( cat );
	  P := Source( alpha );
	  N := Range( alpha );
	  M := Source( beta );

	  alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
	  beta_  := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );

	  internal_hom_id_P_beta := InternalHomOnMorphisms( IdentityMorphism( P ), beta );
	  internal_hom_P_M := Source( internal_hom_id_P_beta );
	  internal_hom_P_N := Range( internal_hom_id_P_beta );

	  k_internal_hom_id_P_beta_0 := KernelLift( internal_hom_P_N^0,
	  	PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_id_P_beta[ 0 ]  ) );
	  
	  alpha_1 := KernelLift( internal_hom_P_N^0, alpha_[0] );

	  lift := Lift( alpha_1, k_internal_hom_id_P_beta_0 );
	  
	  if lift = fail then
	    	return fail;
	  else

	  	lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );

	  	return InternalHomToTensorProductAdjunctionMap( P, M, lift );
	  fi;
end;

compute_colifts_in_chains := 
	function( alpha, beta )
	  local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_N_M, internal_hom_alpha_id_M, k_internal_hom_alpha_id_M_0, beta_1, lift;
	  cat := CapCategory( alpha );
	  U := TensorUnit( cat );
	  P := Range( alpha );
	  N := Source( alpha );
	  M := Range( beta );

	  alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
	  beta_  := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );

	  internal_hom_alpha_id_M := InternalHomOnMorphisms( alpha, IdentityMorphism( M ) );
	  internal_hom_P_M := Source( internal_hom_alpha_id_M );
	  internal_hom_N_M := Range( internal_hom_alpha_id_M );

	  k_internal_hom_alpha_id_M_0 := KernelLift( internal_hom_N_M^0,
	  	PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_alpha_id_M[ 0 ]  ) );
	  
	  beta_1 := KernelLift( internal_hom_N_M^0, beta_[0] );

	  lift := Lift( beta_1, k_internal_hom_alpha_id_M_0 );

	  if lift = fail then
	  	return fail;
	  else  
                lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );

	  	return InternalHomToTensorProductAdjunctionMap( P, M, lift );
	  fi;

end;

generators_of_hom := 
    function( C, D )
    local chains, H, kernel_mor_of_H, kernel_obj_of_H, morphisms_C_to_D, morphisms_from_R_to_kernel, morphisms_from_T_to_H, T;
    chains := CapCategory( C );
    H := InternalHomOnObjects( C, D );
    kernel_mor_of_H := CyclesAt( H, 0 );
    kernel_obj_of_H := Source( kernel_mor_of_H );
    morphisms_from_R_to_kernel := List( [ 1 .. NrColumns( UnderlyingMatrix( kernel_obj_of_H ) ) ], i-> StandardGeneratorMorphism( kernel_obj_of_H, i ) );;
    T := TensorUnit( chains );
    morphisms_from_T_to_H := List( morphisms_from_R_to_kernel, m -> ChainMorphism( T, H, [ PreCompose( m, kernel_mor_of_H) ], 0 ) );
    return List( morphisms_from_T_to_H, m-> InternalHomToTensorProductAdjunctionMap( C, D, m ) );
end;

compute_homotopy_chain_morphisms_for_null_homotopic_morphism := 
    function( f )
    local B, C, colift;
    if not IsNullHomotopic( f ) then
        return fail;
    fi;
    B := Source( f );
    C := Range( f );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( f ) ) ), f );
    if colift = fail then 
      return fail;
    else
      return MapLazy( IntegersList, 
      		n -> PreCompose( 
		MorphismBetweenDirectSums( [ [ IdentityMorphism( B[ n ] ), ZeroMorphism( B[ n ], B[ n + 1 ] ) ] ] ),
		colift[ n + 1 ] ), 1 );
    fi;
    # Here: l[n]: B[n] --> C[n+1], n in Z.
end;

quit;
##################################

# R := HomalgFieldOfRationals( );
# R := HomalgFieldOfRationalsInSingular()*"x,y,z";;
# R := R/( "x*y-z^3"/R );

R := HomalgFieldOfRationalsInSingular()*"x,y,z,t";

cat := LeftPresentations( R: FinalizeCategory := false );
AddEpimorphismFromSomeProjectiveObject( cat, CoverByFreeModule );
SetIsAbelianCategoryWithEnoughProjectives( cat, true );
Finalize( cat );

chains := ChainComplexCategory( cat : FinalizeCategory := false );
AddLift( chains, compute_lifts_in_chains );
AddColift( chains, compute_colifts_in_chains );
AddIsNullHomotopic( chains, phi -> not Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) = fail );
AddHomotopyMorphisms( chains, compute_homotopy_chain_morphisms_for_null_homotopic_morphism );
Finalize( chains );

#################################

# \begin{tikzcd}
# 0 \arrow[rd, "0", dashed] & 
# R/\langle xy \rangle \arrow[l] \arrow[d, "(zt)"'] \arrow[rd, "(z)", dashed] &
# R/\langle x \rangle \arrow[l, "(y)"'] \arrow[d, "(yz)"] \arrow[rd, "0", dashed] & 0 \arrow[l] \\
# 0 & R/\langle xyt \rangle \arrow[l] & R/\langle xy \rangle \arrow[l, "(t)"] & 0 \arrow[l]
# \end{tikzcd}

A4 := AsLeftPresentation( HomalgMatrix( "[ [ x ] ]",1,1,R) );
A3 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1,R) );
B4 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1,R) );
B3 := AsLeftPresentation( HomalgMatrix( "[ [ xyt ] ]",1,1,R) );
a43 := PresentationMorphism( A4, HomalgMatrix( "[ [ y ] ]",1,1, R ), A3 );
b43 := PresentationMorphism( B4, HomalgMatrix( "[ [ t ] ]",1,1, R ), B3 );
CA := ChainComplex( [ a43 ], 4 );
CB := ChainComplex( [ b43 ], 4 );
phi3 := PresentationMorphism( A3, HomalgMatrix( "[ [ zt ] ]",1,1, R ), B3 );
phi4 := PresentationMorphism( A4, HomalgMatrix( "[ [ yz ] ]",1,1, R ), B4 );
phi := ChainMorphism( CA, CB, [ phi3, phi4 ], 3 );
IsZeroForMorphisms( phi );
IsNullHomotopic( phi );
# true
h := HomotopyMorphisms( phi );
Display( h[ 3 ] );

