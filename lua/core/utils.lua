local M = {}
    M.os_name = vim.loop.os_uname().sysname

    M.path_exists = function(path)
        local f = io.open(path, "r")
        if f ~= nil then
            io.close(f)
            return true
        else
            return false
        end
end
return M
