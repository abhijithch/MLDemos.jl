function dbsearch(db::ASCIIString, terms::Array{UTF8String, 1}, condition::ASCIIString; rm=10)
    src="http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
    search_query = form_query(terms, condition)
    resp = get(src; query = Dict("db"=>db, "term"=>search_query, "retmax"=>rm))
    doc = LightXML.parse_string(bytestring(resp.data))
    p = PubIds()
    pids = fetchpubids(doc)
    p.pubids = pids
    p.terms = terms
    p.npubids = nhits(pids)
    return p
end

function form_query(terms::Array{UTF8String, 1}, condition::ASCIIString)
    field = "[Title/Abstract] $(condition)"
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

function tdm(terms::Array{UTF8String, 1}, db::ASCIIString)
    d = 0
    r = Array{Int64, 1}()
    c = Array{Int64, 1}()
    v = Array{Int64, 1}()
    for term in terms
        d = d+1
        docids = dbsearch(db, [term], "AND")
        if !docids.pubids.isnull
            append!(r, round(Int, ones(docids.npubids)*d))
            append!(c, get(docids.pubids))
            append!(v, round(Int, ones(docids.npubids)))
        end
    end
    return sparse(r,c,v)
end

function docs(term::ASCIIString, T::TermDocMatrix)
    ind = find(map(x->x==term), T.terms)
    return find(T.tdm[ind, :])
end

function tfidf(T::TermDocMatrix)
    return T .* log(size(T,2)./sum(T,2))
end

