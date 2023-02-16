module ParseIGRAv2

## Base Modules Used
using DelimitedFiles
using Logging
using PrettyTables
using Printf
using Statistics

## Modules Used
using NCDatasets

## Reexporting exported functions within these modules
using Reexport
@reexport using Dates

import Base: show, download

## Exporting the following functions:
export
        station, stationlist, stationinfodata, stationinfotable,
        isIGRAv2station

## TmPi.jl logging preface

modulelog() = "$(now()) - ParseIGRAv2.jl"

include("stations.jl")
include("downloads.jl")

end
