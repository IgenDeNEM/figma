local sightexports = {
  sTestloader = false,
  sGui = false,
  sPattach = false,
  sControls = false,
  sChat = false,
  sItems = false,
  sModloader = false,
  sCore = false,
  sRadar = false
}
local function sightlangProcessExports()
  for k in pairs(sightexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightexports[k] = exports[k]
    else
      sightexports[k] = false
    end
  end
end
sightlangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangGuiRefreshColors = function()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    guiRefreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
shaderSource = [[
	#include "files/mta-helper.fx"

	struct PSInput
	{
		float4 Position : POSITION0;

		float4 WorldPos : TEXCOORD0;
		float2 Pos : TEXCOORD1;
		float3 Normal : TEXCOORD2;


		float4 Diffuse : COLOR0;

	};

	struct VSInput
	{
		float3 Position : POSITION0;
		float3 Normal : NORMAL0;

		float4 Diffuse : COLOR0;
	};

	const float PI = 3.14159265f;

	PSInput VertexShaderFunction(VSInput VS)
	{
		PSInput PS = (PSInput)0;

		MTAFixUpNormal( VS.Normal );

		PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
		
		float4 worldPos = mul( float4(VS.Position.xyz,1) , gWorld );

		PS.WorldPos.xyz = worldPos.xyz;
		PS.Pos.xy = VS.Position.xy;

		float3 WorldNormal = MTACalcWorldNormal( VS.Normal );
		PS.Normal = WorldNormal;

		PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse);

		return PS;
	}

	texture reflectionTexture;

	sampler2D ReflectionSampler = sampler_state
	{
		Texture = (reflectionTexture);
	};

	float RaySphereIntersect(float3 r0, float3 rd, float3 s0, float sr) {
		float a = dot(rd, rd);

		float3 s0_r0 = r0 - s0;
		float b = 2.0 * dot(rd, s0_r0);
		float c = dot(s0_r0, s0_r0) - (sr * sr);

		float disc = b * b - 4.0 * a* c;

		if (disc < 0.0) {
			return -1.0;
		}
		
		//return (-b - sqrt((b*b) - 4.0*a*c))/(2.0*a);

		return (-b + sqrt(disc)) / (2.0 * a);
	}

	const float3 ObjectPos = float3(0, 0, 0);
	
	const float zcos = 0;
	const float zsin = 0;

	const float xcos = 0;
	const float xsin = 0;

	float3 rotpoint(float3 p) {
		float3 rotationZX = float3(zcos, zsin, 0);
		float3 rotationZY = float3(-zsin, zcos, 0);
		float3 rotationZZ = float3(0, 0, 1);
		
		float3 rotationYX = float3(1, 0, 0);
		float3 rotationYY = float3(0, xcos, xsin);
		float3 rotationYZ = float3(0, -xsin, xcos);

		float3 rotationABX = float3(
			rotationZX.x * rotationYX.x + rotationZX.y * rotationYY.x + rotationZX.z * rotationYZ.x,
			rotationZX.x * rotationYX.y + rotationZX.y * rotationYY.y + rotationZX.z * rotationYZ.y,
			rotationZX.x * rotationYX.z + rotationZX.y * rotationYY.z + rotationZX.z * rotationYZ.z
		);
		
		float3 rotationABY = float3(
			rotationZY.x * rotationYX.x + rotationZY.y * rotationYY.x + rotationZY.z * rotationYZ.x,
			rotationZY.x * rotationYX.y + rotationZY.y * rotationYY.y + rotationZY.z * rotationYZ.y,
			rotationZY.x * rotationYX.z + rotationZY.y * rotationYY.z + rotationZY.z * rotationYZ.z
		);
		
		float3 rotationABZ = float3(
			rotationZZ.x * rotationYX.x + rotationZZ.y * rotationYY.x + rotationZZ.z * rotationYZ.x,
			rotationZZ.x * rotationYX.y + rotationZZ.y * rotationYY.y + rotationZZ.z * rotationYZ.y,
			rotationZZ.x * rotationYX.z + rotationZZ.y * rotationYY.z + rotationZZ.z * rotationYZ.z
		);

		return float3(
				p.x*rotationABX.x + p.y*rotationABY.x + p.z*rotationABZ.x,
				p.x*rotationABX.y + p.y*rotationABY.y + p.z*rotationABZ.y,
				p.x*rotationABX.z + p.y*rotationABY.z + p.z*rotationABZ.z
			);
	}

	float easeOutQuad(float x, float p) {
		return 1 - pow((1 - x), p);
	}

	const float radius = 0.334406;
	const float zp = 1;

	float4 PixelShaderFunction(PSInput PS) : COLOR0
	{
		float3 vec = normalize(PS.WorldPos.xyz - gCameraPosition);
		float d = RaySphereIntersect(gCameraPosition, vec, ObjectPos, radius);

		float3 dir = normalize(gCameraPosition + vec*d - ObjectPos);

		dir = rotpoint(dir);
			
		float theta;

		if(zp > 1)
			theta = acos( -easeOutQuad(-dir.z, zp) );
		else
			theta = acos( dir.z );
		
		float phi = atan2( dir.y, dir.x );

		phi += ( phi < 0 ) ? 2*PI : 0; 

		float4 col = tex2D(ReflectionSampler, float2(phi/(2*PI), (theta-PI/2)/(PI/2) ));

		//return float4((theta-PI/2)/(PI/2), 0, 0, 1);

		return col*PS.Diffuse;// + float4((theta-PI/2)/(PI/2)*0.36, (theta-PI/2)/(PI/2)*0.8, (theta-PI/2)/(PI/2)*0.2, 1)*0.25;
	}

	technique Technique1 
	{
		pass Pass1 
		{
			//CullMode = 2;
			//ZEnable = true;

			VertexShader = compile vs_2_0 VertexShaderFunction();
			PixelShader = compile ps_2_a PixelShaderFunction(); 
		} 
	}
]]
local hdri = {}
local texCacheNum = {}
function doTheTexCache(tex, n)
  texCacheNum[tex] = (texCacheNum[tex] or 0) + n
  if texCacheNum[tex] <= 0 then
    if isElement(hdri[tex]) then
      destroyElement(hdri[tex])
    end
    hdri[tex] = nil
  else
    hdri[tex] = dxCreateTexture("files/tex/" .. tex .. ".dds", "dxt1")
  end
end
local lcdFont = false
local lcdFontScale = false
local faTicks = {}
local digIcon = false
local pickIcon = false
local digColor = false
local digColorEx = false
local digBgColor = false
local digBgColorEx = false
addEvent("refreshFaTicks", false)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
function guiRefreshColors()
  local resource = getResourceFromName("sGui")
  if resource and getResourceState(resource) == "running" then
    lcdFont = sightexports.sGui:getFont("11/W95FA.otf")
    lcdFontScale = sightexports.sGui:getFontScale("11/W95FA.otf")
    digIcon = sightexports.sGui:getFaIconFilename("digging", 24)
    pickIcon = sightexports.sGui:getFaIconFilename("inbox-out", 24)
    digColor = sightexports.sGui:getColorCodeToColor("sightgreen")
    digColorEx = sightexports.sGui:getColorCode("sightgreen")
    digBgColor = sightexports.sGui:getColorCodeToColor("sightgrey1")
    digBgColorEx = sightexports.sGui:getColorCode("sightgrey1")
    faTicks = sightexports.sGui:getFaTicks()
  end
end
local allowedMaterials = {
  [9] = true,
  [10] = true,
  [11] = true,
  [12] = true,
  [13] = true,
  [14] = true,
  [15] = true,
  [16] = true,
  [17] = true,
  [20] = true,
  [80] = true,
  [81] = true,
  [82] = true,
  [115] = true,
  [116] = true,
  [117] = true,
  [118] = true,
  [119] = true,
  [120] = true,
  [122] = true,
  [125] = true,
  [146] = true,
  [147] = true,
  [148] = true,
  [149] = true,
  [150] = true,
  [151] = true,
  [152] = true,
  [153] = true,
  [160] = true,
  [19] = true,
  [21] = true,
  [22] = true,
  [24] = true,
  [25] = true,
  [26] = true,
  [27] = true,
  [40] = true,
  [83] = true,
  [84] = true,
  [87] = true,
  [88] = true,
  [100] = true,
  [110] = true,
  [124] = true,
  [126] = true,
  [128] = true,
  [129] = true,
  [130] = true,
  [132] = true,
  [133] = true,
  [141] = true,
  [142] = true,
  [145] = true,
  [155] = true,
  [156] = true,
  [28] = true,
  [29] = true,
  [30] = true,
  [31] = true,
  [32] = true,
  [33] = true,
  [74] = true,
  [75] = true,
  [76] = true,
  [77] = true,
  [79] = true,
  [86] = true,
  [96] = true,
  [97] = true,
  [98] = true,
  [99] = true
}
local r = 30
local r2 = 0
function checkCanDig(x, y, z)
  x = x * 3
  y = y * 3
  local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(x, y, z + 10, x, y, z - 10, true, true, false, true, false)
  if not hit then
    return false
  end
  if 1 < z - hz then
    return false
  end
  if testLineAgainstWater(x, y, hz + 250, x, y, hz - 0.1) then
    return false
  end
  if not allowedMaterials[mat] then
    return false
  end
  dxDrawLine3D(hx, hy, hz, hx + nx, hy + ny, hz + nz, tocolor(0, 0, 255))
  local nd = math.abs(math.atan2(math.sqrt(nx * nx + ny * ny), nz))
  local nd2 = math.atan2(ny, nx)
  local sx, sy = getScreenFromWorldPosition(hx, hy, hz, 256)
  if sx then
    dxDrawText(math.deg(nd) .. ", " .. math.deg(nd2), sx, sy)
  end
  if nd > math.rad(30) then
    return false
  end
  for k = 0.5, 1.5, 0.5 do
    for i = -1, 1, 2 do
      for j = -1, 1, 2 do
        local hit = processLineOfSight(x, y, hz + 1.25, x + k * i, y + k * j, hz + 1.25, true, true, false, true, false)
        if hit then
          return false
        end
        local hit = processLineOfSight(x, y, hz + 1.25, x, y + k * j, hz + 1.25, true, true, false, true, false)
        if hit then
          return false
        end
        local hit = processLineOfSight(x, y, hz + 1.25, x + k * i, y, hz + 1.25, true, true, false, true, false)
        if hit then
          return false
        end
        if testLineAgainstWater(x + k * i, y + k * j, hz + 250, x + k * i, y + k * j, hz - 0.1) then
          return false
        end
        local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(x + k * i, y + k * j, hz + 5, x + k * i, y + k * j, hz - 2, true, true, false, true, false)
        if not hit or mat < 9 or 157 < mat then
          return false
        end
        if testLineAgainstWater(x, y + k * j, hz + 250, x, y + k * j, hz - 0.1) then
          return false
        end
        local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(x, y + k * j, hz + 5, x, y + k * j, hz - 2, true, true, false, true, false)
        if not hit or mat < 9 or 157 < mat then
          return false
        end
        if testLineAgainstWater(x + k * i, y, hz + 250, x + k * i, y, hz - 0.1) then
          return false
        end
        local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(x + k * i, y, hz + 5, x + k * i, y, hz - 2, true, true, false, true, false)
        if not hit or mat < 9 or 157 < mat then
          return false
        end
      end
    end
  end
  return hz, nd, nd2
end
local holes = {}
local turasModel = false
local holeQueue = {}
function deleteHole(x, y, create)
  for i = #holeQueue, 1, -1 do
    if holeQueue[i][1] == x and holeQueue[i][2] == y then
      table.remove(holeQueue, i)
    end
  end
  if holes[x] and holes[x][y] then
    doTheTexCache(holes[x][y].tex, -1)
    if isElement(holes[x][y].obj) then
      destroyElement(holes[x][y].obj)
    end
    if isElement(holes[x][y].shad) then
      destroyElement(holes[x][y].shad)
    end
    holes[x][y] = nil
    if not create then
      for y in pairs(holes[x]) do
        return
      end
      holes[x] = nil
    end
  end
end
local playerDetectorDetached = {}
local playerDetectors = {}
local shovelObjs = {}
function resetDetector(client)
  if isElement(playerDetectors[client]) then
    detachElements(playerDetectors[client])
    sightexports.sPattach:attach(playerDetectors[client], client, "right-hand", 0, 0, 0, 0, 0, 0)
    playerDetectorDetached[client] = nil
    if isElement(shovelObjs[client]) then
      destroyElement(shovelObjs[client])
    end
    shovelObjs[client] = nil
  end
end
function tryToUnUseDetector(force)
  if playerDetectorDetached[localPlayer] and not force then
    sightexports.sGui:showInfobox("e", "Ásás közben nem tudod eltenni!")
    return
  end
  if playerDetectors[localPlayer] then
    sightexports.sControls:toggleControl({
      "jump",
      "sprint",
      "crouch",
      "aim_weapon",
      "fire",
      "enter_exit"
    }, true)
    sightexports.sChat:localActionC(localPlayer, "elrakott egy fémdetektort.")
    setElementData(localPlayer, "usingMetalDetector", nil)
  end
  triggerServerEvent("gotMetaldetectorUnUse", localPlayer)
  return true
end
function tryToUseDetector()
  if not playerDetectors[localPlayer] then
    if getElementDimension(localPlayer) ~= 0 then
      sightexports.sGui:showInfobox("e", "Interiorban nem tudsz ásni!")
      triggerServerEvent("gotMetaldetectorUnUse", localPlayer)
      return
    end
    if getPedOccupiedVehicle(localPlayer) then
      sightexports.sGui:showInfobox("e", "Autóban nem tudod elővenni!")
      triggerServerEvent("gotMetaldetectorUnUse", localPlayer)
      return
    end
    sightexports.sControls:toggleControl({
      "jump",
      "sprint",
      "crouch",
      "aim_weapon",
      "fire",
      "enter_exit"
    }, false)
    sightexports.sChat:localActionC(localPlayer, "elővett egy fémdetektort.")
    setElementData(localPlayer, "usingMetalDetector", true)
    return true
  end
end
addEvent("gotHoleData", true)
addEventHandler("gotHoleData", getRootElement(), function(x, y, dat, dig)
  if dat then
    local obj, z = createHole(x, y, dat)
    if dig then
      local mz, nd, nd2 = diggableZones[x][y][1], diggableZones[x][y][2], diggableZones[x][y][3]
      playSound3D("files/shovel" .. dig .. ".mp3", x * 3, y * 3, mz)
      if isElement(source) then
        local px, py, pz = getElementPosition(source)
        local deg = math.deg(math.atan2(y * 3 - py, x * 3 - px)) - 90
        setElementRotation(source, 0, 0, deg, "default", true)
        setPedAnimation(source, "asas", "csplay", -1, false, false, false, false)
        if isElement(shovelObjs[source]) then
          destroyElement(shovelObjs[source])
        end
        shovelObjs[source] = createObject(337, 0, 0, 0)
        sightexports.sPattach:attach(shovelObjs[source], source, "weapon", 0, 0, 0, 0, 0, 0)
      end
      if playerDetectors[source] and obj then
        sightexports.sPattach:detach(playerDetectors[source])
        attachElements(playerDetectors[source], obj, -0.25, -0.65, z + 0.125, 0, -4, 0)
        playerDetectorDetached[source] = true
        setTimer(resetDetector, 5000, 1, source)
      end
    end
  else
    deleteHole(x, y)
  end
end)
function createHole(x, y, dat)
  for i = #holeQueue, 1, -1 do
    if holeQueue[i][1] == x and holeQueue[i][2] == y then
      table.remove(holeQueue, i)
    end
  end
  if diggableZones[x] and diggableZones[x][y] then
    local start = getTickCount()
    if not holes[x] then
      holes[x] = {}
    end
    if not holes[x][y] then
      holes[x][y] = {}
    end
    local mz, nd, nd2 = diggableZones[x][y][1], diggableZones[x][y][2], diggableZones[x][y][3]
    local p = dat.dig / dat.digs
    local ox, oy, oz = x * 3, y * 3, mz - 0.045 * (1 - p) * 0.6
    if not isElement(holes[x][y].obj) then
      holes[x][y].obj = createObject(turasModel or 1339, ox, oy, oz, math.deg(nd), 0, math.deg(nd2))
    else
      setElementPosition(holes[x][y].obj, ox, oy, oz)
    end
    local scale = 1
    local zScale = 1
    if p < 1 then
      holes[x][y].p = p
      scale = 0.8 + 0.2 * p
      setObjectScale(holes[x][y].obj, scale, scale, 0.25 + 0.75 * p)
    else
      holes[x][y].p = nil
    end
    holes[x][y].pickUp = dat.pickUp
    if not isElement(holes[x][y].shad) then
      holes[x][y].shad = dxCreateShader(shaderSource, 0, 50)
      if holes[x][y].shad then
        engineApplyShaderToWorldTexture(holes[x][y].shad, "see_pit", holes[x][y].obj)
        dxSetShaderValue(holes[x][y].shad, "zcos", math.cos(-nd2))
        dxSetShaderValue(holes[x][y].shad, "zsin", math.sin(-nd2))
        dxSetShaderValue(holes[x][y].shad, "xcos", math.cos(-nd))
        dxSetShaderValue(holes[x][y].shad, "xsin", math.sin(-nd))
      end
    end
    if holes[x][y].shad then
      if holes[x][y].tex then
        doTheTexCache(holes[x][y].tex, -1)
      end
      holes[x][y].tex = dat.tex
      doTheTexCache(holes[x][y].tex, 1)
      dxSetShaderValue(holes[x][y].shad, "reflectionTexture", hdri[dat.tex])
      dxSetShaderValue(holes[x][y].shad, "radius", 0.334406 * scale)
      dxSetShaderValue(holes[x][y].shad, "ObjectPos", {
        ox,
        oy,
        oz
      })
      dxSetShaderValue(holes[x][y].shad, "zp", 3 - 2 * p)
    end
    return holes[x][y].obj, 0.045 * (1 - p) * 0.6
  end
end
local cx, cy = 0, 0
local metalZones = {}
function setMetalZone(x, y)
  if not metalZones[x] then
    metalZones[x] = {}
  end
  metalZones[x][y] = true
end
function deleteMetalZone(x, y)
  if metalZones[x] and metalZones[x][y] then
    metalZones[x][y] = nil
    for y in pairs(metalZones[x]) do
      return
    end
    metalZones[x] = nil
  end
end
local metalD = 0
local loadedZones = {}
local preUnloadCount = 0
local holeItems = {}
addEvent("pickUpHoleItem", true)
addEventHandler("pickUpHoleItem", getRootElement(), function(x, y, item)
  table.insert(holeItems, {
    x,
    y,
    ":sItems/" .. sightexports.sItems:getItemPic(item),
    getTickCount()
  })
end)
addEvent("deleteMetalDetectorLoot", true)
addEventHandler("deleteMetalDetectorLoot", getRootElement(), function(x, y)
  deleteMetalZone(x, y)
end)
addEvent("gotMetalDetectorLoot", true)
addEventHandler("gotMetalDetectorLoot", getRootElement(), function(sx, sy, dat)
  if loadedZones[sx] and loadedZones[sx][sy] then
    for i = 1, #dat do
      setMetalZone(dat[i][1], dat[i][2])
    end
  end
end)
addEvent("gotMetalDetectorHoles", true)
addEventHandler("gotMetalDetectorHoles", getRootElement(), function(sx, sy, dat)
  if loadedZones[sx] and loadedZones[sx][sy] then
    for i = 1, #dat do
      table.insert(holeQueue, dat[i])
    end
  end
end)
function loadZone(sx, sy)
  if not diggableSync[sx] or not diggableSync[sx][sy] then
    return
  end
  if not loadedZones[sx] then
    loadedZones[sx] = {}
  end
  if loadedZones[sx][sy] then
    if tonumber(loadedZones[sx][sy]) then
      preUnloadCount = preUnloadCount - 1
    end
  else
    triggerServerEvent("metalDetectorZoneLoaded", localPlayer, sx, sy)
  end
  loadedZones[sx][sy] = true
end
function processPreUnload()
  unloadTimerSet = false
  for sx in pairs(loadedZones) do
    for sy in pairs(loadedZones[sx]) do
      if tonumber(loadedZones[sx][sy]) then
        loadedZones[sx][sy] = loadedZones[sx][sy] - 1
        if loadedZones[sx][sy] <= 0 then
          unloadZone(sx, sy)
        end
      end
    end
  end
  if 1 <= preUnloadCount then
    unloadTimerSet = true
    setTimer(processPreUnload, 1000, 1)
  end
end
function preUnloadZone(sx, sy)
  if loadedZones[sx] and loadedZones[sx][sy] then
    loadedZones[sx][sy] = 5
    preUnloadCount = preUnloadCount + 1
    if not unloadTimerSet then
      unloadTimerSet = true
      setTimer(processPreUnload, 1000, 1)
    end
  end
end
function unloadZone(sx, sy)
  if loadedZones[sx] then
    loadedZones[sx][sy] = nil
    for i = 0, syncSize - 1 do
      for j = 0, syncSize - 1 do
        deleteHole(sx * syncSize + i, sy * syncSize + j)
        deleteMetalZone(sx * syncSize + i, sy * syncSize + j)
      end
    end
    triggerServerEvent("metalDetectorZoneUnloaded", localPlayer, sx, sy)
    preUnloadCount = preUnloadCount - 1
    for y in pairs(loadedZones[sx]) do
      return
    end
    loadedZones[sx] = nil
  end
end
local detectorID = false
local sx, sy = 0, 0
local syncTime = 0
local syncedD = 0
local detectorPlayerList = {}
local detectorPlayerR = {}
local detectorPlayerCR = {}
local detectorPlayerR2 = {}
local detectorPlayerCR2 = {}
local beepSound = {}
local beepSound2 = {}
function loadModelIds()
  detectorID = sightexports.sModloader:getModelId("metal_detector")
  turasModel = sightexports.sModloader:getModelId("turas")
  if turasModel then
    for x in pairs(holes) do
      if holes[x] then
        for y in pairs(holes[x]) do
          if holes[x][y] and isElement(holes[x][y].obj) then
            setElementModel(holes[x][y].obj, turasModel)
          end
        end
      end
    end
  end
  if detectorID then
    local players = getElementsByType("player", getRootElement(), true)
    for i = 1, #players do
      if getElementData(players[i], "usingMetalDetector") then
        if isElement(playerDetectors[players[i]]) then
          destroyElement(playerDetectors[players[i]])
        end
        playerDetectors[players[i]] = createObject(detectorID, 0, 0, 0)
        sightexports.sPattach:attach(playerDetectors[players[i]], players[i], "right-hand", 0, 0, 0, 0, 0, 0)
        playerDetectorDetached[source] = nil
        beepSound[players[i]] = playSound3D("files/beep.mp3", 0, 0, 0, true)
        setSoundVolume(beepSound[players[i]], 0)
        beepSound2[players[i]] = playSound3D("files/beep2.mp3", 0, 0, 0, true)
        setSoundVolume(beepSound2[players[i]], 0)
        attachElements(beepSound[players[i]], playerDetectors[players[i]])
        attachElements(beepSound2[players[i]], playerDetectors[players[i]])
        detectorPlayerR[players[i]] = 30
        detectorPlayerR2[players[i]] = 90
        detectorPlayerCR[players[i]] = 30
        detectorPlayerCR2[players[i]] = 90
        if players[i] ~= localPlayer then
          table.insert(detectorPlayerList, players[i])
        end
      end
    end
  end
end
local screenX, screenY = guiGetScreenSize()
function preRenderNormal(delta)
  if holeQueue[1] then
    createHole(holeQueue[1][1], holeQueue[1][2], holeQueue[1][3])
  end
  local px, py, pz = getElementPosition(localPlayer)
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    local player = players[i]
    if player ~= localPlayer then
      local npx, npy = getElementPosition(player)
      if getDistanceBetweenPoints2D(px, py, npx, npy) < 40 then
        if detectorPlayerCR[player] ~= detectorPlayerR[player] and detectorPlayerR[player] and detectorPlayerCR[player] then
          local cr = detectorPlayerCR[player] - detectorPlayerR[player]
          cr = (cr + 180) % 360 - 180
          if 0 < cr then
            detectorPlayerCR[player] = detectorPlayerCR[player] - 180 * delta / 1000
            if detectorPlayerCR[player] < detectorPlayerR[player] then
              detectorPlayerCR[player] = detectorPlayerR[player]
            end
          end
          if cr < 0 then
            detectorPlayerCR[player] = detectorPlayerCR[player] + 180 * delta / 1000
            if detectorPlayerCR[player] > detectorPlayerR[player] then
              detectorPlayerCR[player] = detectorPlayerR[player]
            end
          end
        end
        if detectorPlayerCR2[player] ~= detectorPlayerR2[player] and detectorPlayerR2[player] and detectorPlayerCR2[player] then
          local cr = detectorPlayerCR2[player] - detectorPlayerR2[player]
          cr = (cr + 180) % 360 - 180
          if 0 < cr then
            detectorPlayerCR2[player] = detectorPlayerCR2[player] - 180 * delta / 1000
            if detectorPlayerCR2[player] < detectorPlayerR2[player] then
              detectorPlayerCR2[player] = detectorPlayerR2[player]
            end
          end
          if cr < 0 then
            detectorPlayerCR2[player] = detectorPlayerCR2[player] + 180 * delta / 1000
            if detectorPlayerCR2[player] > detectorPlayerR2[player] then
              detectorPlayerCR2[player] = detectorPlayerR2[player]
            end
          end
        end
      end
    end
  end
  px = math.floor(px / 3 + 0.5)
  py = math.floor(py / 3 + 0.5)
  tsx, tsy = math.floor(px / syncSize), math.floor(py / syncSize)
  if sx ~= tsx or sy ~= tsy then
    for i = -1, 1 do
      for j = -1, 1 do
        preUnloadZone(sx + i, sy + j)
      end
    end
    sx = tsx
    sy = tsy
    for i = -1, 1 do
      for j = -1, 1 do
        loadZone(sx + i, sy + j)
      end
    end
  end
end
local fly = false
addEvent("onClientFlyToggle", true)
addEventHandler("onClientFlyToggle", getRootElement(), function(state)
  fly = state or getTickCount()
end)
local calibration = false
function preRenderMetalDetector(delta)
  if holeQueue[1] then
    createHole(holeQueue[1][1], holeQueue[1][2], holeQueue[1][3])
  end
  local px, py, pz = getElementPosition(localPlayer)
  local opx, opy = px, py
  px = math.floor(px / 3 + 0.5)
  py = math.floor(py / 3 + 0.5)
  tsx, tsy = math.floor(px / syncSize), math.floor(py / syncSize)
  if sx ~= tsx or sy ~= tsy then
    for i = -1, 1 do
      for j = -1, 1 do
        preUnloadZone(sx + i, sy + j)
      end
    end
    sx = tsx
    sy = tsy
    for i = -1, 1 do
      for j = -1, 1 do
        loadZone(sx + i, sy + j)
      end
    end
  end
  local rx, ry, rz = getElementRotation(localPlayer)
  if tonumber(fly) and getTickCount() - fly > 5000 then
    fly = false
  end
  metalD = fly and 8 or 0
  if not playerDetectorDetached[localPlayer] then
    local cx, cy, cz, ctx, cty, ctz = getCameraMatrix()
    local m = getElementMatrix(playerDetectors[localPlayer])
    local cr = math.atan2(cty - cy, ctx - cx)
    cr = cr - math.rad(rz)
    cr = (cr + math.pi) % (math.pi * 2) - math.pi
    if 0 < cr then
      r2 = math.deg(cr)
    else
      r2 = math.deg(-cr)
    end
    local x, y, z = m[4][1], m[4][2], m[4][3]
    local tx, ty, tz = m[4][1] + m[1][1] * 10, m[4][2] + m[1][2] * 10, m[4][3] + m[1][3] * 10
    local vehs = getElementsByType("vehicle", getRootElement(), true)
    if calibration then
      metalD = (getTickCount() - calibration) / 2500
      if 1 < metalD then
        metalD = 2 - metalD
      end
      if metalD < 0 then
        metalD = 0
        calibration = false
      end
      metalD = math.min(8, metalD * 10)
    else
      for i = 1, #vehs do
        local vx, vy, vz = getElementPosition(vehs[i])
        local d = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)
        metalD = metalD + math.max(0, (1 - (d - 4) / 12) * 8)
        if 8 <= metalD then
          metalD = 8
          break
        end
      end
    end
    local hit, hx, hy, hz = processLineOfSight(x, y, z, tx, ty, tz, true, true, false, true, false)
    if hit then
      local d = getDistanceBetweenPoints3D(x, y, z, hx, hy, hz)
      r = r - (d - 1.5) / 0.6 * 10
      if metalD < 8 and not calibration then
        for i = -2, 2 do
          for j = -2, 2 do
            if metalZones[px + i] and metalZones[px + i][py + j] then
              local d = getDistanceBetweenPoints2D(hx, hy, (px + i) * 3, (py + j) * 3)
              if d < 10.5 then
                d = math.max(0, d - 0.5)
                metalD = math.min(8, metalD + getEasingValue((10 - d) / 10, "InQuad") * 8)
              end
            end
          end
        end
      end
    else
      r = 30
    end
  end
  metalD = math.floor(metalD)
  local v2 = math.max(metalD / 2 - 3, 0)
  setSoundVolume(beepSound[localPlayer], metalD / 8 - v2 * 0.55)
  setSoundVolume(beepSound2[localPlayer], v2)
  if 0 < metalD then
    setSoundSpeed(beepSound[localPlayer], metalD * 0.035 + 1)
  end
  syncTime = syncTime - delta
  local sync = syncTime <= 0
  local syncList = false
  if sync then
    syncList = {}
  end
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    local player = players[i]
    if player ~= localPlayer then
      local npx, npy = getElementPosition(player)
      if getDistanceBetweenPoints2D(opx, opy, npx, npy) < 40 then
        if sync then
          table.insert(syncList, player)
        end
        if detectorPlayerCR[player] ~= detectorPlayerR[player] and detectorPlayerR[player] and detectorPlayerCR[player] then
          local cr = detectorPlayerCR[player] - detectorPlayerR[player]
          cr = (cr + 180) % 360 - 180
          if 0 < cr then
            detectorPlayerCR[player] = detectorPlayerCR[player] - 180 * delta / 1000
            if detectorPlayerCR[player] < detectorPlayerR[player] then
              detectorPlayerCR[player] = detectorPlayerR[player]
            end
          end
          if cr < 0 then
            detectorPlayerCR[player] = detectorPlayerCR[player] + 180 * delta / 1000
            if detectorPlayerCR[player] > detectorPlayerR[player] then
              detectorPlayerCR[player] = detectorPlayerR[player]
            end
          end
        end
        if detectorPlayerCR2[player] ~= detectorPlayerR2[player] and detectorPlayerR2[player] and detectorPlayerCR2[player] then
          local cr = detectorPlayerCR2[player] - detectorPlayerR2[player]
          cr = (cr + 180) % 360 - 180
          if 0 < cr then
            detectorPlayerCR2[player] = detectorPlayerCR2[player] - 180 * delta / 1000
            if detectorPlayerCR2[player] < detectorPlayerR2[player] then
              detectorPlayerCR2[player] = detectorPlayerR2[player]
            end
          end
          if cr < 0 then
            detectorPlayerCR2[player] = detectorPlayerCR2[player] + 180 * delta / 1000
            if detectorPlayerCR2[player] > detectorPlayerR2[player] then
              detectorPlayerCR2[player] = detectorPlayerR2[player]
            end
          end
        end
      end
    end
  end
  if sync then
    syncedD = metalD
    if 0 < #syncList then
      syncTime = 200 + math.floor(#syncList / 10) * 50
      triggerServerEvent("syncMetalDetectorData", localPlayer, syncList, r, r2, calibration and 0 or metalD)
    else
      syncTime = 500
    end
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  engineLoadIFP("files/asas.ifp", "asas")
  addEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessed, true, "high+99999")
  addEventHandler("onClientPreRender", getRootElement(), preRenderNormal)
  addEventHandler("onClientRender", getRootElement(), renderNormal)
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "usingMetalDetector" and old ~= new then
    local self = source == localPlayer
    if isElementStreamedIn(source) or self then
      if self then
        if new then
          calibration = getTickCount()
          addEventHandler("onClientClick", getRootElement(), clickMetalDetector)
          addEventHandler("onClientRender", getRootElement(), renderMetalDetector)
          addEventHandler("onClientPreRender", getRootElement(), preRenderMetalDetector)
          removeEventHandler("onClientPreRender", getRootElement(), preRenderNormal)
          removeEventHandler("onClientRender", getRootElement(), renderNormal)
        else
          removeEventHandler("onClientClick", getRootElement(), clickMetalDetector)
          removeEventHandler("onClientRender", getRootElement(), renderMetalDetector)
          removeEventHandler("onClientPreRender", getRootElement(), preRenderMetalDetector)
          addEventHandler("onClientPreRender", getRootElement(), preRenderNormal)
          addEventHandler("onClientRender", getRootElement(), renderNormal)
        end
      end
      if new then
        if not playerDetectors[source] and detectorID then
          playerDetectors[source] = createObject(detectorID, 0, 0, 0)
          sightexports.sPattach:attach(playerDetectors[source], source, "right-hand", 0, 0, 0, 0, 0, 0)
          playerDetectorDetached[source] = nil
          beepSound[source] = playSound3D("files/beep.mp3", 0, 0, 0, true)
          setSoundVolume(beepSound[source], 0)
          beepSound2[source] = playSound3D("files/beep2.mp3", 0, 0, 0, true)
          setSoundVolume(beepSound2[source], 0)
          attachElements(beepSound[source], playerDetectors[source])
          attachElements(beepSound2[source], playerDetectors[source])
          detectorPlayerR[source] = 30
          detectorPlayerR2[source] = 90
          detectorPlayerCR[source] = 30
          detectorPlayerCR2[source] = 90
          if not self then
            table.insert(detectorPlayerList, source)
          end
        end
      elseif playerDetectors[source] then
        if isElement(beepSound[source]) then
          destroyElement(beepSound[source])
        end
        beepSound[source] = nil
        if isElement(beepSound2[source]) then
          destroyElement(beepSound2[source])
        end
        beepSound2[source] = nil
        if isElement(playerDetectors[source]) then
          destroyElement(playerDetectors[source])
        end
        playerDetectors[source] = nil
        playerDetectorDetached[source] = nil
        detectorPlayerR[source] = nil
        detectorPlayerR2[source] = nil
        detectorPlayerCR[source] = nil
        detectorPlayerCR2[source] = nil
        for i = #detectorPlayerList, 1, -1 do
          if detectorPlayerList[i] == source then
            table.remove(detectorPlayerList, i)
          end
        end
      end
    end
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementType(source) == "player" and source ~= localPlayer and getElementData(source, "usingMetalDetector") and not playerDetectors[source] and detectorID then
    playerDetectors[source] = createObject(detectorID, 0, 0, 0)
    sightexports.sPattach:attach(playerDetectors[source], source, "right-hand", 0, 0, 0, 0, 0, 0)
    beepSound[source] = playSound3D("files/beep.mp3", 0, 0, 0, true)
    setSoundVolume(beepSound[source], 0)
    beepSound2[source] = playSound3D("files/beep2.mp3", 0, 0, 0, true)
    setSoundVolume(beepSound2[source], 0)
    attachElements(beepSound[source], playerDetectors[source])
    attachElements(beepSound2[source], playerDetectors[source])
    detectorPlayerR[source] = 30
    detectorPlayerR2[source] = 90
    detectorPlayerCR[source] = 30
    detectorPlayerCR2[source] = 90
    table.insert(detectorPlayerList, source)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if playerDetectors[source] and source ~= localPlayer then
    if isElement(beepSound[source]) then
      destroyElement(beepSound[source])
    end
    beepSound[source] = nil
    if isElement(beepSound2[source]) then
      destroyElement(beepSound2[source])
    end
    beepSound2[source] = nil
    if isElement(shovelObjs[source]) then
      destroyElement(shovelObjs[source])
    end
    shovelObjs[source] = nil
    if isElement(playerDetectors[source]) then
      destroyElement(playerDetectors[source])
    end
    playerDetectors[source] = nil
    playerDetectorDetached[source] = nil
    detectorPlayerR[source] = nil
    detectorPlayerR2[source] = nil
    detectorPlayerCR[source] = nil
    detectorPlayerCR2[source] = nil
    for i = #detectorPlayerList, 1, -1 do
      if detectorPlayerList[i] == source then
        table.remove(detectorPlayerList, i)
      end
    end
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  if playerDetectors[source] and source ~= localPlayer then
    if isElement(beepSound[source]) then
      destroyElement(beepSound[source])
    end
    beepSound[source] = nil
    if isElement(beepSound2[source]) then
      destroyElement(beepSound2[source])
    end
    beepSound2[source] = nil
    if isElement(shovelObjs[source]) then
      destroyElement(shovelObjs[source])
    end
    shovelObjs[source] = nil
    if isElement(playerDetectors[source]) then
      destroyElement(playerDetectors[source])
    end
    playerDetectors[source] = nil
    playerDetectorDetached[source] = nil
    detectorPlayerR[source] = nil
    detectorPlayerR2[source] = nil
    detectorPlayerCR[source] = nil
    detectorPlayerCR2[source] = nil
    for i = #detectorPlayerList, 1, -1 do
      if detectorPlayerList[i] == source then
        table.remove(detectorPlayerList, i)
      end
    end
  end
end)
addEvent("syncMetalDetectorData", true)
addEventHandler("syncMetalDetectorData", getRootElement(), function(r, r2, metalD)
  if isElement(source) and playerDetectors[source] then
    detectorPlayerR[source] = r
    detectorPlayerR2[source] = r2
    local v2 = math.max(metalD / 2 - 3, 0)
    setSoundVolume(beepSound[source], metalD / 8 - v2 * 0.55)
    setSoundVolume(beepSound2[source], v2)
    if 0 < metalD then
      setSoundSpeed(beepSound[source], metalD * 0.035 + 1)
    else
      setSoundSpeed(beepSound[source], 0)
    end
  end
end)
function onClientPedsProcessed()
  if playerDetectors[localPlayer] and not playerDetectorDetached[localPlayer] then
    local r4 = -r2
    local r3 = 0
    if 100 < r2 then
      r3 = (r2 - 100) * 0.55
      r4 = -100
    elseif r2 < 75 then
      r3 = -(75 - r2) / 2
      r4 = -75
    end
    setElementBoneRotation(localPlayer, 2, r3, 0, 0)
    setElementBoneRotation(localPlayer, 3, r3, 0, 0)
    setElementBoneRotation(localPlayer, 22, 0, r4, -60)
    setElementBoneRotation(localPlayer, 23, 0, 0, r)
    setElementBoneRotation(localPlayer, 24, 180, 0, 0)
    setElementBoneRotation(localPlayer, 25, 0, 0, 0)
    setElementBoneRotation(localPlayer, 26, 0, 90, 0)
    sightexports.sCore:updateElementRpHAnim(localPlayer)
  end
  for i = 1, #detectorPlayerList do
    local player = detectorPlayerList[i]
    if not playerDetectorDetached[player] then
      local r, r2 = detectorPlayerCR[player], detectorPlayerCR2[player]
      local r4 = -r2
      local r3 = 0
      if 100 < r2 then
        r3 = (r2 - 100) * 0.55
        r4 = -100
      elseif r2 < 75 then
        r3 = -(75 - r2) / 2
        r4 = -75
      end
      setElementBoneRotation(player, 2, r3, 0, 0)
      setElementBoneRotation(player, 3, r3, 0, 0)
      setElementBoneRotation(player, 22, 0, r4, -60)
      setElementBoneRotation(player, 23, 0, 0, r)
      setElementBoneRotation(player, 24, 180, 0, 0)
      setElementBoneRotation(player, 25, 0, 0, 0)
      setElementBoneRotation(player, 26, 0, 90, 0)
      sightexports.sCore:updateElementRpHAnim(player)
    end
  end
end
local coords = ""
local zone = ""
local nextCoordRefresh = 0
function refreshCoords()
  local x, y, z = getElementPosition(localPlayer)
  zone = sightexports.sRadar:getZoneName(x, y, z, false)
  coords = math.abs(math.floor(x))
  if x < 0 then
    coords = coords .. "W\n"
  else
    coords = coords .. "E\n"
  end
  coords = coords .. math.abs(math.floor(y))
  if y < 0 then
    coords = coords .. "N"
  else
    coords = coords .. "S"
  end
end
local x, y = screenX / 2 - 195, screenY * 0.75 - 125
local moveX, moveY = false, false
local holeHoverX = false
local holeHoverY = false
local lastDig = 0
function clickMetalDetector(button, state)
  if state == "down" and holeHoverX then
    local now = getTickCount()
    if not playerDetectorDetached[localPlayer] and 1000 < now - lastDig then
      lastDig = now
      triggerServerEvent("tryToDigHole", localPlayer, holeHoverX, holeHoverY)
    end
  end
end
function renderNormal()
  local px, py, pz = getElementPosition(localPlayer)
  local now = getTickCount()
  for i = #holeItems, 1, -1 do
    local item = holeItems[i]
    local p = (now - item[4]) / 750
    if 6 < p then
      table.remove(holeItems, i)
    else
      local a = 255
      if 5 < p then
        a = a * getEasingValue(6 - p, "InQuad")
        p = 1
      elseif 1 < p then
        p = 1
      else
        p = getEasingValue(p, "OutQuad")
      end
      local dx, dy = item[1], item[2]
      local d = getDistanceBetweenPoints3D(px, py, pz, dx * 3, dy * 3, diggableZones[dx][dy][1] + 0.25 - 0.5 * (1 - p))
      if d < 6 then
        a = (1 - d / 6) * a
        local x, y = getScreenFromWorldPosition(dx * 3, dy * 3, diggableZones[dx][dy][1] + 0.25 - 0.5 * (1 - p), 72)
        if x then
          dxDrawImage(x - 18, y - 18, 36, 36, item[3], 0, 0, 0, tocolor(255, 255, 255, a * p))
        end
      end
    end
  end
end
function renderMetalDetector()
  local now = getTickCount()
  if now > nextCoordRefresh then
    nextCoordRefresh = now + math.random() * 800 + 800
    refreshCoords()
  end
  local cx, cy = getCursorPosition()
  local tmpX, tmpY = false, false
  local px, py, pz = getElementPosition(localPlayer)
  if cx then
    cx = cx * screenX
    cy = cy * screenY
    if moveX and getKeyState("mouse1") then
      x = math.min(math.max(0, cx - moveX), screenX - 390)
      y = math.min(math.max(0, cy - moveY), screenY - 250)
    elseif getKeyState("mouse1") and cx >= x and cy >= y and cx <= x + 390 and cy <= y + 250 then
      moveX = cx - x
      moveY = cy - y
    else
      moveX, moveY = false, false
      if not playerDetectorDetached[localPlayer] then
        local x = math.floor(px / 3 + 0.5)
        local y = math.floor(py / 3 + 0.5)
        for i = -2, 2 do
          for j = -2, 2 do
            local dx, dy = x + i, y + j
            if diggableZones[dx] and diggableZones[dx][dy] and (not (holes[dx] and holes[dx][dy]) or holes[dx][dy].p or not not holes[dx][dy].pickUp) then
              local d = getDistanceBetweenPoints2D(px, py, dx * 3, dy * 3)
              if d < 10 then
                local x, y = getScreenFromWorldPosition(dx * 3, dy * 3, diggableZones[dx][dy][1] - 0.1, 48)
                if x then
                  local a = 255 - d / 10 * 255
                  if holes[dx] and holes[dx][dy] and holes[dx][dy].pickUp then
                    if d < 1.5 and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                      dxDrawRectangle(x - 16, y - 16, 32, 32, digBgColor)
                      dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. pickIcon .. faTicks[pickIcon], 0, 0, 0, digColor)
                      tmpX = dx
                      tmpY = dy
                    else
                      dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(digBgColorEx[1], digBgColorEx[2], digBgColorEx[3], a))
                      dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. pickIcon .. faTicks[pickIcon], 0, 0, 0, tocolor(255, 255, 255, a))
                    end
                  else
                    if d < 1.5 and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                      dxDrawRectangle(x - 16, y - 16, 32, 32, digBgColor)
                      dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. digIcon .. faTicks[digIcon], 0, 0, 0, digColor)
                      a = 255
                      tmpX = dx
                      tmpY = dy
                    else
                      dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(digBgColorEx[1], digBgColorEx[2], digBgColorEx[3], a))
                      dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. digIcon .. faTicks[digIcon], 0, 0, 0, tocolor(255, 255, 255, a))
                    end
                    if holes[dx] and holes[dx][dy] and holes[dx][dy].p then
                      local w = 96 * holes[dx][dy].p
                      dxDrawRectangle(x - 48 + w, y + 16 + 4, 96 - w, 6, tocolor(digBgColorEx[1], digBgColorEx[2], digBgColorEx[3], a))
                      dxDrawRectangle(x - 48, y + 16 + 4, w, 6, tocolor(digColorEx[1], digColorEx[2], digColorEx[3], a))
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  elseif moveX then
    moveX, moveY = false, false
  end
  local now = getTickCount()
  for i = #holeItems, 1, -1 do
    local item = holeItems[i]
    local p = (now - item[4]) / 750
    if 6 < p then
      table.remove(holeItems, i)
    else
      local a = 255
      if 5 < p then
        a = a * getEasingValue(6 - p, "InQuad")
        p = 1
      elseif 1 < p then
        p = 1
      else
        p = getEasingValue(p, "OutQuad")
      end
      local dx, dy = item[1], item[2]
      local d = getDistanceBetweenPoints3D(px, py, pz, dx * 3, dy * 3, diggableZones[dx][dy][1] + 0.25 - 0.5 * (1 - p))
      if d < 6 then
        a = (1 - d / 6) * a
        local x, y = getScreenFromWorldPosition(dx * 3, dy * 3, diggableZones[dx][dy][1] + 0.25 - 0.5 * (1 - p), 72)
        if x then
          dxDrawImage(x - 18, y - 18, 36, 36, item[3], 0, 0, 0, tocolor(255, 255, 255, a * p))
        end
      end
    end
  end
  if holeHoverX ~= tmpX or holeHoverY ~= tmpY then
    holeHoverX = tmpX
    holeHoverY = tmpY
    sightexports.sGui:setCursorType(tmpX and "link" or "normal")
    if holes[tmpX] and holes[tmpX][tmpY] and holes[tmpX][tmpY].pickUp then
      sightexports.sGui:showTooltip("Tárgy felvétele")
    elseif tmpX then
      sightexports.sGui:showTooltip("Ásás")
    else
      sightexports.sGui:showTooltip()
    end
  end
  local t = 220 + (1 - metalD / 8) * 500
  local blink = getTickCount() % t > t * 0.5
  local h = getTime()
  if 20 <= h or h <= 6 then
    dxDrawImage(x, y, 390, 250, "files/bg2.png")
  else
    dxDrawImage(x, y, 390, 250, "files/bg.png")
  end
  dxDrawText(coords, 0, y + 37, x + 361, y + 37, tocolor(26, 26, 26), lcdFontScale * 0.75, lcdFont, "right", "center")
  dxDrawText(zone, 0, y + 58, x + 361, 0, tocolor(26, 26, 26), lcdFontScale * 0.9, lcdFont, "right", "top")
  dxDrawText("Battery OK", x + 29, y + 58, 0, 0, tocolor(26, 26, 26), lcdFontScale * 0.9, lcdFont, "left", "top")
  if calibration then
    dxDrawText("CALIBRATION", x + 195, y + 39, x + 195, y + 39, tocolor(26, 26, 26), lcdFontScale * 1.25, lcdFont, "center", "center")
  elseif 1 <= metalD then
    dxDrawText("SIGNAL: " .. metalD .. "/" .. 8, x + 195, y + 39, x + 195, y + 39, tocolor(26, 26, 26), lcdFontScale * 1.25, lcdFont, "center", "center")
  else
    dxDrawText("NO SIGNAL", x + 195, y + 39, x + 195, y + 39, tocolor(26, 26, 26), lcdFontScale * 1.25, lcdFont, "center", "center")
  end
  if 1 <= metalD then
    dxDrawImage(x, y, 390, 250, "files/" .. metalD .. ".png", 0, 0, 0, tocolor(255, 255, 255, blink and 255 or 0))
  end
end
