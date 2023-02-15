module ParseIGRAv2

## Base Modules Used
using DelimitedFiles
using Logging
using Printf
using Statistics

## Modules Used
using NCDatasets

## Reexporting exported functions within these modules
using Reexport
@reexport using Dates

import Base: download

## Exporting the following functions:
export
        something

## TmPi.jl logging preface

modulelog() = "$(now()) - ParseIGRAv2.jl"

end
