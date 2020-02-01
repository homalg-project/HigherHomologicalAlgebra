#
# BBGG: Gap package to compute Tate resolutions and construct models for the derived category of coherent sheaves
# over the projective space P^n.
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "BBGG",
Subtitle := "Beilinson monads and derived categories for coherent sheaves over P^n",
Version := "2020.01.30",
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),
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

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/homalg-project/", ~.PackageName )
),

PackageWWWHome := Concatenation( "https://homalg-project.github.io/", ~.PackageName ),
README_URL     := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats  := ".tar.gz",

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
  LongTitle := "(B)eilinson monad and (B)ernstein (G)elfand (G)elfand correspondence",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [
                      [ "GAPDoc", ">= 1.5" ],
			                [ "GradedModulePresentationsForCAP", ">= 0.1" ],
			                [ "GradedModules", ">= 2018.02.04" ],
			                [ "GradedRingForHomalg", ">= 2018.02.04" ],
                      [ "ComplexesForCAP", ">= 2020.01.30" ],
			                [ "Bicomplexes", ">= 2018.06.15" ],
                      [ "StableCategories", ">= 2019.12.04" ],
                      [ "LinearAlgebraForCAP", ">= 2020.01.10" ],
                      [ "SubcategoriesForCAP", ">= 2019.12.15" ],
                      [ "FreydCategoriesForCAP", ">= 2019.11.02" ]
                        ],
  SuggestedOtherPackages := [
                              [ "DerivedCategories", ">= 2020.01.01" ],
                              [ "HomotopyCategories", ">= 2020.01.01" ],
                            ],
  ExternalConditions := [ ] ),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "Beilinson monads", "Tate resolutions", "Derived categories", "Projective space", "Coherent sheaves" ],

));


