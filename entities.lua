-- Stick player, AI, things that move in the game in here

Entity = 
{
    hp = 0,
    posVec = nil,
    col = nil,
    sprite = 0,
    flip = false,
    isDead = false
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
        if (e.isDead) then
            e:Delete()
        end
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
    newInst.col = Disc:Create(newInst.posVec.x, newInst.posVec.y, 4)
    return newInst
end

function Player:Update(ds)
    if (btn(0)) then
        self.posVec.x -= 1 
        self.flip = true 
    end

    if (btn(1)) then 
        self.posVec.x += 1
        self.flip = false
    end

    if (btn(2)) then 
        self.posVec.y -= 1
    end
    if (btn(3)) then 
        self.posVec.y += 1
    end
    
    if (btnp(4)) then
        Spell:Create(self.posVec.x,self.posVec.y,self.flip)
    end
end

function Player:Draw()
    spr(self.sprite,self.posVec.x,self.posVec.y,1,1,self.flip,false)
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

    newInst.hp = 100
    newInst.sprite = 3
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    newInst.col = Disc:Create(newInst.posVec.x + 4, newInst.posVec.y + 4, 4)
    newInst:Add()
end

function Enemy:Update(ds)
    --Ai inplementaion for move???
end

function Enemy:Draw()
    spr(self.sprite,self.posVec.x,self.posVec.y,1,1,true, false)
    circ(self.col.center.x, self.col.center.y, self.col.radius, 15)
    print(self.hp)
end
------------------------------------------------------------------------
function Entity:TakeDamage(damage)
    self.hp -= damage
    if (self.hp <= 0) then
        self.isDead = true
    end
end



------------------------------------------------------------------------

