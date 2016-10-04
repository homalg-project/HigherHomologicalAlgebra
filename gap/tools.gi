
## tools for solving two sided equation over exterior algebra


DeclareOperation( "UnionOfRows", [ IsList ] );
InstallMethod( UnionOfRows, 
               [ IsList ],
function( l )
local current_mat, mat;

if Length( l ) = 0 then 
  
  Error( "The given list is empty" );
  
fi;

return Iterated( l, UnionOfRows );

end );

##                  
DeclareOperation( "UnionOfColumns", [ IsList ] );          
InstallMethod( UnionOfColumns, 
               [ IsList ],
function( l )
local current_mat, mat;

if Length( l ) = 0 then 
  
  Error( "The given list is empty" );
  
fi;

return Iterated( l, UnionOfColumns );

end );


##
DeclareOperation( "HomalgTransposedMat", 
                  [ IsHomalgMatrix ] );
InstallMethod( HomalgTransposedMat, 
                [ IsHomalgMatrix ], 
function( M )
  
  return HomalgMatrix( String( TransposedMat( EntriesOfHomalgMatrixAsListList( M ) ) ), NrColumns( M ), NrRows( M ), HomalgRing( M ) );
 
end );


##
DeclareGlobalFunction( "MyList" );
InstallGlobalFunction( MyList, 

function ( n )
local f, new_l,l;

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
DeclareGlobalFunction( "RingElement" );
InstallGlobalFunction( RingElement, 

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

##
DeclareAttribute( "DecompositionOfHomalgMat", IsHomalgMatrix );
InstallMethod( DecompositionOfHomalgMat, 
                 [ IsHomalgMatrix ],
function( d )
local R, n, l, coeff_list, dd, reduction_element, coeff_element, dd_new, u,v, M, m,r;

dd := ShallowCopy( d );

R := d!.ring;

n := Length( IndeterminatesOfExteriorRing( R ) ) -1;

l := MyList( n );

coeff_list := [ ];

for u in l do 

  v := [ 0..n ];
  
  SubtractSet( v, u );
  
  reduction_element := RingElement( v, R );
  
  dd_new := dd*reduction_element;
  
  m := NrColumns( dd_new );
  
  r:= RingElement( Concatenation( u, v ), R );
  
  M := HomalgDiagonalMatrix( List( [ 1 .. m ], i -> r ), R );   
    
  coeff_element := RightDivide( dd_new, M );
 
  Add( coeff_list, [ u, coeff_element ] );
  
  dd := dd - coeff_element*RingElement( u, R );
   
od;

return coeff_list;

end );

##
DeclareGlobalFunction( "FLeft" );
InstallGlobalFunction( FLeft,

function( sigma, A )
local S,n, basis_indices, zero_matrix,d, e_sigma;

S := A!.ring;
n := Length( IndeterminatesOfExteriorRing( S ) )-1;
basis_indices := MyList( n );

d := DecompositionOfHomalgMat( A );

zero_matrix := A - A;

e_sigma := RingElement( sigma, S );

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
                            
                            return  ( ( RingElement( lambda, S )* RingElement( tau, S ) )/e_sigma )*d[ m ][ 2 ];
                            
                            end ), UnionOfColumns );
                     
end );
                     
                     
##
DeclareGlobalFunction( "FRight" );
InstallGlobalFunction( FRight,

function( sigma, A )
local S,n, basis_indices, zero_matrix,d, e_sigma;

S := A!.ring;
n := Length( IndeterminatesOfExteriorRing( S ) )-1;
basis_indices := MyList( n );

d := DecompositionOfHomalgMat( A );

zero_matrix := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), S );

e_sigma := RingElement( sigma, S );

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
                            
                            return  ( RingElement( tau, S )*( RingElement( lambda, S ) )/e_sigma )*d[ m ][ 2 ];
                            
                            end ), UnionOfRows );
                     
end );
 
DeclareGlobalFunction( "F2" );
InstallGlobalFunction( F2,

 function( sigma, A, B )
 
 local R, r,s, AA, BB, Is_Kronecker_AA, BB_Kronecker_Ir; 
 
 R := A!.ring;
 
 r := NrRows( A );
 s := NrColumns( B );
 
 AA := FLeft( sigma, A );
 BB := FRight( sigma, B );
 
 Is_Kronecker_AA :=  KroneckerMat( HomalgIdentityMatrix( s, R ), AA );
 BB_Kronecker_Ir :=  KroneckerMat( HomalgTransposedMat( BB ), HomalgIdentityMatrix( r, R ) );
 
 return UnionOfColumns( Is_Kronecker_AA, BB_Kronecker_Ir );
 
 end );


DeclareGlobalFunction( "F3" );
InstallGlobalFunction( F3, 

function( A, B )
local S, n, basis_indices;

S := A!.ring;
n := Length( IndeterminatesOfExteriorRing( S ) )-1;
basis_indices := MyList( n );

return UnionOfRows( List( basis_indices, sigma -> F2( sigma, A, B ) ) );

end );


DeclareGlobalFunction( "SolveTwoSidedEquationOverExteriorAlgebra" );
InstallGlobalFunction( SolveTwoSidedEquationOverExteriorAlgebra,

function( A, B, C )
local C_deco, C_deco_list, C_deco_list_vec, C_vec, N, sol, Q, R, l, m, s, r, n, XX, YY, XX_, YY_, X_, Y_, basis_indices;

R := A!.ring;

l := Length( IndeterminatesOfExteriorRing( R ) );
basis_indices := MyList( l-1 );

Q := CoefficientsRing( R ); 

C_deco := DecompositionOfHomalgMat( C );

C_deco_list := List( C_deco, i-> i[ 2 ] );

C_deco_list_vec := List( C_deco_list, c-> UnionOfRows( List( [ 1..NrColumns( C ) ], i-> CertainColumns( c, [ i ] ) ) ) );

C_vec := Q*UnionOfRows( C_deco_list_vec );

N := Q*F3( A, B );

sol := LeftDivide( N, C_vec );

if sol = fail then 

  return fail;
  
fi;

r := NrRows( A );
m := NrColumns( A );
s := NrColumns( C );
n := NrRows( B );

XX := CertainRows( sol, [ 1..m*s*2^l ] );

YY := CertainRows( sol, [ 1+ m*s*2^l ..( m*s+r*n)*2^l] );


XX_ := UnionOfColumns( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ) );
YY_ := UnionOfColumns( List( [ 1 .. n*2^l ], i -> CertainRows( YY, [ ( i - 1 )*r + 1 .. i*r ] ) ) );

X_ := Sum( List( [ 1..2^l ], i-> ( R*CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* RingElement( basis_indices[ i ], R ) ) );
Y_ := Sum( List( [ 1..2^l ], i-> (R*CertainColumns( YY_, [ ( i - 1 )*n + 1 .. i*n ] ) )* RingElement( basis_indices[ i ], R ) ) );

return [ X_, Y_ ];

end );

