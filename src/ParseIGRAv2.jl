module ParseIGRAv2

## Base Modules Used
using DelimitedFiles
using Logging
using PrettyTables
using Printf
using Statistics

## Modules Used
using NCDatasets
using ZipFile

## Reexporting exported functions within these modules
using Reexport
@reexport using Dates

import Base: show, download, read

## Exporting the following functions:
export
        station, stationlist, stationinfodata, stationinfotable,
        isIGRAv2station,

        download, extract, read, show

## TmPi.jl logging preface

modulelog() = "$(now()) - ParseIGRAv2.jl"

include("stations.jl")
include("download.jl")
include("read.jl")

end
