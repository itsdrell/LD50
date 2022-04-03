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
    
end

-------------------------------------------------------------------------
function Playing:Draw()
    cls()

    g_thePlayer:Draw()

    DrawAllEntities()

end
------------------------------------------------------------------------
-- Entity class (update, render, create for all)
-- Player class
-- Enemy class (multi enemies)
-- Spell class (multi spells)
------------------------------------------------------------------------

