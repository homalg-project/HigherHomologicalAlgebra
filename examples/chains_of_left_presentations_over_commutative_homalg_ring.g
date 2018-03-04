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



