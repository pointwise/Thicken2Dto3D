# glyph-thicken2d API
Copyright 2021 Cadence Design Systems, Inc. All rights reserved worldwide.

It is possible to source this script in your own Glyph scripts and use it as a library.

To source this script add the following lines to your script:

```Tcl
    set disableAutoRun_Thicken2D 1 ;# disable the autorun
    source "/some/path/to/your/copy/of/Thicken2Dto3D.glf"
```

See the script `test/test01.glf` for an example.

### Table of Contents
* [Namespace pw::Thicken2D](#namespace-pwthicken2d)
* [pw::Thicken2D Library Docs](#pwthicken2d-library-docs)
* [pw::Thicken2D Library Usage Examples](#pwthicken2d-library-usage-examples)
    * [Thickening a 2D Grid for the COBALT Solver](#thickening-a-2d-grid-for-the-cobalt-solver)
* [Disclaimer](#disclaimer)


## Namespace pw::Thicken2D

All of the procs in this collection reside in the **pw::Thicken2D** namespace.

To call a proc in this collection, you must prefix the proc name with a **pw::Thicken2D::** namespace specifier.

For example:
```Tcl
set disableAutoRun_Thicken2D 1 ;# disable the autorun
source "/some/path/to/your/copy/of/Thicken2Dto3D.glf"
pw::Thicken2D::setVerbose 1
pw::Thicken2D::thicken $doms
```

To avoid the long namespace prefix, you can also import the public **pw::Thicken2D** procs into your script.

For example:
```Tcl
set disableAutoRun_Thicken2D 1 ;# disable the autorun
source "/some/path/to/your/copy/of/Thicken2Dto3D.glf"
# import all public procs
namespace import ::pw::Thicken2D::*
setVerbose 1
thicken $doms
```

```Tcl
set disableAutoRun_Thicken2D 1 ;# disable the autorun
source "/some/path/to/your/copy/of/Thicken2Dto3D.glf"
# import specific public procs
namespace import ::pw::Thicken2D::setVerbose
namespace import ::pw::Thicken2D::thicken
setVerbose 1
thicken $doms
```


## pw::Thicken2D Library Docs

```Tcl
pw::Thicken2D::setVerbose { val }
```
Sets the level of runtime trace information dumped by the script.
<dl>
  <dt><code>val</code></dt>
  <dd>If set to 1, full trace information is dumped. If set to 0, only minimal trace information is dumped. (default: 0)</dd>
</dl>
<br/>

```Tcl
pw::Thicken2D::setExtDirection { val }
```
Sets the extrusion direction.
<dl>
  <dt><code>val</code></dt>
  <dd>The extrusion direction vector as a Tcl list of three floating point values {dx dy dz}. (default: {0 0 1})</dd>
</dl>
<br/>

```Tcl
pw::Thicken2D::setExtDistance { val }
```
Sets the extrusion distance.
<dl>
  <dt><code>val</code></dt>
  <dd>The total extrusion distance traversed by all steps combined. (default: 1.0)</dd>
</dl>
<br/>

```Tcl
pw::Thicken2D::setExtSteps { val }
```
Sets the number of extrusion steps.
<dl>
  <dt><code>val</code></dt>
  <dd>The number of extrusion steps. (default: 1)</dd>
</dl>
<br/>

```Tcl
pw::Thicken2D::setMinSidewallBc { solverName bcName bcType {bcId "null"} }
```
For a given solver, sets the boundary condition that will be applied to the min side wall domains in the thickened grid.

See **pw::Thicken2D::setSidewallBc** for more details.
<br/>

```Tcl
pw::Thicken2D::setMaxSidewallBc { solverName bcName bcType {bcId "null"} }
```
For a given solver, sets the boundary condition that will be applied to the max side wall domains in the thickened grid.

See **pw::Thicken2D::setSidewallBc** for more details.
<br/>

```Tcl
pw::Thicken2D::setSidewallBc { solverName {bcName "Unspecified"} {bcType "Unspecified"} \
                               {bcId "null"} {minMax "both"} }
```
For a given solver, sets the boundary condition that will be applied to the min, max, or to both side wall domains in the thickened grid.
<dl>
  <dt><code>solverName</code></dt>
  <dd>Name of the solver for which this entry is being made. Must be one of the solver names returned by
    <b>[pw::Application getCAESolverNames]</b></dd>
  <dt><code>bcName</code></dt>
  <dd>The side wall BC name. This can be any name allowed by the targeted solver.  If the boundary condition
      already exisits, it will be used as-is (the <code>bcType</code> and <code>bcId</code> values are ignored).
      If the boundary condition does not exit, it is created using the <code>bcType</code> and <code>bcId</code>
      values.<br/>
      <br/>
      If set to <b>Unspecified</b>, the boundary condition(s) specified by <code>minMax</code> will be
      cleared. The <code>bcType</code> and <code>bcId</code> values are ignored.</dd>
  <dt><code>bcType</code></dt>
  <dd>If a boundary condition is created, it will use this solver specific boundary condition type. If the
      boundary condition already exists, this value is ignored.</dd>
  <dt><code>bcId</code></dt>
  <dd>If a boundary condition is created, it will have this user-defined boundary condition id. If the id is set
      to <b>null</b>, a unique value is automatically assigned. If the boundary condition already exists, this
      value is ignored.</dd>
  <dt><code>minMax</code></dt>
  <dd>Indicates the side wall for which this boundary condition is intended. One of <b>min</b>, <b>max</b>, or
      <b>both</b>.</dd>
</dl>

The Min and Max versions of this proc are wrappers around **pw::Thicken2D::setSidewallBc** as detailed below.
```Tcl
   pw::Thicken2D::setMinSidewallBc "CGNS" "Side Wall Min" "Wall"
   # is equivalent to
   pw::Thicken2D::setSidewallBc "CGNS" "Side Wall Min" "Wall" "null" "min"

   pw::Thicken2D::setMaxSidewallBc "CGNS" "Side Wall Max" "Wall"
   # is equivalent to
   pw::Thicken2D::setSidewallBc "CGNS" "Side Wall Max" "Wall" "null" "max"
```

The min side wall domains are the domains from the original 2D grid. The max side wall domains are opposite the min side wall domains on the other end of the extruded 3D grid. For an example, see the boundary condition assignments in the banner image above.

The side wall boundary conditions are optional. Side wall boundary conditions will only be assigned by the script if appropriate solver entries are added.
<br/>
<br/>

```Tcl
pw::Thicken2D::thicken { domsToThicken }
```
Thickens a 2D grid into an extruded 3D grid.
<dl>
  <dt><code>domsToThicken</code></dt>
  <dd>A list of 2D blocks (domains) to thicken.</dd>
</dl>

All boundary conditions in the 2D grid are automatically transfered to the corresponding extruded domains in the resulting 3D grid.

See also, **pw::Thicken2D::setExtDirection**, **proc pw::Thicken2D::setExtDistance**, **proc pw::Thicken2D::setExtSteps**, **pw::Thicken2D::setMinSidewallBc**, **pw::Thicken2D::setMaxSidewallBc**, **pw::Thicken2D::setSidewallBc**.
<br/>

## pw::Thicken2D Library Usage Examples

### Thickening a 2D Grid for the COBALT Solver

```Tcl
    set disableAutoRun_Thicken2D 1 ;# disable the autorun
    source "/some/path/to/your/copy/of/Thicken2Dto3D.glf"

    pw::Application setCAESolver "COBALT" 2

    # Set to 0/1 to disable/enable TRACE messages
    pw::Thicken2D::setVerbose 1

    # Controls extrusion direction
    pw::Thicken2D::setExtDirection {0 0 1} ;# +Z extrusion

    # Controls extrusion distance
    pw::Thicken2D::setExtDistance 2.5

    # Controls extrusion number of steps
    pw::Thicken2D::setExtSteps 4

    pw::Thicken2D::setMinSidewallBc "COBALT" "Side Wall Min" "Solid Wall" "99"
    pw::Thicken2D::setMaxSidewallBc "COBALT" "Side Wall Max" "Solid Wall" "88"

    pw::Thicken2D::thicken [pw::Grid getAll -type pw::Domain]
```


## Disclaimer
This file is licensed under the Cadence Public License Version 1.0 (the "License"), a copy of which is found in the LICENSE file, and is distributed "AS IS." 
TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, CADENCE DISCLAIMS ALL WARRANTIES AND IN NO EVENT SHALL BE LIABLE TO ANY PARTY FOR ANY DAMAGES ARISING OUT OF OR RELATING TO USE OF THIS FILE. 
Please see the License for the full text of applicable terms.
