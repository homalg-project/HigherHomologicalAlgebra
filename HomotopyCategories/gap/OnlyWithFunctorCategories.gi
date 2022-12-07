







##
InstallOtherMethod( WeakCokernelProjection,
          [ IsAdditiveClosureCategory, IsAdditiveClosureMorphism ],
  
  function ( additive_closure, alpha )
    local underlying_category, underlying_category_op, additive_closure_op, S, R, matrix, alpha_op, kappa;
    
    underlying_category := UnderlyingCategory( additive_closure );
    
    underlying_category_op := OppositeAlgebroid( underlying_category );
    additive_closure_op := AdditiveClosure( underlying_category_op );
    
    S := List( ObjectList( Source( alpha ) ), o ->  SetOfObjects( underlying_category_op )[VertexIndex( UnderlyingVertex( o ) )] );
    R := List( ObjectList( Range ( alpha ) ), o ->  SetOfObjects( underlying_category_op )[VertexIndex( UnderlyingVertex( o ) )] );
    
    matrix := MorphismMatrix( alpha );
    
    matrix := List( [ 1 .. Length(R) ], j -> List( [ 1 .. Length(S) ], i -> MorphismInAlgebroid( R[j], OppositeAlgebraElement( UnderlyingQuiverAlgebraElement( matrix[i][j] ) ), S[i] ) ) );
    
    alpha_op := AdditiveClosureMorphism( AdditiveClosureObject( additive_closure_op, R ), matrix, AdditiveClosureObject( additive_closure_op, S ) );
    
    kappa := WeakKernelEmbedding( alpha_op );
    
    S := List( ObjectList( Source( kappa ) ), o ->  SetOfObjects( underlying_category )[VertexIndex( UnderlyingVertex( o ) )] );
    R := List( ObjectList( Range ( kappa ) ), o ->  SetOfObjects( underlying_category )[VertexIndex( UnderlyingVertex( o ) )] );
    
    matrix := MorphismMatrix( kappa );
    
    matrix := List( [ 1 .. Length(R) ], j -> List( [ 1 .. Length(S) ], i -> MorphismInAlgebroid( R[j], OppositeAlgebraElement( UnderlyingQuiverAlgebraElement( matrix[i][j] ) ), S[i] ) ) );
    
    return AdditiveClosureMorphism( AdditiveClosureObject( additive_closure, R ), matrix, AdditiveClosureObject( additive_closure, S ) );
    
end );

##
InstallOtherMethod( WeakKernelEmbedding,
          [ IsAdditiveClosureCategory, IsAdditiveClosureMorphism ],
  
  function ( additive_closure, alpha )
    local underlying_category, PSh, U, Y, iota, D, morphisms, projective_cover_data, K, matrix;
    
    underlying_category := UnderlyingCategory( additive_closure );
    
    if not IsAlgebroid( underlying_category ) then
      TryNextMethod( );
    fi;
    
    PSh := PreSheaves( underlying_category );
    
    U := IsomorphismFromImageOfYonedaEmbeddingOfSourceIntoSource( PSh );
    
    Y := IsomorphismFromSourceIntoImageOfYonedaEmbeddingOfSource( PSh );
    Y := PreCompose( Y, InclusionFunctor( RangeOfFunctor( Y ) ) );
    
    iota := KernelEmbedding( PSh, ApplyFunctor( ExtendFunctorToAdditiveClosureOfSource( Y ), alpha ) );
    
    D := List( ObjectList( Source( alpha ) ), v -> ApplyFunctor( Y, v ) );
    
    morphisms := List( [ 1 .. Length( D ) ], k -> PreCompose( iota, ProjectionInFactorOfDirectSumWithGivenDirectSum( D, k, Range( iota ) ) ) );
    
    projective_cover_data := ProjectiveCoverObjectDataOfPreSheaf( Source( iota ) );
    
    K := AdditiveClosureObject( additive_closure, List( projective_cover_data, pi -> ApplyFunctor( U, AsSubcategoryCell( SourceOfFunctor( U ), Source( pi ) ) ) ) );
    
    matrix := List( projective_cover_data, pi -> List( morphisms, m -> ApplyFunctor( U, AsSubcategoryCell( SourceOfFunctor( U ), PreCompose( PSh, pi, m ) ) ) ) );
    
    return AdditiveClosureMorphism( additive_closure, K, matrix, Source( alpha ) );
    
end );







