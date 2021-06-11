#############################################################################
#
# (C) 2021 Cadence Design Systems, Inc. All rights reserved worldwide.
#
# This sample script is not supported by Cadence Design Systems, Inc.
# It is provided freely for demonstration purposes only.
# SEE THE WARRANTY DISCLAIMER AT THE BOTTOM OF THIS FILE.
#
#############################################################################


# ===============================================
# THICKEN 2D GRID TEST SCRIPT
# ===============================================
# Using Thicken2Dto3D.glf as a library

package require PWI_Glyph 2.17

set disableAutoRun_Thicken2D 1
source [file join [file dirname [info script]] "../Thicken2Dto3D.glf"]

pw::Application reset -keep Clipboard
set mode [pw::Application begin ProjectLoader]
$mode initialize [file join [file dirname [info script]] "baffle-test.pw"]
$mode setAppendMode false
$mode load
$mode end
unset mode

pw::Application setCAESolver "COBALT" 2

# Set to 0/1 to disable/enable TRACE messages
pw::Thicken2D::setVerbose 1

# Controls extrusion direction
pw::Thicken2D::setExtDirection {0 0 1}

# Controls extrusion distance
pw::Thicken2D::setExtDistance 2

# Controls extrusion number of steps
pw::Thicken2D::setExtSteps 4

pw::Thicken2D::setMinSidewallBC "COBALT" "Side Wall Min" "Solid Wall" "99"
pw::Thicken2D::setMaxSidewallBC "COBALT" "Side Wall Max" "Solid Wall" "88"

pw::Thicken2D::thicken [pw::Grid getAll -type pw::Domain]

# END SCRIPT

#############################################################################
#
# This file is licensed under the Cadence Public License Version 1.0 (the
# "License"), a copy of which is found in the included file named "LICENSE",
# and is distributed "AS IS." TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE
# LAW, CADENCE DISCLAIMS ALL WARRANTIES AND IN NO EVENT SHALL BE LIABLE TO
# ANY PARTY FOR ANY DAMAGES ARISING OUT OF OR RELATING TO USE OF THIS FILE.
# Please see the License for the full text of applicable terms.
#
#############################################################################
