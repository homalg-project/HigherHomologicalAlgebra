# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Declarations
#

DeclareOperation( "LaTeXStringOp", [ IsVectorSpaceObject ] );
DeclareOperation( "LaTeXStringOp", [ IsVectorSpaceMorphism ] );

if false then

  #? @Description
  #? The arguments are a category <A>C</A> and an integer <A>n</A>. The output is a vector space of dimension at most <A>n</A>
  #? if <A>n</A> is non-negative and <C>fail</C> otherwise.
  #? @Returns a vector space
  #? @Arguments C, n
  DeclareOperation( RandomObjectByInteger, [ IsCapMatrixCategory, IsInt ] );
  
  #? @Description
  #? The arguments are a category <A>C</A> and a nonempty list <A>L</A> of integers. The output is a vector space whose
  #? dimension is a random element in <A>L</A>. Hence the output may be <C>fail</C> if <A>L</A> contains negative integers.
  #? @Returns a vector space
  #? @Arguments C, L
  DeclareOperation( RandomObjectByList, [ IsCapMatrixCategory, IsList ] );

  #? @Description
  #? The arguments are a vector space object <A>a</A> and an integer <A>n</A>.
  #? The output is a vector space morphism from <A>a</A> into a vector space <A>b</A> with dimension <A>n</A> 
  #? if <A>n</A> is non-negative and <C>fail</C> otherwise.
  #? @Returns a vector space morphism
  #? @Arguments a, n
  DeclareOperation( RandomMorphismWithFixedSourceByInteger, [ IsVectorSpaceObject, IsInt ] );
  
  #? @Description
  #? The arguments are a vector space <A>a</A> and a list <A>L</A> of length $2$. The first entry in $L$ should be an integer and
  #? the second entry is a non-empty list of elements in the underlying homalg field.
  #? The output is <C>fail</C> if <A>L[1]</A> is negative integer or a vector space morphism from <A>a</A> into a vector space <A>b</A> whose dimension
  #? is <A>L[1]</A> and whose matrix entries are linear combinations of elements in <A>L[2]</A>. 
  #? @Returns a vector space morphism
  #? @Arguments a, L
  DeclareOperation( RandomMorphismWithFixedSourceByList, [ IsVectorSpaceObject, IsList ] );
  
  #? @Description
  #? The arguments are a vector space object <A>b</A> and an integer <A>n</A>.
  #? The output is a vector space morphism into <A>b</A> from a vector space <A>a</A> with dimension <A>n</A>
  #? if <A>n</A> is non-negative and <C>fail</C> otherwise.
  #? @Returns a vector space morphism
  #? @Arguments b, n
  DeclareOperation( RandomMorphismWithFixedRangeByInteger, [ IsVectorSpaceObject, IsInt ] );
  
  #? @Description
  #? The arguments are a vector space <A>b</A> and a list <A>L</A> of length $2$. The first entry in $L$ should be an integer and
  #? the second entry is a non-empty list of elemets in the underlying homalg field.
  #? The output is <C>fail</C> if <A>L[1]</A> is a negative integer, and otherwise a vector space morphism into <A>b</A> from a 
  #? vector space <A>a</A> whose dimension is <A>L[1]</A> and whose matrix entries are linear combinations of elements in <A>L[2]</A>. 
  #? @Returns a vector space morphism
  #? @Arguments b, L
  DeclareOperation( RandomMorphismWithFixedRangeByList, [ IsVectorSpaceObject, IsList ] );
  
  #? @Description
  #? The arguments are two vector spaces <A>a, b</A> and an integer <A>n</A>.
  #? The output is a vector space morphism from <A>a</A> to <A>b</A> whose matrix entries are linear combinations of elements
  #? in  $[|n|..|n|]*1_F$, where $F$ is the underlying homalg field.
  #? @Returns a vector space morphism
  #? @Arguments a, b, n
  DeclareOperation( RandomMorphismWithFixedSourceAndRangeByInteger, [ IsVectorSpaceObject, IsVectorSpaceObject, IsInt ] );
  
  #? @Description
  #? The arguments are vector spaces <A>a, b</A> and a non-empty list <A>L</A> of elements in the underlying homalg field.
  #? The output is a vector space morphism from <A>a</A> to <A>b</A> whose matrix entries are linear combinations of elements in <A>L</A>.
  #? @Returns a vector space morphism
  #? @Arguments a, b, L
  DeclareOperation( RandomMorphismWithFixedSourceAndRangeByList, [ IsVectorSpaceObject, IsVectorSpaceObject, IsList ] );
  
  #? @Description
  #? The arguments are a Cap matrix category <A>C</A> and a list <A>L</A> of length $3$.
  #? The first two entries in <A>L</A> are two non-negative integers and the third entry is a non-empty list of elements in the 
  #? underlying homalg field. The output is a random morphism whose source has dimension <A>L[1]</A> and range has dimension
  #? <A>L[2]</A> and whose matrix entries are linear combinations of elements in <A>L[3]</A>.
  #? @Returns a vector space morphism
  #? @Arguments C, L
  DeclareOperation( RandomMorphismByList, [ IsCapMatrixCategory, IsList ] );

fi;

