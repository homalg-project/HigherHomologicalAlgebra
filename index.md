---
layout: default
---

# The Higher Homological Algebra project

This is the home of the Higher Homological Algebra project. It consists of several [GAP](https://www.gap-system.org/) packages,
all of which depend on [`homalg_project`](https://github.com/homalg-project/homalg_project) and [`CAP_project`](https://github.com/homalg-project/CAP_project).

## Packages in the project

{% for package in site.data.packages.package_links %}
  [{{package.name}}]({{site.baseurl}}/{{package.name}})
{% endfor %}

## Dependencies

This project requires GAP version {{site.data.DerivedCategories.GAP}}.
For more information about the dependencies take a look at the individual packages' sites.

## Installation

To install the project, start by installing the latest version of GAP
from [gap-system.org](http://www.gap-system.org). Please refer to the
installation description there for details. Since the project has
fairly new dependencies, earlier versions of GAP might not work.

Then download the tarballs of the Higher Homological Algebra project
packages from the above links into `~/.gap/pkg/`.

_Alternatively_, clone or download the repository

* [HigherHomologicalAlgebra](https://github.com/homalg-project/HigherHomologicalAlgebra/)

via [git](http://git-scm.com) and put it into `~/.gap/pkg/`.

Now you should be able `LoadPackage( "DerivedCategories" );`.

## Author{% if site.data.frontpage.authors.size != 1 %}s{% endif %}
{% for person in site.data.frontpage.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
