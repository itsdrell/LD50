-- The state where all our game happens in 
Playing = {}
g_Playing = Playing
g_spell = nil
spell_flipx = false

-------------------------------------------------------------------------
function Playing:Enter()
    self:StartUp()
end

-------------------------------------------------------------------------
function Playing:StartUp()
    g_thePlayer = Player:Create(64,64)
    Enemy:Create(68,68)
end
 
-------------------------------------------------------------------------
function Playing:Update(ds) 
    g_thePlayer:Update(ds)

    UpdateAllEntities(ds)
    
end

-------------------------------------------------------------------------
function Playing:Draw()
    cls()

    g_thePlayer:Draw()

    DrawAllEntities()

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
-- Entity class (update, render, create for all)
-- Player class
-- Enemy class (multi enemies)
-- Spell class (multi spells)
------------------------------------------------------------------------

