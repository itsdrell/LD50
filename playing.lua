-- The state where all our game happens in 
Playing = {}
g_Playing = Playing
g_spell = nil
spell_flipx = false

-------------------------------------------------------------------------
function Playing:Enter()
    self:StartUp()
    SpawnEnemy()
end

-------------------------------------------------------------------------
function Playing:StartUp()
end
 playerX= 64  playerY = 64
-------------------------------------------------------------------------
function Playing:Update(ds)
    flip_x = false
    if (btn(0)) then
        playerX=playerX-1 
        flip_x = true 
    end
    if (btn(1)) then 
        playerX=playerX+1
    end
    if (btn(2)) then playerY=playerY-1 end
    if (btn(3)) then playerY=playerY+1 end
    
    if (btn(4)) then
        CastSpell(playerX+10,playerY)
    end
    
    if (g_spell ~= nil) then
        UpdateSpell(ds)
    end
end

-------------------------------------------------------------------------
function Playing:Draw()
    cls()
    
    spr(1,playerX,playerY,1,1,flip_x,false)
    flip_x = false
    --circ(playerX+4, playerY+4,4,15)
    
    pset(playerX,playerY,14)

    DrawEnemy()

    if (g_spell ~= nil) then 
        if (flip_x == true) then
        end
        DrawSpell(spell_flipx)
    end
end

-------------------------------------------------------------------------
--sprite mov X
--moving spell X
--bad guy X
--bad guy disapears when hit
--
------------------------------------------------------------------------
function SpawnEnemy()
    enemy_hp = 10
end 

function DrawEnemy()
    spr(3,64,64,1,1,true, false)
    --circ(68,68,4,15)
end

function UpdateEnemy()
end
------------------------------------------------------------------------
function CastSpell(spellX,spellY)
    g_spell = true
    g_spellX = spellX
    g_spellY = spellY
    damage = 10
    spellColX = g_spellX+4
    spellColY = g_spellY+4
    spellRad = 3
end

function DrawSpell(spell_flipx)
    spr(2,g_spellX,g_spellY,1,1,spell_flipx,false)
    --circ(spellColX,spellColY,spellRad,15)
end

function UpdateSpell(ds)
    g_spellX += (80*ds)
    spellColX = g_spellX + 4
    hit = DoesDiscOverlap(spellColX,spellColY,spellRad,68,68,4)
    if (hit) then
        --calc damage
        g_spell = nil
    end
end

function DoesSpellHit()

end

function DoesDiscOverlap(Ax,Ay,Ar,Bx,By,Br)
    xTotal = (Ax - Bx) * (Ax - Bx)
    yTotal = (Ay - By) * (Ay - By)
    rSqrd = (Ar + Br) * (Ar + Br)
    d = (xTotal + yTotal)

    if (d < rSqrd) then
        return true
    end

    return false
end
------------------------------------------------------------------------