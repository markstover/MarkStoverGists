function strtokenizer(inputstr, separator)
  t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..separator.."]+)") do
    print("    i, str = ", i, str)
    t[i] = str
    i = i + 1
  end
  return t
end

local function isolate_domain(uristring)
  local uri_tokenized = strtokenizer(uristring, ":") 
  print("uri_tokenized[1] = ", uri_tokenized[1])
  print("uri_tokenized[2] = ", uri_tokenized[2])
  print("uri_tokenized[3] = ", uri_tokenized[3])
  local lhs_rhs_uri_tokenized = strtokenizer(uri_tokenized[2], "@")
  print("lhs_rhs_uri_tokenized[1] = ", lhs_rhs_uri_tokenized[1])
  print("lhs_rhs_uri_tokenized[2] = ", lhs_rhs_uri_tokenized[2])
  print("lhs_rhs_uri_tokenized[3] = ", lhs_rhs_uri_tokenized[3])
    
  local normalized_rhs = string.lower(lhs_rhs_uri_tokenized[2])
  print("normalized_rhs = ", normalized_rhs)
  return normalized_rhs
end

local function modify_rhs_of_uri_for_to(msg)
  if not fixup_to_header
  then
    return
  end

  local method, ruri, ver = msg:getRequestLine()
  local touri = msg:getUri("To")
  
  local ruri_rhs = isolate_domain(ruri)
  local touri_rhs = isolate_domain(touri)

  if ruri_rhs == touri_rhs
  then
    return
  else
    modify_rhs_of_uri(msg, "To", ruri_rhs)
  end
end
