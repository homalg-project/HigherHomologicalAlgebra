The HomotopyCategories package
=========================

version 23/02/2020.

Introduction
------------
The "HomotopyCategories" package is a Gap/CAP package written for constructing homotopy categories of additive categories, i.e., the category of complexes modulo null-homotopic morphisms. Its aim is to carry out categorical and homological constructions and computations. Homotopy categories are in many cases a nice model for derived categroies. For example, when the category has enough injectives or enough projectives. This package has been written as step toward implementing derived
categories and Tilting equivalences between them. More details can be found at
https://github.com/homalg-project/DerivedCategories.git

Installation
-----------
The package can easily be obtained by cloning the repository
https://github.com/homalg-project/HomotopyCategories.git
in the pkg directory of the Gap installation.

Required packages
-----------------

* This package is written to handle categories that are already implemented in CAP, so you will need a fresh version of CAP. You may install it from
  https://github.com/homalg-project/CAP_project
  
* The complexes categories package "ComplexesForCAP". You can install it from 
  https://github.com/homalg-project/ComplexesForCAP.git

* The stable categories package "StableCategories". You can install it from 
  https://github.com/homalg-project/StableCategories.git

* You will also need "AutoDoc" package to be able to create the documentation and to perform tests.
  A fresh version can be installed from https://github.com/gap-packages/AutoDoc

Remarks
-------
* To be able to run all the examples in the package, you may need to download the homalg_project
  https://github.com/homalg-project/homalg_project.git
* For the installation of Gap see https://www.gap-system.org/

  Of course you are welcome to e-mail me if there are any questions, remarks, suggestions ;)
 
  Kamal Saleh e-mail: saleh@mathematik.uni-siegen.de

License
-------
"HomotopyCategories" package is a free software; you can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
