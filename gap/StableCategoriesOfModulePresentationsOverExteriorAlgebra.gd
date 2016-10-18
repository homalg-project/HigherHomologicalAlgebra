############################################################################
#                                     GAP package
#
#  Copyright 2015,       Kamal Saleh  RWTH Aachen University
#
#! @Chapter StableCategoriesOfModulePresentationsOverExteriorAlgebra.gd
##
#############################################################################


#! @Section Stable categories of presentations category over exterior algebra 


#! @Description
#! given a an exterior algebra <A>R</A>, this constructor returns
#! the stable category of left presentations category over <A>R</A> 
#! @Arguments R
#! @Returns a category
DeclareAttribute( "StableCategoryOfLeftPresentationsOverExteriorAlgebra", IsHomalgRing );

#! @Description
#! given a homalg matrix <A>H</A> over the exterior algebra , this constructor returns
#! the left presentation in the stable module category defined by <A>H</A>.  
#! @Arguments H
#! @Returns an object
DeclareOperation( "AsLeftPresentationInStableCategory", [ IsHomalgMatrix ] );

#! @Description
#! given two objects <A>M,N</A> in the stable category and a homalg matrix <A>H</A> over the 
#! exterior algebra , this constructor returns the corresponding morphism presentation in the stable 
#! module category defined by <A>H</A>.  
#! @Arguments M, H, N
#! @Returns a morphism
DeclareOperation( "PresentationMorphismInStableCategory", [ IsStableCategoryObject, IsHomalgMatrix, IsStableCategoryObject ] );
