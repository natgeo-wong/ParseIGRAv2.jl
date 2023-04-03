function readprofile(station :: IGRAv2Data, icol1 :: Int, icol2 :: Int)

    nlvls = maximum(station.nlevels)
    ntime = length(station.nlevels)

    data = zeros(nlvls,ntime) * NaN

    fio = open(station.file)
    data = readlines(fio)

    for itime = 1 : ntime
        ibeg = station.line[itime] + 1
        idata = @view data[1:station.nlevels[itime],itime]
        for ilvl = 1 : station.nlevels[itime]
            idata[ilvl] = parse(Int,data[ibeg+ilvl-1][icol1:icol2])
            if idata[ilvl] == -99999
                idata[ilvl] = NaN
            end
        end
    end
    close(fio)

    return data

end

profile_temperature(station :: IGRAv2Data)    = readprofile(station,25,31) / 10
profile_pressure(station :: IGRAv2Data)       = readprofile(station,1,7)
profile_vapourpressure(station :: IGRAv2Data) = readprofile(station,73,79)