-- Stick player, AI, things that move in the game in here

Entity = 
{
    hp = 0,
    posVec = nil,
    col = nil,
    sprite = 0,
    flip = false
}

g_allEntities = {}

function Entity:Add()
    add(g_allEntities,self)
end

function Entity:Delete()
    del(g_allEntities,self)
end

function UpdateAllEntities(ds)
    for e in all(g_allEntities) do
        e:Update(ds)
    end 
end

function DrawAllEntities()
    for e in all(g_allEntities) do
        e:Draw()
    end
end
------------------------------------------------------------------------

Player = 
{

}

g_thePlayer = nil

function Player:Create(X,Y)
    local newInst = {}

    setmetatable( Player, { __index = Entity } )
    setmetatable( newInst, { __index = Player } )

    newInst.hp = 10
    newInst.sprite = 1
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    return newInst
end

function Player:Update(ds)
     self.flip = false

    if (btn(0)) then
        self.posVec.x -= 1 
        self.flip = true 
    end

    if (btn(1)) then 
        self.posVec.x += 1
    end

    if (btn(2)) then 
        self.posVec.y -= 1
    end
    if (btn(3)) then 
        self.posVec.y += 1
    end
    
    if (btnp(4)) then
        Spell:Create(self.posVec.x + 10,self.posVec.y)
    end
end

function Player:Draw()
    spr(self.sprite,self.posVec.x,self.posVec.y,1,1,self.flip,false)
    self.flip = false
    --circ(self.posVec.x+4, self.posVec.y+4,4,15)
    
    pset(self.posVec.x,self.posVec.y,14)

end

------------------------------------------------------------------------

Enemy = 
{

}

--g_enemy????

function Enemy:Create(X,Y)
    local newInst = {}

    setmetatable( Enemy, { __index = Entity } )
    setmetatable( newInst, { __index = Enemy } )

    newInst.hp = 10
    newInst.sprite = 3
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    newInst:Add()
end

function Enemy:Update(ds)
    --Ai inplementaion for move???
end

function Enemy:Draw()
    spr(self.sprite,self.posVec.x,self.posVec.y,1,1,true, false)
end

------------------------------------------------------------------------

Spell = 
{

}

function Spell:Create(X,Y)
    local newInst = {}

    setmetatable( Spell, { __index = Entity } )
    setmetatable( newInst, { __index = Spell } )

    newInst.hp = 1
    newInst.sprite = 2
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    newInst:Add()
end

function Spell:Update(ds)
    self.posVec.x += (80*ds)
end

function Spell:Draw()
    spr(2,self.posVec.x,self.posVec.y,1,1,false,false) --Spell Flip
end
------------------------------------------------------------------------
