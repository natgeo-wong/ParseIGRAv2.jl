function readprofile(station :: IGRAv2Data, icol1 :: Int, icol2 :: Int)

    nlvls = maximum(station.nlevels)
    ntime = length(station.nlevels)

    data = zeros(nlvls,ntime) * NaN

    fio = open(station.file)
    sounddata = readlines(fio)

    for itime = 1 : ntime
        ibeg = station.line[itime] + 1
        idata = @view data[1:station.nlevels[itime],itime]
        for ilvl = 1 : station.nlevels[itime]
            idata[ilvl] = parse(Int,sounddata[ibeg+ilvl-1][icol1:icol2])
            if !iszero(sum(idata[ilvl] .== [-99999,-9999,-8888]))
                idata[ilvl] = NaN
            end
        end
    end
    close(fio)

    return data

end

profile_temperature(station :: IGRAv2DataDerived)    = readprofile(station,25,31) / 10
profile_pressure(station :: IGRAv2DataDerived)       = readprofile(station,1,7)
profile_vapourpressure(station :: IGRAv2DataDerived) = readprofile(station,73,79)
profile_geopotential(station :: IGRAv2DataDerived)         = readprofile(station,9,15)
profile_geopotentialestimate(station :: IGRAv2DataDerived) = readprofile(station,17,23)

profile_temperature(station :: IGRAv2DataRaw)      = readprofile(station,23,27) / 10
profile_pressure(station :: IGRAv2DataRaw)         = readprofile(station,10,15)
profile_relativehumidity(station :: IGRAv2DataRaw) = readprofile(station,29,33) / 10
profile_geopotential(station :: IGRAv2DataRaw)     = readprofile(station,17,21)