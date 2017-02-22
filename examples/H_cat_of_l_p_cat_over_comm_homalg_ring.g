LoadPackage( "HomotopyCategories" );
LoadPackage( "ModulePresentation" );

############### computing homotopy ###########################

Compute_Homotopy := 
  function( phi, s, n )
  local A, B, ring, r, mat, j, k, l,i, current_mat, t, b, current_b, list, var, sol, union_of_columns, union_of_rows;

  A := Source( phi );

  B := Range( phi );

  ring := HomalgRing( UnderlyingMatrix( phi [ s ] ) );

  # Here we find which variables should be actually compute. h_i, x_i or y_i.

  var := [ ];

  for j in [ s + 1 .. n ] do 

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if t<>0 then Add( var, [ "h",j, [ NrColumns( UnderlyingMatrix( B[ j -1 ] ) ), NrColumns( UnderlyingMatrix( A[ j ] ) )  ] ] );fi;

  od;

  for k in [ s .. n ] do

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if t<>0 then Add( var, [ "x", k, [ NrRows( UnderlyingMatrix( phi[ k ] ) ), NrRows( UnderlyingMatrix( B[ k ] ) )  ] ] );fi;

  od;

  for l in [ s .. n - 1 ] do

    t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );

    if t<>0 then Add( var, [ "y", l, [ NrRows( UnderlyingMatrix( A[ l + 1 ] ) ), NrRows( UnderlyingMatrix( B[ l ] ) )  ] ] );fi;

  od;

  # the first equation
  mat := 0;
  b := 0;

  union_of_columns := function( m, n )
                      local new_m;
                      new_m := m;
                      if m=0 then new_m := HomalgZeroMatrix( NrRows( n ), 0, ring );fi;
                      return UnionOfColumns( new_m, n );
                      end;

  union_of_rows := function( m, n )
                      local new_m;
                      new_m := m;
                      if m=0 then new_m := HomalgZeroMatrix( 0, NrColumns( n ), ring );fi;
                      return UnionOfRows( new_m, n );
                      end;

  r := NrColumns( UnderlyingMatrix( phi[ s ] ) )* NrRows( UnderlyingMatrix( phi[ s ] ) );

  if r<>0 then

  list := List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ s ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ s ] ), [ c ] ) );

  if Length( list ) = 1 then 
     b := list[ 1 ];
  else
     b := Iterated( UnionOfRows, list );
  fi;

  mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ s + 1 .. n ] do

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if j = s + 1 and t <>0 then

       mat := union_of_columns( mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ s ] ) ), ring ), UnderlyingMatrix( A^s ) ) );

    elif t <> 0 then 

       mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );

    fi;

  od;


  for k in [ s .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = s and t<>0 then 

    mat := union_of_columns( mat, KroneckerMat( Involution( UnderlyingMatrix( B[ s ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ s ] ) ), ring ) ) );
    elif t<>0 then

    mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;

  for l in [ s .. n - 1 ] do 
    t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
    if t<>0 then
    mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );
    fi;
  od;

  fi;

  for i in [ s + 1 .. n - 1 ] do

      r := NrColumns( UnderlyingMatrix( phi[ i ] ) )* NrRows( UnderlyingMatrix( phi[ i ] ) );

      if r <> 0 then 

         list := List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ i ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ i ] ), [ c ] ) );
         if Length( list ) = 1 then 
            current_b := list[ 1 ];
         else
            current_b := Iterated( UnionOfRows, list );
         fi;

      current_mat := HomalgZeroMatrix( r, 0, ring );

      for j in [ s + 1 .. n ] do

          t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j - 1 ] ) );

          if j = i and t<>0 then

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(i - 1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
          elif j = i + 1 and t<>0 then

             current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ i ] ) ), ring ), UnderlyingMatrix( A^i ) ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
          fi; 
      od;


      for k in [ s .. n ] do 

          t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

          if k = i and t<>0 then 

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
          fi;

      od;

     for l in [ s .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
         fi;
     od;

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

  fi;

  od;

  #again for the last non-zero morphism

  r := NrColumns( UnderlyingMatrix( phi[ n ] ) )* NrRows( UnderlyingMatrix( phi[ n ] ) );

  if r<>0 then 

         list :=  List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ n ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ n ] ), [ c ] ) );
         if Length( list ) = 1 then 
            current_b := list[ 1 ];
         else
            current_b := Iterated( UnionOfRows, list );
         fi;

  current_mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ s + 1 .. n ] do

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if j = n and t<>0 then

       current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(n-1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );
    elif t<> 0 then

       current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;


  for k in [ s .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = n and t<>0 then 

    current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ n ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );
    elif t<>0 then

    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;

  for l in [ s .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
         fi; 
  od;

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

  fi;

  # Now the equations that make sure that the maps h_i's are well defined

  for i in [ s .. n - 1 ] do

    r := NrRows( UnderlyingMatrix( A[ i + 1 ] ) ) * NrColumns( UnderlyingMatrix( B[ i ] ) );

    if r <> 0 then

    current_mat := HomalgZeroMatrix( r, 0, ring );

    for j in [ s + 1 .. n ] do 

      t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );
      if j = i + 1 and t<>0 then 

        current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( B[ i ] ) ), ring ), UnderlyingMatrix( A[ i + 1 ] ) ) );
      elif t<>0 then

        current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
      fi;

    od;

    for k in [ s .. n ] do 
    t :=  NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );
    if t<> 0 then 
    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;
    od;

    for l in [ s .. n - 1 ] do
        t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
        if l = i and t<>0 then

           current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( A[ i + 1 ] ) ), ring ) ) );
        elif t<>0 then

           current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
        fi;

    od;

  current_b := HomalgZeroMatrix( r, 1, ring );

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

  fi;

  od;

sol := LeftDivide(mat, b);

if sol = fail then 
   return [ false, sol, mat, b, var ];
else 
   return [ true, sol, mat, b, var ]; 
fi;

end;

compute_homotopy_in_left_presentations := function( phi, m, n )
local cat, underlying_cat, T, psi, sol, new_var;

cat := CapCategory( phi );

underlying_cat := UnderlyingCategory( cat );

if IsCochainComplexCategory( cat ) then 

   return Compute_Homotopy( phi, m, n );

elif IsChainComplexCategory( cat ) then 

   T := ChainToCochainComplexFunctor( underlying_cat  );

   psi := ApplyFunctor( T, phi );

   sol := ShallowCopy( compute_homotopy_in_left_presentations( psi, -n, -m ) );

   new_var := sol[ 5 ];

   new_var := List( new_var, i-> [ i[1],-i[2], i[3] ] );

   sol[ 5 ] := new_var;

   return sol;

fi;

end;

is_null_homotopic :=
   function( mor )
   local S, R, m, n;

   S := Source( mor );

   R := Range( mor );

   if not IsBoundedChainOrCochainComplex( S ) or not IsBoundedChainOrCochainComplex( R ) then 

      Error( "Both source and range must be bounded complexes" );

   fi;

   m := Minimum( ActiveLowerBound( S ), ActiveLowerBound( R ) );

   n := Maximum( ActiveUpperBound( S ), ActiveUpperBound( R ) );

   return compute_homotopy_in_left_presentations( mor, m, n )[ 1 ];

end;

CochainHomotopyCategory := 

 function( R )
 local cat, cochain_cat, homotopy_cat;

 cat := LeftPresentations( R: FinalizeCategory := false );

 Finalize( cat );

 cochain_cat := CochainComplexCategory( cat :FinalizeCategory := false );

 AddIsNullHomotopic( cochain_cat, is_null_homotopic );

 Finalize( cochain_cat );

 homotopy_cat := HomotopyCategory( cochain_cat );

 return homotopy_cat;

end;

#   0      1      2       3     4      5    6
#   0      Z  5   Z   0   Z  6  Z   0  Z    0
#
#                        715 
#
#   0      0      Z   5   Z     Z   6  Z  0 Z   0


#! @Chunk 0
#! @BeginLatexOnly
#! Let $R$ be a commutative homalg ring. The category of finite left presentations over $R$, denoted by fpres-$R$,
#! is abelian. Hence its cochain complex category $\mathrm{Ch}^\bullet($ fpres-$R$ $)$ is again abelian.
#! Let $\mathrm{Ch}^{\bullet b}(\mathrm{fpres}-R)$ be the full subcategory whose objects are bounded complexes. In this 
#! category it is algorithmically decidable whether a cochain morphism is null-homotopic or not. Hence the bounded homotopy category 
#! $H^{\bullet b}(\mathrm{fpres-}R)$ of fpres-$R$ can be constructed. The function $\texttt{is\_null\_homotopic}$ which 
#! decides whether a morphism is null-homotopic or not is implemented in file $\texttt{H\_cat\_of\_l\_p\_cat\_over\_comm\_homalg\_ring.g}$
#! in examples directory. In the following example we construct the homotopy category of finite left presentations over 
#! the ring of integers $\mathbb{Z}$.
#! @EndLatexOnly
#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
cat := LeftPresentations( ZZ );
#! Category of left presentations of Z
cochain_cat := CochainComplexCategory( cat :FinalizeCategory := false );
#! Cochain complexes category over category of left presentations of Z
AddIsNullHomotopic( cochain_cat, is_null_homotopic );
Finalize( cochain_cat );
#! true
homotopy_cat := HomotopyCategory( cochain_cat );
#! Cochain homotopy category of category of left presentations of Z
#! @EndExample
#! @BeginLatexOnly
#! Let us define a morphism
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=4em,column sep=3em,minimum width=2em]
#!   {
#!    \cdots\phantom{0} & 1& 2& 3& 4 & 5 & 6 &\phantom{0}\cdots\\
#!     \cdots\phantom{0}      & 0& 0 & 0 & \mathbb{Z}^{1\times 1} & \mathbb{Z}^{1\times 1} & 0&\phantom{0}\cdots\\
#!     \cdots \phantom{0}     & 0& 0 & \mathbb{Z}^{1\times 1} & \mathbb{Z}^{1\times 1} & 0 & 0&\phantom{0}\cdots\\};
#!
#!   \path[-stealth]
#!     (m-2-2) edge (m-2-3)
#!     (m-2-3) edge  (m-2-4)
#!     (m-2-4) edge  (m-2-5)
#!     (m-2-5) edge node[above=0.5ex] {$(6)$}(m-2-6)
#!     (m-2-6) edge (m-2-7)
#!     (m-2-1) edge (m-2-2)
#!     (m-2-7) edge (m-2-8)
#!     (m-2-5) edge node[right=0.225ex] {$(10)$} (m-3-5)
#!     (m-3-4) edge node[below=0.225ex] {$(4)$} (m-3-5)
#!     (m-3-5) edge (m-3-6)
#!     (m-3-7) edge (m-3-8)
#!(m-3-3) edge (m-3-4)
#! (m-3-2) edge (m-3-3)
#! (m-3-1) edge (m-3-2)
#! (m-3-6) edge (m-3-7);
#! \end{tikzpicture}
#! \end{center}
#! Since $\mathrm{gcd}(4,6)=2\mid 10$, the equation $4x+6y=10$ is solvable, which implies that $\phi$ is null-homotopic.
#! @EndLatexOnly
#! @Example
A := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
id_A := IdentityMorphism( A );
#! <An identity morphism in Category of left presentations of Z>
phi := CochainMorphism( [ 6*id_A ], 4, [ 4*id_A ], 3, [ 10*id_A ], 4 );
#! <A bounded morphism in cochain complexes category over category of 
#! left presentations of Z with active lower bound 3 and active upper bound 5>
H := NaturalQuotientFunctor( cochain_cat, homotopy_cat );
#! Quotient functor from cochain complexes category over category of left 
#! presentations of Z to cochain homotopy category of category of left presentations 
#! of Z
H_phi := ApplyFunctor( H, phi );
#! <A bounded morphism in cochain homotopy category of category of left 
#! presentations of Z with active lower bound 3 and active upper bound 5>
IsZero( H_phi );
#! true
IsNullHomotopic( phi );
#! true
#! @EndExample
#! @BeginLatexOnly
#! With the same discussion, we find that the following morphism 
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=4em,column sep=3em,minimum width=2em]
#!   {
#!    \cdots\phantom{0} & 1& 2& 3& 4 & 5 & 6 &\phantom{0}\cdots\\
#!     \cdots\phantom{0}      & 0& 0 & 0 & \mathbb{Z}^{1\times 1} & \mathbb{Z}^{1\times 1} & 0&\phantom{0}\cdots\\
#!     \cdots \phantom{0}     & 0& 0 & \mathbb{Z}^{1\times 1} & \mathbb{Z}^{1\times 1} & 0 & 0&\phantom{0}\cdots\\};
#!
#!   \path[-stealth]
#!     (m-2-2) edge (m-2-3)
#!     (m-2-3) edge  (m-2-4)
#!     (m-2-4) edge  (m-2-5)
#!     (m-2-5) edge node[above=0.5ex] {$(6)$}(m-2-6)
#!     (m-2-6) edge (m-2-7)
#!     (m-2-1) edge (m-2-2)
#!     (m-2-7) edge (m-2-8)
#!     (m-2-5) edge node[right=0.225ex] {$(7)$} (m-3-5)
#!     (m-3-4) edge node[below=0.225ex] {$(4)$} (m-3-5)
#!     (m-3-5) edge (m-3-6)
#!     (m-3-7) edge (m-3-8)
#!(m-3-3) edge (m-3-4)
#! (m-3-2) edge (m-3-3)
#! (m-3-1) edge (m-3-2)
#! (m-3-6) edge (m-3-7);
#! \end{tikzpicture}
#! \end{center}
#! is not null-homotopic.
#! @EndLatexOnly
#! @Example
psi := CochainMorphism( [ 6*id_A ], 4, [ 4*id_A ], 3, [ 7*id_A ], 4 );
#! <A bounded morphism in cochain complexes category over category of 
#! left presentations of Z with active lower bound 3 and active upper bound 5>
H_psi := ApplyFunctor( H, psi );
#! <A bounded morphism in cochain homotopy category of category of left 
#! presentations of Z with active lower bound 3 and active upper bound 5>
IsZero( H_psi );
#! false
#! @EndExample
#! Hence for any commutative homalg ring $R$ the following function constructs the cochain homotopy category of
#! fpres-$R$.
#! @BeginCode x
#!  CochainHomotopyCategory := 
#! 
#!  function( R )
#!  local cat, cochain_cat, homotopy_cat;
#! 
#!  cat := LeftPresentations( R );
#! 
#!  cochain_cat := CochainComplexCategory( cat :FinalizeCategory := false );
#! 
#!  AddIsNullHomotopic( cochain_cat, is_null_homotopic );
#! 
#!  Finalize( cochain_cat );
#! 
#!  homotopy_cat := HomotopyCategory( cochain_cat );
#! 
#!  return homotopy_cat;
#! 
#!  end;
#! @EndCode
#! @InsertCode x
#! @BeginLatexOnly
#! Let $R=\mathbb{Q}[x,y,z,t]$. Then the cochain complex morphism 
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=4em,column sep=3em,minimum width=2em]
#!   {
#!    \cdots\phantom{0} & -1& 0& 1& 2 & 3 & 4 &\phantom{0}\cdots\\
#!     \cdots\phantom{0}      & 0& 0 & R/\langle x\rangle & R/\langle xy\rangle & 0 & 0&\phantom{0}\cdots\\
#!     \cdots \phantom{0}     & 0& 0 & R/\langle xy\rangle & R/\langle xyt\rangle & 0 & 0&\phantom{0}\cdots\\};
#!
#!   \path[-stealth]
#!     (m-2-2) edge (m-2-3)
#!     (m-2-3) edge  (m-2-4)
#!     (m-2-4) edge  (m-2-5)
#!     (m-2-4) edge node[above=0.5ex] {$(y)$}(m-2-5)
#!     (m-2-5) edge (m-2-6)
#!     (m-2-6) edge (m-2-7)
#!     (m-2-1) edge (m-2-2)
#!     (m-2-7) edge (m-2-8)
#!     (m-2-4) edge node[left=0.225ex] {$(yz)$} (m-3-4)
#!     (m-2-5) edge node[right=0.225ex] {$(zt)$} (m-3-5)
#!     (m-3-4) edge node[below=0.225ex] {$(t)$} (m-3-5)
#!     (m-3-5) edge (m-3-6)
#!     (m-3-7) edge (m-3-8)
#!(m-3-3) edge (m-3-4)
#! (m-3-2) edge (m-3-3)
#! (m-3-1) edge (m-3-2)
#! (m-3-6) edge (m-3-7);
#! \end{tikzpicture}
#! \end{center}
#! is null-homotopic.
#! @EndLatexOnly
#! @Example
R := HomalgFieldOfRationalsInSingular()*"x,y,z,t";
#! Q[x,y,z,t]
homotopy_cat := CochainHomotopyCategory( R );
#! Cochain homotopy category of category of left presentations of Q[x,y,z,t]
A1 := AsLeftPresentation( HomalgMatrix( "[ [ x ] ]", 1, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
A2 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]", 1, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
B1 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]", 1, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
B2 := AsLeftPresentation( HomalgMatrix( "[ [ xyt ] ]", 1, 1, R ) );
#! <An object in Category of left presentations of Q[x,y,z,t]>
a12 := PresentationMorphism( A1, HomalgMatrix( "[ [ y ] ]",1 ,1 , R ), A2 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
b12 := PresentationMorphism( B1, HomalgMatrix( "[ [ t ] ]", 1, 1, R ), B2 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
CA := CochainComplex( [ a12 ], 1 );
#! <A bounded object in cochain complexes category over category of 
#! left presentations of Q[x,y,z,t] with active lower bound 0 and active
#! upper bound 3.>
CB := CochainComplex( [ b12 ], 1 );
#! <A bounded object in cochain complexes category over category of 
#! left presentations of Q[x,y,z,t] with active lower bound 0 and active 
#! upper bound 3.>
f1 := PresentationMorphism( A1, HomalgMatrix( "[ [ yz ] ]", 1, 1, R ), B1 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
f2 := PresentationMorphism( A2, HomalgMatrix( "[ [ zt ] ]", 1, 1, R ), B2 );
#! <A morphism in Category of left presentations of Q[x,y,z,t]>
phi := CochainMorphism( CA, CB, [ f1, f2 ], 1 );
#! <A bounded morphism in cochain complexes category over category of 
#! left presentations of Q[x,y,z,t] with active lower bound 0 and active 
#! upper bound 3>
IsZero( phi );
#! false
cochain_cat := UnderlyingCategory( homotopy_cat );
#! Cochain complexes category over category of left presentations of Q[x,y,z,t]
H := NaturalQuotientFunctor( cochain_cat, homotopy_cat );
#! Quotient functor from cochain complexes category over category of 
#! left presentations of Q[x,y,z,t] to cochain homotopy category of category of 
#! left presentations of Q[x,y,z,t]
H_phi := ApplyFunctor( H, phi );
#! <A bounded morphism in cochain homotopy category of category of left 
#! presentations of Q[x,y,z,t] with active lower bound 3 and active upper bound 5>
IsZero( H_phi );
#! true
#! @EndExample
#! @EndChunk