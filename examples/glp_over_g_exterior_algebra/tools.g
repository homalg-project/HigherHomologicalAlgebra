
## tools for solving two sided equation over exterior algebra
LoadPackage( "GradedRing" );
LoadPackage( "GradedModules" );

DeclareGlobalVariable( "WithComments" );
MakeReadWriteGlobal("WithComments");
WithComments := true;

##
DeclareAttribute( "HomalgTransposedMat", IsHomalgMatrix );

InstallMethod( HomalgTransposedMat, 
                [ IsHomalgMatrix ], 
function( M )
  
    if NrRows( M ) = 0 or NrColumns( M ) = 0 then
    
        return HomalgZeroMatrix( NrColumns( M ), NrRows( M ), M!.ring );
    
    else

        return HomalgMatrix( String( TransposedMat( EntriesOfHomalgMatrixAsListList( M ) ) ), NrColumns( M ), NrRows( M ), HomalgRing( M ) );
        
    fi;

end );

##
DeclareAttribute( "standard_list_of_basis_indices", IsHomalgRing );
InstallMethod( standard_list_of_basis_indices,
                [ IsHomalgRing and IsExteriorRing ],

function ( R )
local f, new_l,l, n;

n := Length( IndeterminatesOfExteriorRing( R ) ) -1;

l := Combinations( [ 0 ..n ] );

f := function( l, m )
local new_l;

new_l:= List( l, function( e )

                if Length( e ) = m then 

                   return e;

                else 

                   return [ ];

                fi;

                end );
new_l := Set( new_l );
Remove( new_l, 1 );

return new_l;

end;

new_l := List( [ 1 .. n+1 ], m-> f( l, m ) );

Add( new_l, [ [ ] ], 1 );

return Concatenation( new_l );

end );


##
DeclareGlobalFunction( "ring_element" );
InstallGlobalFunction( ring_element, 

function( l, R )

local f, s,i;

f := RingElementConstructor( R );

s := "1*";

for i in l do 

s := Concatenation( s, "e",String( i ), "*" );

od;

s:= Concatenation( s, "1" );

return f( s, R );

end );

# DeclareAttribute( "BasisDegrees", IsHomalgRing );
# InstallMethod( BasisDegrees,
#         [ IsHomalgRing ],
#     function( A )
#     local standard_indices, n, basis, list, i, a;
#     standard_indices := standard_list_of_basis_indices( A );

#     n := Length( IndeterminatesOfExteriorRing( A ) ) -1;

#     basis := List( standard_indices, s -> ring_element( s, A) );
#     list := [ ];
#     for i in [ 0 .. n + 1 ] do
#         a := Filtered( basis, e -> Int( String( Degree(e) ) ) = -i );
#         for i in a do
#             Remove(basis,1);
#         od;
#         Add( list, a );
#     od;
#     return list;
# end );

# KeyDependentOperation( "MonomialsOfCertainDegree", IsHomalgRing, IsInt, ReturnTrue );
# InstallMethod( MonomialsOfCertainDegreeOp,
#         [ IsHomalgRing, IsInt ],
#     function( A, d )
#     local n;
#     n := Length( IndeterminatesOfExteriorRing( A ) ) -1;
#     if d = 1 then
#         return [ Zero( A ) ];
#     elif d in -[ 0 .. n + 1 ] then
#         return BasisDegrees( A )[ -d + 1 ];
#     else
#         return [ ];
#     fi;
# end );

##
DeclareAttribute( "DecompositionOfHomalgMat", IsHomalgMatrix );
InstallMethod( DecompositionOfHomalgMat, 
                 [ IsHomalgMatrix ],
function( d )
local R, n, l, coeff_list, dd, reduction_element, coeff_element, dd_new, u,v, M, m,r;

if WithComments = true then
    Print( "DecompositionOfHomalgMat of ", NrRows(d),"x",NrColumns(d)," homalg matrix \n" );
fi;

dd := ShallowCopy( d );

R := d!.ring;

n := Length( IndeterminatesOfExteriorRing( R ) ) -1;

l := standard_list_of_basis_indices( R );

coeff_list := [ ];

for u in l do 

  v := [ 0..n ];
  
  SubtractSet( v, u );
  
  reduction_element := ring_element( v, R );
  
  dd_new := dd*reduction_element;
  
  m := NrColumns( dd_new );
  
  r:= ring_element( Concatenation( u, v ), R );
  
  M := HomalgDiagonalMatrix( List( [ 1 .. m ], i -> r ), R );   
    
  coeff_element := RightDivide( dd_new, M );
 
  Add( coeff_list, [ u, coeff_element ] );
  
  dd := dd - coeff_element*ring_element( u, R );
   
od;

if WithComments = true then
    Print( "DecompositionOfHomalgMat finished\n" );
fi;

return coeff_list;

end );

# ##
# DeclareAttribute( "DecompositionOfHomogeneousHomalgMat1", IsHomalgMatrix  );
# InstallMethod( DecompositionOfHomogeneousHomalgMat1,
#         [ IsHomalgMatrix ],
#     function( M )
#     local A, ind, nr_columns, nr_rows, d, L, i, j, current_degree, p;
#     A := M!.ring;
#     ind := IndeterminatesOfExteriorRing( A );
#     nr_rows := NrRows( M );
#     nr_columns := NrColumns( M );
#     d := DegreesOfEntries(M);

#     L := List( [ 1 .. Length( ind ) + 1 ], i -> HomalgInitialMatrix( nr_rows, nr_columns, A ) );

#     for i in [ 1 .. nr_rows ] do 
#     for j in [ 1 .. nr_columns ] do 
#         current_degree := d[i][j];
#         p := Position( [ 1 .. Length( ind ) + 2 ], Int( String( current_degree ) ) + Length( ind ) + 1 );
#         if p <> Length( ind ) + 2 then 
#             SetMatElm( L[ p ], i, j, MatElm( M, i, j ) );
#         fi;
#     od;
#     od;
#     return Reversed(L);
# end );

##
KeyDependentOperation( "FLeftt", IsHomalgMatrix, IsInt, ReturnTrue );
InstallMethod( FLefttOp, [ IsHomalgMatrix, IsInt ],
function( A, m )
local S, basis_indices, zero_matrix,d, e_sigma, sigma;

if WithComments = true then
    Print( "FLefttOp of ", NrRows(A),"x", NrColumns(A)," homalg matrix and m =", m, "\n" );
fi;

#AddToReasons(["left",A,m]);
S := A!.ring;

basis_indices := standard_list_of_basis_indices( S );

d := DecompositionOfHomalgMat( A );

zero_matrix := HomalgZeroMatrix( NrRows(A), NrColumns(A), S );

sigma := basis_indices[ m ];
e_sigma := ring_element( sigma, S );

return Iterated( List( basis_indices, function( tau )
                            local lambda, m;
                            
                            if ( not IsSubset( sigma, tau ) ) or ( IsSubset( tau, sigma ) and Length( tau ) > Length( sigma ) ) then 
                            
                                return zero_matrix;
                                
                            fi;
                            
                            if tau = sigma then 
                            
                                return d[ 1 ][ 2 ];
                                
                            fi;
                            
                            lambda := ShallowCopy( sigma );
                            
                            SubtractSet( lambda, tau );
                            
                            m := Position( basis_indices, lambda );
                            
                            return  ( ( ring_element( lambda, S )* ring_element( tau, S ) )/e_sigma )*d[ m ][ 2 ];
                            
                            end ), UnionOfColumns );
                     
end );

##
DeclareOperationWithCache( "FLeft", [ IsList, IsHomalgMatrix ] );
InstallMethodWithCache( FLeft,
            [ IsList, IsHomalgMatrix ],
function( sigma, A )
local p, basis_indices;

if WithComments = true then
    Print( "FLeft of ", NrRows(A),"x", NrColumns(A)," homalg matrix and sigma = ", sigma, "\n" );
fi;

basis_indices := standard_list_of_basis_indices(  A!.ring  );
p := Position( basis_indices, sigma ); 
if HasIsOne( A ) and IsOne( A ) then
	return Iterated( [ HomalgZeroMatrix(NrRows(A), (p-1)*NrColumns(A), A!.ring ), A, HomalgZeroMatrix( NrRows(A), ( Length(basis_indices) - p )*NrColumns(A), A!.ring)], UnionOfColumns );
elif HasIsZero( A ) and IsZero( A ) then
	return HomalgZeroMatrix( NrRows(A), NrColumns(A)*Length( basis_indices ), A!.ring );
else
	return FLeftt(A, p);
fi;
end );

KeyDependentOperation( "FRightt", IsHomalgMatrix, IsInt, ReturnTrue );
InstallMethod( FRighttOp, [ IsHomalgMatrix, IsInt ],
function( A, m )
local R, basis_indices, zero_matrix,d, e_sigma, sigma, list;

if WithComments = true then
    Print( "FRighttOp of ", NrRows(A),"x", NrColumns(A)," homalg matrix and m = ", m, "\n" );
fi;
R := A!.ring;
basis_indices := standard_list_of_basis_indices( R );

d := DecompositionOfHomalgMat( A );

zero_matrix := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), R );

sigma := basis_indices[ m ];
e_sigma := ring_element( sigma, R );

list := Iterated( List( basis_indices, function( tau )
                            local lambda, m;
                            
                            if ( not IsSubset( sigma, tau ) ) or ( IsSubset( tau, sigma ) and Length( tau ) > Length( sigma ) ) then 
                            
                                return zero_matrix;
                                
                            fi;
                            
                            if tau = sigma then 
                            
                                return d[ 1 ][ 2 ];
                                
                            fi;
                            
                            lambda := ShallowCopy( sigma );
                            
                            SubtractSet( lambda, tau );
                            
                            m := Position( basis_indices, lambda );
                            
                            return  ( ring_element( tau, R )*( ring_element( lambda, R ) )/e_sigma )*d[ m ][ 2 ];
                            
                            end ), UnionOfRows );
    if WithComments = true then
        Print( "FRightOp finished \n" );
    fi;
    
    return list;
end );

##
DeclareOperationWithCache( "FRight", [ IsList, IsHomalgMatrix ] );
InstallMethodWithCache( FRight,
        [ IsList, IsHomalgMatrix ],
function( sigma, A )
local p, basis_indices;

if WithComments = true then
    Print( "FRight of ", NrRows(A),"x", NrColumns(A)," homalg matrix and sigma = ", sigma, "\n" );
fi;

basis_indices := standard_list_of_basis_indices( A!.ring );
p := Position( basis_indices, sigma ); 
if HasIsOne( A ) and IsOne( A ) then
	return Iterated( [ HomalgZeroMatrix( (p-1)*NrRows(A),NrColumns(A), A!.ring ), A, HomalgZeroMatrix( (Length(basis_indices) - p)*NrRows(A), NrColumns(A), A!.ring)], UnionOfRows );
elif HasIsZero( A ) and IsZero( A ) then
	return HomalgZeroMatrix( NrRows(A)*Length( basis_indices ), NrColumns(A), A!.ring );
else
	return FRightt(A, p);
fi;
end );

DeclareOperationWithCache( "FF2", [ IsList, IsHomalgMatrix, IsHomalgMatrix ] );
InstallMethodWithCache( FF2,
                    [ IsList, IsHomalgMatrix, IsHomalgMatrix ],
function( sigma, A, B )
local R, r,s, AA, BB, Is_Kronecker_AA, BB_Kronecker_Ir; 
 
if WithComments = true then
    Print( "FF2 of ", NrRows(A),"x", NrColumns(A), " & ", NrRows(B),"x", NrColumns(B)," homalg matrices and sigma =", sigma, "\n" );
fi;

R := A!.ring;

r := NrRows( A );
s := NrColumns( B );

AA := FLeft( sigma, A );
BB := FRight( sigma, B );

Is_Kronecker_AA :=  KroneckerMat( HomalgIdentityMatrix( s, R ), AA );
BB_Kronecker_Ir :=  KroneckerMat( Involution( BB ), HomalgIdentityMatrix( r, R ) );

return UnionOfColumns( Is_Kronecker_AA, BB_Kronecker_Ir );

end );


DeclareOperationWithCache( "FF3", [ IsHomalgMatrix, IsHomalgMatrix ] );
InstallMethodWithCache( FF3,
                [ IsHomalgMatrix, IsHomalgMatrix ],
function( A, B )
local S, n, basis_indices;

if WithComments = true then
    Print( "FF3 of ", NrRows(A),"x", NrColumns(A), " & ", NrRows(B),"x", NrColumns(B)," homalg matrices\n" );
fi;

S := A!.ring;
n := Length( IndeterminatesOfExteriorRing( S ) )-1;
basis_indices := standard_list_of_basis_indices( S );

return Iterated( List( basis_indices, sigma -> FF2( sigma, A, B ) ), UnionOfRows );

end );

DeclareOperationWithCache( "SolveTwoSidedEquationOverExteriorAlgebra", [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );
InstallMethodWithCache( SolveTwoSidedEquationOverExteriorAlgebra,
                            [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ],
function( A, B, C )
local C_deco, C_deco_list, C_deco_list_vec, C_vec, N, sol, Q, R, l, m, s, r, n, XX, YY, XX_, YY_, X_, Y_, basis_indices;


if WithComments = true then
    Print( "SolveTwoSidedEquationOverExteriorAlgebra on ", NrRows(A),"x", NrColumns(A), " & ", NrRows(B),"x", NrColumns(B)," & ",NrRows(C),"x", NrColumns(C), "\n" );
fi;

R := A!.ring;

if NrRows( A )= 0 or NrColumns( A ) = 0 then 

   return [ HomalgZeroMatrix( NrColumns(A), NrColumns(C), R ), RightDivide( C, B ) ];
   
elif NrRows( B )= 0 or NrColumns( B ) = 0 then 

   return [ LeftDivide( A, C ), HomalgZeroMatrix( NrRows(C), NrRows( B), R ) ];
   
fi;

l := Length( IndeterminatesOfExteriorRing( R ) );
basis_indices := standard_list_of_basis_indices( R );

Q := CoefficientsRing( R );                                                                                                                                                                                                                                                     

C_deco := DecompositionOfHomalgMat( C );

C_deco_list := List( C_deco, i-> i[ 2 ] );

C_deco_list_vec := List( C_deco_list, c-> Iterated( List( [ 1..NrColumns( C ) ], i-> CertainColumns( c, [ i ] ) ), UnionOfRows ) );

C_vec := Q*Iterated( C_deco_list_vec, UnionOfRows );

N := Q*FF3( A, B );

if WithComments = true then
    Print( "rational linear system with ", NrRows(N), "x", NrColumns(N), " homalg matrices \n" );
fi;

sol := LeftDivide( N, C_vec );

if WithComments = true then
    Print( "done!\n" );
fi;

if sol = fail then 

  return fail;
  
fi;

r := NrRows( A );
m := NrColumns( A );
s := NrColumns( C );
n := NrRows( B );

XX := CertainRows( sol, [ 1..m*s*2^l ] );

YY := CertainRows( sol, [ 1+ m*s*2^l ..( m*s+r*n)*2^l] );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               


XX_ := Iterated( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ), UnionOfColumns );
YY_ := Iterated( List( [ 1 .. n*2^l ], i -> CertainRows( YY, [ ( i - 1 )*r + 1 .. i*r ] ) ), UnionOfColumns );

X_ := Sum( List( [ 1..2^l ], i-> ( R*CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* ring_element( basis_indices[ i ], R ) ) );
Y_ := Sum( List( [ 1..2^l ], i-> (R*CertainColumns( YY_, [ ( i - 1 )*n + 1 .. i*n ] ) )* ring_element( basis_indices[ i ], R ) ) );

return [ X_, Y_ ];

end );

DeclareGlobalFunction( "ReductionOfHomalgMatrix" );
InstallGlobalFunction( ReductionOfHomalgMatrix,
    function( A, D )
    local M,nr_rows, nr_columns, m, l, i, j, r, R;
    R := HomalgRing( A );
    r := UnderlyingNonGradedRing( R );
    M := r*A;
    nr_rows := NrRows( M );
    nr_columns := NrColumns( M ); 
    
    l := List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_columns ], 
        function( j )
        local coef, new_coef, degrees, k;
        coef := Coefficients( MatElmAsString( M, i, j )/HomalgRing( M ) );
        
        degrees := List( coef!.monomials, u -> Degree( Name(u)/R ) );
        
        new_coef := [ ];
        
        for k in [ 1 .. Length( degrees ) ] do
            if degrees[ k ] <> D[i][j] then
                Add( new_coef, Zero( HomalgRing( M ) ) );
            else
                Add( new_coef, MatElm( coef, k, 1 ) );
            fi;
        od;
        new_coef := HomalgMatrix( new_coef, 1, Length( degrees ), HomalgRing( M ) );
        return MatElm( new_coef*HomalgMatrix( coef!.monomials, Length( degrees ), 1, HomalgRing( M ) ), 1, 1 );
        
        end ) );

    return HomalgRing(A)*HomalgMatrix( l, nr_rows, nr_columns, HomalgRing( M ) );
    
end );

random_element := function( R )
local basis_indices;
basis_indices := ShallowCopy( standard_list_of_basis_indices( R ) );
# if the element contains constant then it is unit in the algebra.
Remove( basis_indices, 1 );
return Sum( basis_indices, i -> Random([-10..10])*ring_element(i,R) + Random( Concatenation(List([1..8*Length(basis_indices)],i->0),[1] ) ) *ring_element( [], R ) );
end;

random_matrix := function(m,n,R)
return HomalgMatrix( List([1..m], i-> List([1..n], j -> random_element( R ) ) ), m, n, R );
end;