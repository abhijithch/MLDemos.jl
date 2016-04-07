function dbsearch(db::ASCIIString, terms::Array{UTF8String, 1}; rm=10)
    src="http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
    search_query = form_query(terms)
    resp = get(src; query = Dict("db"=>db, "term"=>search_query, "retmax"=>rm))
    doc = LightXML.parse_string(bytestring(resp.data))
    p = PubIds()
    pids = fetchpubids(doc)
    p.pubids = pids
    p.terms = terms
    p.npubids = nhits(pids)
    return p
end

function form_query(terms::Array{UTF8String, 1})
    field = "[Title/Abstract] OR"
    query = ""
    for term in terms
        query = "$(query) $(term) $(field)"
    end
    println(query)
    return query
end

function fetchpubids(doc::LightXML.XMLDocument)
    root_elem = LightXML.root(doc)
    idList_elem=LightXML.get_elements_by_tagname(root_elem, "IdList")
    ids_xml=LightXML.get_elements_by_tagname(idList_elem[1], "Id")
    ids = Int[]
    for i=1:length(ids_xml)
        push!(ids, parse(Int, LightXML.content(ids_xml[i])))
    end
    return ids
end

function nhits(pubids::Array{Int64, 1})
    return length(pubids)
end

