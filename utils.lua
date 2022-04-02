-- utils for like math and pathfinding stuff
-------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Timer
-------------------------------------------------------------------------
Timer = 
{
    length = 1,
    elapsedTime = 0
}
setmetatable(Timer, 
{
    __call = function(theTable, length) return Timer:Create(length) end
})
g_allTimers = {}

-------------------------------------------------------------------------
function Timer:Create(length)
    local newInst = {}
    setmetatable(newInst, {__index = Timer})

    newInst.length = length
    newInst.elapsedTime = 0

    add(g_allTimers, newInst)
    return newInst
end

-------------------------------------------------------------------------
function Timer:SetLength(length)
    self.length = length

    -- assume we should reset it as well?
    self.elapsedTime = 0
end

-------------------------------------------------------------------------
function Timer:Update(ds)
    if self.elapsedTime > self.length then return end 

    self.elapsedTime = self.elapsedTime + ds
end

-------------------------------------------------------------------------
function Timer:HasElapsed()
    return self.elapsedTime >= self.length
end

-------------------------------------------------------------------------
function Timer:GetElapsedTime()
    return self.elapsedTime
end

-------------------------------------------------------------------------
function Timer:GetNormalizedElapsedTime()
    return Clamp(self.elapsedTime / self.length, 0 , 1)
end

-------------------------------------------------------------------------
function Timer:Reset()
    self.elapsedTime = 0
end

-------------------------------------------------------------------------
function Timer:CheckAndReset()
    if self:HasElapsed() then
        self.elapsedTime = 0
        return true
    end

    return false
end

-------------------------------------------------------------------------
function Timer:ToString()
    return (self.elapsedTime .. self.length)
end

-------------------------------------------------------------------------
-- Standalone
-------------------------------------------------------------------------
function UpdateAllTimers(ds)
    for currentTimer in all(g_allTimers) do 
        currentTimer:Update(ds)
    end
end 