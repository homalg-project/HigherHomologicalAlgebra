#################################
#
# Tensor product on quiver reps
#
################################

##
InstallMethod( BoxProductFunctor,
  [ IsQuiverAlgebra and HasTensorProductFactors ],
  function( A )
    local algebras, cat, cats, product_cat, n, name, F;
     
    algebras := TensorProductFactors( A );
    
    cat := CategoryOfQuiverRepresentations( A );
    
    cats := List( algebras, CategoryOfQuiverRepresentations );
    
    product_cat := CallFuncList( Product, cats );
    
    n := Length( cats );
    
    name := "Box Product functor";
    
    F := CapFunctor( name, product_cat, cat );
    
    # M_1 x M_2 x ... x M_n -> M_1 ⊠ M_2 ⊠ ... ⊠ M_n
    AddObjectFunction( F,
      function( product_obj )
        local objects, matrices, identity_matrices, kronecker_product, mats, current, v, i;
        
        objects := List( [ 1 .. n ], i -> product_obj[ i ] );
        
        matrices := List( objects, MatricesOfRepresentation );
        
        identity_matrices := List( objects, 
                            a -> List( DimensionVector( a ),
                              d -> IdentityMatrix( LeftActingDomain( A ), d ) )
                          );
        
        kronecker_product :=
          function( L )
            return Iterated( L, KroneckerProduct );
        end;
        
        n := Length( objects );
        
        mats := [ ];
        
        for i in Reversed( [ 1 .. n ] ) do
          
          current := ShallowCopy( identity_matrices );
          
          current[ i ] := matrices[ i ];
          
          mats := Concatenation( mats, List( Cartesian( current ), kronecker_product ) );
          
        od;
        
        v :=  List( Cartesian( List( objects, DimensionVector ) ), Product );
        
        return QuiverRepresentation( A, v, mats );
        
    end );
    
    # f_1 x f_2 x ... x f_n -> f_1 ⊠ f_2 ⊠ ... ⊠ f_n
    AddMorphismFunction( F,
      function( source, product_mor, range )
        local list_of_mors, matrices, kronecker_product;
        
        list_of_mors := List( [ 1 .. n ], i -> product_mor[ i ] );
        
        matrices := List( list_of_mors, MatricesOfRepresentationHomomorphism );
        
        kronecker_product :=
          function( L )
            return Iterated( L, KroneckerProduct );
        end;;
        
        matrices := List( Cartesian( matrices ), kronecker_product );
        
        return QuiverRepresentationHomomorphism( source, range, matrices );
        
    end );

    return F;
    
end );

