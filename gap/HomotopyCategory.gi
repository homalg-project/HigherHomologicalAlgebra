

##
InstallMethod( HomotopyCategory,
      [ IsCapCategory ],
  function( cat )
    local chains, name, to_be_finalized, homotopy_category, special_filters;
    
    if not IsPackageMarkedForLoading( "ComplexesForCAP", ">=2019.04.01" ) then
      
      Error( "The package ComplexesForCAP is required to run this method" );
      
    fi;
    
    chains := ValueGlobal( "ChainComplexCategory" )( cat : FinalizeCategory := false );
    
    AddMorphismIntoColiftingObject( chains,
      function( a )
        return ValueGlobal( "NaturalInjectionInMappingCone" )( IdentityMorphism( a ) );
    end );
    
    Finalize( chains );
    
    if not CanCompute( chains, "Colift" ) then
      
      Error( "Colifts should be computable in ", Name( chains ) );
      
    fi;
    
    name := Concatenation( "Homotopy category of ", Name( cat ) );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    special_filters := ValueOption( "SpecialFilters" );
    
    if special_filters = fail then
      
      special_filters := [ IsHomotopyCategory, IsHomotopyCategoryObject, IsHomotopyCategoryMorphism ];
      
    fi;
    
    homotopy_category := StableCategoryByColiftingStructure( chains: NameOfCategory := name,
                                                                     FinalizeCategory := to_be_finalized,
                                                                     SpecialFilters := special_filters );
    
    return homotopy_category;
 
end );

##
InstallMethod( HomotopyCategoryObject,
            [ IsHomotopyCategory, IsCapCategoryObject ],
            
  function( homotopy_category, a )
    local homotopy_a;
    
    if not IsIdenticalObj( UnderlyingCapCategory( homotopy_category ), CapCategory( a ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_a := StableCategoryObject( homotopy_category, a );
    
    SetFilterObj( homotopy_a, IsHomotopyCategoryObject );
    
    return homotopy_a;
    
end );

##
InstallMethod( HomotopyCategoryMorphism,
            [ IsHomotopyCategory, IsCapCategoryMorphism ],
            
  function( homotopy_category, phi )
    local homotopy_phi;
    
    if not IsIdenticalObj( UnderlyingCapCategory( homotopy_category ), CapCategory( phi ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_phi := StableCategoryMorphism( homotopy_category, phi );
    
    SetFilterObj( homotopy_phi, IsHomotopyCategoryMorphism );
    
    return homotopy_phi;
  
end );
 
#
