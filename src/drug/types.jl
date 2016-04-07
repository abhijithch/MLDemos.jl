immutable EntrezSearchResult
    uri::URI  # query URI
    timestamp::DateTime  # access date and time
    success::Bool  # the query finished successfully or not
    doc::LightXML.XMLDocument  # the result XML object
end

#=
immutable PubIDs
    terms::Array{AbstractString, 1}
    pubids::Array{Int64, 1}
    npubids::Int64
end
=#

type PubIds
    terms::Nullable{Array{UTF8String, 1}}
    pubids::Nullable{Array{Int64, 1}}
    npubids::Nullable{Int64}

    function PubIds()
        new(nothing, nothing, nothing)
    end
end
