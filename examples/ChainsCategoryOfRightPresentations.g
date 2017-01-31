LoadPackage( "ModulePresentationsForCap" );;
LoadPackage( "complex" );;

#! @Chunk complexes_example_2
#! @BeginLatexOnly
#! bla latex code here.
#! @EndLatexOnly
#! @Example
S := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );;
right_pre_category := RightPresentations( S );;
m := HomalgMatrix( "[ [ e0, e1, e2 ],[ 0, 0, e0 ] ]", 2, 3, S );;
M := AsRightPresentation( m );;
F := FreeRightPresentation( 2, S );;
f_matrix := HomalgMatrix( "[ [ e1, 0 ], [ 0, 1 ] ]",2, 2, S );;
f := PresentationMorphism( F, f_matrix, M );;
g := KernelEmbedding( f );;
K := Source( g );;
h := ZeroMorphism( M, K );;
l := RepeatListZ( [ h, f, g ] );;
C := ChainComplex( right_pre_category, l );;
# Display( C, 0, 1 );
C[ 2 ];;
C^2;;
#! @EndExample
#! @EndChunk

