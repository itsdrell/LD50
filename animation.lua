-- A thing we can just stick on a player or bad guy 

Animation = 
{
    current_frame = 1,
    frames = {},
    timer = {}
}

-------------------------------------------------------------------------
function Animation:Create(length, frames)
    local newinst = {} 

    setmetatable( newinst, { __index = Animation } )

    newinst.frames = frames;
    newinst.timer = Timer:Create(length);

    return newinst;
end 

-------------------------------------------------------------------------
function Animation:Update(ds) 
    if self.timer:CheckAndReset() then 
        self.current_frame = (self.current_frame + 1) % (#self.frames + 1);
        
        -- hack cause fucking lua one indexing breaking my math and its late
        if(self.current_frame == 0) then self.current_frame = 1 end
    end 
end 

-------------------------------------------------------------------------
function Animation:Draw(x,y)
    spr(self.frames[self.current_frame], x, y)
end