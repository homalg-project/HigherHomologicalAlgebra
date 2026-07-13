# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#


##
InstallMethod( AbstractionAlgebroid,
        [ IsCapFullSubcategory ],
  
  function ( seq )
    local nr_vertices, arrows, q, vertices_latex, morphisms_latex, F, k, kF, o, convert_string_to_morphism,
    distinguished_object, range_cat, relations, quo_kF, data_tables, oid, object_func, morphism_func, data, known_values_on_objects, full_functor, f, t;
    
    nr_vertices := Length( SetOfObjects( seq ) );
    
    arrows := Concatenation(
                List( [ 1 .. nr_vertices - 1 ],
                    i -> Concatenation( List( [ i + 1 .. nr_vertices ],
                        j -> List( [ 1 .. Length( IrreducibleMorphisms( seq, [ i, j ] ) ) ],
                            k -> [ Concatenation( "m", String(i), "_", String(j), "_", String(k) ), i, j, Concatenation( "m_{", String(i), ",", String(j), "}^{", String(k), "}" ) ] ) ) ) ) );
    
    q := FinQuiver(
            Concatenation(
                "q(",
                JoinStringsWithSeparator( List( [ 1 .. nr_vertices ], i -> Concatenation( "E", String( i ) ) ), "," ),
                ")[", JoinStringsWithSeparator( List( arrows, m -> Concatenation( m[1], ":", "E", String(m[2]), "->", "E", String(m[3]) ) ), "," ), "]" ) );
    
    vertices_latex := List( [ 1 .. nr_vertices ], i -> Concatenation( "E_{", String(i), "}" ) );
    morphisms_latex := List( arrows, m -> m[4] );
    
    SetLaTeXStringsOfObjects( q, vertices_latex );
    SetLaTeXStringsOfMorphisms( q, morphisms_latex );
    
    F := PathCategory( q );
    
    range_cat := RangeCategoryOfHomomorphismStructure( seq );
    
    kF := LinearClosure( CommutativeSemiringOfLinearCategory( seq ), F );
    
    o := CallFuncListAtRuntime( SetOfObjects, [ kF ] );
    
    convert_string_to_morphism :=
      function( str )
        str := SplitString( str, "_" );
        str[1] := str[1]{ [ 2 .. Length( str[1] ) ] };
        str := List( str, Int );
        if Length( str ) = 3 then
          return IrreducibleMorphisms( seq, [ str[1], str[2] ] )[str[3]];
        else
          return IdentityMorphism( seq, seq[str[1]] );
        fi;
    end;
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( seq );
    
    relations := Concatenation(
      List( [ 1 .. nr_vertices - 2 ],
         i -> Concatenation( List( [ i + 2 .. nr_vertices ],
            function( j )
              local H_ij, B_ij, morphisms, u, coeffs;
              
              H_ij := HomomorphismStructureOnObjects( seq, seq[i], seq[j] );
              
              B_ij := CallFuncListAtRuntime( BasisOfExternalHom, [ kF, o[i], o[j] ] );
              
              morphisms := List( B_ij, b -> PreComposeList( seq, seq[i], List( LabelsOfMorphisms(q){MorphismIndices( MorphismDatum(b)[2][1] )}, convert_string_to_morphism ), seq[j] ) );
              
              morphisms := List( morphisms, m -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( seq, distinguished_object, m, H_ij ) );
              
              u := KernelEmbedding( range_cat, UniversalMorphismFromDirectSum( range_cat, ListWithIdenticalEntries( Length( morphisms ), distinguished_object ), H_ij, morphisms ) );
              
              coeffs := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( u ) );
              
              return List( coeffs, coeff -> CallFuncListAtRuntime( LinearCombinationOfMorphisms, [ kF, o[i], coeff, B_ij, o[j] ] ) );
              
            end ) ) ) );
    
    quo_kF := CallFuncListAtRuntime( QuotientCategory, [ kF, relations ] );
    
    data_tables := CallFuncListAtRuntime( DataTablesOfLinearCategory, [ quo_kF ] );

    oid := AlgebroidFromDataTables( data_tables : range_of_HomStructure := range_cat );
    
    SetIsAdmissibleAlgebroid( oid, true );
    
    SetDefiningCategory( oid, quo_kF );
    
    # defining the isomorphisms from/to abstraction algebroid
    
    object_func := o -> seq[ObjectIndex( o )];
    
    morphism_func :=
      function( s, alpha, r )
        local components;
        
        components := DecompositionIndicesOfMorphismInAlgebroid( alpha );
        
        Assert( 0, Length( components ) <= 1 );
        
        if IsEmpty( components ) then
            return ZeroMorphism( seq, s, r );
        else
            return PreComposeList( seq, s, List( LabelsOfMorphisms( q ){ components[1][2] }, convert_string_to_morphism ), r );
        fi;
        
    end;
    
    known_values_on_objects := [ CallFuncListAtRuntime( SetOfObjects, [ oid ] ), CallFuncListAtRuntime( SetOfObjects, [ seq ] ) ];

    data := AdditiveFunctorDataFromValuesOnBasisMorphisms( oid, seq, object_func, morphism_func : is_full := true, known_values_on_objects := known_values_on_objects );
    
    ##
    f := CapFunctor( "Isomorphism: abstraction algebroid ⟶ strong exceptional sequence", oid, seq );
    AddObjectFunction( f, data[1] );
    AddMorphismFunction( f, data[2] );
    
    #= comment for Julia
    DeactivateCachingObject( ObjectCache( f ) );
    DeactivateCachingObject( MorphismCache( f ) );
    # =#
    
    ##
    t := CapFunctor( "Isomorphism: strong exceptional sequence ⟶ abstraction algebroid", seq, oid );
    AddObjectFunction( t, data[3] );
    AddMorphismFunction( t, data[4] );

    #= comment for Julia
    DeactivateCachingObject( ObjectCache( t ) );
    DeactivateCachingObject( MorphismCache( t ) );
    # =#
    
    SetIsomorphismFromAbstractionAlgebroid( seq, f );
    SetIsomorphismIntoAbstractionAlgebroid( seq, t );
    
    return oid;
    
end );

##
InstallMethod( IsomorphismIntoAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local oid;
    
    # to set the attribute
    oid := AbstractionAlgebroid( seq );
    
    return IsomorphismIntoAbstractionAlgebroid( seq );
    
end );

##
InstallMethod( IsomorphismFromAbstractionAlgebroid,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local oid;
    
    # to set the attribute
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
  function( k, nr_vertices, nr_arrows )
    local q, P, kP, oid, Aoid, KAoid, objects;
    
    q := RandomFinQuiver( nr_vertices, nr_arrows, false );
    
    P := PathCategory( q );
    
    kP := LinearClosure( k, P );

    oid := AlgebroidFromDataTables( kP );
    
    Aoid := AdditiveClosure( oid );
    
    KAoid := HomotopyCategoryByCochains( Aoid );
    
    objects := CallFuncListAtRuntime( SetOfObjectsOfCategory, [ oid ] );

    objects := List( objects, o -> CallFuncListAtRuntime( AsAdditiveClosureObject, [ o ] ) );

    objects := List( objects, o -> CallFuncListAtRuntime( CreateComplex, [ KAoid, o, 0 ] ) );
    
    return CallFuncListAtRuntime( CreateStrongExceptionalSequence, [ objects ] );
    
end );

