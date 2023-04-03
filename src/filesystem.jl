zippath(station::IGRAv2Raw,path) = joinpath(path,"IGRAv2","raw","$(station.ID).txt.zip")
txtpath(station::IGRAv2Raw,path) = joinpath(path,"IGRAv2","raw","$(station.ID).txt")

zippath(station::IGRAv2Derived,path) = joinpath(path,"IGRAv2","derived","$(station.ID).txt.zip")
txtpath(station::IGRAv2Derived,path) = joinpath(path,"IGRAv2","derived","$(station.ID).txt")