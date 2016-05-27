module Entrez

using LightXML, DataFrames, URIParser
include("types.jl")

#types
export EntrezSearchResult, PubIds, TermDocMatrix

# functions
export dbsearch, tdm

include("dbquery.jl")
end
