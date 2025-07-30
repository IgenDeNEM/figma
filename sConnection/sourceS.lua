local connection = false
local datas = {
	["host"] = "localhost",
	["user"] = "sight-external.sql",
	["pw"] = "qEY55AyNU4bsYffn",
	["database"] = "sightmain",
}

--[[
SQL:
user: sight-admin.sql
pass: 19q4DKGvNtqdEf21

user: sight-external.sql
pass: qEY55AyNU4bsYffn
]]--

addEventHandler("onResourceStart", resourceRoot, function()
    connection = dbConnect("mysql", "dbname=" .. datas["database"] .. ";host=" .. datas["host"], datas["user"], datas["pw"], "autoreconnect=1")
    
    if not connection then
        outputDebugString("CONNECTION FAILED", 1)
        cancelEvent()
    else
        dbExec(connection, "SET NAMES utf8")
    end
end)

function getConnection()
	return connection
end

function dbInsert(tableName, insertValues)
  if tableName and insertValues and type(insertValues) == "table" then
    local columns = {}
    local values = {}

    for column, value in pairs(insertValues) do
      table.insert(columns, column)
      table.insert(values, value)
    end

    local paramString = ("?,"):rep(#columns):sub(1, -2)
    local queryString = dbPrepareString(connection, "INSERT INTO ?? (" .. table.concat(columns, ",") .. ") VALUES (" .. paramString .. ");", tableName, unpack(values))

    return dbExec(connection, queryString)
  end

  return false
end

function dbUpdate(tableName, setFields, whereFields)
  if tableName and setFields and type(setFields) == "table" and whereFields and type(whereFields) == "table" then
    local columns = {}
    local values = {}
    local wheres = {}

    for column, value in pairs(setFields) do
      if value then
        if string.sub(value, 0, 1) == "%" and string.sub(value, string.len(value)) == "%" then
          table.insert(columns, string.format("`%s`=%s", column, string.gsub(value, "%%", "")))
        else
          table.insert(columns, string.format("`%s`=?", column))
          table.insert(values, value)
        end 
      end
    end

    for column, value in pairs(whereFields) do
      table.insert(wheres, string.format("`%s`=?", column))
      table.insert(values, value)
    end

    local queryString = dbPrepareString(connection, "UPDATE ?? SET " .. table.concat(columns, ", ") .. " WHERE " .. table.concat(wheres, " AND ") .. ";", tableName, unpack(values))

    return dbExec(connection, queryString)
  end

  return false
end