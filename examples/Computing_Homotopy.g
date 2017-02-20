LoadPackage( "QPA" );
LoadPackage( "complex" );
LoadPackage( "HomotopyCategories" );

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


DeclareGlobalFunction( "C_H" );
InstallGlobalFunction( C_H, 
  function( phi, m, n )
  local A, B, var, i, j, Hom_i, Q, V, v, var_list, f_mat_v, current_mat, k, d, mat, vector, h, sol;
  A := Source( phi );
  B := Range( phi );
  var_list := [ ];
  for i in [ m + 1 .. n ] do
    Hom_i := BasisOfHom( A[ i ], B[ i - 1 ] );
    for j in Hom_i do
       Add( var_list, [ i, j ] );
    od;
  od;
  Q := QuiverOfRepresentation( B[ m ] );
  k := AlgebraOfRepresentation( A[ m ] )!.field;
  V := Vertices( Q );

  # for the morphism in index m
  mat := [ ];
  for v in V do
     f_mat_v := MatrixOfLinearTransformation( MapForVertex( phi[ m ], v ) );
     d := DimensionsMat( f_mat_v );
     current_mat := [ f_mat_v ]; 
     for var in var_list do 
         if var[ 1 ] = m + 1 then 
            Add( current_mat, MatrixOfLinearTransformation( MapForVertex( A^m, v ) )*
                                                         MatrixOfLinearTransformation( MapForVertex( var[ 2 ], v ) ) );
         else
            Add( current_mat, MakeZeroMatrix( k, d[ 1 ], d[ 2 ] ) );
         fi;
     od;
     if not ForAll( current_mat, IsZero ) then Add( mat, current_mat ); fi;
  od;

  # for morphisms from m+1 to n-1.
  for i in [ m + 1 .. n - 1 ] do 
      for v in  V do 
            f_mat_v := MatrixOfLinearTransformation( MapForVertex( phi[ i ], v ) );
            d := DimensionsMat( f_mat_v );
            current_mat := [ f_mat_v ];
            for var in var_list do
               if  var[ 1 ] = i then 
                  Add( current_mat, MatrixOfLinearTransformation( MapForVertex( var[ 2 ], v ) )*
                                                         MatrixOfLinearTransformation( MapForVertex( B^(i-1), v ) ) );
               elif var[ 1 ] = i + 1 then
                  Add( current_mat, MatrixOfLinearTransformation( MapForVertex( A^i, v ) )*
                                                         MatrixOfLinearTransformation( MapForVertex( var[ 2 ], v ) ) );
               else
                  Add( current_mat, MakeZeroMatrix( k, d[ 1 ], d[ 2 ] ) ); 
               fi;
            od; 
   if not ForAll( current_mat, IsZero ) then Add( mat, current_mat ); fi;
      od;
  od;


      # for the last mo rphism 
      for v in V do
            f_mat_v := MatrixOfLinearTransformation( MapForVertex( phi[ n ], v ) );
            d := DimensionsMat( f_mat_v );
            current_mat := [ f_mat_v ];
            for var in var_list do
               if var[ 1 ] = n  then    
                  Add( current_mat, MatrixOfLinearTransformation( MapForVertex( var[ 2 ], v ) )*
                                                         MatrixOfLinearTransformation( MapForVertex( B^(n-1), v ) ) );
               else
                  Add( current_mat, MakeZeroMatrix( k, d[ 1 ], d[ 2 ] ) );
               fi;
            od;
            if not ForAll( current_mat, IsZero ) then Add( mat, current_mat ); fi; 
      od;

  mat := TransposedMat( mat );
  mat := List( mat, l -> StackMatricesDiagonally( l ) );
  mat := List( mat, function( m )
                    local cols;
                    cols := ColsOfMatrix( m );
                    cols := Concatenation( cols );
                    return MatrixByCols( k, [ cols ] );
                    end );
  vector := RowVector( k, ColsOfMatrix( mat[ 1 ] )[ 1 ] );
  mat := TransposedMat( StackMatricesHorizontally( List( [ 2 .. Length( mat ) ], i->mat[ i ] ) ) );

  sol := SolutionMat( mat, vector );

  if sol = fail then 
     return fail;
  else
     sol := sol!.entries;
     mat := [ ];
     for i in [ m + 1 .. n ] do 
         h := ZeroMorphism( A[ i ], B[ i - 1 ] );
         for var in var_list do
             if var[ 1 ] = i then
                  h := h + sol[ 1 ]*var[ 2 ];
                  Remove( sol, 1 );
             fi;
         od;
         Add( mat, h );
      od;
  return mat;
  fi;
end );

test_function := 
  function( phi )
  if IsBoundedChainOrCochainMorphism( phi ) then 
     if C_H( phi, ActiveLowerBound( phi ), ActiveUpperBound( phi ) ) = fail then
        return false;
     else
        return true;
     fi;
  fi;
  Error( "the morphism must be bounded" );
end;
 
# Testing

Q := RightQuiver("Q1(3)[a:1->2,b:2->3]" );
#! Q1(3)[a:1->2,b:2->3]
A := PathAlgebra( Rationals, Q );
#! Rationals * Q1
cat := CategoryOfQuiverRepresentations( A );
#! quiver representations over Rationals * Q1
cochain_cat := CochainComplexCategory( cat );
#! Cochain complexes category over quiver representations over Rationals * Q1
SetTestFunctionForHomotopyCategory( cochain_cat, test_function );;
homotopy_cat := HomotopyCategory( cochain_cat );
#! The homotopy category of cochain complexes category over quiver representations over Rationals * Q1
m12 := MatrixByRows( Rationals, [ [ 2, 4 ] ] );
#! <1x2 matrix over Rationals>
m23 := MatrixByRows( Rationals, [ [ 3, 4, 5 ], [ 1, 2, 3 ] ] );
#! <2x3 matrix over Rationals>
r1 := QuiverRepresentation( A, [ 1, 2, 3 ], [ m12, m23 ] );
#! <1,2,3>
r2 := QuiverRepresentation( A, [ 1, 1, 1 ], [ MatrixByRows( Rationals, [ [ 2 ] ] ), MatrixByRows( Rationals, [ [ 4 ] ] ) ] );
#! <1,1,1>
f1 := MatrixByRows( Rationals, [ [ 5 ] ] );;
f2 := MatrixByRows( Rationals, [ [ 3 ], [ 1 ] ] );;
f3 := MatrixByRows( Rationals, [ [ 4 ], [ 0 ], [ 0 ] ] );;
f := QuiverRepresentationHomomorphism( r1, r2, [ f1, f2, f3 ] );
#! <(1,2,3)->(1,1,1)>
g := KernelEmbedding( f );
#! <(0,1,2)->(1,2,3)>
CA := CochainComplex( [ g,f ], 1 );
#! <A bounded object in cochain complexes category over quiver representations over Rationals * Q1 with active lower bound 0 and active upper bound 4.>
CB := DirectSum( CA, CA );      
#! <A bounded object in cochain complexes category over quiver representations over Rationals * Q1 with active lower bound 0 and active upper bound 4.>

b := BasisOfHom( CA[ 2 ], CB[ 1 ] );;
h2 := 2*b[ 1 ]+32*b[ 2 ]+67*b[3]+12*b[4]-88*b[5]+11*b[6];;
m := MatricesOfRepresentationHomomorphism( h2 );
#! [ <1x0 empty matrix over Rationals>, <2x2 matrix over Rationals>, <3x4 matrix over Rationals> ]
RowsOfMatrix( m[ 1 ] );
#! [ [  ] ]
RowsOfMatrix( m[ 2 ] );
#! [ [ -78/5, -162/5 ], [ 39/5, 81/5 ] ]
RowsOfMatrix( m[ 3 ] );
#! [ [ 231/5, -148/5, -656/5, -377/5 ], [ -121, 2, 203, 32 ], [ 67, 12, -88, 11 ] ]

b := BasisOfHom( CA[ 3 ], CB[ 2 ] );                          
#! [ <(1,1,1)->(2,4,6)>, <(1,1,1)->(2,4,6)> ]
h3 := 2001*b[ 1 ]-92*b[ 2 ];                             
#! <(1,1,1)->(2,4,6)>
m := MatricesOfRepresentationHomomorphism( h2 );
#! [ <1x0 empty matrix over Rationals>, <2x2 matrix over Rationals>, <3x4 matrix over Rationals> ]
RowsOfMatrix( m[ 1 ] );
#! [ [  ] ]
RowsOfMatrix( m[ 2 ] );
#! [ [ -78/5, -162/5 ], [ 39/5, 81/5 ] ]
RowsOfMatrix( m[ 3 ] );
#! [ [ 231/5, -148/5, -656/5, -377/5 ], [ -121, 2, 203, 32 ], [ 67, 12, -88, 11 ] ]

phi1 := PreCompose( CA^1, h2 );                           
#! <(0,1,2)->(0,2,4)>
phi2 := PreCompose( h2, CB^1 ) + PreCompose( CA^2, h3 );
#! <(1,2,3)->(2,4,6)>
phi3 := PreCompose( h3, CB^2 );
#! <(1,1,1)->(2,2,2)>
phi := CochainMorphism( CA, CB, [ phi1, phi2, phi3 ], 1 );
#! <A bounded morphism in cochain complexes category over quiver representations over Rationals * Q1 with active lower bound 0 and active upper bound 4.>
phi_ := AsHomotopyCategoryMorphism( phi );
#! <A bounded morphism in the homotopy category of cochain complexes category over quiver representations over Rationals * Q1 with active lower bound 
#! 0 and active upper bound 4>
IsZero( phi_ );
#! true
