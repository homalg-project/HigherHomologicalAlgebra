LoadPackage( "QPA" );
LoadPackage( "ComplexesForCAP" );

DeclareOperation( "LinearQuiver", [ IsDirection, IsObject, IsInt, IsInt ] );
DeclareOperation( "LinearRightQuiver", [ IsObject, IsInt, IsInt ] );
DeclareOperation( "LinearLeftQuiver", [ IsObject, IsInt, IsInt ] );

DeclareOperation( "MultiplyQuiver", [ IsRightQuiver, IsInt ] );

InstallMethod( LinearRightQuiver, 
	[ IsObject, IsInt, IsInt ],
  function( k, m, n )
    return LinearQuiver( RIGHT, k, m, n );
end );

InstallMethod( LinearLeftQuiver, 
	[ IsObject, IsInt, IsInt ],
  function( k, m, n )
    return LinearQuiver( LEFT, k, m, n );
end );



InstallMethod( LinearQuiver, 
	[ IsDirection, IsObject, IsInt, IsInt ],
  function( d, k, m, n )
    local L, kL, c, l, constructor;
    if d = RIGHT then 
      	constructor := "RightQuiver";
    else
        constructor := "LeftQuiver";
    fi;

    if m<=n then
    	L := ValueGlobal(constructor)(  Concatenation( "L(v", String(m), ")[d", String(m), "]" ), n - m + 1, 
    		List( [ m .. n - 1 ], i-> [ Concatenation( "v", String(i) ), Concatenation( "v", String(i+1) ) ]  ) );
    	kL := PathAlgebra( k, L );
    	c := ArrowLabels( L );
    	l := List( [ 1 .. Length( c )-1 ], i -> [ c[i], c[i+1] ] );
	if d = RIGHT then
    	    l := List( l, label -> PrimitivePathByLabel( L, label[1] )*PrimitivePathByLabel( L, label[2] ) );
	else
	    l := List( l, label -> PrimitivePathByLabel( L, label[2] )*PrimitivePathByLabel( L, label[1] ) );
	fi;
    	l := List( l, r -> QuiverAlgebraElement( kL, [1], [r] ) );
    	return [ L, kL, l ];
    else
        L := ValueGlobal(constructor)(  Concatenation( "L(v", String(n), ")[d", String(n+1), "]" ), m - n + 1,
	        List( [ n .. m - 1 ], i-> [ Concatenation( "v", String(i+1) ), Concatenation( "v", String(i) ) ]  ) );
        kL := PathAlgebra( k, L );
	c := ArrowLabels( L );
	l := List( [ 1 .. Length( c )-1 ], i -> [ c[i+1], c[i] ] );
	if d = RIGHT then
	    l := List( l, label -> PrimitivePathByLabel( L, label[1] )*PrimitivePathByLabel( L, label[2] ) );
	else 
	    l := List( l, label -> PrimitivePathByLabel( L, label[2] )*PrimitivePathByLabel( L, label[1] ) );
	fi;
	l := List( l, r -> QuiverAlgebraElement( kL, [1], [r] ) );
	L!.("m") := m;
	L!.("n") := n;
	return [ L, kL, l ];
    fi;
end );


DeclareOperation( "ArrowsBetweenTwoVertices", [ IsVertex, IsVertex ] );

InstallMethod( ArrowsBetweenTwoVertices, 
		[ IsVertex, IsVertex ],
  function( v1, v2 )
    return Intersection( OutgoingArrows( v1 ), IncomingArrows( v2 ) );
end );

DeclareOperation( "StackMatricesDiagonally", [ IsQPAMatrix, IsQPAMatrix ] );
DeclareOperation( "StackMatricesDiagonally", [ IsDenseList ] );


InstallMethod( StackMatricesDiagonally, 
                [ IsQPAMatrix, IsQPAMatrix ],
 function( M1, M2 )
 local d1,d2,F, M1_, M2_; 

 d1 := DimensionsMat( M1 );
 d2 := DimensionsMat( M2 );

 if d1[1]*d1[2] = 0 then return M2;fi;
 if d2[1]*d2[2] = 0 then return M1;fi;

 F := BaseDomain( M1 );
 if F <> BaseDomain( M2 ) then
    Error( "matrices over different rings" );
 fi;

 M1_ := StackMatricesHorizontally( M1, MakeZeroMatrix( F, d1[1], d2[2] ) );
 M2_ := StackMatricesHorizontally( MakeZeroMatrix( F, d2[1], d1[2] ), M2 );
 return StackMatricesVertically( M1_, M2_ );
end );

InstallMethod( StackMatricesDiagonally, [ IsDenseList ],
function( matrices )
  return Iterated( matrices, StackMatricesDiagonally );
end );


# f := function( q, kq, rel, m, n )
#  local quiver, kquiver, c, l, rel1, rel2, L, arrows, paths;
#  L := LinearRightQuiver( m, n );
#  quiver := QuiverProduct( L, q );
#  kquiver := PathAlgebra( LeftActingDomain( kq ), quiver );
#  c := ArrowLabels( L );
#  l := Concatenation( List( [ 1 .. Length(c)-1], i -> List( VertexLabels( q ), j -> [ [ c[i], j ], [ c[i+1], j ] ] ) ) );
#  l := List( l, label -> PrimitivePathByLabel( quiver, label[1] )*PrimitivePathByLabel( quiver, label[2] ) );
#  rel1 := List( l, r -> QuiverAlgebraElement( kquiver, [1], [r] ) );
#  c := VertexLabels( L );
#  l := Concatenation( List( [ 1 .. Length(c)-1], i -> List( ArrowLabels( q ), j -> [ [ c[i], j ], [ c[i+1], j ] ] ) ) );
#  l := List( l, label -> [ PrimitivePathByLabel( quiver, label[1] ), PrimitivePathByLabel( quiver, label[2] ) ] );
#  l := List( l, arrows -> [ arrows[1]*ArrowsBetweenTwoVertices( Target( arrows[1] ), Target( arrows[2] ) )[1], 
#       				ArrowsBetweenTwoVertices( Source( arrows[1] ), Source( arrows[2] ) )[1]*arrows[2] ] );
#  rel2 := List( l, paths-> QuiverAlgebraElement( kquiver, [ 1, -1 ], paths ) );
#  if rel=[] then return [ quiver, kquiver, Concatenation( rel1, rel2 ) ] ;fi;
#  paths := List( rel, r -> [ Coefficients( r ), Paths( r ) ] );
#  arrows := List( paths, p -> [ p[1], List( p[2], path -> ArrowList( path ) ) ] );
#  l := Concatenation( List( Vertices( L ), v -> List( arrows, p -> [ p[1], List( p[2], l -> List( l, u-> [ Label(v), Label(u) ] ) ) ] ) ) );
#  l := List( l, u -> [ u[1], List( u[2], l-> Product( List( l, label->PrimitivePathByLabel( quiver, label ) ) ) )] );
#  l := DuplicateFreeList( List( l, h-> QuiverAlgebraElement( kquiver, h[1], h[2] ) ) );
#  l := Filtered( l, u-> not IsZero(u) );
#  return [ quiver, kquiver, Concatenation( l, rel1, rel2 ) ];
# end;

# q := RightQuiver( "q(0)[a]", 2, [ [ 0, 1 ], [ 1, 0 ] ] );
# p := f(q, -2, 5 );
# A := QuotientOfPathAlgebra( last, p );
# QuotientOfPathAlgebraElement( A, p[1] );
# { 0 }

k := Rationals;
Q := RightQuiver("Q(4)[a:1->2,b:1->3,c:2->4,d:3->4]" );
kQ := PathAlgebra( k, Q );
AQ := QuotientOfPathAlgebra( kQ, [ kQ.ac-kQ.bd ] );

product_of_algebras := function( Aq, m, n )
    local k, Lmn, AL;
    k := LeftActingDomain( Aq );
    Lmn := LinearRightQuiver( k, m, n );
    if Lmn[3] = [ ] then 
        AL := Lmn[2];
    else
        AL := QuotientOfPathAlgebra( Lmn[2], Lmn[3] );
    fi;
    return TensorProductOfAlgebras( AL, Aq );
end;

convert_chain_or_cochain_to_representation := 
    function( C, A  )
    local L, m, n, Q, dimension_vector, matrices1, matrices2, matrices; 
    
    L := QuiverOfAlgebra( TensorProductFactors( A )[1] );
    m := ShallowCopy( Label( Vertex( L, 1 ) ) );
    RemoveCharacters( m, "v" );
    m := Int(m);
    n := m + NumberOfVertices( L ) - 1;
    if IsChainComplex( C ) then
        Q := QuiverOfAlgebra( A );
        dimension_vector := Concatenation( List( [ m .. n ], i-> DimensionVector( C[ i ] ) ) );
        matrices1 := Concatenation( List( [ m .. n ], i -> MatricesOfRepresentation( C[ i ] ) ) );
        matrices2 := Concatenation( List( [ m + 1 .. n ], i-> MatricesOfRepresentationHomomorphism( C^i ) ) );
        matrices := Concatenation( matrices1, matrices2 );
        return QuiverRepresentation( A, dimension_vector, Arrows( Q ), matrices );   
    else
        Q := QuiverOfAlgebra( A );
        dimension_vector := Concatenation( List( [ m .. n ], i-> DimensionVector( C[ i ] ) ) );
        matrices1 := Concatenation( List( [ m .. n ], i -> MatricesOfRepresentation( C[ i ] ) ) );
        matrices2 := Concatenation( List( [ m .. n - 1 ], i-> MatricesOfRepresentationHomomorphism( C^i ) ) );
        matrices := Concatenation( matrices1, matrices2 );
        return QuiverRepresentation( A, dimension_vector, Arrows( Q ), matrices );
    fi;
    
end;

convert_rep_mor_to_complex_mor := 
    function( C1, C2, mor, A )
    local Q, L, q, m, n, mats; 
    # Do the compatibility stuff
    Q := QuiverOfAlgebra( A );
    L := QuiverOfAlgebra( TensorProductFactors( A )[1] );
    q := QuiverOfAlgebra( TensorProductFactors( A )[2] );
    m := ShallowCopy( Label( Vertex( L, 1 ) ) );
    RemoveCharacters( m, "v" );
    m := Int(m);
    n := m + NumberOfVertices( L ) - 1;
#     maps := MatricesOfRepresentationHomomorphism( mor );
    mats := MatricesOfRepresentationHomomorphism( mor );
    mats := List( [ 1 .. NumberOfVertices( L ) ], 
                i -> List( [ 1 .. NumberOfVertices( q ) ],
                        j-> mats[ (i-1)*NumberOfVertices( q ) + j ] ) );
    mats := List( [ m .. n ], k -> QuiverRepresentationHomomorphism( C1[k], C2[k], mats[k-m+1] ) );
    if IsChainComplex( C1 ) then 
        return ChainMorphism( C1, C2, mats, m );
    else
        return CochainMorphism( C1, C2, mats, m );
    fi;
end;

basis_of_hom := 
    function( C1, C2 )
    local m, n, A, R1, R2, B; 
    
    m := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) ) + 1;
    n := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) ) - 1;
    if IsChainComplex( C1 ) then
        A := product_of_algebras( AlgebraOfRepresentation( C1[m] ), n, m );
    else
        A := product_of_algebras( AlgebraOfRepresentation( C1[m] ), m, n );
    fi;
    R1 := convert_chain_or_cochain_to_representation( C1, A );
    R2 := convert_chain_or_cochain_to_representation( C2, A );
    B := BasisOfHom( R1, R2 );
    return List( B, mor -> convert_rep_mor_to_complex_mor( C1, C2, mor, A ) );
end;
    
compute_lift_in_quiver_rep := 
    function( f, g )
    local homs_basis, Q, k, V, homs_basis_composed_with_g, l, vector, mat, sol, lift, h;
    
    homs_basis := BasisOfHom( Source( f ), Source( g ) );
    Q := QuiverOfRepresentation( Source( f ) );
    k := LeftActingDomain( AlgebraOfRepresentation( Source( f ) ) );
    V := Vertices( Q );
    homs_basis_composed_with_g := List( homs_basis, m -> PreCompose( m, g ) );
    l := List( V, v -> Concatenation( [ MatrixOfLinearTransformation( MapForVertex( f, v ) ) ],
                                        List( homs_basis_composed_with_g, h -> MatrixOfLinearTransformation( MapForVertex( h, v ) ) ) ) );
    l := TransposedMat( l );
    l := List( l, row_of_matrices -> StackMatricesDiagonally( row_of_matrices ) );
    l := List( l, function( m )
                    local cols;
                    cols := ColsOfMatrix( m );
                    cols := Concatenation( cols );
                    return MatrixByCols( k, [ cols ] );
                    end );
    vector := RowVector( k, ColsOfMatrix( l[ 1 ] )[ 1 ] );
    mat := TransposedMat( StackMatricesHorizontally( List( [ 2 .. Length( l ) ], i -> l[ i ] ) ) );

    sol := SolutionMat( mat, vector );

    if sol = fail then 
     return fail;
    else
    sol := sol!.entries;
    lift := ZeroMorphism( Source( f ), Source( g ) );
    for h in homs_basis do
        if not IsZero( sol[ 1 ] ) then
            lift := lift + sol[ 1 ]*h;
        fi;
    Remove( sol, 1 );
    od;
     
    fi;
    return h;
end;


dual_functor := 
    function( cat )
    local A, Q, A_op, Q_op, cat_op, dual, cat_of_op_quiver; 
    
    cat_op := Opposite( cat );
    A := AlgebraOfCategory( cat );
    Q := QuiverOfAlgebra( A );
    A_op := OppositeAlgebra( A );
    Q_op := QuiverOfAlgebra( A_op );
    cat_of_op_quiver := CategoryOfQuiverRepresentations( A_op );
    dual := CapFunctor( "Dual functor", cat_op, cat_of_op_quiver );
    AddObjectFunction( dual, 
        function( r )
        return QuiverRepresentation( A_op, DimensionVector( Opposite(r) ), Arrows( Q_op ), List( MatricesOfRepresentation( Opposite(r) ), TransposedMat ) );
        end );
    AddMorphismFunction( dual,
        function( new_source, phi, new_range )
        return QuiverRepresentationHomomorphism( new_source, new_range, List( MatricesOfRepresentationHomomorphism( Opposite( phi ) ), TransposedMat ) );
        end );
    return dual;
end;

# Q := RightQuiver("Q(5)[a:1->2,b:3->2,c:4->3,d:3->5]" );
# Q(5)[a:1->2,b:3->2,c:4->3,d:3->5]
# gap> kQ := PathAlgebra( Rationals, Q );
# Rationals * Q
# gap> ind_kQ := IndecProjRepresentations( kQ );
# [ <1,1,0,0,0>, <0,1,0,0,0>, <0,1,1,0,1>, <0,1,1,1,1>, <0,0,0,0,1> ]
# gap> R := DirectSum( ind_kQ );
# <1,4,2,1,3>
# gap> cat := CapCategory( ind_kQ[1] );
# quiver representations over Rationals * Q
# gap> D := dual_functor( cat );
# Dual functor
# gap> R_dual := ApplyFunctor( D, Opposite( R ) );
# <1,4,2,1,3>
# gap> f := ProjectiveCover( R_dual );
# <(4,4,7,7,3)->(1,4,2,1,3)>
# gap> DD := dual_functor( CapCategory( R_dual ) );
# Dual functor
# gap> ApplyFunctor( DD, Opposite( f ) );
# <(1,4,2,1,3)->(4,4,7,7,3)>
# gap> l := last;
# <(1,4,2,1,3)->(4,4,7,7,3)>



















