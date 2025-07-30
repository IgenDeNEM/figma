function formatVATNumber(number)
  local number = tostring(number)
  if utf8.len(number) < 11 then
    return ""
  end
  local firstPart = utf8.sub(number, 1, 8)
  local secondPart = utf8.sub(number, 9, 9)
  local thirdPart = utf8.sub(number, 10, 11)
  return firstPart .. "-" .. secondPart .. "-" .. thirdPart
end
local tableAccents = {}
  tableAccents["\195\160"] = "a"
  tableAccents["á"] = "a"
  tableAccents["\195\162"] = "a"
  tableAccents["\195\163"] = "a"
  tableAccents["\195\164"] = "a"
  tableAccents["\195\167"] = "c"
  tableAccents["\195\168"] = "e"
  tableAccents["é"] = "e"
  tableAccents["??"] = "e"
  tableAccents["\195\171"] = "e"
  tableAccents["\195\172"] = "i"
  tableAccents["í"] = "i"
  tableAccents["\195\174"] = "i"
  tableAccents["\195\175"] = "i"
  tableAccents["\195\177"] = "n"
  tableAccents["\195\178"] = "o"
  tableAccents["ó"] = "o"
  tableAccents["\195\180"] = "o"
  tableAccents["?µ"] = "o"
  tableAccents["ö"] = "o"
  tableAccents["\195\185"] = "u"
  tableAccents["??"] = "u"
  tableAccents["ű"] = "u"
  tableAccents["ü"] = "u"
  tableAccents["\195\189"] = "y"
  tableAccents["\195\191"] = "y"
  tableAccents["\195\128"] = "A"
  tableAccents["Á"] = "A"
  tableAccents["\195\130"] = "A"
  tableAccents["\195\131"] = "A"
  tableAccents["\195\132"] = "A"
  tableAccents["\195\135"] = "C"
  tableAccents["\195\136"] = "E"
  tableAccents["É"] = "E"
  tableAccents["\195\138"] = "E"
  tableAccents["\195\139"] = "E"
  tableAccents["\195\140"] = "I"
  tableAccents["Í"] = "I"
  tableAccents["\195\142"] = "I"
  tableAccents["\195\143"] = "I"
  tableAccents["\195\145"] = "N"
  tableAccents["\195\146"] = "O"
  tableAccents["Ó"] = "O"
  tableAccents["\195\148"] = "O"
  tableAccents["\195\149"] = "O"
  tableAccents["Ö"] = "O"
  tableAccents["\195\153"] = "U"
  tableAccents["Ú"] = "U"
  tableAccents["\195\155"] = "U"
  tableAccents["Ü"] = "U"
  tableAccents["\195\157"] = "Y"
function stripAccents(str)
  str = utf8.lower(str)
  local normalizedString = ""
  for strChar in string.gfind(str, "([%z\001-\127\194-\244][\128-\191]*)") do
    if tableAccents[strChar] ~= nil then
      normalizedString = normalizedString .. tableAccents[strChar]
    else
      normalizedString = normalizedString .. strChar
    end
  end
  return normalizedString
end
