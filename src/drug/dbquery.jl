function querydb(db::AbstractString, terms::Array{AbstractString, 1}; retmax=10)
    src="http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
    search_query = form_query(terms)
    return LightXML.parse_string(bytestring(resp.data))
end

function form_query(terms::Array{AbstractString, 1})
    field = "[Title/Abstract] OR"
    query = ""
    for term in terms
        query = "$(query) $(term) $(field)"
    end
    return query
end

function pubids(doc::LightXML.XMLDocument)
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
