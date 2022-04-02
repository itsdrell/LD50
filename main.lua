-------------------------------------------------------------------------
g_allStates = {}
g_currentState = "playing" -- attract,tutorial, playing, gameLost

g_totalTime = 0

-------------------------------------------------------------
function GoToState(state)
    g_currentState = state
    g_allStates[g_currentState]:Enter()
end

-------------------------------------------------------------
function InitStates()
    --g_allStates["attract"] = g_Attract
    --g_allStates["tutorial"] = g_Tutorial
    g_allStates["playing"] = g_Playing
    --g_allStates["gameLost"] = g_GameLostScreen
    --g_allStates["gameWon"] = g_GameWonScreen
end

-------------------------------------------------------------------------
function main_init()
    InitStates();
end

-------------------------------------------------------------------------
function main_update(ds)
    g_totalTime = g_totalTime + ds;
    g_allStates[g_currentState]:Update(ds);
end

-------------------------------------------------------------------------
function main_draw()
    g_allStates[g_currentState]:Draw(ds)
end