# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring_element", "morphism" ],
        src_template := "UnderlyingMatrix( ring_element * morphism )",
        dst_template := "ring_element * UnderlyingMatrix( morphism )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2", "func" ],
        src_template := "Length( ListN( list1, list2, func ) )",
        dst_template := "Length( list1 )",
    )
);
