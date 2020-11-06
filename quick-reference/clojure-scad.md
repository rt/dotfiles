**Shapes**

cube([], center = true)
sphere(r)
cylinder(h, r1, r2)

**Transformations**

translate([])
scale([])
rotate([])
mirror([])

**Constructive solid geometry**

union(...)
difference(x, y)
intersection(...)

multmatrix() : Multiplies the geometry of all child elements with the given affine transformation matrix
color( c = [r, g, b, a]) {...}
offset(r, delta, chamfer) : Offset generates a new 2d interior or exterior outline from an existing outline
minkowski : Displays the minkowski sum of child nodes. 
hull : Displays the convex hull of child nodes.: 
