--// Waits until the game is loaded and then calls callback, prevents any unloaded errors
return function (callback: (any) -> any)
    repeat task.wait() until game:IsLoaded()
    callback()
end