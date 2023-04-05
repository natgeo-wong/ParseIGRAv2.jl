zippath(station::IGRAv2StationRaw,path) = joinpath(path,"IGRAv2","raw","$(station.ID).txt.zip")
txtpath(station::IGRAv2StationRaw,path) = joinpath(path,"IGRAv2","raw","$(station.ID).txt")

zippath(station::IGRAv2StationDerived,path) = joinpath(path,"IGRAv2","derived","$(station.ID).txt.zip")
txtpath(station::IGRAv2StationDerived,path) = joinpath(path,"IGRAv2","derived","$(station.ID).txt")