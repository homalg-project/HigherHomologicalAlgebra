# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "DerivedCategories",
Subtitle := "Derived categories of Abelian categories",
Version := "2022.09-02",
Date := "21/09/2022",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen University",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/DerivedCategories",
PackageInfoURL  := "https://homalg-project.github.io/HigherHomologicalAlgebra/DerivedCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HigherHomologicalAlgebra/DerivedCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/DerivedCategories-", ~.Version, "/DerivedCategories-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "DerivedCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Derived categories of Abelian categories",
),

Dependencies := rec(
  GAP := ">= 4.11.1",
  NeededOtherPackages := [ 
        [ "ToolsForHigherHomologicalAlgebra", ">= 2020.10-02" ],
        [ "CAP", ">= 2022.08-04" ],
        [ "QPA", ">= 2.0-dev"],
        [ "Algebroids", ">= 2021.11-07" ],
        [ "SubcategoriesForCAP", ">= 2020.10-02" ],
        [ "HomotopyCategories", ">= 2021.07-02" ],
        [ "BBGG", ">= 2020.10-02" ],
        [ "FunctorCategories", ">= 2022.09-18" ],
          ],
  SuggestedOtherPackages := [
            [ "NConvex", ">= 2019.12.06" ],
            [ "4ti2Interface", ">= 2010.10-02" ]
          ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
