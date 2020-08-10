
# The following two functions tells whether the lift or colift is unique


## PreCompose( alpha , Colift( alpha, beta ) ) = beta

if not IsBound( ColiftUniquenessInfos ) then
  
  DeclareOperation( "ColiftUniquenessInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
  
  ##
  InstallMethod( ColiftUniquenessInfos,
            [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
    function( alpha, beta )
      local category, range, D, h, K, hom_D_K;
    
      category := CapCategory( alpha );
      
      if not HasRangeCategoryOfHomomorphismStructure( category ) then
        
        Error( "The category should have homomorphism structure" );
        
      fi;
      
      range := RangeCategoryOfHomomorphismStructure( category );
      
      if not HasRangeCategoryOfHomomorphismStructure( range ) then
        
        Error( "The range category should also have homomorphism structure" );
      
      fi;
      
      D := DistinguishedObjectOfHomomorphismStructure( category );
      
      h := HomomorphismStructureOnMorphisms( alpha, IdentityMorphism( Range( beta ) ) );
      
      K := KernelObject( h );
      
      hom_D_K := HomomorphismStructureOnObjects( D, K );
      
      if IsZero( hom_D_K ) then
        
        Print( "If there is a colift, it is unique\n" );
        
      else
        
        Print( "If there is a colift, it is not unique\n" );
        Print( "Since the kernel object is: " );
        Display( K );
 
      fi;

  end );

fi;


## PreCompose( Lift( alpha, beta ), beta ) = alpha


if not IsBound( LiftUniquenessInfos ) then

  DeclareOperation( "LiftUniquenessInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

  ##
  InstallMethod( LiftUniquenessInfos,
            [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
    function( beta, alpha )
      local category, range, D, h, K, hom_D_K;
    
      category := CapCategory( alpha );
      
      if not HasRangeCategoryOfHomomorphismStructure( category ) then
        
        Error( "" );
        
      fi;
      
      range := RangeCategoryOfHomomorphismStructure( category );
      
      if not HasRangeCategoryOfHomomorphismStructure( range ) then
        
        Error( "" );
      
      fi;
      
      D := DistinguishedObjectOfHomomorphismStructure( category );
      
      h := HomomorphismStructureOnMorphisms( IdentityMorphism( Source( beta ) ), alpha );
      
      K := KernelObject( h );
      
      hom_D_K := HomomorphismStructureOnObjects( D, K );
      
      if IsZero( hom_D_K ) then
        
        Print( "If there is a lift, it is unique\n" );
        
      else
        
        Print( "If there is a lift, it is not unique\n" );
        Print( "Since the kernel object is: " );
        Display( K );
        
      fi;

  end );
  
fi;

if not IsBound( LiftColiftUniquenessInfos ) then

  DeclareOperation( "LiftColiftUniquenessInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

  ##
  InstallMethod( LiftColiftUniquenessInfos,
            [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
    function( alpha, beta, gamma, delta )
      local category, range, D, h1, h2, h, K, hom_D_K;
    
      category := CapCategory( alpha );
      
      if not HasRangeCategoryOfHomomorphismStructure( category ) then
        
        Error( "" );
        
      fi;
      
      range := RangeCategoryOfHomomorphismStructure( category );
      
      if not HasRangeCategoryOfHomomorphismStructure( range ) then
        
        Error( "" );
      
      fi;
      
      D := DistinguishedObjectOfHomomorphismStructure( category );
      
      
      h1 := HomomorphismStructureOnMorphisms( IdentityMorphism( Source( alpha ) ), beta );
      
      h2 := HomomorphismStructureOnMorphisms( gamma, IdentityMorphism( Range( delta ) ) );
      
      h := MorphismBetweenDirectSums( [ [ h1, h2 ] ] );
      
      K := KernelObject( h );
      
      hom_D_K := HomomorphismStructureOnObjects( D, K );
      
      if IsZero( hom_D_K ) then
        
        Print( "If there is a lift_colift, it is unique\n" );
        
      else
        
        Print( "If there is a lift_colift, it is not unique\n" );
        Print( "Since the kernel object is: " );
        Display( K );
        
      fi;

  end );
  
fi;

