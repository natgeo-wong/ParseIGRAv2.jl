struct IGRAv2Raw{ST<:AbstractString,FT<:Real} <: IGRAv2Station
       ID :: ST
     name :: ST
      lon :: FT
      lat :: FT
        z :: FT
    start :: Int
     stop :: Int
    https :: ST
end

struct IGRAv2Derived{ST<:AbstractString,FT<:Real} <: IGRAv2Station
       ID :: ST
     name :: ST
      lon :: FT
      lat :: FT
        z :: FT
    start :: Int
     stop :: Int
    https :: ST
end


function stationinfodata(ii :: Int, derived :: Bool)

    if derived
        fid = joinpath(@__DIR__,"..","files","igra2station-derived-list.csv")
    else
        fid = joinpath(@__DIR__,"..","files","igra2station-raw-list.csv")
    end

    if iszero(ii)
        return readdlm(fid,',')[:,[1,5,2,3,4,6,7]]
    else
        return readdlm(fid,',')[ii,[1,5,2,3,4,6,7]]
    end

end

stationinfotable(;derived :: Bool=false) = pretty_table(
    stationinfodata(0,derived),
    header=["ID","Name","Latitude","Longitude","Altitude","Year Start","Year End"],
    alignment=[:c,:l,:c,:c,:c,:c,:c],
    tf = tf_compact
)

stationlist(;derived :: Bool) = stationinfodata(0,derived)[:,1]

function isIGRAv2station(stn :: AbstractString, derived :: Bool)

    if !iszero(sum(stationlist(derived=derived) .== stn))
          return true
    else; return false
    end

end

function station(ID :: AbstractString, FT = Float64, ST = String; derived :: Bool = false)
    if isIGRAv2station(ID,derived)
        data = stationinfodata(findfirst(stationlist(derived=derived).==ID),derived)
        if derived
            return IGRAv2Derived{ST,FT}(
                data[1], data[2], data[4], data[3], data[5], data[6], data[7],
                "https://www1.ncdc.noaa.gov/pub/data/igra/derived/derived-por/$(ID).txt.zip"
            )
        else
            return IGRAv2Raw{ST,FT}(
                data[1], data[2], data[4], data[3], data[5], data[6], data[7],
                "https://www1.ncdc.noaa.gov/pub/data/igra/data/data-por/$(ID).txt.zip"
            )
        end
    else
        error("$(modulelog()) - $(ID) is not a valid station ID in the IGRAv2 database")
    end
end

function show(io::IO, stn::IGRAv2Station)
    print(
		io,
		"The IGRAv2 Station \"$(stn.ID)\" has the following properties:\n",
		"    Station ID                 (ID) : ", stn.ID,                  '\n',
		"    Station Name             (name) : ", stn.name,                '\n',
		"    Station Coordinates (lon,lat,z) : ", [stn.lon,stn.lat,stn.z], '\n',
        "    Valid Years        (start,stop) : ", [stn.start,stn.stop],    '\n',
		"    HTTPs Remote File       (https) : ", stn.https,               '\n',
	)
end