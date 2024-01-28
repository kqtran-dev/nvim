function path_exists(path)
    local f = io.open(path, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local paths = {
    "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents",
    "/c/Users/k/iCloudDrive/iCloud~md~obsidian"
}

local workspaces = {}
for _, path in ipairs(paths) do
    if path_exists(path) then
        table.insert(workspaces, { name = "main", path = path })
    end
end
