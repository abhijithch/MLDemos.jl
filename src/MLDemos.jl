module MLDemos

using LightXML, DataFrames, URIParser, Requests
import Requests: get, options
include("$(Pkg.dir())/MLDemos/src/drug/types.jl")
include("$(Pkg.dir())/MLDemos/src/drug/dbquery.jl")
#include("$(Pkg.dir())/MLDemos/src/xgboost/higgs.jl")
include("$(Pkg.dir())/MLDemos/src/xgboost/mushroom.jl")

# functions
export dbsearch, tdm, readlibsvm

#types
export EntrezSearchResult, PubIds, TermDocMatrix


end # module
