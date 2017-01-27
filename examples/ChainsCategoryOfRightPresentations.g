LoadPackage( "ModulePresentationsForCap" );;
LoadPackage( "complex" );;

#! @Chunk example1
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
Display( C, 0, 3 );
#!
#! -----------------------------------------------------------------
#! In index 0
#!
#! Object is
#! e0,e1,e2,
#! 0, 0, e0 
#!
#! An object in Category of right presentations of Q{e0,e1,e2}
#!
#! Differential is
#! 0,0,
#! 0,0,
#! 0,0 
#!
#! A zero morphism in Category of right presentations of Q{e0,e1,e2}
#!
#! -----------------------------------------------------------------
#! In index 1
#!
#! Object is
#! (an empty 2 x 0 matrix)
#! 
#! An object in Category of right presentations of Q{e0,e1,e2}
#! 
#! Differential is
#! e1,0,
#! 0, 1 
#! 
#! A morphism in Category of right presentations of Q{e0,e1,e2}
#! 
#! -----------------------------------------------------------------
#! In index 2
#! 
#! Object is
#! 0, 0, 0, 0, 0,
#! e2,e1,0, e0,0,
#! 0, e2,e1,0, e0
#! 
#! An object in Category of right presentations of Q{e0,e1,e2}
#! 
#! Differential is
#! 1,0,     0,    
#! 0,-e0*e2,-e0*e1
#! 
#! A monomorphism in Category of right presentations of Q{e0,e1,e2}
#! 
#! -----------------------------------------------------------------
#! In index 3
#! 
#! Object is
#! e0,e1,e2,
#! 0, 0, e0 
#! 
#! An object in Category of right presentations of Q{e0,e1,e2}
#! 
#! Differential is
#! 0,0,
#! 0,0,
#! 0,0 
#! 
#! A zero morphism in Category of right presentations of Q{e0,e1,e2}
C[ 2 ];;
C^2;;
#! @EndExample
#! @EndChunk

