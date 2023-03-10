function profile_temperature(
    station :: IGRAv2Data
)

    if station.derived
        fID = joinpath(station.path,"IGRAv2","derived","$(station.ID).txt")
    else
        fID = joinpath(station.path,"IGRAv2","raw","$(station.ID).txt")
    end

    nlvls = maximum(station.nlevels)
    ntime = length(station.nlevels)

    tair = zeros(nlvls,ntime) * NaN

    fio = open(fID)
    data = readlines(fio)

    for itime = 1 : ntime
        ibeg = station.line[itime] + 1
        itair = @view tair[1:station.nlevels[itime],itime]
        for ilvl = 1 : station.nlevels[itime]
            itair[ilvl] = parse(Int,data[ibeg+ilvl-1][25:31]) / 10
            if itair[ilvl] == -9999.9
                itair[ilvl] = NaN
            end
        end
    end
    close(fio)

    return tair

end

function profile_pressure(
    station :: IGRAv2Data
)

    if station.derived
        fID = joinpath(station.path,"IGRAv2","derived","$(station.ID).txt")
    else
        fID = joinpath(station.path,"IGRAv2","raw","$(station.ID).txt")
    end

    nlvls = maximum(station.nlevels)
    ntime = length(station.nlevels)

    pres = zeros(nlvls,ntime) * NaN

    fio = open(fID)
    data = readlines(fio)

    for itime = 1 : ntime
        ibeg = station.line[itime] + 1
        ipres = @view pres[1:station.nlevels[itime],itime]
        for ilvl = 1 : station.nlevels[itime]
            ipres[ilvl] = parse(Int,data[ibeg+ilvl-1][1:7])
            if ipres[ilvl] == -99999
                ipres[ilvl] = NaN
            end
        end
    end
    close(fio)

    return pres

end

function profile_vapourpressure(
    station :: IGRAv2Data
)

    if station.derived
        fID = joinpath(station.path,"IGRAv2","derived","$(station.ID).txt")
    else
        fID = joinpath(station.path,"IGRAv2","raw","$(station.ID).txt")
    end

    nlvls = maximum(station.nlevels)
    ntime = length(station.nlevels)

    vappres = zeros(nlvls,ntime) * NaN

    fio = open(fID)
    data = readlines(fio)

    for itime = 1 : ntime
        ibeg = station.line[itime] + 1
        ivap = @view vappres[1:station.nlevels[itime],itime]
        for ilvl = 1 : station.nlevels[itime]
            ivap[ilvl] = parse(Int,data[ibeg+ilvl-1][73:79])
            if ivap[ilvl] == -99999
                ivap[ilvl] = NaN
            end
        end
    end
    close(fio)

    return vappres

end