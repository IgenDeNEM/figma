smsPrice = 10
callPrice = 10
ringtoneNum = 27
notiNum = 26
origFE = fileExists
origFC = fileCreate
origFO = fileOpen
origFD = fileDelete
function formatPhoneNumber(num)
  num = tostring(num)
  if utf8.len(num) == 10 then
    local out = ""
    for i = 1, 11 do
      out = out .. utf8.sub(num, i, i)
      if i == 2 or i == 4 or i == 7 then
        out = out .. "-"
      end
    end
    return "+" .. out
  elseif utf8.len(num) == 11 then
    local out = ""
    for i = 1, 11 do
      out = out .. utf8.sub(num, i, i)
      if i == 2 or i == 4 or i == 7 then
        out = out .. "-"
      end
    end
    return "+" .. out
  end
  return num
end
local te = teaEncode
local td = teaDecode
local teaKeys = {
  ad = "gX4&lnZtsight",
  co = "2cpsS(bZsight",
  mk = "%Ih2^7#Wsight",
  sm = "B5FkGkIlsight",
  bc = "4bgi%Tgysight",
  ts = "7QPy5QKKsight"
}
function teaEncode(data, key)
  local prefix = utf8.sub(key, 1, 2)
  if teaKeys[prefix] then
    return te(data, teaKeys[prefix] .. key)
  else
    return ""
  end
end
function teaDecode(data, key)
  local prefix = utf8.sub(key, 1, 2)
  if teaKeys[prefix] then
    return td(data, teaKeys[prefix] .. key)
  else
    return ""
  end
end
