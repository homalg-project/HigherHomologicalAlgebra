

##
BindGlobal( "IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE",
    function( N )
      return IsZero( HilbertPolynomial( AsPresentationInHomalg( N ) ) );
end );

##
InstallMethod( CoherentSheavesOverProjectiveSpace,
          [ IsHomalgGradedRing ],
  function( S )
    local graded_lp_cat_sym, sub_cat;
    
    graded_lp_cat_sym := GradedLeftPresentations( S );
    
    sub_cat := FullSubcategoryByMembershipFunction( graded_lp_cat_sym, IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE );
    
    return graded_lp_cat_sym / sub_cat;
    
end );


