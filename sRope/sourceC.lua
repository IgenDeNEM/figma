points, sticks, trackedObjects = {}, {}, {}
local gravity = 0.5
local updateInterval = 25

function point(x, y, z, pinned, player)
    return {
        pos = Vector3(x, y, z),
        oldPos = Vector3(x, y, z),
        owner = player,
        pinned = (pinned or false)
    }
end

function stick(a, b, player)
    local p0, p1 = points[player][a], points[player][b]
    return {
        p0 = p0,
        p1 = p1,
        length = getDistanceBetweenPoints3D(p0.pos, p1.pos) * 2
    }
end

function updatePoints(dt)
    local dim = getElementDimension(localPlayer)
    for obj, objPoints in pairs(trackedObjects) do
        if objPoints and points[obj] and getElementDimension(obj) == dim then
            for _, pt in ipairs(points[obj]) do
                if not pt.pinned then
                    local nextPos = Vector3(pt.pos.x, pt.pos.y, pt.pos.z - gravity * dt)
                    if isLineOfSightClear(pt.pos, nextPos, true, false, false, true) then
                        pt.pos.z = nextPos.z
                    end
                end
            end

            local firstPoint = points[obj][1]
            if firstPoint and firstPoint.attached then
                if isElement(firstPoint.attached) then
                    local x, y, z = getElementPosition(firstPoint.attached)
                    firstPoint.pos = Vector3(x, y, z)
                else
                    points[obj] = nil
                    trackedObjects[obj] = nil
                end
            else
                local matrix = getElementMatrix(obj)
                if matrix then
                    firstPoint.pos = Vector3(getPositionFromElementOffset(matrix, 0.05, -0.1, 0))
                end
            end
        end
    end
end

function updateSticks(dt)
    local dim = getElementDimension(localPlayer)
    for obj, objSticks in pairs(trackedObjects) do
        if sticks[obj] and getElementDimension(obj) == dim then
            for _, stk in ipairs(sticks[obj]) do
                local dx = stk.p1.pos.x - stk.p0.pos.x
                local dy = stk.p1.pos.y - stk.p0.pos.y
                local dz = stk.p1.pos.z - stk.p0.pos.z
                local dist = math.sqrt(dx * dx + dy * dy + dz * dz)
                local diff = stk.length - dist

                local percent = diff / dist / 2
                local offsetX, offsetY, offsetZ = dx * percent, dy * percent, dz * percent

                if not stk.p0.pinned then
                    stk.p0.pos.x = stk.p0.pos.x - offsetX
                    stk.p0.pos.y = stk.p0.pos.y - offsetY
                    stk.p0.pos.z = stk.p0.pos.z - offsetZ
                end

                if not stk.p1.pinned then
                    stk.p1.pos.x = stk.p1.pos.x + offsetX
                    stk.p1.pos.y = stk.p1.pos.y + offsetY
                    stk.p1.pos.z = stk.p1.pos.z + offsetZ
                end
            end
        end
    end
end

function renderSticks()
    local dim = getElementDimension(localPlayer)
    for obj, objSticks in pairs(trackedObjects) do
        if sticks[obj] and getElementDimension(obj) == dim then
            for _, stk in ipairs(sticks[obj]) do
                dxDrawLine3D(stk.p0.pos, stk.p1.pos, tocolor(0, 0, 0), 1.5)
            end
        end
    end
end

colshape = createColSphere(1929.3624267578, -1784.5462646484, 13.3828125, 40)

function updateSimulation()
    if not isElementWithinColShape(localPlayer, colshape) then
        return
    end
    local dt = updateInterval / 600
    updatePoints(dt)
    updateSticks(dt / 10)
end

function renderSimulation()
    if not isElementWithinColShape(localPlayer, colshape) then
        return
    end
    renderSticks()
end

addEventHandler("onClientRender", root, renderSimulation)
setTimer(updateSimulation, updateInterval, 0)

function createRopeAttachedTo(element1, element2)
    local x, y, z = getElementPosition(element1)
    z, y, x = z + 0.65, y + 0.3, x + 0.05

    points[element2] = points[element2] or {}
    sticks[element2] = sticks[element2] or {}
    trackedObjects[element2] = true

    table.insert(points[element2], point(x, y, z, true))
    points[element2][1].dim = 0

    for i = 1, 15 do
        table.insert(points[element2], point(x, y, z, false, element2))
        points[element2][i].dim = 0
        table.insert(sticks[element2], stick(i, i + 1, element2))
        sticks[element2][i].dim = 0
    end

    local firstPoint = points[element2][1]
    firstPoint.jumper = true
    firstPoint.veh = element1
    firstPoint.attached = element2

    points[element2][15].pinned = true

    return element1
end

function removeRopeFromElement(element)
    if trackedObjects[element] then
        points[element] = nil
        sticks[element] = nil
        trackedObjects[element] = nil
    end
end
