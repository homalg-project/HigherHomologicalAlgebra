LoadPackage( "RingsForHomalg" );
LoadPackage( "ModulePresentations" );
LoadPackage( "ComplexesForCAP" );
ReadPackage( "ComplexesForCAP", "examples/temp_dir/random_methods_for_module_presentations.g" );

R := HomalgFieldOfRationalsInSingular()*"x,y,z,t";

cat := LeftPresentations( R : FinalizeCategory := false );
ADD_RANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "left" );

# constructing the chain complex category of left presentations over R
chains := ChainComplexCategory( cat );

# constructing the cochain complex category of left presentations over R
cochains := CochainComplexCategory( cat );


#################################

# \begin{tikzcd}
# 0 \arrow[rd, "0", dashed] & 
# R/\langle xy \rangle \arrow[l] \arrow[d, "(zt)"'] \arrow[rd, "(z)", dashed] &
# R/\langle x \rangle \arrow[l, "(y)"'] \arrow[d, "(yz)"] \arrow[rd, "0", dashed] & 0 \arrow[l] \\
# 0 & R/\langle xyt \rangle \arrow[l] & R/\langle xy \rangle \arrow[l, "(t)"] & 0 \arrow[l]
# \end{tikzcd}

A4 := AsLeftPresentation( HomalgMatrix( "[ [ x ] ]",1,1,R) );
A3 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1,R) );
B4 := AsLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1,R) );
B3 := AsLeftPresentation( HomalgMatrix( "[ [ xyt ] ]",1,1,R) );
a43 := PresentationMorphism( A4, HomalgMatrix( "[ [ y ] ]",1,1, R ), A3 );
b43 := PresentationMorphism( B4, HomalgMatrix( "[ [ t ] ]",1,1, R ), B3 );
CA := ChainComplex( [ a43 ], 4 );
CB := ChainComplex( [ b43 ], 4 );
phi3 := PresentationMorphism( A3, HomalgMatrix( "[ [ zt ] ]",1,1, R ), B3 );
phi4 := PresentationMorphism( A4, HomalgMatrix( "[ [ yz ] ]",1,1, R ), B4 );
phi := ChainMorphism( CA, CB, [ phi3, phi4 ], 3 );
IsZeroForMorphisms( phi );
IsNullHomotopic( phi );
# true
h := HomotopyMorphisms( phi );
Display( h[ 3 ] );

