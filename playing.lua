-- The state where all our game happens in 
Playing = {}
g_Playing = Playing

-------------------------------------------------------------------------
function Playing:Enter()
    self:StartUp()
end

-------------------------------------------------------------------------
function Playing:StartUp()
end
X = 64  Y = 64
-------------------------------------------------------------------------
function Playing:Update(ds)
    if (btn(0)) then X=X-1 end
    if (btn(1)) then X=X+1 end
    if (btn(2)) then Y=Y-1 end
    if (btn(3)) then Y=Y+1 end
end

-------------------------------------------------------------------------
function Playing:Draw()
    cls(5)
    circfill(X,Y,7,14)
end