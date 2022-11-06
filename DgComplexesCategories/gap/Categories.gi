# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

##
InstallMethod( DgCochainComplexCategory,
               [ IsCapCategory ],

  function ( cat )
    local name, dgCh_cat;
    
    name := Concatenation( "DgCochainComplexCategory( ", Name( cat ), " )" );
    
    dgCh_cat := CreateCapCategory( name );
    
    SetUnderlyingCategory( dgCh_cat, cat );
    
    dgCh_cat!.category_as_first_argument := true;
    
    SetFilterObj( dgCh_cat, IsDgCochainComplexCategory );
    
    AddObjectRepresentation( dgCh_cat, IsDgCochainComplex );
    
    AddMorphismRepresentation( dgCh_cat, IsDgCochainComplexMorphism );
    
    ADD_BASIC_FUNCTIONS_TO_DG_COCHAIN_COMPLEX_CATEGORY( dgCh_cat );
    
    ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_DG_COCHAIN_COMPLEX_CATEGORY( dgCh_cat );
    
    dgCh_cat!.compiler_hints :=
      rec( category_filter := IsDgCochainComplexCategory,
           object_filter := IsDgCochainComplex,
           morphism_filter := IsDgCochainComplexMorphism );
    
    Finalize( dgCh_cat );
    
    return dgCh_cat;
    
end );

##
InstallGlobalFunction( ADD_BASIC_FUNCTIONS_TO_DG_COCHAIN_COMPLEX_CATEGORY,
  function ( dgCh_cat )
    
    AddIsEqualForObjects( dgCh_cat,
      function( dgCh_cat, S, R )
      
        return ForAll(
                [ Minimum( LowerBoundOfDgComplex( S ), LowerBoundOfDgComplex( R ) ) .. Maximum( UpperBoundOfDgComplex( S ), UpperBoundOfDgComplex( R ) ) ],
                i -> IsEqualForMorphismsOnMor( UnderlyingCategory( dgCh_cat ), S^i, R^i )
        );
        
    end );
    
    AddIsEqualForMorphisms( dgCh_cat,
      function( dgCh_cat, phi, psi )
      
        return DegreeOfDgComplexMorphism( phi ) = DegreeOfDgComplexMorphism( psi )
                    and ForAll(
                            [ Minimum( LowerBoundOfDgComplexMorphism( phi ), LowerBoundOfDgComplexMorphism( psi ) ) .. Maximum( UpperBoundOfDgComplexMorphism( phi ), UpperBoundOfDgComplexMorphism( psi ) ) ],
                            i -> IsEqualForMorphisms( UnderlyingCategory( dgCh_cat ), phi[i], psi[i] )
                        );
        
    end );
    
    AddIsCongruentForMorphisms( dgCh_cat,
      function( dgCh_cat, phi, psi )
      
        return DegreeOfDgComplexMorphism( phi ) = DegreeOfDgComplexMorphism( psi )
                    and ForAll(
                            [ Minimum( LowerBoundOfDgComplexMorphism( phi ), LowerBoundOfDgComplexMorphism( psi ) ) .. Maximum( UpperBoundOfDgComplexMorphism( phi ), UpperBoundOfDgComplexMorphism( psi ) ) ],
                            i -> IsCongruentForMorphisms( UnderlyingCategory( dgCh_cat ), phi[i], psi[i] )
                        );
        
    end );
    
    AddIsWellDefinedForObjects( dgCh_cat,
      function ( dgCh_cat, C )
        
        return ForAll( [ LowerBoundOfDgComplex( C ) .. UpperBoundOfDgComplex( C ) ],
                        i -> IsWellDefinedForMorphisms( UnderlyingCategory( dgCh_cat ), C^i )
                                and IsZeroForMorphisms( UnderlyingCategory( dgCh_cat ), PreCompose( UnderlyingCategory( dgCh_cat ), C^i, C^(i+1) ) )
                    );
    end );
    
    AddIsWellDefinedForMorphisms( dgCh_cat,
      function ( dgCh_cat, phi )
        
        return ForAll( [ Minimum( LowerBoundOfDgComplex( Source( phi ) ), LowerBoundOfDgComplex( Range( phi ) ) ) .. Maximum( UpperBoundOfDgComplex( Source( phi ) ), UpperBoundOfDgComplex( Range( phi ) ) ) ],
                        i -> IsWellDefinedForMorphisms( UnderlyingCategory( dgCh_cat ), phi[i] )
                                and IsEqualForObjects( UnderlyingCategory( dgCh_cat ), Source( phi[i] ), Source( phi )[i] )
                                    and IsEqualForObjects( UnderlyingCategory( dgCh_cat ), Range( phi[i] ), Range( phi )[i + DegreeOfDgComplexMorphism( phi )] )
                    );
    end );
    
    AddIdentityMorphism( dgCh_cat,
      function ( dgCh_cat, C )
        
        return DgCochainComplexMorphism( dgCh_cat, C, C, [ 0, AsZFunction( i -> IdentityMorphism( UnderlyingCategory( dgCh_cat ), C[i] ) ) ] );
    
    end );
    
    AddPreCompose( dgCh_cat,
      function ( dgCh_cat, phi, psi )
        
        return DgCochainComplexMorphism(
                    dgCh_cat,
                    Source( phi ),
                    Range( psi ),
                    Pair( DegreeOfDgComplexMorphism( phi ) + DegreeOfDgComplexMorphism( psi ),
                            AsZFunction( i -> PreCompose( UnderlyingCategory( dgCh_cat ), phi[i], psi[i+DegreeOfDgComplexMorphism( phi )] ) ) )
                );
    
    end );
    
end );
