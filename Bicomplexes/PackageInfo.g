# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "Bicomplexes",
Subtitle := "Bicomplexes for Abelian categories",
Version := "2023.11-01",
Date := "2023-11-11",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "http://www.mathematik.uni-kl.de/~barakat/",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
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
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/Bicomplexes",
PackageInfoURL  := "https://homalg-project.github.io/HigherHomologicalAlgebra/Bicomplexes/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HigherHomologicalAlgebra/Bicomplexes/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/Bicomplexes-", ~.Version, "/Bicomplexes-", ~.Version ),
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
  BookName  := "Bicomplexes",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Bicomplexes for Abelian categories",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                   [ "CAP", ">= 2023.05-03" ],
                   [ "ComplexesCategories", ">= 2020.03.12" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "bicomplexes", "abelian category" ],

));
