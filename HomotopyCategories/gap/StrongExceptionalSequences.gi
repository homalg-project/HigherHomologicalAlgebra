






##################################
##
## Constructors
##
#################################

##
InstallGlobalFunction( CreateStrongExceptionalSequence,
  
  function ( list_of_objects )
    local full;
    
    full := FullSubcategoryGeneratedByListOfObjects( list_of_objects );
    
    full!.Name := Concatenation( "A strong exceptional sequence in ", Name( AmbientCategory( full ) ) );
    
    return full;
    
end );

##
InstallMethod( IrreducibleMorphismsOp,
          [ IsCapFullSubcategory, IsList ],
    
  function( seq, indices )
    local i, j, Ei, Ej, range_cat, Hom_EiEj, distinguished_object, composite_morphisms, u, cokernel_projection;
    
    Ei := seq[indices[1]];
    Ej := seq[indices[2]];
    
    if indices[1] >= indices[2] then
        return [];
    fi;
    
    range_cat := RangeCategoryOfHomomorphismStructure( seq );
    
    Hom_EiEj := HomomorphismStructureOnObjects( seq, Ei, Ej );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( seq );
    
    composite_morphisms := CompositeMorphisms( seq, indices );
    
    u := UniversalMorphismFromDirectSum(
                  range_cat,
                  ListWithIdenticalEntries( Length( composite_morphisms ), distinguished_object ),
                  Hom_EiEj,
                  List( composite_morphisms, alpha -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( seq, distinguished_object, alpha, Hom_EiEj ) ) );
    
    cokernel_projection := CokernelProjection( u );
    
    return List( BasisOfExternalHom( range_cat, distinguished_object, Range( cokernel_projection ) ),
                      eta -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( seq, Ei, Ej, Lift( eta, cokernel_projection ) ) );
    
end );

##
InstallMethod( CompositeMorphismsOp,
          [ IsCapFullSubcategory, IsList ],
   
  function( seq, indices )
    
    return Concatenation(
              List( [ indices[1]+1 .. indices[2]-1 ],
                  ell -> ListX(
                        IrreducibleMorphisms( seq, [ indices[1], ell ] ),
                        Concatenation( IrreducibleMorphisms( seq, [ ell, indices[2] ] ), CompositeMorphisms( seq, [ ell, indices[2] ] ) ),
                        PreCompose ) ) );
    
end );

##
InstallMethod( DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence,
          [ IsCapFullSubcategory, IsCapCategoryObject ],
  
  function ( seq, A )
    local ambient_cat, object_func, morphism_func;
    
    ambient_cat := AmbientCategory( seq );
    
    if not IsIdenticalObj( ambient_cat, CapCategory( A ) ) then
        Error( "The object passed to 'DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence' must live in the ambient category of the strong exceptional sequence!\n" );
    fi;
    
    object_func := i -> HomomorphismStructureOnObjects( ambient_cat, UnderlyingCell( seq[i] ), A );
    
    morphism_func := { i, k, j } -> HomomorphismStructureOnMorphismsWithGivenObjects(
                                                  ambient_cat,
                                                  object_func(j),
                                                  UnderlyingCell( IrreducibleMorphisms( seq, [ i, j ] )[k] ),
                                                  IdentityMorphism( ambient_cat, A ),
                                                  object_func(i) );
    
    return Pair( object_func, morphism_func );
    
end );

##
InstallMethod( DataOfYonedaEmbeddingOnMorphismRelativeToStrongExceptionalSequence,
          [ IsCapFullSubcategory, IsCapCategoryMorphism ],
  
  function ( seq, alpha )
    local ambient_cat, s_func, r_func;
    
    ambient_cat := AmbientCategory( seq );
    
    if not IsIdenticalObj( ambient_cat, CapCategory( alpha ) ) then
        Error( "The morphism passed to 'DataOfYonedaEmbeddingOnMorphismRelativeToStrongExceptionalSequence' must live in the ambient category of the strong exceptional sequence!\n" );
    fi;
    
    s_func := DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence( seq, Source( alpha ) )[1];
    r_func := DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence( seq,  Range( alpha ) )[1];
    
    return i -> HomomorphismStructureOnMorphismsWithGivenObjects(
                              ambient_cat,
                              s_func(i),
                              UnderlyingCell( IdentityMorphism( seq, seq[i] ) ),
                              alpha,
                              r_func(i) );
    
end );

##
InstallMethod( DataOfExceptionalCover,
          [ IsCapFullSubcategory, IsCapCategoryObject ],
  
  function( seq, A )
    local ambient_cat, range_cat, distinguished_object, nr_objects, data, u;
    
    ambient_cat := AmbientCategory( seq );
    
    range_cat := RangeCategoryOfHomomorphismStructure( ambient_cat );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( ambient_cat );
    
    nr_objects := Length( SetOfKnownObjects( seq ) );
    
    data := DataOfYonedaEmbeddingOnObjectRelativeToStrongExceptionalSequence( seq, A );
    
    u := List( [ 1 .. nr_objects ],
            i -> Concatenation( List( [ i + 1 .. nr_objects ],
              j -> List( [ 1 .. Length( IrreducibleMorphisms( seq, [i,j] ) ) ],
                k -> data[2]( i, k, j ) ) ) ) );
    
    u := ListN( [ 1 .. nr_objects ], u,
            { i, tau } -> PreInverseForMorphisms( range_cat, CokernelProjection( range_cat, UniversalMorphismFromDirectSum( range_cat, data[1](i), tau ) ) ) );
    
    u := List( u,
            pre_inverse -> List( BasisOfExternalHom( range_cat, distinguished_object, Source( pre_inverse ) ),
              b -> PreCompose( range_cat, b, pre_inverse ) ) );
    
    return ListN( [ 1 .. nr_objects], u,
              { i, ell } -> List( ell, eta -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ambient_cat, UnderlyingCell( seq[i] ), A, eta ) ) );
    
end );


##
InstallOtherMethod( ExceptionalCover,
          [ IsCapFullSubcategory, IsCapCategoryObject, IsList ],
  
  { seq, A, cover_data } -> UniversalMorphismFromDirectSum( AmbientCategory( seq ), A, Concatenation( cover_data ) )
);

##
InstallMethod( ExceptionalCover,
          [ IsCapFullSubcategory, IsCapCategoryObject ],
  
  { seq, A } -> ExceptionalCover( seq, A, DataOfExceptionalCover( seq, A ) )
);

##
InstallMethod( PossibileExceptionalShifts,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function( seq, A )
    local nr_objects, u_seq, l_seq;
    
    if not IsIdenticalObj( AmbientCategory( seq ), CapCategory( A ) ) then
        Error( "the object passed to 'PossibileExceptionalShifts' does not belong to the ambient category of the strong exceptional sequence!\n" );
    fi;
     
    nr_objects := Length( SetOfKnownObjects( seq ) );
    
    u_seq := Maximum( List( [ 1 .. nr_objects ], i -> UpperBound( UnderlyingCell( seq[i] ) ) ) );
    l_seq := Minimum( List( [ 1 .. nr_objects ], i -> LowerBound( UnderlyingCell( seq[i] ) ) ) );
    
    return [ LowerBound( A ) - u_seq .. UpperBound( A ) - l_seq ];
    
end );

##
InstallMethod( ExceptionalShifts,
           [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function ( seq, A )
    local ambient_cat, nr_objects, possible_shifts, shifts_A;
    
    ambient_cat := AmbientCategory( seq );
    
    nr_objects := Length( SetOfKnownObjects( seq ) );
    
    possible_shifts := PossibileExceptionalShifts( seq, A );
    
    shifts_A := List( possible_shifts, i -> ApplyShift( A, i ) );
    
    return possible_shifts{ Filtered( [ 1 .. Length( possible_shifts ) ],
                                          j -> ForAny( [ 1 .. nr_objects ],
                                            i -> not IsZeroForObjects( HomomorphismStructureOnObjects( ambient_cat, UnderlyingCell( seq[i] ), shifts_A[j] ) ) ) ) };
    
end );

##
InstallMethod( MaximalExceptionalShift,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function( seq, A )
    local ambient_cat, nr_objects, possible_shifts, shift_A, j, i;
    
    ambient_cat := AmbientCategory( seq );
    
    nr_objects := Length( SetOfKnownObjects( seq ) );
    
    possible_shifts := Reversed( PossibileExceptionalShifts( seq, A ) );
    
    for j in [ 1 .. Length( possible_shifts ) ] do
      
      shift_A := ApplyShift( A, possible_shifts[j] );
      
      for i in [ 1 .. nr_objects ] do
        
        if not IsZeroForObjects( HomomorphismStructureOnObjects( ambient_cat, UnderlyingCell( seq[i] ), shift_A ) ) then
            return possible_shifts[j];
        fi;
        
      od;
      
    od;
    
    return -infinity;
    
end );

#
#          -> R_i
#  q^i-1  /      \ r^i
#        /        \
#   X_im1          -> X_i
#
#   i -> [ q_im1, r^i ]
#

##
InstallOtherMethod( DataOfExceptionalReplacement,
         [ IsCapFullSubcategory, IsHomotopyCategoryObject, IsObject ],
  
  function( seq, A, max_shift )
    local ambient_cat, data;
    
    ambient_cat := AmbientCategory( seq );
    
    data :=
      AsZFunction(
        function( i )
          local r_i, q_im1, X_i, dec;
          
          if i > max_shift then
            
            r_i := UniversalMorphismFromZeroObject( ambient_cat, ApplyShift( A, i ) );
            
            q_im1 := UniversalMorphismIntoZeroObject( ambient_cat, ApplyShift( A, i-1 ) );
            
            return [ q_im1, r_i, [] ];
            
          else
            
            X_i := Source( data[i+1][1] );
            
            dec := Concatenation( DataOfExceptionalCover( seq, X_i ) );
            
            r_i := UniversalMorphismFromDirectSum( AmbientCategory( seq ), X_i, dec );
            
            q_im1 := MorphismFromStandardCoConeObject( r_i );
            
            return [ q_im1, r_i, dec ];
            
          fi;
          
        end );
        
    return data;
    
end );

##
InstallMethod( DataOfExceptionalReplacement,
         [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  { seq, A } -> DataOfExceptionalReplacement( seq, A, MaximalExceptionalShift( seq, A ) )
);

##
InstallMethodWithCache( ExceptionalReplacement,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject, IsBool ],
  
  function ( seq, A, bool )
    local ambient_cat, homotopy_cat, max_shift, data, objs, diffs, GA, zero_object, i;
    
    ambient_cat := AmbientCategory( seq );
    
    homotopy_cat := HomotopyCategoryByCochains( ambient_cat );
    
    if bool = false then
      
      max_shift := MaximalExceptionalShift( seq, A );
      
      data := DataOfExceptionalReplacement( seq, A, max_shift );
      
      objs := ApplyMap( data, pair -> Source( pair[2] ) ); # i.e., i -> Source( data[i][2] )
      
      diffs := AsZFunction( i -> PreCompose( ambient_cat, data[i][2], data[i+1][1] ) );
      
      return CreateComplex( homotopy_cat, [ objs, diffs, -infinity, max_shift ] );
      
    else
      
      GA := ExceptionalReplacement( seq, A, false );
      
      data := BaseZFunctions( Objects( GA ) )[1];
      
      zero_object := ZeroObject( ambient_cat );
      
      i := UpperBound( GA ) + 1;
      
      repeat i := i-1; until IsEqualForObjects( GA[i], zero_object ) and MaximalExceptionalShift( seq, Range( data[i][2] ) ) = -infinity;
      
      return CreateComplex( homotopy_cat, [ Objects( GA ), Differentials( GA ), i+1, UpperBound( GA ) ] );
      
    fi;
    
end );

##
InstallMethod( InterpretExceptionalReplacementAsObjectInHomotopyCategoryOfAdditiveClosure,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function( seq, GA )
    local additive_closure, homotopy_category, data, objs, diffs;
    
    additive_closure := AdditiveClosure( seq );
    
    homotopy_category := HomotopyCategoryByCochains( additive_closure );
    
    data := BaseZFunctions( Objects( GA ) )[1];
    
    objs := ApplyMap( data, triple -> AdditiveClosureObject( additive_closure, List( triple[3], m -> AsSubcategoryCell( seq, Source( m ) ) ) ) );
    
    diffs :=
      AsZFunction(
        function( i )
          local S, injs, R, projs, matrix;
          
          S := List( data[i][3], Source );
          injs := List( [ 1 .. Length( S ) ], k -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( S, k, GA[i] ) );
          
          R := List( data[i+1][3], Source );
          projs := List( [ 1 .. Length( R ) ], k -> ProjectionInFactorOfDirectSumWithGivenDirectSum( R, k, GA[i+1] ) );
          
          matrix := List( injs, iota -> List( projs, pi -> AsSubcategoryCell( seq, PreComposeList( AmbientCategory( seq ), [ iota, GA^i, pi ] ) ) ) );
          
          return AdditiveClosureMorphism( objs[i], matrix, objs[i+1] );
          
        end );
        
    return CreateComplex( homotopy_category, [ objs, diffs, LowerBound( GA ), UpperBound( GA ) ] );
    
end );

##
InstallMethod( RemainderOfObjectRelativeToStrongExceptionalSequence,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function( seq, A )
    local GA;
    
    GA := ExceptionalReplacement( seq, A, true );
    
    return Source( BaseZFunctions( Objects( GA ) )[1][LowerBound( GA )][1] );
    
end );

##
InstallMethod( TriangulatedSubcategory,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local name, ambient_cat, has_zero_remainder;
    
    name := Concatenation( "TriangulatedSubcategory( ", Name( seq ), " )" );
    
    ambient_cat := AmbientCategory( seq );
    
    has_zero_remainder := { cat, A } -> IsZeroForObjects( ambient_cat, RemainderOfObjectRelativeToStrongExceptionalSequence( seq, UnderlyingCell( A ) ) );
    
    return FullSubcategoryByObjectMembershipFunction( ambient_cat, has_zero_remainder : name_of_full_subcategory := name );
    
end );

##
InstallMethod( IsomorphismFromConvolutionOfExceptionalReplacement,
          [ IsCapFullSubcategory, IsHomotopyCategoryObject ],
  
  function ( seq, A )
    local GA, GA_data, data;
    
    GA := ExceptionalReplacement( seq, A, true );
    
    GA_data := BaseZFunctions( Objects( GA ) )[1];
    
    data :=
      AsZFunction(
        function ( i )
          local X_im1, r_i, shift_std_r_i, j_i, shift_std_j_i;
          
          if i > UpperBound( GA ) then
            
            X_im1 := Range( GA_data[i-1][2] );
            
            return Shift( StandardExactTriangle( UniversalMorphismIntoZeroObject( X_im1 ) ), -i );
            
          else
            
            r_i := GA_data[i][2];
            shift_std_r_i := Shift( StandardExactTriangle( r_i ), -i-1 );
            
            j_i := PostnikovSystemAt( GA, i+1 )^i;
            shift_std_j_i := Shift( StandardExactTriangle( j_i ), -i-1 );
            
            return ExactTriangleByOctahedralAxiom( shift_std_r_i, data[i+1], shift_std_j_i );
            
          fi;
          
        end );
    
    return data[LowerBound( GA )]^1;
    
end );


##
InstallMethod( ConvolutionFunctor,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local ambient_cat, additive_closure, homotopy_cat, I, name, F;
    
    ambient_cat := AmbientCategory( seq );
    
    additive_closure := AdditiveClosure( seq );
    
    homotopy_cat := HomotopyCategoryByCochains( additive_closure );
    
    I := ExtendFunctorToHomotopyCategoriesByCochains( ExtendFunctorToAdditiveClosureOfSource( InclusionFunctor( seq ) ) );
    
    name := "Convolution functor";
    
    F := CapFunctor( name, homotopy_cat, ambient_cat );
    
    AddObjectFunction( F, C -> Convolution( ApplyFunctor( I, C ) ) );
    
    AddMorphismFunction( F, { S, alpha, R } -> Convolution( ApplyFunctor( I, alpha ) ) );
    
    return F;
    
end );

##
InstallMethod( ReplacementFunctor,
          [ IsCapFullSubcategory ],
  
  function ( seq )
    local ambient_cat, additive_closure, homotopy_cat, name, G;
    
    ambient_cat := AmbientCategory( seq );
    
    additive_closure := AdditiveClosure( seq );
    
    homotopy_cat := HomotopyCategoryByCochains( additive_closure );
    
    name := "Replacement functor";
    
    G := CapFunctor( name, ambient_cat, homotopy_cat );
    
    AddObjectFunction( G, A -> InterpretExceptionalReplacementAsObjectInHomotopyCategoryOfAdditiveClosure( seq, ExceptionalReplacement( seq, A, true ) ) );
    
    AddMorphismFunction( G, function( S, alpha, R ) Error( "not yet implemented!\n" ); end );
    
    return G;
    
end );

##
InstallMethod( CounitOfConvolutionReplacementAdjunction,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( seq );
    
    F := ConvolutionFunctor( seq );
    
    G := ReplacementFunctor( seq );
    
    name := Concatenation( "Counit ", TEXTMTRANSLATIONS.epsilon, " : F", TEXTMTRANSLATIONS.circ, "G ", TEXTMTRANSLATIONS.Longrightarrow, " Id of the adjunction F ", TEXTMTRANSLATIONS.dashv, " G" );
    
    nat := NaturalTransformation( name, PreCompose( G, F ), IdentityFunctor( ambient_cat ) );
    
    AddNaturalTransformationFunction( nat,
    
      { FG_A, A, id_A } -> IsomorphismFromConvolutionOfExceptionalReplacement( seq, A )
    );
    
    return nat;
    
end );

##
InstallMethod( UnitOfConvolutionReplacementAdjunction,
          [ IsCapFullSubcategory ],
  
  function( seq )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( seq );
    
    F := ConvolutionFunctor( seq );
    
    G := ReplacementFunctor( seq );
    
    name := Concatenation( "Unit ", TEXTMTRANSLATIONS.eta, " : Id ", TEXTMTRANSLATIONS.Longrightarrow, " G", TEXTMTRANSLATIONS.circ, "F of the adjunction F ", TEXTMTRANSLATIONS.dashv, " G" );
    
    nat := NaturalTransformation( name, IdentityFunctor( SourceOfFunctor( F ) ), PreCompose( F, G ) );
    
    AddNaturalTransformationFunction( nat,
      
      function( GF_C, C, id_C ) Error( "not yet implemented!\n" ); end
    );
    
    return nat;
    
end );
