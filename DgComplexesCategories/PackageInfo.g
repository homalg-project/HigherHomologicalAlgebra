# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "DgComplexesCategories",
Subtitle := "Category of graded (co)chain complexes of an additive category",
Version := "2022.09-02",
Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh/",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
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
PackageWWWHome  := "https://homalg-project.github.io/pkg/DgComplexesCategories",
PackageInfoURL  := "https://homalg-project.github.io/HigherHomologicalAlgebra/DgComplexesCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HigherHomologicalAlgebra/DgComplexesCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/DgComplexesCategories-", ~.Version, "/DgComplexesCategories-", ~.Version ),
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
  BookName  := "DgComplexesCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Category of graded (co)chain complexes of an additive category",
),

Dependencies := rec(
  GAP := ">= 4.11.1",
  NeededOtherPackages := [
                            [ "AutoDoc", ">= 2019.09.04" ],
                            [ "ComplexesCategories", ">= 2022.09-01" ]
                         ],
  SuggestedOtherPackages := [
                              [ "Algebroids", ">= 2022.09-23" ]
                            ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ ],

));
