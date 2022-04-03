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
    Enemy:Create(80,80)
end
 
-------------------------------------------------------------------------
function Playing:Update(ds) 
    g_thePlayer:Update(ds)

    UpdateAllEntities(ds)

    UpdateAllItems(ds)

    camera(g_thePlayer.posVec.x -64, g_thePlayer.posVec.y - 64)

    
end

-------------------------------------------------------------------------
function Playing:Draw()
    cls()
    
    map(0,0,0,0,127,127)

    g_thePlayer:Draw()

    DrawAllEntities()

    DrawAllItems()

    local healthW = Lerp(g_thePlayer.posVec.x - 64, g_thePlayer.posVec.x - 32, (g_thePlayer.currHp / g_thePlayer.maxHp))
    rectfill(g_thePlayer.posVec.x - 64, g_thePlayer.posVec.y -64, g_thePlayer.posVec.x - 32, g_thePlayer.posVec.y - 56, 8)
    rectfill(g_thePlayer.posVec.x - 64, g_thePlayer.posVec.y -64, healthW, g_thePlayer.posVec.y - 56, 11)



end
------------------------------------------------------------------------

------------------------------------------------------------------------

