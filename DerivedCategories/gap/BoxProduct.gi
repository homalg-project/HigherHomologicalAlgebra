# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
#
###############################

##
InstallMethod( BoxProduct,
      [ IsCapCategoryObjectInAlgebroid, IsCapCategoryObjectInAlgebroid, IsAlgebroid ],
  ElementaryTensor
);

##
InstallMethod( BoxProduct,
      [ IsCapCategoryMorphismInAlgebroid, IsCapCategoryMorphismInAlgebroid, IsAlgebroid ],
  { alpha_1, alpha_2, algebroid } -> PreCompose(
                                        ElementaryTensor( Source( alpha_1 ), alpha_2, algebroid ),
                                        ElementaryTensor( alpha_1, Range( alpha_2 ), algebroid )
                                      )
);

##
InstallMethod( BoxProduct,
      [ IsAdditiveClosureObject, IsAdditiveClosureObject, IsAdditiveClosureCategory ],
  function( o_1, o_2, additive_closure )
    local underlying_category;
    
    o_1 := ObjectList( o_1 );
    
    o_2 := ObjectList( o_2 );
    
    underlying_category := UnderlyingCategory( additive_closure );
    
    if IsEmpty( o_1 ) or IsEmpty( o_2 ) then
      
      return ZeroObject( additive_closure );
      
    else
      
      return ListX( o_1, o_2, { a, b } -> BoxProduct( a, b, underlying_category ) ) / additive_closure;
      
    fi;
    
end );

##
InstallMethod( BoxProduct,
      [ IsAdditiveClosureMorphism, IsAdditiveClosureMorphism, IsAdditiveClosureCategory ],
  function( alpha_1, alpha_2, additive_closure )
    local matrix_1, matrix_2, s, r, underlying_category;
    
    matrix_1 := MorphismMatrix( alpha_1 );
    
    matrix_2 := MorphismMatrix( alpha_2 );
    
    if ForAny( [ matrix_1, matrix_2 ], m -> IsEmpty( m ) or IsEmpty( m[ 1 ] ) ) then
      
      s := BoxProduct( Source( alpha_1 ), Source( alpha_2 ), additive_closure );
      
      r := BoxProduct( Range( alpha_1 ), Range( alpha_2 ), additive_closure );
      
      return ZeroMorphism( s, r );
      
    else
      
      underlying_category := UnderlyingCategory( additive_closure );
      
      return ListX( matrix_1, matrix_2,
                { row_1, row_2 } ->
                    ListX( row_1, row_2,
                        { m1, m2 } -> BoxProduct( m1, m2, underlying_category )
                         )
                  ) / additive_closure;
                     
    fi;
        
end );

##
InstallMethod( BoxProduct,
          [ IsQuiverRowsObject, IsQuiverRowsObject, IsQuiverRowsCategory ],
  function( o_1, o_2, QRows )
    local quiver_1, quiver_2, quiver, vertices_1, vertices_2, vertices;
    
    quiver_1 := UnderlyingQuiver( CapCategory( o_1 ) );
    
    quiver_2 := UnderlyingQuiver( CapCategory( o_2 ) );
    
    quiver := UnderlyingQuiver( QRows );
    
    vertices_1 := ListOfQuiverVertices( o_1 );
    
    vertices_1 := Concatenation( List( vertices_1,
                    l -> ListWithIdenticalEntries(
                            l[ 2 ],
                            VertexIndex( l[ 1 ] )
                          ) ) );
    
    vertices_2 := ListOfQuiverVertices( o_2 );
    
    vertices_2 := Concatenation( List( vertices_2,
                    l -> ListWithIdenticalEntries(
                            l[ 2 ],
                            VertexIndex( l[ 1 ] )
                          ) ) );
    
    if IsEmpty( vertices_1 ) or IsEmpty( vertices_2 ) then
      
      return ZeroObject( QRows );
      
    else
      
      vertices := ListX( vertices_1, vertices_2,
                    { i, j } -> 
                      [ Vertex( quiver, ProductQuiverVertexIndex( [ quiver_1, quiver_2 ], [ i, j ] ) ), 1 ]
                    );
      
      return QuiverRowsObject( vertices, QRows );
      
    fi;
    
end );

##
InstallMethod( BoxProduct,
          [ IsQuiverRowsMorphism, IsQuiverRowsMorphism, IsQuiverRowsCategory ],
  function( alpha_1, alpha_2, QRows )
    local A, matrix_1, matrix_2, s, r, matrix;
    
    A := UnderlyingQuiverAlgebra( QRows );
        
    matrix_1 := MorphismMatrix( alpha_1 );
    
    matrix_2 := MorphismMatrix( alpha_2 );
    
    s := BoxProduct( Source( alpha_1 ), Source( alpha_2 ), QRows );
    
    r := BoxProduct( Range( alpha_1 ), Range( alpha_2 ), QRows );

    if ForAny( [ matrix_1, matrix_2 ], m -> IsEmpty( m ) or IsEmpty( m[ 1 ] ) ) then
      
      return ZeroMorphism( s, r );
      
    else
      
      matrix := ListX( matrix_1, matrix_2,
                { row_1, row_2 } -> ListX( row_1, row_2,
                  { e_1, e_2 } -> ElementaryTensor( e_1, e_2, A )
                    ) );
      
      return QuiverRowsMorphism( s, matrix, r );
                     
    fi;
     
end );

##
InstallMethod( BoxProduct,
          [ IsList, IsQuiverRepresentationCategory ],
          
  function( objects, cat_reps )
    local A, matrices, identity_matrices, kronecker_product, mats, current, v, i, n;
    
    A := AlgebraOfCategory( cat_reps );
    
    if IsCapCategoryMorphism( objects[ 1 ] ) then
      TryNextMethod( );
    fi;
    
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

##
InstallMethod( BoxProduct,
          [ IsQuiverRepresentation, IsQuiverRepresentation, IsQuiverRepresentationCategory ],
          
  { o_1, o_2, cat_reps } -> BoxProduct( [ o_1, o_2 ], cat_reps )
);

##
InstallMethod( BoxProduct,
          [ IsList, IsQuiverRepresentationCategory ],
          
  function( morphisms, cat_reps )
    local source, range, matrices, kronecker_product;
    
    if IsCapCategoryObject( morphisms[1] ) then
      TryNextMethod( );
    fi;
    
    source := BoxProduct( List( morphisms, Source ), cat_reps );
    
    range := BoxProduct( List( morphisms, Range ), cat_reps );
    
    matrices := List( morphisms, MatricesOfRepresentationHomomorphism );
    
    kronecker_product :=
      function( L )
        return Iterated( L, KroneckerProduct );
    end;;
    
    matrices := List( Cartesian( matrices ), kronecker_product );
    
    return QuiverRepresentationHomomorphism( source, range, matrices );
    
end );

##
InstallMethod( BoxProduct,
          [ IsQuiverRepresentationHomomorphism, IsQuiverRepresentationHomomorphism, IsQuiverRepresentationCategory ],
          
  { alpha_1, alpha_2, cat_reps } -> BoxProduct( [ alpha_1, alpha_2 ], cat_reps )
);

