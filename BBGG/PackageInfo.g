# SPDX-License-Identifier: GPL-2.0-or-later
# BBGG: Beilinson monads and derived categories for coherent sheaves over P^n
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "BBGG",
Subtitle := "Beilinson monads and derived categories for coherent sheaves over P^n",
Version := "2020.11-01",
Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
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
                       "57072 Siegen\n",
                       "Germany" ),
    Place := "Siegen",
    Institution := "Universität Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/HigherHomologicalAlgebra/BBGG",
PackageInfoURL  := "https://homalg-project.github.io/HigherHomologicalAlgebra/BBGG/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HigherHomologicalAlgebra/BBGG/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/BBGG-", ~.Version, "/BBGG-", ~.Version ),
# END URLS

ArchiveFormats  := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=
  "The <span class='pkgname'>BBGG</span> package provides\
 a GAP package to implement the Bernstein, Gelfand and Gelfand correspondence,\
 in order to give several models for the derived category of coherent sheaves,\
 over the projective space. First as a triangulated stable category over left modules over\
 exterior algebras and the secondly by constructing the Beilinson monads.",

PackageDoc := rec(
  BookName  := "BBGG",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Beilinson monads and derived categories for coherent sheaves over P^n",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [
                      [ "GAPDoc", ">= 1.5" ],
			                [ "GradedModulePresentationsForCAP", ">= 0.1" ],
			                [ "GradedModules", ">= 2020.04.30" ],
			                [ "GradedRingForHomalg", ">= 2020.05.01" ],
			                [ "Bicomplexes", ">= 2020.03.11" ],
                      [ "StableCategories", ">= 2019.12.04" ],
                      [ "LinearAlgebraForCAP", ">= 2020.04.16" ],
                      [ "SubcategoriesForCAP", ">= 2020.04.05" ],
                      [ "FreydCategoriesForCAP", ">= 2019.11.02" ]
                        ],
  SuggestedOtherPackages := [
                              #[ "DerivedCategories", ">= 2020.01.01" ],
                              #[ "HomotopyCategories", ">= 2020.01.01" ],
                            ],
  ExternalConditions := [ ] ),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "Beilinson monads", "Tate resolutions", "Derived categories", "Projective space", "Coherent sheaves" ],

));
