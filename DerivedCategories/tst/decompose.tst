gap> ConstructIsomorphicQuiverRepresentation :=
>  function( a )
>    local A, q, arrows, vertices, L, p, dim, m, inverse_m, new_mats, arrow;
>    A := AlgebraOfRepresentation( a );
>    q := QuiverOfRepresentation( a );
>    arrows := Arrows( q );
>    vertices := Vertices( q );
>    L := List( vertices, v -> [ Size( IncomingArrows( v ) ), Size( OutgoingArrows( v ) ) ] );
>    p := Position( L, Maximum( L ) );
>    dim := Dimension( VectorSpaceOfRepresentation( a, p ) );
>    if IsZero( dim ) then
>      return a;
>    fi;
>    m := RandomUnimodularMat( dim );
>    inverse_m := m^-1;
>    m := MatrixByRows( LeftActingDomain( A ), m );
>    inverse_m := MatrixByRows( LeftActingDomain( A ), inverse_m );
>    new_mats := [ ];
>    for arrow in arrows do
>      if Source( arrow ) = vertices[ p ] then
>        Add( new_mats, m * RightMatrixOfLinearTransformation( MapForArrow( a, arrow ) ) );
>      elif Target( arrow ) = vertices[ p ] then
>        Add( new_mats, RightMatrixOfLinearTransformation( MapForArrow( a, arrow ) ) * inverse_m );
>      else
>        Add( new_mats, RightMatrixOfLinearTransformation( MapForArrow( a, arrow ) ) );
>      fi;
>    od;
>    return QuiverRepresentation( A, DimensionVector( a ), new_mats );
> end;;
gap> N := NanosecondsSinceEpoch( );; 
gap> field := HomalgFieldOfRationals( );;
gap> #field := Rationals;;
gap> A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreStrongExceptionalCollection( field, 2 + N mod 3, 2 + N mod 7, 0 );;
gap> cat := CategoryOfQuiverRepresentations( A );;
gap> projs := IndecProjRepresentations( A );;
gap> L := List( [ 1 .. 6 ], i -> Random( projs ) );;
gap> a := DirectSum( L );;
gap> d := DecomposeProjectiveQuiverRepresentation( a );;
gap> m := MorphismBetweenDirectSums( List( d, i -> [ i ] ) );;
gap> IsIsomorphism( m ) and Range( m ) = a;
true
gap> projs := List( projs, ConstructIsomorphicQuiverRepresentation );;
gap> L := List( [ 1 .. 6 ], i -> Random( projs ) );;
gap> a := DirectSum( L );;
gap> d := DecomposeProjectiveQuiverRepresentation( a );;
gap> m := MorphismBetweenDirectSums( List( d, i -> [ i ] ) );;
gap> IsIsomorphism( m ) and Range( m ) = a;
true
gap> a := ConstructIsomorphicQuiverRepresentation( a );;
gap> d := DecomposeProjectiveQuiverRepresentation( a );;
gap> m := MorphismBetweenDirectSums( List( d, i -> [ i ] ) );;
gap> IsIsomorphism( m ) and Range( m ) = a;
true
