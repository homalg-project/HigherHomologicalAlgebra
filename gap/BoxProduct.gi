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

##
InstallMethodWithCache( BoxProductFunctor,
          [ IsQuiverAlgebra, IsQuiverAlgebra ],
  { A, B } -> BoxProductFunctor( TensorProductOfAlgebras( A, B ) )
);

##
InstallMethodWithCache( EmbeddingFromProductOfAlgebroidsIntoTensorProduct,
          [ IsAlgebroid, IsAlgebroid ],
  function( A, B )
    local product_AB, tensor_AB, name, F;
    
    product_AB := Product( A, B );
    
    tensor_AB := TensorProductOnObjects( A, B );
    
    name := "Tensor product functor";
    
    F := CapFunctor( name, product_AB, tensor_AB );
    
    AddObjectFunction( F,
      a -> ElementaryTensor( a[ 1 ], a[ 2 ], tensor_AB )
    );
    
    AddMorphismFunction( F,
      { s, alpha, r } -> PreCompose(
                            ElementaryTensor( Source( alpha[ 1 ] ), alpha[ 2 ], tensor_AB ),
                            ElementaryTensor( alpha[ 1 ], Range( alpha[ 2 ] ), tensor_AB )
                          )
    );
    
    return F;
    
end );

##
InstallMethod( ExtendFunctorFromProductCategoryToAdditiveClosures,
          [ IsCapFunctor ],
  function( F )
    local product_cat, range_cat, A_1, A_2, product_add_cat, range_add_cat, FF;
    
    product_cat := AsCapCategory( Source( F ) );
    
    if not IsCapProductCategory( product_cat ) then
      
      Error( "The source of the functor should be a product category" );
      
    fi;
    
    range_cat := AsCapCategory( Range( F ) );
    
    A_1 := product_cat[ 1 ];
    A_2 := product_cat[ 2 ];
    
    A_1 := AdditiveClosure( A_1 );
    A_2 := AdditiveClosure( A_2 );
    
    product_add_cat := Product( A_1, A_2 );
    range_add_cat := AdditiveClosure( range_cat );
    
    FF := CapFunctor( "Extension of a functor from product category to additive closures", product_add_cat, range_add_cat );
    
    AddObjectFunction( FF,
      function( product_object )
        local list_1, list_2;
        
        list_1 := ObjectList( product_object[ 1 ] );
        
        list_2 := ObjectList( product_object[ 2 ] );
        
        if IsEmpty( list_1 ) or IsEmpty( list_2 ) then
          
          return ZeroObject( range_add_cat );
          
        else
          
          return ListX( list_1, list_2, { a, b } -> ApplyFunctor( F, [ a, b ] / product_cat ) ) / range_add_cat;
        
        fi;
    end );
    
    AddMorphismFunction( FF,
      function( s, product_morphism, r )
        local matrix_1, matrix_2;
        
        matrix_1 := MorphismMatrix( product_morphism[ 1 ] );
        
        matrix_2 := MorphismMatrix( product_morphism[ 2 ] );
        
        if IsEmpty( matrix_1 ) or IsEmpty( matrix_1[ 1 ] ) or IsEmpty( matrix_2 ) or IsEmpty( matrix_2[ 1 ] ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return ListX(matrix_1, matrix_2, {row_1,row_2} -> ListX( row_1, row_2, { s, t } -> ApplyFunctor( F, [ s, t ] / product_cat ) ) ) / range_add_cat;
        
        fi;
        
    end );
    
    return FF;
    
end );

##
InstallMethod( ProductOfFunctors,
          [ IsCapProductCategory, IsList, IsCapProductCategory ],
  function( S, functors, R )
    local F;
    
    #S := Product( List( functors, func -> AsCapCategory( Source( func ) ) ) );
    
    #R := Product( List( functors, func -> AsCapCategory( Range( func ) ) ) );
    
    F := CapFunctor( "Product of functors", S, R );
    
    AddObjectFunction( F,
      object -> ListN( functors, Components( object ), { func, o } -> ApplyFunctor( func, o ) ) / R
    );

    AddMorphismFunction( F,
      { s, morphism, r }
        -> ListN( functors, Components( morphism ), { func, m } -> ApplyFunctor( func, m ) ) / R
    );
    
    return F;
    
end );

