-- Title screen 
Item =
{
    posVec = nil,
    rerity = 0,
    part = 0,
    pickUp = false,
    col = nil
    --hp = 0
    --dmgMul = 0
    --dmgNull = 0
}

g_allItems = {}

function Item:Add()
    add(g_allItems,self)
end

function Item:Delete()
    del(g_allItems,self)
end

function UpdateAllItems(ds)
end

function DrawAllItems()
    for e in all(g_allItems) do
        e:Draw()
    end
end
-------------------------------------------------------------------------
function Item:Create(x,y)
    local newInst = {}

    setmetatable( newInst, { __index = Item })


    newInst.posVec = Vector2:Create(x,y)
    newInst.rarity = rnd(2)
    newInst.part = rnd(2)
    newInst.col = Disc:Create(newInst.posVec.x, newInst.posVec.y, 4)
    newInst:Add()

    return newInst
end

function Item:Update(ds)
end

function Item:Draw()
    if (not self.pickUp) then
        spr(21, self.posVec.x, self.posVec.y, 1, 1)
    end
end
-------------------------------------------------------------------------
