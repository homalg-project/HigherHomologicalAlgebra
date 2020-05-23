#
# HomotopyCategories: Package to create homotopy categories of an additive category
#
# Reading the declaration part of the package.
#

ReadPackage( "HomotopyCategories", "gap/HomotopyCategories.gd");
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryObjects.gd");
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryMorphisms.gd");
ReadPackage( "HomotopyCategories", "gap/Functors.gd" );
ReadPackage( "HomotopyCategories", "gap/Convolution.gd" );
ReadPackage( "HomotopyCategories", "gap/ImportedMethods.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "HomotopyCategories", "gap/Julia.gd" );
fi;
