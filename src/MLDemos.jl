module MLDemos

using LightXML, DataFrames, URIParser, Requests
import Requests: get, options
include("$(Pkg.dir())/MLDemos/src/drug/types.jl")
# functions
export dbsearch, tdm

#types
export EntrezSearchResult, PubIds, TermDocMatrix

include("$(Pkg.dir())/MLDemos/src/drug/dbquery.jl")


end # module
