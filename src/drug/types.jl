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
    npubids::Int64

    function PubIds()
        new(nothing, nothing, 0)
    end
end

type TermDocMatrix
    nterms::Int64
    terms::Array{UTF8String, 1}
    ndocs::Int64
    tdm::SparseMatrixCSC

    function TermDocMatrix(terms::Array{UTF8String, 1}, ndocs::Int)
        nterms = length(terms)
        tdm = spzeros(nterms, ndocs)
        new(nterms, terms, ndocs, tdm)
    end
end
