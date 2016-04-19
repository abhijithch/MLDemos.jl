module Entrez

using LightXML, DataFrames, URIParser

# functions
export dbsearch, tdm

#types
export EntrezSearchResult, PubIDs, TermDocMatrix

include("types.jl")
include("dbquery.jl")
end
