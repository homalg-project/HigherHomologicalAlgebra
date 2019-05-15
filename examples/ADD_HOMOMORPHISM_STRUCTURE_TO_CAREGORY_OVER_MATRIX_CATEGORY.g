LoadPackage( "LinearAlgebraForCAP" );

DeclareOperation( "BasisOfExternalHom", [ IsCapCategoryObject, IsCapCategoryObject ] );
DeclareAttribute( "FieldForHomomorphismStructure", IsCapCategory );
DeclareAttribute( "CoefficientsOfLinearMorphism", IsCapCategoryMorphism );
DeclareOperation( "MultiplyWithElementInFieldForHomomorphismStructure", [ IsMultiplicativeElement, IsCapCategoryMorphism ] );

##
AddHomomorphismStructureOnCategory :=
  function( cat )
    local field;
    
    field := FieldForHomomorphismStructure( cat );

    SetRangeCategoryOfHomomorphismStructure( cat, MatrixCategory( field ) );

    AddDistinguishedObjectOfHomomorphismStructure( cat,
       function( )
         
         return VectorSpaceObject( 1, field );
    
    end );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
      function( a, b )
        local dimension;
        
        dimension := Length( BasisOfExternalHom( a, b ) );
        
        return VectorSpaceObject( dimension, field );
    
    end );
    
    #          alpha
    #      a --------> a'     s = H(a',b) ---??--> r = H(a,b')
    #      |           |
    # alpha.h.beta     h
    #      |           |
    #      v           v
    #      b' <------- b
    #          beta
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
      function( s, alpha, beta, r )
        local B, mat;
        
        B := BasisOfExternalHom( Range( alpha ), Source( beta ) );
        
        B := List( B, b -> PreCompose( [ alpha, b, beta ] ) );
        
        B := List( B, CoefficientsOfLinearMorphism );
        
        # Improve this
        if Dimension( s ) * Dimension( r ) = 0 then
          
          mat := HomalgZeroMatrix( Dimension( s ), Dimension( r ), field );
        
        else
          
          mat := HomalgMatrix( B, Dimension( s ), Dimension( r ), field );
        
        fi;
        
        return VectorSpaceMorphism( s, mat, r );
    
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
      function( )
        
        return VectorSpaceObject( 1, field );
    
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( cat,
      function( alpha )
        local coeff, D;
        
        coeff := CoefficientsOfLinearMorphism( alpha );
        
        coeff := HomalgMatrix( coeff, 1, Length( coeff ), field );
        
        D := VectorSpaceObject( 1, field );
        
        return VectorSpaceMorphism( D, coeff, VectorSpaceObject( NrCols( coeff ), field ) );
    
    end );
    
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( cat,
      function( a, b, iota )
        local mat, coeff, B, L;
        
        mat := UnderlyingMatrix( iota );
        
        coeff := EntriesOfHomalgMatrix( mat );
        
        B := BasisOfExternalHom( a, b );
        
        L := List( [ 1 .. Length( coeff ) ], i -> MultiplyWithElementInFieldForHomomorphismStructure( coeff[ i ], B[ i ] ) );
        
        if L = [  ] then
          
          return ZeroMorphism( a, b );
        
        else
          
          return Sum( L );
        
        fi;
    
    end );

end;

######

InstallMethod( BasisOfExternalHom,
    [ IsVectorSpaceObject, IsVectorSpaceObject ],
  function( a, b )
    local cat, hom_ab, D, B;
    
    cat := CapCategory( a );
    
    hom_ab := HomomorphismStructureOnObjects( a, b );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    B := List( [ 1 .. Dimension( hom_ab ) ],
          i -> List( [ 1 .. Dimension( hom_ab ) ],
            function( j )
                                                
              if i = j then
                                                  
                return 1;
                                                  
              else
                                                  
                return 0;
                                                
              fi;
                                              
            end ) );
    
    B := List( B, mat -> VectorSpaceMorphism( D, mat, hom_ab ) );
    
    return List( B, mor -> InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( a, b, mor ) );
    
end );

InstallMethod( FieldForHomomorphismStructure, [ IsCapMatrixCategory ], CommutativeRingOfLinearCategory );

InstallMethod( CoefficientsOfLinearMorphism,
    [ IsVectorSpaceMorphism ],
  function( phi )
    
    return EntriesOfHomalgMatrix( UnderlyingMatrix( InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( phi ) ) );
    
end );

InstallMethod( MultiplyWithElementInFieldForHomomorphismStructure, 
  [ IsMultiplicativeElement, IsVectorSpaceMorphism ], MultiplyWithElementOfCommutativeRingForMorphisms );


