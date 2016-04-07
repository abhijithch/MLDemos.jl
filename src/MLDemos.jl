module MLDemos

using LightXML, DataFrames, URIParser, Requests
import Requests: get, options

# functions
export dbsearch

#types
export EntrezSearchResult, PubIds

include("$(Pkg.dir())/MLDemos/src/drug/dbquery.jl")
include("$(Pkg.dir())/MLDemos/src/drug/types.jl")

end # module
