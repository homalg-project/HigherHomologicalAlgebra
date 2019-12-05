The ComplexesForCAP package
=========================

version 02/12/2019.

Introduction
------------
The "ComplexesForCAP" package is a Gap/CAP package written for constructing chain or cochain complexes category of a given CAP category. Its aim is to carry out categorical and homological constructions and computation in the complexes categories such as homology, cohomology, mapping cones, mapping cylinders, resolutions, etc.


Installation
-----------
The package can easily be obtained by cloning the repository
https://github.com/homalg-project/ComplexesForCAP.git
in the pkg directory of the Gap installation.

Required packages
-----------------

* This package is written to handle categories that are already implemented in CAP, so you will need a fresh version of CAP. You may install it from
  https://github.com/homalg-project/CAP_project
  
* The infinite lists package "InfiniteLists". You can install it from 
  https://github.com/oysteins/InfiniteLists.git

* You will also need "AutoDoc" package to be able to create the documentation and to perform tests. A fresh version can be installed from
https://github.com/gap-packages/AutoDoc

Remarks
-------
* To create the documentation go in your terminal to where you installed the package and 
 perform the command
   ```sh
   bla-bla/ComplexesForCAP$ gap makedoc.g
   ```
* To be able to run all the examples in the package, you may need to download the homalg_project
  https://github.com/homalg-project/homalg_project.git
* For the installation of Gap see https://www.gap-system.org/

  Of course you are welcome to e-mail me if there are any questions, remarks, suggestions ;)
  
  Kamal Saleh e-mail: saleh@mathematik.uni-siegen.de
