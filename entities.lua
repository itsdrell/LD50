-- Stick player, AI, things that move in the game in here

Entity = 
{
    currHp = 0,
    maxHp = 0,
    posVec = nil,
    col = nil,
    amimation = nil,
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
            e:OnDeath()
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

    newInst.currHp = 100
    newInst.maxHp = 100
    newInst.animation = Animation:Create(.25,{1, 2, 3, 4})
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    newInst.col = Disc:Create(newInst.posVec.x, newInst.posVec.y, 4)
    return newInst
end

function Player:Update(ds)
    local dx = 0
    local dy = 0

    if (btn(0)) then
        dx -= 1 
        self.flip = true 
    end

    if (btn(1)) then 
        dx += 1
        self.flip = false
    end

    if (btn(2)) then 
        dy -= 1
    end
    if (btn(3)) then 
        dy += 1
    end
    
    if (CanMove(self.posVec.x + dx, self.posVec.y, 7, 7)) then 
        self.posVec.x += dx
    end

    if (CanMove(self.posVec.x, self.posVec.y + dy, 7, 7)) then 
        self.posVec.y += dy
    end


    if (btnp(4)) then
        Spell:Create(self.posVec.x,self.posVec.y,self.flip)
    end

    self.animation:Update(ds)

    self.currHp -= .01

    for e in all(g_allItems) do
        if(DoesDiscOverlap(self.posVec.x, self.posVec.y, 4, e.posVec.x, e.posVec.y, 4)) then
            if (btn(0, 1)) then
                e.pickUp = true
            end
        end
    end

end

function Player:Draw()
    --circ(self.posVec.x+4, self.posVec.y+4,4,15)
    self.animation:Draw(self.posVec.x,self.posVec.y, self.flip)
    --pset(self.posVec.x,self.posVec.y,14)

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

    newInst.currHp = 100
    newInst.maxHp = 100
    newInst.animation = Animation:Create(.25,{33})
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = false
    newInst.col = Disc:Create(newInst.posVec.x + 4, newInst.posVec.y + 4, 4)
    newInst.vel = Vector2:Create(0,0)
    newInst.dirTimer = Timer:Create(3)
    newInst.movSpeed = 8
    newInst:Add()
end

function Enemy:Update(ds)
    --Ai inplementaion for move???
    local dx = 0
    local dy = 0

    if (self.dirTimer:CheckAndReset()) then 
        --pick another direction
        self.vel.x = (rnd(2) - 1) * self.movSpeed
        self.vel.y = (rnd(2) - 1) * self.movSpeed
    end

    dx += self.vel.x
    dy += self.vel.y

    if (CanMove(self.posVec.x + dx, self.posVec.y, 7, 7)) then
        self.posVec.x += (dx * ds)
        self.col.center.x += (dx * ds)
    end

    if (CanMove(self.posVec.x, self.posVec.y + dy, 7, 7)) then
        self.posVec.y += (dy * ds)
        self.col.center.y += (dy * ds)
    end

    self.animation:Update(ds)
end

function Enemy:Draw()
    self.animation:Draw(self.posVec.x, self.posVec.y, self.flip)

    local healthW = flr(Lerp(0, 8, (self.currHp / self.maxHp)))
    rectfill(self.posVec.x, self.posVec.y - 3, self.posVec.x + 8, self.posVec.y - 4, 8)
    rectfill(self.posVec.x, self.posVec.y - 3, self.posVec.x + healthW, self.posVec.y - 4, 11)
    --circ(self.col.center.x, self.col.center.y, self.col.radius, 15)
end

function Enemy:OnDeath()
    Item:Create(self.posVec.x, self.posVec.y)
end

------------------------------------------------------------------------
function Entity:TakeDamage(damage)
    self.currHp -= damage
    if (self.currHp <= 0) then
        self.isDead = true
    end
end

function Entity:OnDeath()

end
------------------------------------------------------------------------

