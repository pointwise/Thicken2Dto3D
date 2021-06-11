# glyph-thicken2d
Copyright 2021 Cadence Design Systems, Inc. All rights reserved worldwide.

Some solvers will not accept 2D grid blocks as input for 2D analysis. Instead, these solvers require an equivalent, 3D grid that is one cell thick.

This glyph script thickens a 2D grid into a one cell deep, 3D grid. All boundary conditions in the 2D grid are automatically transfered to the corresponding extruded domains in the resulting 3D grid.

![Thicken2d Banner Image](../master/images/banner.png  "thicken2d banner Image")


### Table of Contents
* [Running The Script](#running-the-script)
    * [Dialog Box Options](#dialog-box-options)
* [Script Limitations](#script-limitations)
* [Sourcing This Script](#sourcing-this-script)
* [Disclaimer](#disclaimer)


## Running The Script

* Build a 2D grid in an XY plane. The CAE dimension **must** be set to 2.
* Apply boundary conditions to the appropriate connectors.
* Execute this script.
* Set the desired options in the dialog box.
* Press OK to thicken the grid.

### Dialog Box Options

<img src="../master/images/dialog.png" width="400px" alt="Thicken2d Dialog Box Image"/>

* **Extrude Steps** - Sets the number of extrusion steps.
* **Extrude Distance** - Sets the total extrusion distance traversed by all steps combined.
* **Min Side BC** - Sets the boundary condition that will be applied to the min side wall domains in the thickened grid.
  * You can select the name of an existing boundary condition using the drop down list (the *Type* and *Id* are displayed).
  * To create a new boundary condition, enter a unique *Name* along with its *Type* and *Id*.
  * Set the *Name* to *Unspecified* to skip the appication of a min side boundary condition.
* **Max Side BC** - Sets the boundary condition that will be applied to the max side wall domains in the thickened grid.
  * You can select the name of an existing boundary condition using the drop down list (the *Type* and *Id* are displayed).
  * To create a new boundary condition, enter a unique *Name* along with its *Type* and *Id*.
  * Set the *Name* to *Unspecified* to skip the appication of a max side boundary condition.
* **Enable verbose output** - Select this option to see detailed runtime information. Unselect this option to see minimal runtime information.


## Script Limitations

The dialog does not support setting the extrusion direction and always extrudes in the +Z direction.

This script cannot be used directly with solvers that do not support 2D grid mode. Instead, the 2D grids will need to be thickened manually using Pointwise's block extrusion tools. However, as a workaround, you can:

* Load your 2D grid into Pointwise.
* Change the CAE solver to one that supports 2D mode (e.g. CGNS).
* Switch the mode to 2D (menu CAE/Set Dimension/2D).
* Thicken the 2D grid with the script.
* Switch solver to the one you really want to use.
* Reset the BC and VC types.


## Sourcing This Script

It is possible to source this script in your own Glyph scripts and use it as a library.

See the [Thicken2D API Docs](docs/Thicken2Dto3D_API.md) for information on how to use this script as a library.


## Disclaimer
This file is licensed under the Cadence Public License Version 1.0 (the "License"), a copy of which is found in the LICENSE file, and is distributed "AS IS." 
TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, CADENCE DISCLAIMS ALL WARRANTIES AND IN NO EVENT SHALL BE LIABLE TO ANY PARTY FOR ANY DAMAGES ARISING OUT OF OR RELATING TO USE OF THIS FILE. 
Please see the License for the full text of applicable terms.
