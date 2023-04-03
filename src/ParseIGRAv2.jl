module ParseIGRAv2

## Base Modules Used
using DelimitedFiles
using Logging
using PrettyTables
using Printf
using Statistics

## Modules Used
using ZipFile

## Reexporting exported functions within these modules
using Reexport
@reexport using Dates

import Base: show, download, read

## Exporting the following functions:
export
        station, stationlist, stationinfodata, stationinfotable,
        isIGRAv2station,

        profile_pressure, profile_temperature, profile_vapourpressure,

        download, extract, read, show,

        IGRAv2Raw, IGRAv2Derived, IGRAv2Data


## Abstract SuperTypes
"""
    IGRAv2Station

Abstract supertype that contains information on IGRAv2 Stations

All `IGRAv2Station` Types contain the following fields:
- `ID`    : The IGRAv2 Station identifier, 11 characters long
- `name`  : Name of the station location
- `lon`   : Longitude of the station
- `lat`   : Latitude of the station
- `z`     : Altitude of the station
- `start` : Year data start
- `stop`  : Year data stops
- `https` : Remote https link to access/download data
"""
abstract type IGRAv2Station end

## TmPi.jl logging preface

modulelog() = "$(now()) - ParseIGRAv2.jl"

include("stations.jl")
include("download.jl")
include("read.jl")
include("profiles.jl")

end
