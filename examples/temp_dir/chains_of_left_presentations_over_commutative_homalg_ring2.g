LoadPackage( "RingsForHomalg" );
LoadPackage( "ModulePresentations" );
LoadPackage( "ComplexesForCAP" );
ReadPackage( "ComplexesForCAP", "examples/temp_dir/random_methods_for_module_presentations.g" );

R := HomalgFieldOfRationalsInSingular()*"x,y,z,t";

cat := LeftPresentations( R : FinalizeCategory := false );
ADD_RRANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "left" );

# constructing the chain complex category of left presentations over R
chains := ChainComplexCategory( cat );

# constructing the cochain complex category of left presentations over R
cochains := CochainComplexCategory( cat );

M := AsLeftPresentation( HomalgMatrix( "x,y,z,t", 4, 1, R ) );

N := AsLeftPresentation( HomalgMatrix( "x-y,y+t,z+x,t^2", 4, 1, R ) );

while true do
  
  phi := RandomMorphismWithFixedSourceAndRange( M, N, 4 );
  
  if not IsZero( phi ) then
    
    break;
    
  fi;
  
od;


