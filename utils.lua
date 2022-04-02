-- utils for like math and pathfinding stuff
-------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------
function Pick(condition, valueIfTrue, valueIfFalse)
    return condition and valueIfTrue or valueIfFalse
end

-------------------------------------------------------------------------
function Lerp(start, end, percent)
    return start * (1 - percent) + (percent * end);
end 

-------------------------------------------------------------------------
function RangeMap(inValue, inStart, inEnd, outStart, outEnd)

	inRange = inEnd - inStart;
	outRange = outEnd - outStart;
	inRelativeToStart = inValue - inStart;

	fractionIntoRange = inRelativeToStart / inRange;
	outRelativeToStart = fractionIntoRange * outRange;

	return outRelativeToStart + outStart;
end

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

-------------------------------------------------------------------------
-- Vector 2
-------------------------------------------------------------------------
Vector2 = 
{
    x = 0,
    y = 0,   
}

-------------------------------------------------------------------------
function Vector2:Create(x,y)
    local newInstance = {}
    setmetatable( newInstance, 
    { 
        __index = Vector2,
        __add = AddTwoVectors,
        __sub = SubtractTwoVectors
    })

    -- if you add a copy constructor, dont just set them equal to another
    -- since thats a reference and not a copy

    newInstance.x = x
    newInstance.y = y

    return newInstance
end

-------------------------------------------------------------------------
function AddTwoVectors(vecA, vecB)
    return Vector2:Create(vecA.x + vecB.x, vecA.y + vecB.y)
end

-------------------------------------------------------------------------
function SubtractTwoVectors(vecA, vecB)
    return Vector2:Create(vecA.x - vecB.x, vecA.y - vecB.y)
end

-------------------------------------------------------------------------
-- Class
-------------------------------------------------------------------------
Disc =
{
    center = {x = 0, y = 0},
    radius = 1
}

-------------------------------------------------------------------------
function Disc:Create(input1, input2, input3)
    local newInstance = {}
    setmetatable( newInstance, 
    { 
        __index = Disc,
    })

    -- if you add a copy constructor, dont just set them equal to another
    -- since thats a reference and not a copy
    
    -- figure out if we are using a vec2 to create or x,y,r
    -- gotta do this cause lua doesn't support overloading
    if type(input1) == "table" then
        newInstance.center = Vector2:Create(input1.x, input1.y)
        newInstance.radius = input2
    else
        newInstance.center = Vector2:Create(input1,input2)
        newInstance.radius = input3
    end

    return newInstance
end

-------------------------------------------------------------------------
-- AABB2
-------------------------------------------------------------------------
AABB2 = 
{
    mins = {x = 0, y = 0},
    maxs = {x = 1, y = 1}
}

-------------------------------------------------------------------------
-- YOU CAN NOT JUST ASSIGN THEM TO MINS,MAXS IF ITS A VECTOR
-- BECAUSE ITS NOT A COPY, ITS A REFERENCE AND IF YOU CHANGE THE MINS
-- YOU WILL CHANGE THE VALUES YOU PASSED IN DURING CONSTRUCTION AS WELL
-- think of them as needing to be const
function AABB2:Create(input1, input2, input3, input4)
    local newInstance = {}
    setmetatable( newInstance, 
    { 
        __index = AABB2,
    })

    -- if you add a copy constructor, dont just set them equal to another
    -- since thats a reference and not a copy

    if type(input1) == "table" and type(input2) == "table" then 
        newInstance.mins = Vector2:Create(input1.x, input1.y) 
        newInstance.maxs = Vector2:Create(input2.x, input2.y)
    
    elseif type(input1) == "table" and type(input2) ~= "table" then
        newInstance.mins = Vector2:Create(input1.x, input1.y)
        newInstance.maxs = Vector2:Create(input2, input3)

    elseif type(input1) ~= "table" and type(input3) == "table" then
        newInstance.mins = Vector2:Create(input1, input2)
        newInstance.maxs = Vector2:Create(input3.x, input3.y)

    else
        newInstance.mins = Vector2:Create(input1, input2)
        newInstance.maxs = Vector2:Create(input3,input4)
    end

    return newInstance
end

-------------------------------------------------------------------------
function AABB2:GetWidth()
    return Abs(self.maxs.x - self.mins.x)
end

-------------------------------------------------------------------------
function AABB2:GetHeight()
    return Abs(self.maxs.y - self.mins.y)
end

-------------------------------------------------------------------------
function AABB2:GetAABB2FromSelf(vec2MinPercentage, vec2MaxPercentage)
    newminx, newminy, newmaxx, newmaxy = AABB2GetAABB2FromAABB2(vec2MinPercentage.x, vec2MinPercentage.y, vec2MaxPercentage.x, vec2MaxPercentage.y, self.mins.x, self.mins.y, self.maxs.x, self.maxs.y)

    return AABB2:Create(newminx, newminy,newmaxx, newmaxy)
end

-------------------------------------------------------------------------
function GetAABB2FromAABB2(minX, minY, maxX, maxY, boundsMinX, boundsMinY, boundsMaxX, boundsMaxY)
    local width = Abs(boundsMaxX - boundsMinX);
    local height = Abs(boundsMaxY - boundsMinY);

    -- if you have a bug its the + here
    local newMinsX = (minX * width) + boundsMinX
    local newMinsY = (minY * height) + boundsMinX;

    local newMaxX = (maxX * width) + boundsMaxX;
    local newMaxY = (maxY * height) + boundsMaxY;

    return newMinsX, newMinsY, newMaxX, newMaxY;

end