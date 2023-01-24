






##
InstallMethod( AbstractionAlgebroid,
        [ IsCapFullSubcategory ],
  
  function ( seq )
    local nr_vertices, arrows, q, vertices_latex, morphisms_latex, F, k, kF, o, convert_string_to_morphism, distinguished_object, range_cat, relations, oid, object_func, morphism_func, data, full_functor, f, t;
    
    nr_vertices := Length( SetOfKnownObjects( seq ) );
    
    arrows := Concatenation(
                List( [ 1 .. nr_vertices - 1 ],
                    i -> Concatenation( List( [ i + 1 .. nr_vertices ],
                        j -> List( [ 1 .. Length( IrreducibleMorphisms( seq, [ i, j ] ) ) ],
                            k -> [ Concatenation( "m", String(i), "_", String(j), "_", String(k) ), i, j, Concatenation( "m_{", String(i), ",", String(j), "}^{", String(k), "}" ) ] ) ) ) ) );
    
    q := RightQuiver(
            Concatenation(
                "q(",
                JoinStringsWithSeparator( List( [ 1 .. nr_vertices ], i -> Concatenation( "E", String( i ) ) ), "," ),
                ")[", JoinStringsWithSeparator( List( arrows, m -> Concatenation( m[1], ":", String(m[2]), "->", String(m[3]) ) ), "," ), "]" ) );
    
    vertices_latex := List( [ 1 .. nr_vertices ], i -> Concatenation( "E_{", String(i), "}" ) );
    morphisms_latex := List( arrows, m -> m[4] );
    
    SetLabelsAsLaTeXStrings( q, vertices_latex, morphisms_latex );
    
    F := FreeCategory( q );
    
    range_cat := RangeCategoryOfHomomorphismStructure( seq );
    
    kF := Algebroid( CommutativeRingOfLinearCategory( seq ),  FreeCategory( q ) : range_of_HomStructure := range_cat );
    
    o := SetOfObjects( kF );
    
    convert_string_to_morphism :=
      function( str )
        str := SplitString( str, "_" );
        Remove( str[1], 1 );
        str := List( str, Int );
        if Length( str ) = 3 then
          return IrreducibleMorphisms( seq, [ str[1], str[2] ] )[str[3]];
        else
          return IdentityMorphism( seq[str[1]] );
        fi;
    end;
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( seq );
    
    relations := Concatenation(
      List( [ 1 .. nr_vertices - 2 ],
         i -> Concatenation( List( [ i + 2 .. nr_vertices ],
            function( j )
              local H_ij, morphisms, u, coeffs, B_ij;
              
              H_ij := HomomorphismStructureOnObjects( seq, seq[i], seq[j] );
              
              morphisms := List( BasisPathsByVertexIndex( kF )[i][j], p -> PreComposeList( seq, List( ArrowList( p ), a -> convert_string_to_morphism( Label( a ) ) ) ) );
              
              morphisms := List( morphisms, m -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( seq, distinguished_object, m, H_ij ) );
              
              u := KernelEmbedding( range_cat, UniversalMorphismFromDirectSum( range_cat, ListWithIdenticalEntries( Length( morphisms ), distinguished_object ), H_ij, morphisms ) );
              
              coeffs := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( u ) );
              
              B_ij := BasisOfExternalHom( kF, o[i], o[j] ); # whose elements are wrappers of the elements of BasisPathsByVertexIndex( kF )[i][j]
              
              return List( coeffs, coeff -> SumOfMorphisms( kF, o[i], ListN( coeff, B_ij, { c, f } -> MultiplyWithElementOfCommutativeRingForMorphisms( kF, c, f ) ), o[j] ) );
              
            end ) ) ) );
    
    oid := QuotientCategory( kF, relations : range_of_HomStructure := range_cat );
    
    # defining the isomorphisms from/to abstraction algebroid
    
    object_func := o -> seq[VertexIndex( UnderlyingVertex( o ) )];
    
    morphism_func :=
      function( s, alpha, r )
        local components;
        
        components := Paths( UnderlyingQuiverAlgebraElement( alpha ) );
        
        Assert( 0, Length( components ) <= 1 );
        
        if IsEmpty( components ) then
            return ZeroMorphism( seq, s, r );
        else
            return PreComposeList( seq, Concatenation( [ IdentityMorphism( s ) ], List( ArrowList( components[1] ), a -> convert_string_to_morphism( Label(a) ) ) ) );
        fi;
        
    end;
    
    data := AdditiveFunctorByTwoFunctionsData( oid, seq, object_func, morphism_func : full_functor := true, values_on_objects := [ SetOfObjects( oid ), SetOfKnownObjects( seq ) ] );
    
    ##
    f := CapFunctor( Concatenation( "Isomorphism: abstraction algebroid ", TEXTMTRANSLATIONS.longrightarrow, " strong exceptional sequence" ), oid, seq );
    AddObjectFunction( f, data[1] );
    AddMorphismFunction( f, data[2] );
    
    DeactivateCachingObject( ObjectCache( f ) );
    DeactivateCachingObject( MorphismCache( f ) );
    
    ##
    t := CapFunctor( Concatenation( "Isomorphism: strong exceptional sequence ", TEXTMTRANSLATIONS.longrightarrow, " abstraction algebroid" ), seq, oid ); 
    AddObjectFunction( t, data[3] );
    AddMorphismFunction( t, data[4] );
    DeactivateCachingObject( ObjectCache( t ) );
    DeactivateCachingObject( MorphismCache( t ) );
    
    SetIsomorphismFromAbstractionAlgebroid( seq, f );
    SetIsomorphismIntoAbstractionAlgebroid( seq, t );
    
    return oid;
    
end );

##
InstallMethod( IsomorphismIntoAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local oid;
    
    oid := AbstractionAlgebroid( seq );
    
    return IsomorphismIntoAbstractionAlgebroid( seq );
    
end );

##
InstallMethod( IsomorphismFromAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local oid;
    
    oid := AbstractionAlgebroid( seq );
    
    return IsomorphismFromAbstractionAlgebroid( seq );
    
end );

##
InstallMethod( ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local I, F;
    
    I := ExtendFunctorToHomotopyCategoriesByCochains( ExtendFunctorToAdditiveClosures( IsomorphismFromAbstractionAlgebroid( seq ) ) );    
    
    F := PreCompose( I, ConvolutionFunctor( seq ) );
    
    F!.Name := "Convolution functor";
    
    return F;
    
end );

##
InstallMethod( ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local I, G;
    
    I := ExtendFunctorToHomotopyCategoriesByCochains( ExtendFunctorToAdditiveClosures( IsomorphismIntoAbstractionAlgebroid( seq ) ) );
    
    G := PreCompose( ReplacementFunctor( seq ), I );
    
    G!.Name := "Replacement functor";
    
    return G;
    
end );

## Convenience for development

InstallGlobalFunction( RandomStrongExceptionalSequence,
  function( k, nr_vertices, nr_arrows, nr_relations )
    local sources_of_arrows, ranges_of_arrows, arrows, all_labels, q, v_latex, a_latex, A, G, H, df_H, rel, g, e, oid, Aoid, KAoid, i;
    
    sources_of_arrows := List( [ 1 .. nr_arrows ], i -> Random( [ 1 .. nr_vertices - 1 ] ) );
    ranges_of_arrows := List( [ 1 .. nr_arrows ], i -> Random( [ sources_of_arrows[ i ] + 1 .. nr_vertices ] ) );
    
    arrows := Collected( ListN( sources_of_arrows, ranges_of_arrows, {s,r} -> [ s, r ] ) );
    
    all_labels := Concatenation( List( arrows, l -> List( [ 1 .. l[2] ],
                      i -> [ Concatenation( "r", String( l[1][1] ), "_", String( l[1][2] ), "_", String( i ) ),
                             Concatenation( "r_{", String( l[1][1] ), ",", String( l[1][2] ), "}^{", String( i ), "}" ) ] ) ) );
    
    sources_of_arrows := Concatenation( List( arrows, l -> List( [ 1 .. l[2] ], k -> l[1][1] ) ) );
    ranges_of_arrows :=  Concatenation( List( arrows, l -> List( [ 1 .. l[2] ], k -> l[1][2] ) ) );
    
    q := RightQuiver( "q", [ 1 .. nr_vertices ], List( all_labels, l -> l[1] ), sources_of_arrows, ranges_of_arrows );
    
    v_latex := List( [ 1 .. nr_vertices ], i -> Concatenation( "V_", String( i ) ) );
    a_latex := List( all_labels, l -> l[2] );
    
    SetLabelsAsLaTeXStrings( q, v_latex, a_latex );
    SetLabelsAsLaTeXStrings( OppositeQuiver( q ), v_latex, a_latex );
    
    # PLEASE CHANGE THE FOLLOWING CODE
    A := PathAlgebra( k, q );
    
    G := GeneratorsOfLeftOperatorAdditiveGroup( A );
    
    G := List( G, g -> g!.paths[ 1 ] );
    
    G := Filtered( G, g -> Length( g ) >= 2 );
    
    H := List( G, g -> [ Source( g ), Target( g ) ] );
    
    df_H := DuplicateFreeList( H );
    
    G := List( df_H, u -> G{ Positions( H, u ) } );
    
    rel := [ ];
      
    if not IsEmpty( G ) then
      
      for i in [ 1 .. nr_relations ] do
        
        g := Random( G );
        
        e := QuiverAlgebraElement( A, List( [ 1 .. Length( g ) ], k -> Random( [ -2 .. 2 ] ) ), g );
        
        Add( rel, e );
        
      od;
    
    fi;
    
    rel := ComputeGroebnerBasis( rel );
    
    A := QuotientOfPathAlgebra( A, rel );
    
    oid := Algebroid( A : range_of_HomStructure := CategoryOfRows( k : overhead := false ) );
    
    Aoid := AdditiveClosure( oid );
    
    KAoid := HomotopyCategoryByCochains( Aoid );
    
    return CreateStrongExceptionalSequence( List( SetOfObjects( oid ), o -> CreateComplex( KAoid, AsAdditiveClosureObject( o ), 0 ) ) );
    
end );

