function getPlayerAdminTitle(playerSource, noCol)
  local adminLevel = getElementData(playerSource, "acc.adminLevel") or 0
  if adminLevel == 11 then
    return (not noCol and "[color=sightred]" or "") .. "Tulajdonos"
  elseif adminLevel == 10 then
    return (not noCol and "[color=sightblue]" or "") .. "Fejlesztő"
  elseif adminLevel == 9 then
    return (not noCol and "[color=sightblue-second]" or "") .. "SysEngineer"
  elseif adminLevel == 8 then
    return (not noCol and "[color=sightgreen-second]" or "") .. "Manager"
  elseif adminLevel == 7 then
    return (not noCol and "[color=sightorange]" or "") .. "SzuperAdmin"
  elseif adminLevel == 6 then
    return (not noCol and "[color=sightyellow]" or "") .. "FőAdmin"
  elseif 0 < adminLevel then
    return (not noCol and "[color=sightgreen]" or "") .. "Admin " .. adminLevel
  end
  return "N/A"
end
function isPlayerInAdminDuty(playerSource)
  return getElementData(playerSource, "adminDuty")
end

function getPlayerAdminTitleLOG(playerSource, noCol)
  local adminLevel = getElementData(playerSource, "acc.adminLevel") or 0
  if adminLevel == 11 then
    return (not noCol and "" or "") .. "Tulajdonos"
  elseif adminLevel == 10 then
    return (not noCol and "" or "") .. "Fejlesztő"
  elseif adminLevel == 9 then
    return (not noCol and "" or "") .. "SysEngineer"
  elseif adminLevel == 8 then
    return (not noCol and "" or "") .. "Manager"
  elseif adminLevel == 7 then
    return (not noCol and "" or "") .. "SzuperAdmin"
  elseif adminLevel == 6 then
    return (not noCol and "" or "") .. "FőAdmin"
  elseif 0 < adminLevel then
    return (not noCol and "" or "") .. "Admin " .. adminLevel
  end
  return "N/A"
end
