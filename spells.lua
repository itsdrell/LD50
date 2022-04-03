-- all spells and def go in here
Spell = 
{

}

function Spell:Create(X,Y,flip)
    local newInst = {}

    setmetatable( Spell, { __index = Entity } )
    setmetatable( newInst, { __index = Spell } )

    newInst.hp = 1
    newInst.animation = Animation:Create(.25, {17, 18})
    newInst.damage = 10
    newInst.posVec = Vector2:Create(X,Y)
    newInst.flip = flip

    if (newInst.flip) then 
        newInst.col = Disc:Create(newInst.posVec.x - 8, newInst.posVec.y + 4, 3)
    else
        newInst.col = Disc:Create(newInst.posVec.x + 4, newInst.posVec.y + 4, 3)
    end

    newInst:Add()
end

function Spell:Update(ds)
    if(self.flip) then 
        self.posVec.x -= (80*ds)
        self.col.center.x = self.posVec.x +2
    else 
        self.posVec.x += (80*ds)
        self.col.center.x = self.posVec.x + 4
    end

    for e in all(g_allEntities) do
        local hit = DoesDiscOverlap(self.col.center.x, self.col.center.y,self.col.radius,e.col.center.x,e.col.center.y,e.col.radius)
        if ((hit) and (e ~= self)) then 
            e:TakeDamage(self.damage)
            self:Delete()
        end
    end

    self.animation:Update(ds)

end

function Spell:Draw()
    self.animation:Draw(self.posVec.x, self.posVec.y, self.flip)

    --circ(self.col.center.x, self.col.center.y, self.col.radius, 15)
    print(self.col.center.x, 10, 30)
end

function DoesDiscOverlap(Ax,Ay,Ar,Bx,By,Br)
    xTotal = (Bx - Ax) * (Bx - Ax)
    yTotal = (By - Ay) * (By - Ay)
    rSqrd = (Ar + Br) * (Ar + Br)
    d = abs(xTotal + yTotal)

    if (d < rSqrd) then
        return true
    end

    return false
end