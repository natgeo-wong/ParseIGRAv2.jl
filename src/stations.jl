struct IGRAv2Station{ST<:AbstractString,FT<:Real}
       ID :: ST
     name :: ST
      lon :: FT
      lat :: FT
        z :: FT
    start :: Int
     stop :: Int
end


function stationinfodata(ii :: Int = 0)

    fid = joinpath(@__DIR__,"..","files","igra2-station-list.txt")

    if iszero(ii)
        return readdlm(fid,'|')[:,[1,5,2,3,4,6,7]]
    else
        return readdlm(fid,'|')[ii,[1,5,2,3,4,6,7]]
    end

end

stationinfotable() = pretty_table(
    stationinfodata(),header=head,
    alignment=[:c,:l,:c,:c,:c,:c,:c],
    tf = tf_compact
)

stationlist() = stationinfodata()[:,1]

function isIGRAv2station(stn :: String)

    if !iszero(sum(stationlist() .== stn))
          return true
    else; return false
    end

end

station(ID :: String, FT = Float64, ST = String) = if isIGRAv2station(ID)
    data = stationinfodata(findfirst(stationlist().==ID))
    name = data[2]
    while name[end] == ' '
        name = name[1:(end-1)]
    end
    return IGRAv2Station{ST,FT}(
        data[1], name, data[4], data[3], data[5], data[6], data[7]
    )
else
    error("$(modulelog()) - $(ID) is not a valid station ID in the IGRAv2 database")
end

function show(io::IO, stn::IGRAv2Station)
    print(
		io,
		"The IGRAv2 Station \"$(stn.ID)\" has the following properties:\n",
		"    Station ID          (ID) : ", stn.ID, '\n',
		"    Name              (name) : ", stn.name, '\n',
		"    Coordinates  (lon,lat,z) : ", [stn.lon,stn.lat,stn.z], '\n',
		"    Valid Dates (start,stop) : ", [stn.start,stn.stop]
	)
end